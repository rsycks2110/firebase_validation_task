import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_validation_task/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../utils/ui_helper.dart';

class SignUpPage extends StatelessWidget{

TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController genderController=TextEditingController();
TextEditingController passwordController=TextEditingController();
TextEditingController rePasswordController=TextEditingController();

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
              Center(child: Text("Register",style:UiHelper.mTextStyle20(),)),
              SizedBox(height: 10,),
              Text("Name",style: UiHelper.mTextStyle16(),),
              SizedBox(height: 10),
              UiHelper.CustomTextField(mController: nameController, mText: "Enter Your Name"),
              SizedBox(height: 10),
              Text("Email",style: UiHelper.mTextStyle16(),),
              SizedBox(height: 10),
              UiHelper.CustomTextField(mController: emailController, mText: "Enter Your  Email"),
              SizedBox(height: 10),
              Text("Gender",style: UiHelper.mTextStyle16(),),
                        SizedBox(height: 10),
              UiHelper.CustomTextField(mController: genderController, mText: "Enter Your Gender"),
              SizedBox(height: 10),
              Text("Password",style: UiHelper.mTextStyle16(),),
              SizedBox(height: 10),
              UiHelper.CustomTextField(mController: passwordController, mText: "Enter Your Password",mObscureText: true),
              SizedBox(height: 10),
              Text("RePassword",style: UiHelper.mTextStyle16(),),
              SizedBox(height: 10),
              UiHelper.CustomTextField(mController: rePasswordController, mText: "Re Enter Your Password",mObscureText: true),
               SizedBox(height: 25,),
                        Container(height: 2,width: double.infinity,color: AppConstants.primaryColor,),
                        SizedBox(height: 25,),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(onPressed: () async{
                            UserCredential? userCredential;
                            String name=nameController.text.toString();
                            String email=emailController.text.toString();
                            String gender=genderController.text.toString();
                            String password=passwordController.text.toString();
                            String rePassword=rePasswordController.text.toString();
                          FirebaseAuth firebaseAuth=FirebaseAuth.instance;
                          if(name==""||gender==""||email== "" || password == ""){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter All The Fields ')));
                          }
                           else if(password!=rePassword){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Didn't Match")));
                            }
                          else{
                          try {
                     userCredential= await firebaseAuth.createUserWithEmailAndPassword(
                                email: email, password: password);
                          } on FirebaseAuthException catch(e){
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password provided is too weak.')));
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email.')));
                            } else if(e.code=="invalid-email"){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The Email You Entered Is Invalid')));
                            }
                          } catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }}
                          if(userCredential!.user!.uid!=null) {
                                     FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
                                 DocumentReference<Map<String, dynamic>> notes =  firebaseFireStore.collection("users").doc("${userCredential!.user!.uid}");
                            var docRef = notes.set(
                                   {
                                     "name":name,
                                     "email":email,
                                     "gender":gender,
                                   }
                                 );
                          }
                          }, child: Text("Register",style: UiHelper.mTextStyle16(mColor:AppConstants.secondaryColor),),
                          style: ElevatedButton.styleFrom(backgroundColor: AppConstants.tertiaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),),
                        )
                      ],
                    ),
            ),
          )),
    );
  }

}
