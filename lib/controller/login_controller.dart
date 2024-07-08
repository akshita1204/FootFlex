import 'dart:math';

import 'package:client_application/models/user/user.dart';
import 'package:client_application/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController
{
  GetStorage box =GetStorage();
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl=TextEditingController();
  TextEditingController registerNumberCtrl=TextEditingController();
  TextEditingController loginNumberCtrl=TextEditingController();

  OtpFieldControllerV2 otpController= OtpFieldControllerV2();
  bool otpFieldShown=false;
  int? otpsend;
  int? otpEntered;
  User? loginUser;


 @override
 void onReady()
 {
  Map<String,dynamic>?user=box.read('loginUser');
  if(user!=null)
  {
    loginUser=User.fromJson(user);
    Get.to(const HomePage());
  }
  super.onReady();
 }

  @override
  void onInit()
  {
    userCollection=firestore.collection('users');
    super.onInit();
  }

  
addUser()
{
try {
  if(otpsend==otpEntered)
  {
 DocumentReference doc=userCollection.doc();
    User user=User(
    id:doc.id,
    name:registerNameCtrl.text,
    number:int.parse(registerNumberCtrl.text),
  );
final userJson=user.toJson;
doc.set(userJson);
Get.snackbar('Success', 'User added successfully',colorText:Colors.green);
registerNameCtrl.clear();
registerNumberCtrl.clear();
otpController.clear();
update();
  }
  else
  {
    Get.snackbar('Error', 'OTP entered is incorrect',colorText:Colors.red);
  }
} 
catch (e) {
Get.snackbar('Error', e.toString(),colorText:Colors.red);
print(e);
}
}


sendOtp()
{
try {
   if(registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty)
 {
  Get.snackbar('Error', 'Please fill the fields',colorText:Colors.red);
  return;
 }
  final random=Random();
  int otp=1000 + random.nextInt(9000);
  print(otp);
  if(otp !=null)
  {
   
   otpFieldShown = true;
    otpsend=otp;
   Get.snackbar('Success', 'OTP sent Successfully',colorText: Colors.green);
  }
  else
  {
    Get.snackbar('Error', 'OTP not Sent',colorText: Colors.red);
  }
}  catch (e) {
  print(e);
  // TODO
}
finally{
  update();
}
}


Future<void> loginWithPhone() async {
  try {
    String phoneNumber = loginNumberCtrl.text;
    if (phoneNumber.isNotEmpty) {
      var querySnapshot = await userCollection.where('number', isEqualTo: int.tryParse(phoneNumber)).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>;
         box.write('loginUser', userData);
         loginNumberCtrl.clear();
         Get.to(const HomePage());
        Get.snackbar('Success', 'Login Successful', colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'User not found. Please register', colorText: Colors.red);
      }
    } 
    else {
      Get.snackbar('Error', 'Please enter a phone number', colorText: Colors.red);
    }
  } catch (error) {
    Get.snackbar('Error', 'An error occurred: $error', colorText: Colors.red);
  }
}

}

