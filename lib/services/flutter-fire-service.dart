import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fbStorage;
import 'package:sample_firebase/models/complaint.dart';
import 'package:sample_firebase/models/file-model.dart';

class FlutterFireService {
  CollectionReference _db;
  fbStorage.FirebaseStorage _storage;
  bool _isNotInit = true;
  static FlutterFireService _instace = FlutterFireService._internal();
  factory FlutterFireService() {
    return _instace;
  }
  FlutterFireService._internal();

  Future<void> init() async {
    if (_isNotInit) {
      await Firebase.initializeApp();
      _db = FirebaseFirestore.instance.collection('complaints');
      _storage = fbStorage.FirebaseStorage.instance;
      _isNotInit = false;
    }
  }

  Future<String> uploadComplaint(Complaint complaint) async {
    try {
      List<FileModel> files = complaint.files;
      String id =
          '${complaint.fullName.substring(0, 3)}-${new DateTime.now().toIso8601String()}';
      await _db.doc(id).set(complaint.asMap());
      if (files != null) {
        for (int i = 0; i < files.length; i++) {
          await _storage.ref(id).child(files[i].name).putData(files[i].fielUI8);
        }
      }
      return id;
    } catch (error) {
      throw error;
    }
  }
}
