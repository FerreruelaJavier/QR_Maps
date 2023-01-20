import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition inici = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.50,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(new Marker(markerId: MarkerId('El sitio'), position: scan.getLatLng()));

    MapType mapatipo = MapType.normal;

    GoogleMap mapa = GoogleMap(
      mapType: mapatipo,
      initialCameraPosition: inici,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas Ramirez'),
      ),
      body: mapa
    );
  }
}
