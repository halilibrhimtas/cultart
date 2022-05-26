import 'dart:convert';
import 'package:cultart/models/tiyatro.dart';
import 'package:cultart/pages/tiyatrolar/harita/harita.dart';
import 'package:cultart/pages/tiyatrolar/sehirler/izmir_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sehirler/adana_detay.dart';
import 'sehirler/ankara_detay.dart';
import 'sehirler/antalya_detay.dart';
import 'sehirler/istanbul_detay.dart';

class TheatrePage extends StatefulWidget {
  const TheatrePage({Key? key}) : super(key: key);

  @override
  _TheatrePageState createState() => _TheatrePageState();
}

class _TheatrePageState extends State<TheatrePage> {
  List<Tiyatro> adanaList = [];
  List<Tiyatro> tiyatroList = [];
  List<Tiyatro> antalyaList = [];
  List<Tiyatro> ankaraList = [];
  List<Tiyatro> izmirList = [];
  List<Tiyatro> istanbulList = [];
  List<Widget> tabs = const [
    Tab(icon: Text("Adana", style: TextStyle(color:Colors.black38, fontSize: 16),)),
    Tab(icon: Text("İstanbul", style: TextStyle(color:Colors.black38, fontSize: 16),)),
    Tab(icon: Text("Ankara", style: TextStyle(color:Colors.black38, fontSize: 16),)),
    Tab(icon: Text("Antalya", style: TextStyle(color:Colors.black38, fontSize: 16),)),
    Tab(icon: Text("İzmir", style: TextStyle(color:Colors.black38, fontSize: 16),)),
  ];


  Future<void> tiyatroIndir() async {
    var response = await rootBundle.loadString("assets/tiyatro.json");
    List<dynamic> data = jsonDecode(response);
    tiyatroList = data.map((data) => Tiyatro.fromJson(data)).toList();
    setState(() {
      for(int i = 0; i <= 14; i++){
        if(tiyatroList[i].sehir == "Adana") {
          adanaList.add(tiyatroList[i]);
        }
        if(tiyatroList[i].sehir == "Antalya") {
          antalyaList.add(tiyatroList[i]);
        }
        if(tiyatroList[i].sehir == "İstanbul") {
          istanbulList.add(tiyatroList[i]);
        }
        if(tiyatroList[i].sehir == "Ankara") {
          ankaraList.add(tiyatroList[i]);
        }
        if(tiyatroList[i].sehir == "İzmir") {
          izmirList.add(tiyatroList[i]);
        }
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tiyatroIndir();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black38
            ),
            labelColor: Colors.white,
            isScrollable: true,
            physics: const BouncingScrollPhysics(),
            tabs: tabs ),
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
              child: IconButton(icon: const Icon(Icons.map_sharp), color: Colors.black38, onPressed: ()  {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Harita()));
              },),
            )
          ],
        ),
        body: TabBarView(
          children: [
            AdanaPage(adanaList: adanaList),
            IstanbulPage(istanbulList: istanbulList),
            AnkaraPage(ankaraList: ankaraList),
            AntalyaPage(antalyaList: antalyaList),
            IzmirPage(izmirList: izmirList),
          ],
        )
      ),
    );

  }
}

class IzmirPage extends StatelessWidget {
  const IzmirPage({
    Key? key,
    required this.izmirList,
  }) : super(key: key);

  final List<Tiyatro> izmirList;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: izmirList.length,
            itemBuilder: (context, index) {
              Tiyatro izmirTiyatro = izmirList[index];
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.network(izmirTiyatro.oyunAfis!, height: 400, width: 350,),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      TextButton(child: Text(izmirTiyatro.oyunAdi!), onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IzmirDetaySayfasi(tiyatro: izmirTiyatro,)));
                      },)
                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}

class AntalyaPage extends StatelessWidget {
  const AntalyaPage({
    Key? key,
    required this.antalyaList,
  }) : super(key: key);

  final List<Tiyatro> antalyaList;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: antalyaList.length,
            itemBuilder: (context, index) {
              Tiyatro antalyaTiyatro = antalyaList[index];
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.network(antalyaTiyatro.oyunAfis!, height: 400, width: 350,),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      TextButton(child: Text(antalyaTiyatro.oyunAdi!), onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>  AntalyaDetaySayfasi(tiyatro: antalyaTiyatro)));
                      },)
                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}

class AnkaraPage extends StatelessWidget {
  const AnkaraPage({
    Key? key,
    required this.ankaraList,
  }) : super(key: key);

  final List<Tiyatro> ankaraList;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: ankaraList.length,
            itemBuilder: (context, index) {
              Tiyatro ankaraTiyatro = ankaraList[index];
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.network(ankaraTiyatro.oyunAfis!, height: 400, width: 350,),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      TextButton(child: Text(ankaraTiyatro.oyunAdi!), onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnkaraDetaySayfasi(tiyatro: ankaraTiyatro)));
                      },)
                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}

class IstanbulPage extends StatelessWidget {
  const IstanbulPage({
    Key? key,
    required this.istanbulList,
  }) : super(key: key);

  final List<Tiyatro> istanbulList;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: istanbulList.length,
            itemBuilder: (context, index) {
              Tiyatro istanbulTiyatro= istanbulList[index];
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.network(istanbulTiyatro.oyunAfis!, height: 400, width: 350,),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      TextButton(child: Text(istanbulTiyatro.oyunAdi!), onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IstanbulDetaySayfasi(tiyatro: istanbulTiyatro)));
                      },
                      )
                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}

class AdanaPage extends StatelessWidget {
  const AdanaPage({
    Key? key,
    required this.adanaList,
  }) : super(key: key);

  final List<Tiyatro> adanaList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: adanaList.length,
        itemBuilder: (context, index) {
          Tiyatro adanaTiyatro = adanaList[index];
          return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.network(adanaTiyatro.oyunAfis!, height: 400, width: 350,),
          const Padding(padding: EdgeInsets.only(bottom: 8.0)),
          TextButton(child: Text(adanaTiyatro.oyunAdi!), onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdanaDetaySayfasi(tiyatro: adanaTiyatro)));
          },)
        ],
      ),
    ),
          );
      }
      )
    );
  }
}
