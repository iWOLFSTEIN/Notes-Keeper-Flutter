import 'package:flutter/material.dart';
import 'package:notes_keeper/file_utils.dart';

import 'NotesEditor.dart';

class Notes extends StatefulWidget {
  Notes({Key key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
 
  @override
  List listTitles ;
  List dateAndTime;
 
Future<List> listTitlesMedthod() async{
     listTitles = await FileUtilts.myFuction();
     return listTitles;
}


  var _drawerAnimation = false;

   // Snack bar here
  void mySnackBar(BuildContext context) {
    var snackBar = SnackBar(
      duration: Duration(milliseconds: 1000),
      backgroundColor: Colors.cyanAccent,
      elevation: 8,
      content: Text(
        "Item is deleted!",
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         _drawerAnimation = !_drawerAnimation;
        //       });
        //     },
        //     child: Icon(Icons.dehaze)),
        title: Text("Notes"),
      ),
      body: Container(

          // Stack that contains the user defined drawer and list view
          child: Row(
        children: <Widget>[
          // Animated container treated as drawer
          // Card(
          //   elevation: 8,
          //   child: AnimatedContainer(
          //     child: (_drawerAnimation == false)
          //         ? null
          //         : Column(
          //             children: <Widget>[
          //               Container(
          //                 padding: EdgeInsets.only(
          //                     top: (MediaQuery.of(context).size.height * 5) /
          //                         100),
          //                 width: (MediaQuery.of(context).size.width * 40) / 100,
          //                 child: RaisedButton(
          //                   color: Colors.white,
          //                   elevation: 10,
          //                   onPressed: () {},
          //                 ),
          //               ),
          //               Container(
          //                 width: (MediaQuery.of(context).size.width * 40) / 100,
          //                 child: RaisedButton(
          //                   color: Colors.white,
          //                   elevation: 10,
          //                   onPressed: () {},
          //                 ),
          //               )
          //             ],
          //           ),
          //     curve: Curves.easeInCirc,
          //     duration: Duration(milliseconds: 200),
          //     color: Colors.cyanAccent,
          //     height: MediaQuery.of(context).size.height,
          //     width: (_drawerAnimation)
          //         ? MediaQuery.of(context).size.width / 2.3
          //         : 0,
          //   ),
          // ),

          // ListView that contains the notes
          Expanded(
            child: FutureBuilder(

                         future: listTitlesMedthod(),
                          builder: (context, AsyncSnapshot snapshot){
                            return ListView.builder(
                  itemCount: snapshot.data[0].length,
                  itemBuilder: (context, item) {

                   // Dimissible widget to swipe delete the notes
                    return Dismissible(
                      key: UniqueKey(),
                      //Key(listTitles[item]),

                      // Background from left to right
                      background: Card(
                        color: Colors.cyanAccent,
                        elevation: 8,
                        child: ListTile(
                          leading: Container(
                            margin: EdgeInsets.only(
                                top: (MediaQuery.of(context).size.height * 2) /
                                    100),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.delete, color: Colors.cyanAccent)),
                          ),
                        ),
                      ),

                      // background from right to left
                      secondaryBackground: Card(
                        color: Colors.cyanAccent,
                        elevation: 8,
                        child: ListTile(
                            trailing: Container(
                          margin: EdgeInsets.only(
                              top:
                                  (MediaQuery.of(context).size.height * 2) / 100),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.delete, color: Colors.cyanAccent)),
                        )),
                      ),

                      onDismissed: (direction) {
                        mySnackBar(context);
                         FileUtilts.deleteFile(snapshot.data[0][item]);
                        //  FileUtilts.deleteEndFile(snapshot.data[item]);
                      },

                      // Notes that are created by the user
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.cyanAccent,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )),
                          title:  Text(
                              "${snapshot.data[0][item]}",
                              style: TextStyle(color: Colors.white),
                            
                          ),
                          subtitle: Text(
                              "${snapshot.data[1][item]}",
                              style: TextStyle(color: Colors.white),
                            ),
                         
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Edit(
                                appBarTitle: "Update",
                                titleOfNote: snapshot.data[0][item],
                                contentOfNote: snapshot.data[2][item],
                              );
                            }));
                          },
                        ),
                      ),
                    );
                  });
                           } ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyanAccent,
          child: Icon(
            Icons.create,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Edit(
                appBarTitle: "Create",
              );
            }));
            setState(() {
              _drawerAnimation = false;
             
             
            });
          }),
    );
  }
}
