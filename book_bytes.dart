import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'book.dart';

class BookDetailsScreen extends StatelessWidget {
 final Book book;

 BookDetailsScreen({this.book});

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.network(book.imageUrl),
              ),
            ),
            Text(
              'Author: ${book.author}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Price: ${book.price}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Description: ${book.description}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
 }
}