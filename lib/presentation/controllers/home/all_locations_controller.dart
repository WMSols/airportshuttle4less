import 'package:get/get.dart';

import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';

class AllLocationsController extends GetxController {
  final selectedScope = AppTexts.homeLocationsAll.obs;

  List<String> get scopes => const [
    AppTexts.homeLocationsAll,
    AppTexts.homeLocationsDmv,
    AppTexts.homeLocationsNationwide,
    AppTexts.homeLocationsWorldwide,
  ];

  List<HomeLocationTileData> get items {
    if (selectedScope.value == AppTexts.homeLocationsDmv) {
      return HomeConstants.dmvLocations;
    }
    if (selectedScope.value == AppTexts.homeLocationsNationwide) {
      return HomeConstants.nationwideLocations;
    }
    if (selectedScope.value == AppTexts.homeLocationsWorldwide) {
      return HomeConstants.worldwideLocations;
    }
    return [
      ...HomeConstants.dmvLocations,
      ...HomeConstants.nationwideLocations,
      ...HomeConstants.worldwideLocations,
    ];
  }

  void setScope(String? value) {
    if (value == null) return;
    selectedScope.value = value;
  }
}
