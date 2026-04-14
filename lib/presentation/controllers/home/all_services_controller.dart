import 'package:get/get.dart';

import 'package:airportshuttle4less/core/constants/home_constants.dart';

class AllServicesController extends GetxController {
  List<HomeServiceTileData> get items => HomeConstants.allServiceTiles;
}
