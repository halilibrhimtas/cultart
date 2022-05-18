import 'package:flutter/material.dart';

class TheatrePage extends StatefulWidget {
  const TheatrePage({Key? key}) : super(key: key);

  @override
  _TheatrePageState createState() => _TheatrePageState();
}

class _TheatrePageState extends State<TheatrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  const Text(
          "TİYATRO",
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
