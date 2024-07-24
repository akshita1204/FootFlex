
import 'package:client_application/controller/login_controller.dart';
import 'package:client_application/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
     return GetBuilder<LoginController>(builder: (ctrl){
    return Scaffold(
      body:Container(
     width: double.maxFinite,
     padding: const EdgeInsets.all(20),
     decoration: BoxDecoration(
      color: Colors.blueGrey[50],
      ),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Welcome Back!',
        style:TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color:Colors.purple,
        )),
        
       const SizedBox(height: 20),

        TextField(
          controller: ctrl.loginNumberCtrl,
          keyboardType:TextInputType.phone,
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

       ElevatedButton(onPressed: (){
        ctrl.loginWithPhone();
       },
       style:ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
       ),
       child:const Text('Login'),
      ),

     const SizedBox(height: 20),

     TextButton(onPressed: (){
      Get.to(const RegisterPage());
     }, child: const Text('Register New Account'))

      ],
    )


      )
    );
  });
  }
  }
