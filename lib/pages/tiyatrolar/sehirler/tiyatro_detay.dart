import 'package:cultart/models/tiyatro.dart';
import 'package:cultart/service/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../harita/harita.dart';

class TiyatroDetaySayfasi extends StatefulWidget {
  final Tiyatro tiyatro;

  const TiyatroDetaySayfasi({Key? key, required this.tiyatro})
      : super(key: key);

  @override
  _TiyatroDetaySayfasiState createState() => _TiyatroDetaySayfasiState();
}

class _TiyatroDetaySayfasiState extends State<TiyatroDetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Container(
                  height: 480,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.network(widget.tiyatro.oyunAfis!).image
                    )
                  ),
                ),
                Text(" ${widget.tiyatro.salon}",
                  style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Yazan",
                    style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${widget.tiyatro.yazan}",
                    style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.normal),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Oyun Konusu",
                    style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                  ),
                ),
                Text("${widget.tiyatro.oyunKonusu}",
                  style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: const Color(0xFF606670),fontWeight: FontWeight.normal),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Salon Konumu",
                    style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF606670),
                  ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Harita(tiyatro: widget.tiyatro)));
                    },
                    child: Row(
                      children:  [
                        const Icon(Icons.map_rounded),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        Text("Salonun Konumu için tıklayınız",
                          style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 17, color: Colors.white,fontWeight: FontWeight.normal),
                        )
                      ],
                    )
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Bilet",
                    style: GoogleFonts.alegreyaSans( decoration:  TextDecoration.none, fontSize: 20, color: const Color(0xFF606670),fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF606670),
                    ),
                    onPressed: () {
                      launchURL(widget.tiyatro.oyunUrl!);
                    },
                    child:
                         Row(
                           children: [
                             const Icon(Icons.theater_comedy),
                             const Padding(padding: EdgeInsets.only(right: 8)),
                             Text("Daha fazla detay ve bilet için tıklayınız",
                              style: GoogleFonts.alegreyaSans( decoration: TextDecoration.none, fontSize: 17, color: Colors.white,fontWeight: FontWeight.normal),
                        ),
                           ],
                         ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
