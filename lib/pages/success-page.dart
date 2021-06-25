import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final id;
  const SuccessPage({Key key, @required String this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Denuncia Creada"),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          return Future.value(false);
        },
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.green[900],
            alignment: Alignment.center,
            child: Text(
              '🎇🎉¡Felicidades!🎇🎉\n\n id: ${this.id}',
              style: new TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
