class BookShelf {
  late String id;
  late String bookName;
  late String author;
  late String category;

  BookShelf({
    required this.id,
    required this.bookName,
    required this.author,
    required this.category,
  });

  BookShelf.fromJson(Map<String,dynamic> json){
    bookName = json['book_name'];
    author = json['author'];
    category = json['category'];
  }
  
}
