part of 'bookshelf_cubit.dart';

@immutable
abstract class BookshelfState {}

class BookshelfInitial extends BookshelfState {}

class BookshelfRetrieved extends BookshelfState {
  final List<BookShelf> bookShelf;

  BookshelfRetrieved(this.bookShelf);
}

class BookshelfError extends BookshelfState {
  final String error;

  BookshelfError(this.error);
}

class BookshelfDataEdit extends BookshelfState {
  final String response;

  BookshelfDataEdit(this.response);
}

class BookshelfDataAdded extends BookshelfState {
  final String response;

  BookshelfDataAdded(this.response);
}

class BookshelfDataDeleted extends BookshelfState {
  final String response;

  BookshelfDataDeleted(this.response);
}
