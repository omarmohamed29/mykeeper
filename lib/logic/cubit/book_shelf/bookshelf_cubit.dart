import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokhatat/data/model/book_shelf.dart';

import 'package:mokhatat/data/repository/book_shelf_repository.dart';
import 'package:mokhatat/data/webservice/book_shelf_webservice.dart';

part 'bookshelf_state.dart';

class BookshelfCubit extends Cubit<BookshelfState> {
  final BookShelfWebService bookShelfWebService;
  final BookShelfRepo bookShelfRepo;

  BookshelfCubit(
    this.bookShelfWebService,
    this.bookShelfRepo,
  ) : super(BookshelfInitial());

  Future<void> retrieveBookshelfData() async {
    await bookShelfRepo.retrieveData().then((data) {
      if (data.toString() == {}.toString()) {
        emit(BookshelfError('you havent set your Bookshelf yet!'));
      } else {
        emit(BookshelfRetrieved(data));
      }
    });
  }

  Future<void> addBookshelfData(
      String bookName, String author, String category) async {
    await bookShelfWebService
        .addBookData(bookName, author, category)
        .then((response) {
      if (response) {
        emit(BookshelfDataAdded('your Book data has been added successfully'));
      } else {
        emit(BookshelfError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> editBookshelfData(
      String bookName, String author, String category, String id) async {
    await bookShelfWebService
        .editBookData(bookName, author, category, id)
        .then((response) {
      if (response) {
        emit(BookshelfDataEdit(
            'your Bookshelf data has been edited successfully'));
      } else {
        emit(BookshelfError('Something went wrong please try again later'));
      }
    });
  }

  Future<void> deleteBookshelfData(String id) async {
    await bookShelfWebService.deleteBook(id).then((response) {
      if (response) {
        emit(BookshelfDataDeleted('Book deleted successfully'));
      } else {
        emit(BookshelfError('Something went wrong please try again later'));
      }
    });
  }
}
