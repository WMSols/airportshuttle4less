import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Public website URLs used on the marketing home screen.
abstract class HomeConstants {
  HomeConstants._();

  static const String site = 'https://airportshuttles4less.com/';
  static const String washingtonDc =
      'https://airportshuttles4less.com/shuttle-service-washington-dc.html';
  static const String baltimore =
      'https://airportshuttles4less.com/shuttle-service-baltimore-md.html';
  static const String maryland =
      'https://airportshuttles4less.com/maryland.html';
  static const String alexandria =
      'https://airportshuttles4less.com/alexandria-va-shuttle-service.html';
  static const String arlington =
      'https://airportshuttles4less.com/shuttle-service-arlington-va.html';
  static const String springfield =
      'https://airportshuttles4less.com/shuttle-service-springfield-va.html';
  static const String annapolis =
      'https://airportshuttles4less.com/shuttle-service-annapolis-md.html';
  static const String fairfax =
      'https://airportshuttles4less.com/fairfax-shuttle-service.html';
  static const String leesburg =
      'https://airportshuttles4less.com/shuttle-service-leesburg-va.html';
  static const String stafford =
      'https://airportshuttles4less.com/shuttle-service-stafford-va.html';
  static const String waldorf =
      'https://airportshuttles4less.com/shuttle-service-waldrof-md.html';
  static const String gaithersburg =
      'https://airportshuttles4less.com/shuttle-service-gaithersburg-md.html';
  static const String oxonHill =
      'https://airportshuttles4less.com/transportation-oxon-hill-md.html';
  static const String columbia =
      'https://airportshuttles4less.com/shuttle-service-columbia-md.html';
  static const String bethesda =
      'https://airportshuttles4less.com/transportation-bethesda-md.html';
  static const String annandale =
      'https://airportshuttles4less.com/transportation-annandale-va.html';
  static const String greatFalls =
      'https://airportshuttles4less.com/transportation-great-falls-va.html';
  static const String mclean =
      'https://airportshuttles4less.com/mclean-shuttle-service.html';
  static const String fallsChurch =
      'https://airportshuttles4less.com/shuttle-service-falls-church-va.html';
  static const String idylwood =
      'https://airportshuttles4less.com/shuttle-service-idlywood-va.html';
  static const String lincolnia =
      'https://airportshuttles4less.com/shuttle-service-lincolnia-va.html';
  static const String oakton =
      'https://airportshuttles4less.com/oakton-va-shuttle-service.html';
  static const String potomac =
      'https://airportshuttles4less.com/potomac-md-shuttle-service.html';
  static const String tysons =
      'https://airportshuttles4less.com/shuttle-service-tysons-va.html';
  static const String westFallsChurch =
      'https://airportshuttles4less.com/shuttle-service-west-falls-church-va.html';
  static const String wolfTrap =
      'https://airportshuttles4less.com/shuttle-service-wolf-trap-va.html';
  static const String silverSpring =
      'https://airportshuttles4less.com/shuttle-service-silver-spring-md.html';

  static const int locationAutoAdvanceMs = 4500;
  static const int preferredVehicleAutoAdvanceMs = 4200;
  static const int partnersAutoAdvanceMs = 3200;
  static const double preferredVehicleViewportFraction = 0.86;
  static const double partnersViewportFraction = 0.34;

  static const List<HomeLocationSlide> locationSlides = [
    HomeLocationSlide(
      label: AppTexts.homeLocationAlexandria,
      imageAsset: AppImages.locationAlexandria,
      url: HomeConstants.alexandria,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationWashington,
      imageAsset: AppImages.locationWashington,
      url: HomeConstants.washingtonDc,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationArlington,
      imageAsset: AppImages.locationArlington,
      url: HomeConstants.arlington,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationBaltimore,
      imageAsset: AppImages.locationBaltimore,
      url: HomeConstants.baltimore,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationSpringfield,
      imageAsset: AppImages.locationSpringfield,
      url: HomeConstants.springfield,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationMaryland,
      imageAsset: AppImages.locationMaryland,
      url: HomeConstants.maryland,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationAnnapolis,
      imageAsset: AppImages.locationAnnapolis,
      url: HomeConstants.annapolis,
    ),
    HomeLocationSlide(
      label: AppTexts.homeLocationFairfax,
      imageAsset: AppImages.locationFairfax,
      url: HomeConstants.fairfax,
    ),
  ];

  static const List<HomeLocationTileData> dmvLocations = [
    HomeLocationTileData(
      label: AppTexts.locationAlexandriaVa,
      imageAsset: AppImages.locationAlexandria,
      url: HomeConstants.alexandria,
    ),
    HomeLocationTileData(
      label: AppTexts.locationWashingtonDc,
      imageAsset: AppImages.locationWashington,
      url: HomeConstants.washingtonDc,
    ),
    HomeLocationTileData(
      label: AppTexts.locationArlingtonVa,
      imageAsset: AppImages.locationArlington,
      url: HomeConstants.arlington,
    ),
    HomeLocationTileData(
      label: AppTexts.locationBaltimoreMd,
      imageAsset: AppImages.locationBaltimore,
      url: HomeConstants.baltimore,
    ),
    HomeLocationTileData(
      label: AppTexts.locationSpringfieldVa,
      imageAsset: AppImages.locationSpringfield,
      url: HomeConstants.springfield,
    ),
    HomeLocationTileData(
      label: AppTexts.locationMaryland,
      imageAsset: AppImages.locationMaryland,
      url: HomeConstants.maryland,
    ),
    HomeLocationTileData(
      label: AppTexts.locationAnnapolisMd,
      imageAsset: AppImages.locationAnnapolis,
      url: HomeConstants.annapolis,
    ),
    HomeLocationTileData(
      label: AppTexts.locationFairfaxVa,
      imageAsset: AppImages.locationFairfax,
      url: HomeConstants.fairfax,
    ),
    HomeLocationTileData(
      label: AppTexts.locationLeesburgVa,
      imageAsset: AppImages.locationLeesburg,
      url: HomeConstants.leesburg,
    ),
    HomeLocationTileData(
      label: AppTexts.locationStaffordVa,
      imageAsset: AppImages.locationStafford,
      url: HomeConstants.stafford,
    ),
    HomeLocationTileData(
      label: AppTexts.locationWaldorfMd,
      imageAsset: AppImages.locationWaldorf,
      url: HomeConstants.waldorf,
    ),
    HomeLocationTileData(
      label: AppTexts.locationGaithersburgMd,
      imageAsset: AppImages.locationGaithersburg,
      url: HomeConstants.gaithersburg,
    ),
    HomeLocationTileData(
      label: AppTexts.locationOxonHillMd,
      imageAsset: AppImages.locationOxonHill,
      url: HomeConstants.oxonHill,
    ),
    HomeLocationTileData(
      label: AppTexts.locationColumbiaMd,
      imageAsset: AppImages.locationColumbia,
      url: HomeConstants.columbia,
    ),
    HomeLocationTileData(
      label: AppTexts.locationBethesdaMd,
      imageAsset: AppImages.locationBethesda,
      url: HomeConstants.bethesda,
    ),
    HomeLocationTileData(
      label: AppTexts.locationAnnandaleVa,
      imageAsset: AppImages.locationAnnandale,
      url: HomeConstants.annandale,
    ),
    HomeLocationTileData(
      label: AppTexts.locationGreatFallsVa,
      imageAsset: AppImages.locationGreatFalls,
      url: HomeConstants.greatFalls,
    ),
    HomeLocationTileData(
      label: AppTexts.locationMcleanVirginia,
      imageAsset: AppImages.locationMcleanVirginia,
      url: HomeConstants.mclean,
    ),
    HomeLocationTileData(
      label: AppTexts.locationFallsChurchVa,
      imageAsset: AppImages.locationFallsChurch,
      url: HomeConstants.fallsChurch,
    ),
    HomeLocationTileData(
      label: AppTexts.locationIdylwoodVa,
      imageAsset: AppImages.locationIdylwood,
      url: HomeConstants.idylwood,
    ),
    HomeLocationTileData(
      label: AppTexts.locationLincolniaVa,
      imageAsset: AppImages.locationLincolnia,
      url: HomeConstants.lincolnia,
    ),
    HomeLocationTileData(
      label: AppTexts.locationOaktonVa,
      imageAsset: AppImages.locationOakton,
      url: HomeConstants.oakton,
    ),
    HomeLocationTileData(
      label: AppTexts.locationPotomacMd,
      imageAsset: AppImages.locationPotomac,
      url: HomeConstants.potomac,
    ),
    HomeLocationTileData(
      label: AppTexts.locationTysonsVa,
      imageAsset: AppImages.locationTysons,
      url: HomeConstants.tysons,
    ),
    HomeLocationTileData(
      label: AppTexts.locationWestFallsChurchVa,
      imageAsset: AppImages.locationWestFallsChurch,
      url: HomeConstants.westFallsChurch,
    ),
    HomeLocationTileData(
      label: AppTexts.locationWolfTrapVirginia,
      imageAsset: AppImages.locationWolfTrapVirginia,
      url: HomeConstants.wolfTrap,
    ),
    HomeLocationTileData(
      label: AppTexts.locationSilverSpring,
      imageAsset: AppImages.locationSilverSpring,
      url: HomeConstants.silverSpring,
    ),
  ];

  static const List<HomeLocationTileData> nationwideLocations = [
    HomeLocationTileData(
      label: AppTexts.locationNewYork,
      imageAsset: AppImages.locationNewYork,
    ),
    HomeLocationTileData(
      label: AppTexts.locationWashingtonDc,
      imageAsset: AppImages.locationWashington,
    ),
    HomeLocationTileData(
      label: AppTexts.locationBostonMassachusetts,
      imageAsset: AppImages.locationBostonMassachusetts,
    ),
    HomeLocationTileData(
      label: AppTexts.locationAtlantaGeorgia,
      imageAsset: AppImages.locationAtlantaGeorgia,
    ),
    HomeLocationTileData(
      label: AppTexts.locationMaryland,
      imageAsset: AppImages.locationMaryland,
    ),
    HomeLocationTileData(
      label: AppTexts.locationLosAngeles,
      imageAsset: AppImages.locationLosAngeles,
    ),
    HomeLocationTileData(
      label: AppTexts.locationNewJersey,
      imageAsset: AppImages.locationNewJersey,
    ),
    HomeLocationTileData(
      label: AppTexts.locationDelaware,
      imageAsset: AppImages.locationDelaware,
    ),
    HomeLocationTileData(
      label: AppTexts.locationPennsylvania,
      imageAsset: AppImages.locationPennsylvania,
    ),
    HomeLocationTileData(
      label: AppTexts.locationWolfTrapVirginia,
      imageAsset: AppImages.locationWolfTrapVirginia,
    ),
  ];

  static const List<HomeLocationTileData> worldwideLocations = [
    HomeLocationTileData(
      label: AppTexts.locationUnitedStates,
      imageAsset: AppImages.locationUnitedStates,
    ),
    HomeLocationTileData(
      label: AppTexts.locationDubai,
      imageAsset: AppImages.locationDubai,
    ),
    HomeLocationTileData(
      label: AppTexts.locationFrance,
      imageAsset: AppImages.locationFrance,
    ),
    HomeLocationTileData(
      label: AppTexts.locationIndia,
      imageAsset: AppImages.locationIndia,
    ),
    HomeLocationTileData(
      label: AppTexts.locationUnitedKingdom,
      imageAsset: AppImages.locationUnitedKingdom,
    ),
  ];

  static const List<HomeServiceTileData> serviceTiles = [
    HomeServiceTileData(
      title: AppTexts.serviceAirportTransportation,
      imageAsset: AppImages.serviceAirportTransportation,
      titleOnLeft: true,
      description:
          "Missing a flight can be every traveler's worst nightmare. Get rid of it by using AS4L's best airport shuttle service with on-time chauffeur transportation.",
      readMoreLabel: 'Read more about Airport Transportation Services',
      readMoreUrl:
          'https://airportshuttles4less.com/shuttle-service-baltimore-md.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.servicePointToPointLimo,
      imageAsset: AppImages.servicePointToPoint,
      titleOnLeft: false,
      description:
          'Reliable point-to-point transportation services seem like a dream. AS4L offers affordable, comfortable, and convenient transfers tailored for your route.',
      readMoreLabel: 'Read more about Point to Point Services',
      readMoreUrl:
          'https://airportshuttles4less.com/point-to-point-limo-service.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceHourlyLimo,
      imageAsset: AppImages.serviceHourlyLimo,
      titleOnLeft: true,
      description:
          'Traveling peacefully can be a challenge in busy DMV areas. Search for the limo rental near me by AS4L and experience unmatched comfort and convenience.',
      readMoreLabel: 'Read more about SEDAN & Car Services',
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-hourly-limo-service.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceGroupTransportation,
      imageAsset: AppImages.serviceGroupTransportation,
      titleOnLeft: false,
      description:
          'Traveling with family, friends, or coworkers? We make group trips stress-free with roomy vehicles, reliable scheduling, and professional drivers.',
      readMoreLabel: 'Read more about Group Transportation Services',
      readMoreUrl:
          'https://airportshuttles4less.com/sprinter-vans-buses-group-transportation.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceCorporateTransportation,
      imageAsset: AppImages.serviceCorporateTransportation,
      titleOnLeft: true,
      description:
          'Your choice of chauffeured transportation reflects your corporate standards. AS4L combines professionalism and elegance for executive travel.',
      readMoreLabel: 'Read more about Corporate Services',
      readMoreUrl:
          'https://airportshuttles4less.com/corporate-transportation-services.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceBusCharterRental,
      imageAsset: AppImages.serviceBusCharterRental,
      titleOnLeft: false,
      description:
          'Need a bus for a trip, tour, or event? Our clean charter buses with certified drivers manage routes, timing, and permits for smooth travel.',
      readMoreLabel: 'Read more about Bus charter Services',
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-bus-charter-rental.html',
      darkPreview: true,
    ),
  ];

  static const List<HomeServiceTileData> allServiceTiles = [
    HomeServiceTileData(
      title: AppTexts.servicePointToPointLimo,
      imageAsset: AppImages.servicePointToPoint,
      titleOnLeft: true,
      description:
          'Direct private transfers between two destinations with professional chauffeurs, luxury vehicles, and dependable timing for business, events, and daily travel.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/point-to-point-limo-service.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceAirportTransportation,
      imageAsset: AppImages.serviceAirportTransportation,
      titleOnLeft: false,
      description:
          'Reliable airport transportation to and from BWI, IAD, and DCA with on-time pickups, luggage support, and comfortable rides for individuals and groups.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/airport-transportation-baltimore-md.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceVanOrExclusiveShuttles,
      imageAsset: AppImages.serviceVanOrExclusiveShuttles,
      titleOnLeft: true,
      description:
          'Exclusive shuttle and van solutions across the DMV with door-to-door service for airport runs, events, weddings, and group transfers.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl: 'https://airportshuttles4less.com/bwi-shuttle-service.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceHourlyLimo,
      imageAsset: AppImages.serviceHourlyLimo,
      titleOnLeft: false,
      description:
          'Flexible hourly limo service for meetings, city tours, nightlife, and multi-stop plans, with your chauffeur following your schedule.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-hourly-limo-service.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceCorporateTransportation,
      imageAsset: AppImages.serviceCorporateTransportation,
      titleOnLeft: true,
      description:
          'Executive transportation for meetings, corporate events, airport transfers, and VIP travel with professional presentation and punctual service.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/corporate-transportation-services.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceWineryCityTours,
      imageAsset: AppImages.serviceWineryAndCityTours,
      titleOnLeft: false,
      description:
          'Custom winery and city tours in Maryland, D.C., and Virginia with curated routes, comfortable vehicles, and safe round-trip transportation.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/winery-and-city-tours.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceGroupTransportation,
      imageAsset: AppImages.serviceGroupTransportation,
      titleOnLeft: true,
      description:
          'Group transportation with sprinters, minibuses, and coaches for sports, schools, corporate outings, weddings, and long-distance transfers.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/sprinter-vans-buses-group-transportation.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.servicePrivateSchoolBus,
      imageAsset: AppImages.servicePrivateSchoolBus,
      titleOnLeft: false,
      description:
          'Safe and dependable private school transportation for daily commutes, field trips, campus events, and college group travel.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-private-school-transportation.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceBachelorEttePartyLimo,
      imageAsset: AppImages.serviceBachelorEttePartyLimo,
      titleOnLeft: true,
      description:
          'Bachelor and bachelorette party limo and bus options with nightlife-ready vehicles, multi-stop itineraries, and safe chauffeur service.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-d.c-party-limo-service.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceWeddingSpecial,
      imageAsset: AppImages.serviceWeddingSpecial,
      titleOnLeft: false,
      description:
          'Wedding-special transportation for couples and guests, including luxury sedans, limos, and shuttle options coordinated to your timeline.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-wedding-limo-services.html',
      darkPreview: false,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceBusCharterRental,
      imageAsset: AppImages.serviceBusCharterRental,
      titleOnLeft: true,
      description:
          'Bus charter rentals for city tours, weddings, retreats, and state-to-state travel with comfortable seating and experienced drivers.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-bus-charter-rental.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceExoticCarRental,
      imageAsset: AppImages.serviceExoticCarRental,
      titleOnLeft: false,
      description:
          'Exotic and luxury car rentals with chauffeur options for corporate travel, events, airport transfers, and premium city rides.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/baltimore-exotic-car-rental.html',
      darkPreview: true,
    ),
    HomeServiceTileData(
      title: AppTexts.serviceMinivans,
      imageAsset: AppImages.serviceMinivans,
      titleOnLeft: true,
      description:
          'Minivan airport transfer service for up to five passengers with luggage, with dependable routes to BWI, IAD, DCA, and beyond.',
      readMoreLabel: AppTexts.homeReadMoreWebsite,
      readMoreUrl:
          'https://airportshuttles4less.com/minivan-airport-transfer.html',
      darkPreview: false,
    ),
  ];

  static const List<HomeProcessCellData> processCells = [
    HomeProcessCellData(
      icon: Iconsax.shield_tick,
      label: AppTexts.homeProcess1Label,
    ),
    HomeProcessCellData(icon: Iconsax.clock, label: AppTexts.homeProcess2Label),
    HomeProcessCellData(
      icon: Iconsax.routing_2,
      label: AppTexts.homeProcess3Label,
    ),
    HomeProcessCellData(
      icon: Iconsax.user_tick,
      label: AppTexts.homeProcess4Label,
    ),
  ];

  static const List<HomePartnerData> partners = [
    HomePartnerData(imageAsset: AppImages.partner1),
    HomePartnerData(imageAsset: AppImages.partner2),
    HomePartnerData(imageAsset: AppImages.partner3),
    HomePartnerData(imageAsset: AppImages.partner4),
    HomePartnerData(imageAsset: AppImages.partner5),
    HomePartnerData(imageAsset: AppImages.partner6),
  ];

  static const List<HomePreferredVehicle> preferredVehicles = [
    HomePreferredVehicle(
      title: 'ROLLS ROYCE\nPHANTOM',
      imageAsset: AppImages.preferredRollsRoycePhantom,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '2'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '0'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'PREMIUM SEDAN',
      imageAsset: AppImages.preferredPremiumSedan,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '2'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '2'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'LUXURY MERCEDES\nS550',
      imageAsset: AppImages.preferredLuxuryMercedesS550,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '3'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '3'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'EXCLUSIVE SEDAN',
      imageAsset: AppImages.preferredExclusiveSedan,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '3'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '3'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'EXCLUSIVE SUV',
      imageAsset: AppImages.preferredExclusiveSuv,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '6'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '6'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'SPRINTER VAN',
      imageAsset: AppImages.preferredSprinterVan,
      features: [
        HomePreferredVehicleFeature(
          icon: Iconsax.call,
          value: AppTexts.preferredVehicleCallForRates,
        ),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'HUMMER LIMO',
      imageAsset: AppImages.preferredHummerLimo,
      features: [
        HomePreferredVehicleFeature(
          icon: Iconsax.call,
          value: AppTexts.preferredVehicleCallForRates,
        ),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'PARTY BUS',
      imageAsset: AppImages.preferredPartyBus,
      features: [
        HomePreferredVehicleFeature(
          icon: Iconsax.call,
          value: AppTexts.preferredVehicleCallForRates,
        ),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'LUXURY SUV',
      imageAsset: AppImages.preferredLuxurySuv,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '5'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '5'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.flash_1, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'PREMIUM SUV',
      imageAsset: AppImages.preferredPremiumSuv,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '5'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '5'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.flash_1, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'COACH BUS',
      imageAsset: AppImages.preferredCoachBus,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '56'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '60'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.flash_1, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'EXECUTIVE\nMINI BUS',
      imageAsset: AppImages.preferredExecutiveMiniBus,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '27'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '27'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.flash_1, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'JET - SPRINTER',
      imageAsset: AppImages.preferredJetSprinter,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '8'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '0'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'MERCEDES BENZ\nMAYBACH S680',
      imageAsset: AppImages.preferredMercedesMaybachS680,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '2'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '0'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'MERCEDES EXECUTIVE\nSPRINTER',
      imageAsset: AppImages.preferredMercedesExecutiveSprinter,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '12'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '12'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'MERCEDES LIMO\nSPRINTER',
      imageAsset: AppImages.preferredMercedesLimoSprinter,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '13'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '12'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.card, value: AppTexts.yes),
      ],
    ),
    HomePreferredVehicle(
      title: 'LINCOLN MKT\nLIMOUSINE',
      imageAsset: AppImages.preferredLincolnMktLimo,
      features: [
        HomePreferredVehicleFeature(icon: Iconsax.user, value: '8'),
        HomePreferredVehicleFeature(icon: Iconsax.briefcase, value: '0'),
        HomePreferredVehicleFeature(icon: Iconsax.wifi, value: AppTexts.yes),
        HomePreferredVehicleFeature(icon: Iconsax.note_1, value: AppTexts.yes),
      ],
    ),
  ];
}

class HomeLocationSlide {
  const HomeLocationSlide({
    required this.label,
    required this.imageAsset,
    required this.url,
  });

  final String label;
  final String imageAsset;
  final String url;
}

class HomeLocationTileData {
  const HomeLocationTileData({
    required this.label,
    required this.imageAsset,
    this.url,
  });

  final String label;
  final String imageAsset;
  final String? url;
}

class HomeServiceTileData {
  const HomeServiceTileData({
    required this.title,
    required this.imageAsset,
    required this.titleOnLeft,
    required this.description,
    required this.readMoreLabel,
    required this.readMoreUrl,
    required this.darkPreview,
  });

  final String title;
  final String imageAsset;
  final bool titleOnLeft;
  final String description;
  final String readMoreLabel;
  final String readMoreUrl;
  final bool darkPreview;
}

class HomeProcessCellData {
  const HomeProcessCellData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class HomePreferredVehicleFeature {
  const HomePreferredVehicleFeature({required this.icon, required this.value});

  final IconData icon;
  final String value;
}

class HomePreferredVehicle {
  const HomePreferredVehicle({
    required this.title,
    required this.imageAsset,
    required this.features,
  });

  final String title;
  final String imageAsset;
  final List<HomePreferredVehicleFeature> features;
}

class HomePartnerData {
  const HomePartnerData({required this.imageAsset});

  final String imageAsset;
}
