import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/book.dart';




class KitapEkle extends ChangeNotifier{
  FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Uuid uuid = const Uuid();
  kitapEkle(Kitap kitap) async {
     var kitaplar = db.collection("kitaplar").doc(uuid.v4());
     try{
       await kitaplar.set(
           {
             "email": kitap.email,
             "userSharePhoto": kitap.userSharePhoto,
             "yorum": kitap.yorum,
             "dateTime" : kitap.dateTime,

           });
       return true;
     } catch (e){
       return Future.error(e);
     }

    }
     }



final kitapProvider = ChangeNotifierProvider((any){
  return KitapEkle();
});
