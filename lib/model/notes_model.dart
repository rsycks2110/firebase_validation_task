class NotesModel{
  String title;
  String desc;
  int notesCreatedAt;
  String? noteID;


  NotesModel({required this.title,required this.desc,required this.notesCreatedAt,noteID});

  factory NotesModel.fromDoc(Map<String,dynamic> map){
    return NotesModel(
        title: map["title"],
        desc: map["desc"],
        notesCreatedAt: map["notesCreatedAt"],
        noteID: map["noteID"]);
  }
 Map<String,dynamic> toDoc(){
    return {
      "title":title,
      "desc":desc,
      "notesCreatedAt":notesCreatedAt,
      "noteID":noteID
    };
  }

}