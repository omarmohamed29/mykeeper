import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/book_shelf/bookshelf_cubit.dart';
import 'package:mokhatat/presentation/widgets/drawerIcons.dart';

class BookShelfScreen extends StatefulWidget {
  const BookShelfScreen({Key? key}) : super(key: key);

  @override
  State<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  Future<void> getBookData() async {
    return await BlocProvider.of<BookshelfCubit>(context)
        .retrieveBookshelfData();
  }

  Future<void> _removeBook(String id) async {
    return await BlocProvider.of<BookshelfCubit>(context)
        .deleteBookshelfData(id);
  }

  final PageController ctrl = PageController(viewportFraction: 0.8);

  String activeTag = "Latest";

  int currentPage = 0;
  double _width = 180;

  void time() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _width = 0.0;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    time();
    ctrl.addListener(() {
      int next = ctrl.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    getBookData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, addBookShelf);
              },
              icon: const Icon(
                Icons.add,
                size: 30,
                color: Color(0xFFDF7861),
              ))
        ],
        title: const Text(
          'Book Shelf',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD18B81),
              fontFamily: 'ubuntu',
              fontSize: 30),
        ),
      ),
      body: BlocConsumer<BookshelfCubit, BookshelfState>(
        listener: ((context, state) {
          if (state is BookshelfDataDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text((state).response),
              backgroundColor: const Color(0xFFD18B81),
              elevation: 0.0,
              action: SnackBarAction(
                label: 'Okay!',
                textColor: Colors.white,
                onPressed: () {
                  getBookData();
                },
              ),
            ));
          }
        }),
        builder: (context, state) {
          if (state is BookshelfRetrieved) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  MydrawerIcons.bookshelf,
                  size: 25,
                  color: Color(0xFFD18B81),
                ),
                const Center(
                  child: Text(
                    'A book is a gift you can open again and again ,SO KEEP READING',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD18B81),
                        fontFamily: 'ubuntu',
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 500,
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: ctrl,
                        itemCount: (state).bookShelf.length,
                        itemBuilder: ((context, int currentIndex) {
                          bool active = currentIndex == currentPage;
                          final double top = active ? 50 : 100;
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutQuint,
                            margin: EdgeInsets.only(
                                top: top, bottom: 30, right: 30),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(209, 139, 129, 0.5),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: 10,
                                  color: const Color(0xFFD18B81),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 50,
                                  right: 50,
                                  bottom: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            tooltip: "delete book",
                                            onPressed: () {
                                              _removeBook((state)
                                                  .bookShelf[currentIndex]
                                                  .id);
                                            },
                                            icon: const Icon(
                                              Icons.cancel,
                                              size: 25,
                                              color: Colors.white,
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          (state)
                                              .bookShelf[currentIndex]
                                              .bookName
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'ubuntu',
                                              fontSize: 30),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (state)
                                              .bookShelf[currentIndex]
                                              .author,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'ubuntu',
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          (state)
                                              .bookShelf[currentIndex]
                                              .category,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: 'ubuntu',
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                  ),
                ),
              ],
            );
          } else if (state is BookshelfInitial) {
            return const SizedBox();
          } else if (state is BookshelfDataDeleted) {
            return const SizedBox();
          } else {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Start by adding your favourite book from the top right icon',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD18B81),
                      fontFamily: 'ubuntu',
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
