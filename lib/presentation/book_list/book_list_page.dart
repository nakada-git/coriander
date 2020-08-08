import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/presentation/add_books/add_book_page.dart';
import 'package:coriander/presentation/book_list/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTitles = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                  ),
                )
                .toList();
            return ListView(
              children: listTitles,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBookPage(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
