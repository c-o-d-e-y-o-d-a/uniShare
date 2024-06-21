import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if(video != null){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        )));
    }
  }

  showOptionDialog(BuildContext context){
    return showDialog(
     context: context,
     builder: (context) => SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () => pickVideo(ImageSource.gallery, context),
          child: 
          Row(
            children: [
              Icon(Icons.image),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 20.0
                    ),)

              
              )

          ],)
        ),

        SimpleDialogOption(
                    onPressed: () => pickVideo(ImageSource.camera, context),
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Camera',
                              style: TextStyle(fontSize: 20.0),
                            ))
                      ],
                    )),

                     SimpleDialogOption(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Row(
                      children: [
                        Icon(Icons.cancel),
                        Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 20.0),
                            ))
                      ],
                    ))
      ],
     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: 
      InkWell(
        onTap: () {
          showOptionDialog(context);


        },
        child: Container(
          width: 190,
          height:50,
          decoration: BoxDecoration(color:Colors.yellow),
          child: const Center(
            child:Text(
              'Add Video',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),

            ),
          ),
        ),
      ),
    ));
  }
}
