import 'dart:async';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static const LatLng sourceLocation = LatLng(20.177973, -100.988347);
  static const LatLng destination = LatLng(20.536156, -100.816050);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularMenu(
      alignment: Alignment.bottomLeft,
      items: [
        CircularMenuItem(
          onTap: () {},
          icon: Icons.map,
          color: Colors.green,
        ),
        CircularMenuItem(
          onTap: () {},
          icon: Icons.map_sharp,
          color: Colors.purple,
        ),
        CircularMenuItem(
          onTap: () {},
          icon: Icons.map_rounded,
          color: Colors.blue,
        ),
        CircularMenuItem(
          onTap: () {},
          icon: Icons.satellite_alt,
          color: Colors.yellow,
        )
      ],
      backgroundWidget: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 14.5),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    )
        );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
