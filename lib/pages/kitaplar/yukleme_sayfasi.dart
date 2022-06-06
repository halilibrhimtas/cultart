import 'dart:io';
import 'package:cultart/models/book.dart';
import 'package:cultart/pages/kitaplar/book_page.dart';
import 'package:cultart/service/kitap_ekle.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class YuklemeSayfasi extends ConsumerStatefulWidget {
  const YuklemeSayfasi({Key? key}) : super(key: key);

  @override
  _YuklemeSayfasiState createState() => _YuklemeSayfasiState();
}

class _YuklemeSayfasiState extends ConsumerState<YuklemeSayfasi> {
  File? _imageFile;
  List<String?> _text = [];
  bool secim = false;
  var uuid = const Uuid();
  final User? user = FirebaseAuth.instance.currentUser;
  final storageRef = FirebaseStorage.instance.ref();
  var isClickable = false;
  TextEditingController yorumController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  getImageGallery() async {
    final picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
      if(image != null){
        setState(() {
          secim = true;
        });
        _imageFile = File(image.path);
        processImage(_imageFile!);
      }


  }
  getImageCamera() async {
    final picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.camera, imageQuality: 90);
      if(image != null){
        setState(() {
          secim = true;
        });
        _imageFile = File(image.path);
        processImage(_imageFile!);
      }
  }
  processImage(File imageFile) async {
    final visionImage =  GoogleVisionImage.fromFile(imageFile);
    ImageLabeler labeler = GoogleVision.instance
        .imageLabeler(const ImageLabelerOptions(confidenceThreshold: 0.75));
    List<ImageLabel> labels = await labeler.processImage(visionImage);
    _text = [];

    for (ImageLabel label in labels) {
      setState(() {
        if(label.text == "Poster") _text.add(label.text);
        if(label.text == "Paper") _text.add(label.text);
        if(label.text == "Fiction") _text.add(label.text);
        if(_text.isNotEmpty) {
          isClickable = true;
        }else {
          isClickable = false;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final database = ref.read(kitapProvider);
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.camera, color: Color(0xFF606670)),
            onPressed: (){
              getImageCamera();
            },
          ),
          IconButton(
            icon: const Icon(Icons.image, color: Color(0xFF606670)),
            onPressed: (){
              getImageGallery();
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (_imageFile == null)
                    ? DottedBorder(
                  strokeWidth: 2,
                  dashPattern: const [
                    5,
                    5,
                  ],
                  color:const Color(0xFF606670),
                      child: Container(
                          height: 250,
                          width: 300,
                          color: Colors.white70,
                        child: const Icon(Icons.arrow_upward, size: 100, color: Color(0xFF606670),),
                        ),
                    )
                    : Center(
                        child: SizedBox(
                          width: 300,
                          height: 250,
                          child: Image.file(_imageFile!),
                        ),
                      ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 75),
                  child: Center(
                    child: _text.isEmpty
                        ?  ( secim == true ?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          const Icon(Icons.close, color: Colors.red, size: 20,),
                     const Padding(padding: EdgeInsets.only(left: 7)),
                     Text("Fotoğraf kitap içermemektedir",
                       style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: Colors.red,fontWeight: FontWeight.normal),
                     )
                    ]
                    )
                        :  Text("Seçim yapılmadı",
                      style: GoogleFonts.alegreyaSans( decoration:TextDecoration.none, fontSize: 17, color: Color(0xFF606670),fontWeight: FontWeight.normal),

                    ))
                        : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                          const Icon(Icons.check_rounded , color: Colors.green, size: 20,),
                          const Padding(padding: EdgeInsets.only(left: 7)),
                          Text("Fotoğraf uygundur",
                            style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: Colors.green, fontWeight: FontWeight.normal),

                          )
                        ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: yorumController,
                    decoration: const InputDecoration(
                      labelText: "Yorum",
                    ),
                  ),
                ),

                Visibility(
                  visible: isClickable,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF606670),
                      ),
                        onPressed: () async {
                          String imageName = "images/"+uuid.v4()+".jpg";
                        try {
                          await storageRef.child(imageName).putFile(_imageFile!);
                          String url = await  storageRef.child(imageName).getDownloadURL();
                          var date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
                          await database.kitapEkle(Kitap(user!.email, url, yorumController.text, date));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookPage()
                              ));
                        } on FirebaseException catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                    }, child: const Text("Yükle", style: TextStyle(color: Color(0xFF606670)),),),
                ),
              ]),
          ),
          ),
        ),
      );
  }
}
