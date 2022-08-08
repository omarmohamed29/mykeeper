import 'package:mokhatat/data/model/book_shelf.dart';
import 'package:mokhatat/data/repository/shared_prefs.dart';
import 'package:mokhatat/data/webservice/book_shelf_webservice.dart';

class BookShelfRepo {
  final Sharedprefs sharedprefs;
  final BookShelfWebService bookShelfWebService;

  BookShelfRepo(this.sharedprefs, this.bookShelfWebService);

  Future<dynamic> retrieveData() async {
    final retrievedData = await bookShelfWebService.retrieveBook();
    if (retrievedData.isEmpty) {
      return {};
    } else {
      List<BookShelf> getData = [];
      List<BookShelf> bookShelf = [];
      retrievedData.forEach((id, value) {
        getData.add(BookShelf(
            id: id,
            bookName: value['book_name'],
            author: value['author'],
            category: value['category']));
      });
      bookShelf = getData.toList();
      return bookShelf;
    }
  }
}
