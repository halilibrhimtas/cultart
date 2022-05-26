import 'package:cultart/models/tiyatro.dart';
import 'package:cultart/pages/tiyatrolar/url_launcher.dart';
import 'package:flutter/material.dart';

class IzmirDetaySayfasi extends StatefulWidget {

  const IzmirDetaySayfasi({Key? key, required this.tiyatro}) : super(key: key);
  final Tiyatro tiyatro;
  @override
  _IzmirDetaySayfasiState createState() => _IzmirDetaySayfasiState();
}

class _IzmirDetaySayfasiState extends State<IzmirDetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("${widget.tiyatro.sehir} Devlet Tiyatrosu"),
              Image.network(widget.tiyatro.oyunAfis!),
              Text("Oyun Adı: ${widget.tiyatro.oyunAdi!}"),
              Text("Yazan: ${widget.tiyatro.yazan}"),
              Text("Oyun Konusu: ${widget.tiyatro.oyunKonusu}"),
              TextButton(onPressed: (){
                launchURL(widget.tiyatro.oyunUrl!);
              },
                  child: const Text("Daha fazla detay ve bilet için tıklayınız"))
            ],
          ),
        ),
      ),
    );
  }
}
