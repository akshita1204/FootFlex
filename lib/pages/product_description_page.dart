import 'package:client_application/controller/purchase_controller.dart';
import 'package:client_application/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescriptionPage extends StatelessWidget {


  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product=Get.arguments['data'];
    return GetBuilder<PurchaseController>(builder: (ctrl){
    return Scaffold(
      appBar: AppBar(
        title: Text('Footware Store',style:TextStyle(
        fontWeight: FontWeight.bold,
      )),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.logout)),
      ],
      ),

      body:SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:Image.network(
           product.image??'',
            fit:BoxFit.contain,
            width: double.infinity,
            height: 200,
            ),
  
            
          ),

          const SizedBox(height:20),
          Text(
            product.name??'',
            style:const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
             )
          ),

          const SizedBox(height:20),

          Text(
            product.description??'',
            style:TextStyle(
              fontSize: 16,
              height: 1.5,
             )
          ),

          const SizedBox(height:20),

          Text(
            'Rs:${product.price??''}',
            style:const TextStyle(
              fontSize: 20,
              color:Colors.green,
              fontWeight: FontWeight.bold,
             )
          ),

          const SizedBox(height:20),

          TextField(
            controller: ctrl.addressController,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              labelText: 'Enter your Billing address',
            ),
          ),

          const SizedBox(height:20),
          SizedBox(
            width:double.infinity,
            child:ElevatedButton(
              style:ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.purple,    
              ),
              child:const Text('Buy Now',style:TextStyle(fontSize: 18,color:Colors.white)),   
              onPressed: (){
                ctrl.submitOrder(price: product.price??0, item:product.name??'' , description: product.description??'');
              })
          )
        ],),
      )
    );
    });
  }
}