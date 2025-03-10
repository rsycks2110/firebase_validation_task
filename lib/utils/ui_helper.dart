import 'package:firebase_validation_task/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{

 static  mTextStyle16({mFontSize=14,mFontWeight=FontWeight.w500,mColor=Colors.black,mDecoration=TextDecoration.none}){
    return TextStyle(
      color: mColor,
      fontSize: mFontSize,
      fontWeight: mFontWeight,
      decoration: mDecoration
    );
  }

 static mTextStyle20({mFontSize=20,mFontWeight=FontWeight.bold,mColor=Colors.black}){
    return TextStyle(
        color:mColor,
        fontSize: mFontSize,
        fontWeight: mFontWeight
    );
  }
  static CustomTextField({required mController,required mText,mSuffixIcon,mObscureText=false,mMaxLines=7,mMinLines=4}){
   return SizedBox(height: 35,
     child: TextField(
       controller: mController,
       obscureText: mObscureText,
       decoration: InputDecoration(
         filled:true,
         fillColor: AppConstants.textFillColor,
         hintText: mText,
         hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),
         suffixIcon: mSuffixIcon,
         // border: OutlineInputBorder(
         //   borderRadius: BorderRadius.circular(5),
         //   borderSide: BorderSide(color: AppConstants.textFillColor,width: 2,)
         // ),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(5),
             borderSide: BorderSide(color: AppConstants.textFillColor,width: 2,)
         ),
         focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(5),
             borderSide: BorderSide(color: AppConstants.textFillColor,width: 2,)
         ),
         disabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(5),
             borderSide: BorderSide(color: AppConstants.textFillColor,width: 2,)
         )
       ),
     ),
   );
  }

}