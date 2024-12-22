// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'clustering.dart';

/// MapsDemo is the Main Application.
class MapsClusteringDemo extends StatelessWidget {
  /// Default Constructor
  const MapsClusteringDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoogleMaps examples')),
      body: SafeArea(child: ClusteringMap()),
    );
  }
}

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    initializeMapRenderer();
  }
  runApp(const MaterialApp(home: MapsClusteringDemo()));
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}
