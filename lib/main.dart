import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/init/app_initializer.dart';
import 'package:airportshuttle4less/core/init/app_system_ui.dart';
import 'package:airportshuttle4less/app.dart';

void main() async {
  final initialRoute = await AppInitializer.init();
  AppSystemUi.setOverlayStyle();
  runApp(AirportShuttles4LessApp(initialRoute: initialRoute));
}
