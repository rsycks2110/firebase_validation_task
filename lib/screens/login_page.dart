import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_validation_task/constants/app_constants.dart';
import 'package:firebase_validation_task/screens/forgot_password.dart';
import 'package:firebase_validation_task/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ui_helper.dart';
import 'home_page.dart';

class LogInPage extends StatelessWidget{

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Center(child: Text("Login",style:UiHelper.mTextStyle20(),)),
                  SizedBox(height: 10,),

                  Text("Email",style: UiHelper.mTextStyle16(),),
                  SizedBox(height: 10),
                  UiHelper.CustomTextField(mController: emailController, mText: "Enter Your  Email"),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Text("Password",style: UiHelper.mTextStyle16(),),
                  SizedBox(height: 10),
                  UiHelper.CustomTextField(mController: passwordController, mText: "Enter Your Password",mObscureText: true),
                  SizedBox(height: 10),
                  SizedBox(height: 25,),

                  SizedBox(
                    height: 40,
                    child: ElevatedButton(onPressed: () async{
                      UserCredential? userCredential;
                      String email=emailController.text.toString();
                      String password=passwordController.text.toString();
                      if(email==""||password==""){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter All The Fields Correctly.')));
                      }else{
                        try{
                          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                        userCredential= await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
                      final SharedPreferences prefs= await SharedPreferences.getInstance();
                          prefs.setBool("isLoggedIn", true);
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return HomePage();
                          }));
                        } on FirebaseAuthException catch(e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email.')));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password provided for that user.')));
                          } else if(e.code=='invalid-email'){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Given Email Is Invalid.')));
                          }
                        }
                      }

                    }, child: Text("Login",style: UiHelper.mTextStyle16(mColor:AppConstants.secondaryColor),),
                      style: ElevatedButton.styleFrom(backgroundColor: AppConstants.tertiaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ForgotPassword();
                          }));
                        },
                          child: Text("Forgot Password",style: UiHelper.mTextStyle16(mColor:AppConstants.tertiaryColor,mDecoration: TextDecoration.underline),)),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SignUpPage();
                          }));
                        },
                          child: Text("Not Registered Yet, Register From Here ",style: UiHelper.mTextStyle16(mColor:AppConstants.highLightColor,mDecoration: TextDecoration.underline),)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

}
