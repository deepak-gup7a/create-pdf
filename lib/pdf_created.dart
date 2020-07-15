import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class CreatePdf extends StatefulWidget {
  List<File>images;
  CreatePdf(this.images);
  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdf> {
  final pdf = pw.Document();
  _showPdf(List<File> images)
  {
      for(int i=0;i<images.length;i++)
        {
          final image = PdfImage.file(pdf.document,bytes: File(images[i].path).readAsBytesSync());
            pdf.addPage(
              pw.Page(
                build: (pw.Context context){
                  return pw.Center(
                    child: pw.Image(image),
                  );
                }
              )
            );
        }
      //savePdf();
  }

  @override
  void initState() {
    super.initState();
    _showPdf(widget.images);
  }

  Future savePdf()async{
    var dir = await getExternalStorageDirectory();
    var path = dir.path+'/example.pdf';
    print(dir);
    final file = File(path);
    await file.writeAsBytes(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pdf==null?Text("Loading.."):MaterialButton(
          child: Text("done"),
          onPressed:()=> savePdf(),
        ),
      ),
    );
  }
}
