class Book {
 final int id;
 final String title;
 final String author;
 final String imageUrl;
 final String price;
 final String description;

 Book({
    this.id,
    this.title,
    this.author,
    this.imageUrl,
    this.price,
    this.description,
 });

 factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      description: json['description'],
    );
 }
}