import 'package:cultart/pages/kitaplar/book_page.dart';
import 'package:cultart/pages/tiyatrolar/theatre_page.dart';
import 'package:flutter/material.dart';
import 'package:cultart/pages/filmler/movie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie_sharp), label: "Film"),
          BottomNavigationBarItem(
              icon: Icon(Icons.theater_comedy_outlined), label: "Tiyatro"),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined), label: "Kitap"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        onTap: onTapped,
      ),
      body: PageView(
        controller: pageController,
        children: const [
          MoviePage(),
          TheatrePage(),
          BookPage(),
        ],
      ),
    );
  }
}
