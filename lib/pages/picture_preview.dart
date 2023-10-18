import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urban_rider/pages/map.dart';

class PicturePreview extends StatefulWidget {
  final File? image;
  const PicturePreview({Key? key, required this.image}) : super(key: key);

  @override
  State<PicturePreview> createState() => _PicturePreviewState();
}

class _PicturePreviewState extends State<PicturePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.withOpacity(0.55),
                border: Border.all(width: 3)
              ),
              child: widget.image==null? Text("there is no image"):Image.file(
                widget.image!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3)
                    ),
                    child: Center(child: Text("Retake",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MapPage()));

                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.4,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3),
                      color: Colors.black
                    ),
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Start Ride",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                        Icon(Icons.arrow_forward_outlined,color: Colors.white,)
                      ],
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),

    );
  }
}
