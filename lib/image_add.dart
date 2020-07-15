
import 'package:create_pdf/pdf_created.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageAdd extends StatefulWidget {
  @override
  _ImageAddState createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  List<File> images =[];


  _addImage(ImageSource source) async{
    var upload =await ImagePicker.pickImage(source:source);
    if(upload != null)
    {
      setState(() {
        images.add(upload);
      });
    }
  }

  Future<File> _cropImage(int index)async{
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: images[index].path,
      aspectRatioPresets: Platform.isAndroid
        ?[
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]:
      [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'crop',
          toolbarColor: Colors.cyan,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if(croppedFile!=null)
      {
          setState(() {
            images[index] = croppedFile;
          });
      }
  }

  _createPdf(){
    return Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return CreatePdf(images);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Images"),),
      body: ListView.builder(itemCount:images.length,
          itemBuilder: (context,int index){
        return MaterialButton(
          padding: EdgeInsets.all(0),
          height: 255,
          onPressed: (){
            _cropImage(index);
          },
          child: Image.file(images[index],width: 250,height: 250,),
        );
      }),
      persistentFooterButtons: [
        FlatButton(
          color: Colors.cyan,
          onPressed:()=> _addImage(ImageSource.gallery),
          child: Text("open Gallery",style: TextStyle(color: Colors.white)),
        ),
        FlatButton(
          color: Colors.cyan,
          onPressed:()=> _addImage(ImageSource.camera),
          child: Text("open camera",style: TextStyle(color: Colors.white)),
        ),
        FlatButton(
          color: Colors.cyan,
          onPressed:()=> _createPdf(),
          child: Text("convert to pdf",style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}
