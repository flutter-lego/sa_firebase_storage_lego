import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../../../main.dart';

import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NewFirebaseStorage {
  ////////////// config ////////////////////
  // firebase storage bucket
  FirebaseStorage storage = FirebaseStorage.instance; // option 1: default
  // FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: 'secondary-storage-bucket'); // option 2: different bucket

  // firebase storage path
  static Reference _ref() {
    return FirebaseStorage.instance.ref("NewStorage");
  }

  ////////////////////////////////////////

  static Future<Uint8List?> get(String fileName) async {
    try {
      Uint8List? data = await _ref().child(fileName).getData();
      return data;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> set(String fileName, Uint8List data) async {
    try {
      var result = await _ref().child(fileName).putData(data);
      return result.toString();
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> delete(String fileName) async {
    try {
      await _ref().child(fileName).delete();
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getDownloadURL(String fileName) async {
    try {
      String url = await _ref().child(fileName).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}
