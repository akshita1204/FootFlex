import 'package:client_application/controller/login_controller.dart';
import 'package:client_application/models/user/user.dart';
import 'package:client_application/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseController extends GetxController
{

  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference orderCollection;
  TextEditingController addressController=TextEditingController();


  double orderPrice=0;
  String itemName='';
  String orderAddress='';


  @override
  void onInit() {
   orderCollection=firestore.collection('orders');
   super.onInit();
    
  }

  submitOrder({
  required double price,
  required String item,
  required String description,
  })
  {
    orderPrice=price;
    itemName=item;
    orderAddress=addressController.text;


    Razorpay razorpay=Razorpay();
    var options = {
  'key': '<YOUR_KEY_HERE>',
  'amount': price * 100,
  'name': item,
  'description': description ,
};


//_razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//_razorpay.open(options);
 
  }
  
  void _handlePaymentSuccess(PaymentSuccessResponse)
  {
   // orderSuccess(transactionId: response.paymentId);
 Get.snackbar('Success', 'Payment is Successful',colorText: Colors.green);
  }
  void _handlePaymentError(PaymentFailureResponse)
  {
    Get.snackbar('Error', 'Error in Payment',colorText: Colors.red);
  }


Future<void>orderSuccess({required String? transactionId}) async
{
  User?loginUse=Get.find<LoginController>().loginUser;
  try{
    if(transactionId !=null)
    {
      DocumentReference docRef=await orderCollection.add(
        {
         'customer':loginUse?.name??'',
         'phone':loginUse?.number??'',
          'item':itemName,
          'price':orderPrice,
          'address':orderAddress,
          'transactionId':transactionId,
          'dateTime':DateTime.now().toString(),
        }
      );
      showOrderSuccessDialog(docRef.id);
      Get.snackbar('Success', 'Order Places Succesfully',colorText:Colors.green);
    }
    else
    {
     Get.snackbar('Error', 'Please fill all the fields',colorText:Colors.red); 
    }
  }
  catch(error){
Get.snackbar('Error', 'Failed to place Order',colorText:Colors.red);
  }
  
}

void showOrderSuccessDialog(String orderId)
{
Get.defaultDialog(
  title: "Order Success",
  content: Text("Your order is $orderId"),
  confirm: ElevatedButton(onPressed: (){
    Get.off(const HomePage());
  }, child: const Text('Close')
  )
);
}
  
}
