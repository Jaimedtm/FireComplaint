import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static const String title = "🎉 Flutter Complaint 🎉";

  @override
  Widget build(BuildContext context) {
    /* Con la query obtenemos las dimensiones de pantalla.
       Esta variable suele ser util para hacer UI Responsive
    */
    Size screen = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      /* Este es el contenedor principal por ende debe usar todo
       el ancho y alto disponible*/
      body: new Container(
        padding: new EdgeInsets.all(15),
        width: screen.width,
        height: screen.height,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text(
              "🚨🚨Denuncia🚨🚨",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
            ),
            new FlutterLogo(
              size: screen.height / 4,
            ),
            new Container(
              constraints: new BoxConstraints(maxWidth: 500),
              height: 60,
              width: screen.width * 0.85,
              child: new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40)),
                ),
                onPressed: () => Navigator.of(context).pushNamed("complaint"),
                child: Text(
                  "🚔🚔 Nueva denuncia 🚔🚔",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
