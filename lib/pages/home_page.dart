import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_rider/pages/picture_preview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        onPressed: ()async{
          XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
          setState(() {
            image = File(pickedImage!.path);

          });
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PicturePreview(
            image: image,

          )));

        },
        backgroundColor: Colors.black.withOpacity(0.8),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined,size: 50,),
            Text("Tack picture",style: TextStyle(fontSize: 8),)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const NetworkImage("https://i.pinimg.com/736x/32/97/95/3297956bc29c18cd93c127f774a8b260.jpg"),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 50,),
            const Text("Urban Rider",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),

          ],
        ),
      ),

    );
  }
}
