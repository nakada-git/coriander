import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle;

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してくだ代');
    }
    Firestore.instance.collection('books').add(
      {'title': bookTitle},
    );
  }
}
