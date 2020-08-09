import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    final imageURL = await _uploadImageFile();

    Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'imageURL': imageURL,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateBook(Book book) async {
    final imageURL = await _uploadImageFile();

    final document =
        Firestore.instance.collection('books').document(book.documentID);
    await document.updateData(
      {
        'title': bookTitle,
        'imageURL': imageURL,
        'updateAt': Timestamp.now(),
      },
    );
  }

  Future<String> _uploadImageFile() async {
    if (imageFile == null) {
      return '';
    }
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('books').child(bookTitle);
    final snapshot = await ref
        .putFile(
          imageFile,
        )
        .onComplete;
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
