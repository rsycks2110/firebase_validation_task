import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_validation_task/constants/app_constants.dart';
import 'package:firebase_validation_task/firebase/firebase_provider.dart';
import 'package:flutter/material.dart';

import '../model/notes_model.dart';
import '../utils/ui_helper.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NotesModel> listNotes=[];
  List<String> weekDays=[
    "Mon","Tue","Wed","Thu","Fri","Sat","Sun"
  ];

  TextEditingController titleController=TextEditingController();

  TextEditingController descController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Notes"),
      ),

      body:StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
          stream: FirebaseProvider.fetchAllNotes(),
        builder: (context,snapshots) {
            listNotes.clear();
            for(QueryDocumentSnapshot<Map<String, dynamic>> eachDoc in snapshots.data!.docs) {
              listNotes.add(NotesModel.fromDoc(eachDoc.data()));
            }
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return listNotes.isNotEmpty ? ListView.builder(
              itemCount: listNotes.length,
              itemBuilder: (context, index) {
                var time = DateTime.fromMillisecondsSinceEpoch(
                    listNotes[index].notesCreatedAt);
                var dayCreatedAt = time.day;
                var weekDayCreatedAt = time.weekday;
                var timeCreatedAt = "${time.hour}:${time.minute}";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(context: context, builder: (
                            context) {
                          return bottomSheetContent(
                              mIndex: index, isUpdate: true);
                        });
                      },
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: Column(
                            children: [
                              Text(weekDays[weekDayCreatedAt - 1]),
                              Text("${dayCreatedAt}")
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppConstants.highLightColor.withOpacity(
                                  0.2)
                          ),
                        ),
                        title: Text(listNotes[index].title??""),
                        subtitle: Text(timeCreatedAt ?? ""),
                        trailing: InkWell(
                            onTap: () {
                              FirebaseProvider.deleteNotes(listNotes[index]);
                              setState(() {});
                            },
                            child: Icon(Icons.delete)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(listNotes[index].desc??""),
                    )
                  ],
                );
              },) : Center(child: Text("No Notes Added..", style: UiHelper.mTextStyle20(),));
          },),


      floatingActionButton: FloatingActionButton(onPressed: (){
        titleController.clear();
        descController.clear();
        setState(() {

        });
        showModalBottomSheet(context: context, builder: (context){

          return Padding(
            padding:  EdgeInsets.only(left: 11,right: 11,top: 11,bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 25,),
                  UiHelper.CustomTextField(mController: titleController, mText: "Enter Title Here",),
                  SizedBox(height: 20,),
                  TextField(
                    controller: descController,
                    minLines: 4,
                    maxLines: 7,
                    decoration: InputDecoration(
                      fillColor: AppConstants.textFillColor,
                      filled: true,
                      hintText: "Enter Description Here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: (){
                        var Note = NotesModel(
                            title: titleController.text.toString(),
                            desc: descController.text.toString(),
                            notesCreatedAt: DateTime.now().millisecondsSinceEpoch);

                          FirebaseProvider.addNotes(Note);
                        Navigator.pop(context);
                      },
                        child: Text( "Add",style: UiHelper.mTextStyle20(mColor: AppConstants.secondaryColor),),style: ElevatedButton.styleFrom(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),backgroundColor: AppConstants.tertiaryColor),),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Cancel",style: UiHelper.mTextStyle20(mColor: AppConstants.secondaryColor)),style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.tertiaryColor, shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),),
                      )],)


                ],
              ),
              height: MediaQuery.of(context).size.height/2 + MediaQuery.of(context).viewInsets.bottom,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
          );
        },);

      },child: Icon(Icons.add),),
    );
  }

 Widget bottomSheetContent({bool isUpdate=false,int mIndex=-1}){

    return Padding(
      padding:  EdgeInsets.only(left: 11,right: 11,top: 11,bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height/2 + MediaQuery.of(context).viewInsets.bottom,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 25,),
            UiHelper.CustomTextField(mController: titleController, mText: "Enter Title Here",),
            SizedBox(height: 20,),
            TextField(
              controller: descController,
              minLines: 4,
              maxLines: 7,
              decoration: InputDecoration(
                fillColor: AppConstants.textFillColor,
                filled: true,
                hintText: "Enter Description Here",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(width: 0,color: AppConstants.textFillColor)
                ),
              ),
            ),

            SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: () {
                  var Note = NotesModel(
                      noteID: listNotes[mIndex].noteID,
                      title: titleController.text.toString(),
                      desc: descController.text.toString(),
                      notesCreatedAt: DateTime.now().millisecondsSinceEpoch);
                  FirebaseProvider.updateNotes(Note);
                  Navigator.pop(context);
                },
                  child: Text( "Update",style: UiHelper.mTextStyle20(mColor: AppConstants.secondaryColor),),style: ElevatedButton.styleFrom(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),backgroundColor: AppConstants.tertiaryColor),),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel",style: UiHelper.mTextStyle20(mColor: AppConstants.secondaryColor)),style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.tertiaryColor, shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),),
                )],)


          ],
        ),
      ),
    );
  }
}
