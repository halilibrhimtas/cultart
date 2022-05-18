import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title:  const Text(
        "KİTAP",
        style: TextStyle(
        color: Colors.black38,
        fontSize: 25,
        fontWeight: FontWeight.w300,
    ),

    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: const Icon(
    Icons.menu_rounded,
    color: Colors.black38,
    ),
    automaticallyImplyLeading: false,
    actions: [
    Container(
    margin: const EdgeInsets.only(right: 15),
    child: const Icon(Icons.search_outlined, color: Colors.black38,),
    )
    ],
    ),);
  }
}
