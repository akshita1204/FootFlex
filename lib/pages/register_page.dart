import 'package:client_application/controller/login_controller.dart';
import 'package:client_application/pages/login_page.dart';
import 'package:client_application/widget/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl){
    return Scaffold(
      body:Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.blueGrey[50],
     ),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text('Create your Account!',
        style:TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color:Colors.purple,
        )
      ),

    const SizedBox(height: 20),

    
        TextField(
          keyboardType:TextInputType.phone,
          controller: ctrl.registerNameCtrl,
          decoration: InputDecoration(
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.phone_android),
            labelText: 'Your Name',
            hintText: 'Enter your Name',       
          ),
        ),

   const SizedBox(height: 20),

     TextField(
          keyboardType:TextInputType.phone,
          controller: ctrl.registerNumberCtrl,
          decoration: InputDecoration(
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.phone_android),
            labelText: 'Mobile Number',
            hintText: 'Enter your Mobile Number',       
          ),
        ),

        const SizedBox(height: 20),

       OtpTextField(otpController: ctrl.otpController,
        visible: ctrl.otpFieldShown,
         onComplete: (otp) {  
          ctrl.otpEntered=int.tryParse(otp!);
       },),

        const SizedBox(height: 20),

        ElevatedButton(onPressed: (){
        if(ctrl.otpFieldShown)
        {
          ctrl.addUser();
        }
        else
        {
          ctrl.sendOtp();
        }
        },
       style:ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
       ),
       child: Text(ctrl.otpFieldShown ?'Register' :'Send OTP'),
      ),

      const SizedBox(height: 20),

      TextButton(onPressed: (){
        Get.to(const LoginPage());
      }, child: const Text('Login'))

    ],)
      )
    );
  });
  }
}