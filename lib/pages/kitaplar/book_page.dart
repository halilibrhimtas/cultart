import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cultart/pages/kitaplar/yukleme_sayfasi.dart';
import 'package:cultart/service/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/login/login_page.dart';


class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('kitaplar').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key:_key,
      drawer:  Header(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "KİTAP",
          style: TextStyle(
            color: Color.fromARGB(96, 161, 108, 108),
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:  IconButton(
          icon: const Icon(Icons.menu_rounded),
          color: Colors.black38,
          onPressed: () {
            _key.currentState!.openDrawer();

        },
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child:  IconButton(
              icon: const Icon(Icons.upload_file, size: 30,),
              color: const Color(0xFF606670),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const YuklemeSayfasi()
                    )
                );
              },
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Color(0xFF606670)),
                ],
              ),
            );
          }
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return ListTile(
                title: KitapFeed(data: data, document: document)
              );
            })
                .toList()
                .cast(),
          );
        },
      )
    );
  }
}

// ignore: must_be_immutable
class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  String? url;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader( // <-- SEE HERE
              decoration: const BoxDecoration(color: Color(0xFF606670)),
              accountName: Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture:
              CircleAvatar(
                radius: 50,
                backgroundImage: Image.network(FirebaseAuth.instance.currentUser!.photoURL!).image,
              ),
            ),
            ListTile(
              leading: IconButton(onPressed: ()async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()
                        )
                    )
                );
              },
                  icon: const Icon(Icons.exit_to_app_rounded)),
              title: const Text("Çıkış"),
            ),
          ],
        )
    );
  }
}

class KitapFeed extends StatefulWidget {
   const KitapFeed({
    Key? key,
    required this.data, required this.document,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final DocumentSnapshot<Object?> document;
  @override
  State<KitapFeed> createState() => _KitapFeedState();
}

class _KitapFeedState extends State<KitapFeed> {
  CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);
  bool isLiked = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (users.doc(widget.document.id) == widget.document.reference){
      isLiked = true;
    }else{
      isLiked = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
    ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: Image.network(FirebaseAuth.instance.currentUser!.photoURL!).image,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 8)),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft ,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 15, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.network(widget.data["userSharePhoto"]).image
                )
              ),
              width: 250,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Yorum  ",
                      style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("${widget.data["yorum"]}",
                        style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 16, color: const Color(0xFF606670),fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    launchURL(widget.data["kitapUrl"]);
                  },
                      child: Text("kitap url"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
