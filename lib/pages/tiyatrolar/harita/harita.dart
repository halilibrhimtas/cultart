// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:typed_data';
import 'package:cultart/models/tiyatro.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";

class Harita extends StatefulWidget {
  final Tiyatro tiyatro;

  const Harita({Key? key, required this.tiyatro}) : super(key: key);

  @override
  _HaritaState createState() => _HaritaState();
}

class _HaritaState extends State<Harita> {
  final Set<Marker> markers = {};
  Uint8List? markerbitmap;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> konum() {
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: [
        GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.tiyatro.salonKonum!["latitude"],
                  widget.tiyatro.salonKonum!["longitude"]),
              zoom: 15.0,
            ),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setState(() {
                markers.add(Marker(
                  markerId: MarkerId(LatLng(
                          widget.tiyatro.salonKonum!["latitude"],
                          widget.tiyatro.salonKonum!["longitude"])
                      .toString()),
                  position: LatLng(widget.tiyatro.salonKonum!["latitude"],
                      widget.tiyatro.salonKonum!["longitude"]),
                  infoWindow: InfoWindow(title: widget.tiyatro.salon!),
                ));
              });
            },
            markers: markers),
      ]),
    );
  }
}
