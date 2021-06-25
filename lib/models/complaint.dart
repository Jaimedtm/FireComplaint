import 'package:sample_firebase/models/file-model.dart';

class Complaint {
  String fullName;
  String email;
  List<FileModel> files;

  Complaint({this.fullName, this.email, this.files = const []});

  Map<String, dynamic> asMap() {
    return {
      "fullName": this.fullName,
      "email": this.email,
      "hasFiles": this.files.length > 0 ? true : false
    };
  }
}
