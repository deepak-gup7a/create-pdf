import 'package:create_pdf/image_add.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.white70,
              child: Text("create new"),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return ImageAdd();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
