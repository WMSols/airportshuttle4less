abstract class HeroTags {
  HeroTags._();

  static const String homeHeroBanner = 'home.hero.banner';
  static const String homeWelcomeImage = 'home.welcome.image';

  static String homePreferredVehicle(int index) =>
      'home.preferred.vehicle.$index';

  static String homeWorkProcessTile(int index) =>
      'home.workprocess.tile.$index';

  static String homeServiceTile(int index) => 'home.service.tile.$index';

  static String allLocationsTile(String scope, int index) =>
      'all.locations.$scope.$index';

  static String allServicesTile(int index) => 'all.services.$index';
}
