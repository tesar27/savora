import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
  ];

  static AppLocalizations of(BuildContext context) {
    final AppLocalizations? localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );

    assert(localizations != null, 'AppLocalizations not found in context.');
    return localizations!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
        'en': <String, String>{
          'appTitle': 'Savora',
          'homeTab': 'Home',
          'favouriteTab': 'Favourite',
          'discoverTab': 'Discover',
          'bookingsTab': 'Bookings',
          'profileTab': 'Profile',
          'cityFreiburg': 'Freiburg',
          'nearby': 'Nearby',
          'top10Highlights': 'Top 10 Highlights',
          'trending': 'Trending',
          'topRated': 'Top Rated',
          'newOnSavora': 'New on Savora',
          'myFavorites': 'My Favorites',
          'pizza': 'Pizza',
          'settings': 'Settings',
          'language': 'Language',
          'languageSystem': 'System Default',
          'languageEnglish': 'English',
          'languageGerman': 'German',
          'favouriteTitle': 'Favourite',
          'discoverTitle': 'Discover',
          'bookingsTitle': 'Bookings',
          'profileTitle': 'Profile',
          'editProfile': 'Edit Profile',
          'changePhoto': 'Change Photo',
          'saveChanges': 'Save Changes',
          'firstName': 'First Name',
          'lastName': 'Last Name',
          'emailAddress': 'Email Address',
          'password': 'Password',
          'favorites': 'Favorites',
          'savings': 'Savings',
          'deals': 'Deals',
          'level': 'Level',
          'restaurants': 'Restaurants',
          'cities': 'Cities',
          'rating': 'Rating',
          'reviews': 'Reviews',
          'inviteFriends': 'Invite Friends',
          'friends': 'Friends',
          'membership': 'Membership',
          'helpSupport': 'Help & Support',
          'sendGiftCard': 'Send Gift Card',
          'editProfileSubtitle': 'Edit profile',
          'freeMonthBanner': '1 Month Savora free!',
          'inviteFriendsBanner': 'Invite Friends',
        },
        'de': <String, String>{
          'appTitle': 'Savora',
          'homeTab': 'Start',
          'favouriteTab': 'Favoriten',
          'discoverTab': 'Entdecken',
          'bookingsTab': 'Buchungen',
          'profileTab': 'Profil',
          'cityFreiburg': 'Freiburg',
          'nearby': 'In deiner Nahe',
          'top10Highlights': 'Top 10 Highlights',
          'trending': 'Trending',
          'topRated': 'Top bewertet',
          'newOnSavora': 'Neu bei Savora',
          'myFavorites': 'Meine Favoriten',
          'pizza': 'Pizza',
          'settings': 'Einstellungen',
          'language': 'Sprache',
          'languageSystem': 'Systemsprache',
          'languageEnglish': 'Englisch',
          'languageGerman': 'Deutsch',
          'favouriteTitle': 'Favoriten',
          'discoverTitle': 'Entdecken',
          'bookingsTitle': 'Buchungen',
          'profileTitle': 'Profil',
          'editProfile': 'Profil bearbeiten',
          'changePhoto': 'Foto andern',
          'saveChanges': 'Anderungen speichern',
          'firstName': 'Vorname',
          'lastName': 'Nachname',
          'emailAddress': 'E-Mail-Adresse',
          'password': 'Passwort',
          'favorites': 'Favoriten',
          'savings': 'Ersparnis',
          'deals': 'Deals',
          'level': 'Level',
          'restaurants': 'Restaurants',
          'cities': 'Stadte',
          'rating': 'Bewertung',
          'reviews': 'Rezensionen',
          'inviteFriends': 'Freund*innen einladen',
          'friends': 'Freunde',
          'membership': 'Mitgliedschaft',
          'helpSupport': 'Hilfe & Support',
          'sendGiftCard': 'Geschenkkarte senden',
          'editProfileSubtitle': 'Profil bearbeiten',
          'freeMonthBanner': '1 Monat NeoTaste gratis!',
          'inviteFriendsBanner': 'Freund*innen einladen',
        },
      };

  String _text(String key) {
    final String languageCode =
        _localizedValues.containsKey(locale.languageCode)
        ? locale.languageCode
        : 'en';

    return _localizedValues[languageCode]?[key] ??
        _localizedValues['en']![key] ??
        key;
  }

  String get appTitle => _text('appTitle');
  String get homeTab => _text('homeTab');
  String get favouriteTab => _text('favouriteTab');
  String get discoverTab => _text('discoverTab');
  String get bookingsTab => _text('bookingsTab');
  String get profileTab => _text('profileTab');
  String get cityFreiburg => _text('cityFreiburg');
  String get nearby => _text('nearby');
  String get top10Highlights => _text('top10Highlights');
  String get trending => _text('trending');
  String get topRated => _text('topRated');
  String get newOnSavora => _text('newOnSavora');
  String get myFavorites => _text('myFavorites');
  String get pizza => _text('pizza');
  String get settings => _text('settings');
  String get language => _text('language');
  String get languageSystem => _text('languageSystem');
  String get languageEnglish => _text('languageEnglish');
  String get languageGerman => _text('languageGerman');
  String get favouriteTitle => _text('favouriteTitle');
  String get discoverTitle => _text('discoverTitle');
  String get bookingsTitle => _text('bookingsTitle');
  String get profileTitle => _text('profileTitle');
  String get editProfile => _text('editProfile');
  String get changePhoto => _text('changePhoto');
  String get saveChanges => _text('saveChanges');
  String get firstName => _text('firstName');
  String get lastName => _text('lastName');
  String get emailAddress => _text('emailAddress');
  String get password => _text('password');
  String get favorites => _text('favorites');
  String get savings => _text('savings');
  String get deals => _text('deals');
  String get level => _text('level');
  String get restaurants => _text('restaurants');
  String get cities => _text('cities');
  String get rating => _text('rating');
  String get reviews => _text('reviews');
  String get inviteFriends => _text('inviteFriends');
  String get friends => _text('friends');
  String get membership => _text('membership');
  String get helpSupport => _text('helpSupport');
  String get sendGiftCard => _text('sendGiftCard');
  String get editProfileSubtitle => _text('editProfileSubtitle');
  String get freeMonthBanner => _text('freeMonthBanner');
  String get inviteFriendsBanner => _text('inviteFriendsBanner');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .map((Locale item) => item.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
