import 'package:flutter/material.dart';
import 'package:sample_firebase/models/file-model.dart';

class FileCard extends StatelessWidget {
  final FileModel file;
  const FileCard({Key key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      height: 100,
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "📄",
                    style: new TextStyle(fontSize: 40),
                  )),
              Expanded(
                flex: 3,
                child: textData(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Tipo: ' + file.type,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Nombre: ' + file.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Peso: ${file.size.toStringAsFixed(2)} Mb',
          ),
        ),
      ],
    );
  }
}
