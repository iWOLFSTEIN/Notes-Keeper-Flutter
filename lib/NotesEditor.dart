import 'package:flutter/material.dart';
import 'package:notes_keeper/file_utils.dart';

class Edit extends StatefulWidget {
  var appBarTitle;
  var titleOfNote;
  var contentOfNote;

  Edit({Key key, this.appBarTitle, this.titleOfNote,this.contentOfNote}) : super(key: key);

  @override
  _EditState createState() => _EditState(appBarTitle, titleOfNote, contentOfNote);
}

class _EditState extends State<Edit> {
   var titleOfNote;
  var contentOfNote;
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var appBarTitle;
  _EditState(this.appBarTitle, this.titleOfNote, this.contentOfNote);

  @override
  void initState() { 
    super.initState();
    titleController.text = titleOfNote;
    contentController.text = contentOfNote;
  }

  Widget alertDialogueMessege(BuildContext context) {
    var alert = AlertDialog(
      content: Text("Saved Successfully!"),

      elevation: 8,

      //  backgroundColor: Colors.cyanAccent,
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      right: (MediaQuery.of(context).size.width * 10) / 100),
                  child: GestureDetector(
                    onTap: () {
                      FileUtilts.saveToFile(
                          titleController.text, contentController.text);
                          // FileUtilts.saveToEndFile(titleController.text);
                      alertDialogueMessege(context);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize:
                              (MediaQuery.of(context).size.width * 4.7) / 100,
                          color: Colors.cyanAccent),
                    ),
                  )))
        ],
        title: Text(appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Title text field
            Padding(
              padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height * 1) / 100,
                left: (MediaQuery.of(context).size.width * 4) / 100,
                right: (MediaQuery.of(context).size.width * 4) / 100,
              ),
              child: TextField(
                keyboardAppearance: Brightness.dark,
                controller: titleController,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: (MediaQuery.of(context).size.width * 4) / 100,
                right: (MediaQuery.of(context).size.width * 4) / 100,
              ),
              child: TextField(
                keyboardAppearance: Brightness.dark,
                controller: contentController,
                maxLines: 150,
                minLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  //  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                    hintText: 'Notes',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      //   fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}
