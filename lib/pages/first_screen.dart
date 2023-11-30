import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen ({super.key});
  bool permitted=false;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: TextButton(
           // make the function async
           onPressed: () async {
             // ### Add the next 2 lines ###
             final permitted = await PhotoManager.requestPermissionExtend();
             if (permitted==true){
               return;
             }
             // ######
             Navigator.of(context).push(
               MaterialPageRoute(builder: (_) => Gallery()),
             );
           },
           child: Text('Open Gallery'),
       ),
     );
  }
}
