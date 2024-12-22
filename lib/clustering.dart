import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusteringMap extends StatefulWidget {
  const ClusteringMap({super.key});

  @override
  State<ClusteringMap> createState() => MapSampleState();
}

class MapSampleState extends State<ClusteringMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kTokyo = CameraPosition(
    target: LatLng(35.681236, 139.767125), // Tokyo Station coordinates
    zoom: 14,
  );

  final Set<Marker> _markers = {};

  void _addMarkers() {
    final List<LatLng> positions = [
      LatLng(35.682839, 139.759455), // Marunouchi
      LatLng(35.684063, 139.766084), // Nihonbashi
      LatLng(35.676398, 139.769017), // Ginza
      LatLng(35.689634, 139.692101), // Shinjuku
      LatLng(35.673343, 139.710388), // Roppongi
      LatLng(35.658034, 139.751599), // Tokyo Tower
      LatLng(35.689487, 139.691711), // Tokyo Metropolitan Government Building
      LatLng(35.693840, 139.703549), // Shibuya
      LatLng(35.710062, 139.810700), // Asakusa
      LatLng(35.689634, 139.692101), // Ikebukuro
      LatLng(35.689634, 139.700413), // Akihabara
      LatLng(35.689634, 139.702042), // Ueno
      LatLng(35.689634, 139.703071), // Odaiba
      LatLng(35.689634, 139.704100), // Ebisu
      LatLng(35.689634, 139.705129), // Meguro
      LatLng(35.689634, 139.706158), // Shinagawa
      LatLng(35.689634, 139.707187), // Gotanda
      LatLng(35.689634, 139.708216), // Kamata
      LatLng(35.689634, 139.709245), // Setagaya
      LatLng(35.689634, 139.710274), // Nakano
    ];

    for (int i = 0; i < positions.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: positions[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
          clusterManagerId: ClusterManagerId('1'),
        ),
      );
    }
  }

  Set<ClusterManager> clusterManagers = {
    ClusterManager(
      clusterManagerId: ClusterManagerId('1'),
      onClusterTap: (Cluster cluster) => print(cluster.count),
    )
  };

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kTokyo,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        clusterManagers: clusterManagers,
      ),
    );
  }
}
