import 'package:flutter/material.dart';
import 'MyNotes.dart';

void main() => runApp(
  MyApp()
  );

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
       
        theme: ThemeData(
          brightness: Brightness.dark
        ),
        home: Notes()
      ),
    );
  }
}