import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sample_firebase/models/complaint.dart';
import 'package:sample_firebase/models/file-model.dart';
import 'package:sample_firebase/models/input-exception.dart';
import 'package:sample_firebase/pages/success-page.dart';
import 'package:sample_firebase/services/flutter-fire-service.dart';
import 'package:sample_firebase/widgets/file-card.dart';

class ComplaintPage extends StatefulWidget {
  ComplaintPage({Key key}) : super(key: key);

  @override
  ComplaintPageState createState() => ComplaintPageState();
}

class ComplaintPageState extends State<ComplaintPage> {
  String fullName;
  String email;
  List<FileModel> files = [];
  Size screen;
  final _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(title: Text("📃 Nueva denuncia 📃"), centerTitle: true),
      body: Container(
        padding: new EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        width: screen.width,
        height: screen.height,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Column(
              children: [
                new Text("Datos del denunciante",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
                new SizedBox(
                  height: 20,
                ),
                form(),
              ],
            ),
            new Container(
              constraints: new BoxConstraints(maxWidth: 500),
              height: 60,
              width: screen.width * 0.90,
              child: new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40)),
                ),
                onPressed: sendComplaint,
                child: Text(
                  "Enviar denuncia",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Esta función retorna el formulario para la denuncia
  Widget form() {
    return new Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              new TextFormField(
                decoration: InputDecoration(hintText: "Nombre completo"),
                onChanged: (value) {
                  this.fullName = value;
                  setState(() => null);
                },
                validator: (value) {
                  if (value.length < 1 || value == "" || value == " ") {
                    return "¡Campo vacio!";
                  }
                  return null;
                },
              ),
              new SizedBox(
                height: 15,
              ),
              new TextFormField(
                decoration: InputDecoration(hintText: "Correo electronico"),
                onChanged: (value) {
                  this.email = value;
                  setState(() => null);
                },
                validator: (value) {
                  //Expresion regular para validar el correo electronico
                  bool isValidEmail = new RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value);
                  if (!isValidEmail) {
                    return "¡Correo invalido!";
                  }
                  return null;
                },
              ),
              new SizedBox(
                height: 25,
              ),
              files.length > 0 ? filesList() : Container(height: 0),
              new SizedBox(
                height: files.length > 0 ? 25 : 0,
              ),
              new Container(
                constraints: new BoxConstraints(maxWidth: 500),
                height: 60,
                width: screen.width * 0.90,
                child: new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40)),
                  ),
                  onPressed: addFile,
                  child: Text(
                    "🗃 Añadir archivos 🗃",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget filesList() {
    return new Container(
      constraints: BoxConstraints(
        minHeight: 60,
        maxHeight: 250,
      ),
      child: new ListView.builder(
        shrinkWrap: true,
        physics: new BouncingScrollPhysics(),
        itemCount: files.length,
        itemBuilder: (BuildContext context, int index) {
          return new Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              background: new Container(
                color: Colors.red[200],
                child: Center(
                  child: Text(
                    "Eliminar",
                    style: new TextStyle(fontSize: 35),
                  ),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  files.removeAt(index);
                });
              },
              child: FileCard(file: files[index]));
        },
      ),
    );
  }

  Future<void> addFile() async {
    FilePickerResult userFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (userFile != null) {
      this.files.add(new FileModel(userFile));
      setState(() => null);
    }
  }

  Future<void> sendComplaint() async {
    SnackBar snackbar = new SnackBar(
      content: new Text("...Enviando denuncia 🆗"),
      backgroundColor: Colors.green,
    );
    try {
      if (!_formKey.currentState.validate()) {
        throw new InputException("¡Campos de texto invalidos! 🥶");
      }
      final fireService = new FlutterFireService();
      final complaint = new Complaint(
          fullName: this.fullName, email: this.email, files: this.files);
      await fireService.init();
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      final id = await fireService.uploadComplaint(complaint);
      /* Es necesario cambiar de pagina de esta forma
      porque se tiene que mandar el id como parametro */
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => SuccessPage(id: id)));
    } on InputException catch (err) {
      snackbar = new SnackBar(
        content: new Text(err.toString()),
        backgroundColor: Colors.red[400],
      );
    } on FirebaseException catch (error) {
      log(error.toString());
      snackbar = new SnackBar(
        content: new Text('Error al intentar generar denuncia 😲 [${error.code}]'),
        backgroundColor: Colors.deepOrange[900],
      );
    } catch (_) {
      snackbar = new SnackBar(
        content: new Text("...Lo sentimos hubo un error 😪"),
        backgroundColor: Colors.deepPurple,
      );
    } finally {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
