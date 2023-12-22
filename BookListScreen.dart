import 'package:flutter/material.dart';
import 'package:your_app_name/api_service.dart';
import 'package:your_app_name/book_detail_screen.dart';
import 'package:your_app_name/book.dart';

class BookListScreen extends StatefulWidget {
 final String title;

 BookListScreen({Key key, this.title}) : super(key: key);

 @override
 _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
 List<Book> _books = [];
 int _page = 1;
 String _searchText = '';
 bool _isLoading = true;

 @override
 void initState() {
    super.initState();
    fetchBooks();
 }

 Future<void> fetchBooks() async {
    final apiService = ApiService();
    final books = await apiService.fetchBooks();

    setState(() {
      _books = books;
      _isLoading = false;
    });
 }

 Future<void> _refreshBooks() async {
    await Future.delayed(Duration(seconds: 2));
    fetchBooks();
 }

 void _searchBooks(String query) {
    setState(() {
      _searchText = query;
    });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String query = await showSearch(context: context, delegate: BookSearchDelegate(_books));
              if (query != null) {
                _searchBooks(query);
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshBooks,
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (BuildContext context, int index) {
                 final book = _books[index];
                 if (_searchText.isNotEmpty && book.title.toLowerCase().contains(_searchText.toLowerCase()) == false && book.author.toLowerCase().contains(_searchText.toLowerCase()) == false) {
                    return Container();
                 }
                 return ListTile(
                    leading: Image.network(book.imageUrl),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                 );
                },
              ),
            ),
    );
 }
}

class BookSearchDelegate extends SearchDelegate<String> {
 final List<Book> _books;

 BookSearchDelegate(this._books);

 @override
 List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
 }

 @override
 Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
 }

 @override
 Widget buildResults(BuildContext context) {
    return Container();
 }

 @override
 Widget buildSuggestions(BuildContext context) {
    final filteredBooks = _books.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase()) || book.author.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredBooks.length,
      itemBuilder: (BuildContext context, int index) {
        final book = filteredBooks[index];
        return ListTile(