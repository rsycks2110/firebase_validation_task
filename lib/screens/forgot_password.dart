import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_validation_task/constants/app_constants.dart';
import 'package:firebase_validation_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {


  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiHelper.CustomTextField(mController: emailController, mText: "Enter Your Email Here"),
              SizedBox(height: 20,),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width/3,
                child: ElevatedButton(onPressed: (){
                  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
                  firebaseAuth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                    return Center(child: Text("Reset Password link Sent To Your Email "));
                  }).catchError((error){
                    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error While Sending Link:")));
                  });
                }, child: Center(child: Text("Reset Password",style: UiHelper.mTextStyle16(),)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppConstants.tertiaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
