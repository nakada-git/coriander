import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///C:/Users/daiki/Desktop/coriander/lib/domain/book.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final docs = await Firestore.instance.collection('books').getDocuments();
    final books = docs.documents.map((doc) => Book(doc['title'])).toList();
    this.books = books;
    notifyListeners();
  }
}
