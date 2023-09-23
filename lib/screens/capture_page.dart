
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'package:my_meal/assets/images/image_constants.dart';
import 'package:my_meal/screens/message_page.dart';
import 'package:my_meal/theme/pallete.dart';
import 'package:my_meal/widgets/circle_btn.dart';

class CapturePage extends StatefulWidget {

  static route() => MaterialPageRoute(builder: (context) => const CapturePage());

  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {

  File? image;

  Future captureImage() async {

    try{
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) {
        return null;
      }

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print("Failed to capture image: $e");
    }
  }

  Future imgUpload() async {

    await Firebase.initializeApp();
    final storageRef = FirebaseStorage.instance.ref();

    final imgRef = storageRef
        .child("images")
        .child(DateTime.now().toIso8601String());

    try{
      await imgRef.putFile(image!).snapshotEvents.listen((event) {

        ProgressDialog progressDialog = ProgressDialog(context: context);

        switch (event.state) {
          case TaskState.running:
            progressDialog.show(msg: "Sharing meal");
            break;
          case TaskState.paused:
            break;
          case TaskState.success:

            progressDialog.close();

            Navigator.pushReplacement(context, MessagePage.route());

            break;
          case TaskState.canceled:

            progressDialog.close();
            break;
          case TaskState.error:

            progressDialog.close();

            CherryToast(
              title: const Text(
                "Sorry, we have encountered an error.",
                style: TextStyle(
                  fontFamily: "Andika",
                ),
              ),
              icon: Icons.error,
              iconColor: Colors.red,
              themeColor: Pallete.accentColor,
              borderRadius: 10,
              toastPosition: Position.bottom,
              animationType: AnimationType.fromBottom,
            ).show(context);

            break;
        }
      });
    } on FirebaseException catch (e) {
      print("Upload failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              left: 20,
              bottom: 30,
            ),
            child: CircleButton(
              width: 45,
              height: 45,
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 26,
                color: Pallete.primaryColor,
              ),
              callBack: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              ImageConstants.animal,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color.fromRGBO(244, 244, 244, 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        ImageConstants.cutlery,
                      ),
                      Image.asset(
                        ImageConstants.corners,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: image != null ? Image.file(
                          image!,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ) : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Pallete.imageBgColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Text(
                    image != null ? "Will you eat this?" : "Click your meal",
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Andika",
                    ),
                  ),
                  const SizedBox(height: 30,),
                  CircleButton(
                    height: 64,
                    width: 64,
                    icon: Icon(
                      image != null ? Icons.check : Icons.camera_alt,
                      size: 36,
                      color: Pallete.primaryColor,
                    ),
                    callBack: () {
                      image != null ? imgUpload() : captureImage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
