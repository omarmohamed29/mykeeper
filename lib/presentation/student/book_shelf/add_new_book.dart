import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/book_shelf/bookshelf_cubit.dart';

class AddNewBook extends StatefulWidget {
  const AddNewBook({Key? key}) : super(key: key);

  @override
  State<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _bookData = {
    'book_name': '',
    'author': '',
    'category': '',
  };
  bool _isLoading = false;

  Future<void> _uploadBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await BlocProvider.of<BookshelfCubit>(context).addBookshelfData(
            _bookData['book_name'].toString(),
            _bookData['author'].toString(),
            _bookData['category'].toString());
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookshelfCubit, BookshelfState>(
      listener: (context, state) {
        if(state is BookshelfDataAdded){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFD18B81),
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Add a favourite book',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD18B81),
                fontFamily: 'ubuntu',
                fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Book Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'ubuntu',
                            fontSize: 20)),
                    TextFormField(
                      cursorColor: const Color(0xFFD18B81),
                      style: const TextStyle(
                        fontFamily: 'ubuntu',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid name';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _bookData['book_name'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "Enter the book name ",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.grey,
                              fontSize: 12.0)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Author",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'ubuntu',
                            fontSize: 20)),
                    TextFormField(
                      cursorColor: const Color(0xFFD18B81),
                      style: const TextStyle(
                        fontFamily: 'ubuntu',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid author name';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _bookData['author'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "who wrote this book?",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.grey,
                              fontSize: 12.0)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'ubuntu',
                            fontSize: 20)),
                    TextFormField(
                      cursorColor: const Color(0xFFD18B81),
                      style: const TextStyle(
                        fontFamily: 'ubuntu',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid category';
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _bookData['category'] = input.toString();
                      },
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD18B81))),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: "which category this book belongs to ! ",
                          hintStyle: TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.grey,
                              fontSize: 12.0)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: MaterialButton(
                      onPressed: _uploadBook,
                      color: const Color(0xFFD18B81),
                      height: 50,
                      minWidth: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                      hoverColor: const Color(0xFFD18B81),
                      child: Center(
                        child: _isLoading
                            ? const Center(
                                child: SpinKitCircle(
                                color: Colors.white,
                                size: 22,
                              ))
                            : const Center(
                                child: Text(
                                  "Submit your data ! ",
                                  style: TextStyle(
                                      fontFamily: 'ubuntu',
                                      color: Colors.white,
                                      fontSize: 23),
                                ),
                              ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
