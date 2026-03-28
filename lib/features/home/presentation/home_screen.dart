import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'models/home_models.dart';
import 'widgets/category_selector.dart';
import 'widgets/food_venue_card.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<HomeCategory> _categories = <HomeCategory>[
    HomeCategory(icon: Icons.local_fire_department_rounded, label: 'Popular'),
    HomeCategory(icon: Icons.local_pizza_rounded, label: 'Western'),
    HomeCategory(icon: Icons.coffee_rounded, label: 'Drinks'),
    HomeCategory(icon: Icons.bakery_dining_rounded, label: 'Bakery'),
    HomeCategory(icon: Icons.icecream_rounded, label: 'Dessert'),
  ];

  static const List<DealSectionModel> _sections = <DealSectionModel>[
    DealSectionModel(
      title: 'Nearby',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/5938/food-salad-healthy-lunch.jpg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Fino',
          subtitle: 'Cafe, Ice Cream, Drinks',
          rating: 4.8,
          distance: '70 km',
          redeemedText: '100+ redeemed',
          tags: <String>['2-for-1 cakes', '2-for-1 winery deal'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Tama Bistro',
          subtitle: 'Bistro, Burgers, Lunch',
          rating: 4.9,
          distance: '71 km',
          redeemedText: '100+ redeemed',
          tags: <String>['2-for-1 main dish'],
        ),
      ],
    ),
    DealSectionModel(
      title: 'Top 10 Highlights',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/2619967/pexels-photo-2619967.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: "L'Osteria Freiburg Ramparts",
          subtitle: 'Italian, Pizza, Pasta',
          rating: 4.8,
          distance: '71 km',
          rank: '#1',
          redeemedText: '3.8k+ redeemed',
          tags: <String>['2-for-1 pasta', '2-for-1 aperitif'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/4958792/pexels-photo-4958792.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Enchilada Freiburg',
          subtitle: 'Mexican, Tacos, Dinner',
          rating: 4.8,
          distance: '71 km',
          rank: '#2',
          redeemedText: '2.4k+ redeemed',
          tags: <String>['2-for-1 main dish'],
        ),
      ],
    ),
    DealSectionModel(
      title: 'Trending',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Golden Slice',
          subtitle: 'Pizza, Casual Dining',
          rating: 4.7,
          distance: '18 km',
          redeemedText: '2k+ redeemed',
          tags: <String>['2-for-1 family pizza'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/1437267/pexels-photo-1437267.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Urban Grill',
          subtitle: 'Steak, Burgers',
          rating: 4.6,
          distance: '23 km',
          redeemedText: '1.5k+ redeemed',
          tags: <String>['2-for-1 burgers'],
        ),
      ],
    ),
    DealSectionModel(
      title: 'Top Rated',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Rosso Trattoria',
          subtitle: 'Italian, Fine Dining',
          rating: 4.9,
          distance: '11 km',
          redeemedText: '1.1k+ redeemed',
          tags: <String>['2-for-1 tasting menu'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/2233729/pexels-photo-2233729.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Sea Cove',
          subtitle: 'Seafood, Grill',
          rating: 4.9,
          distance: '15 km',
          redeemedText: '950+ redeemed',
          tags: <String>['2-for-1 chef special'],
        ),
      ],
    ),
    DealSectionModel(
      title: 'New on Savora',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'The Brunch Lab',
          subtitle: 'Brunch, Coffee',
          rating: 4.6,
          distance: '8 km',
          redeemedText: '350+ redeemed',
          tags: <String>['2-for-1 brunch combo'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Sora Ramen',
          subtitle: 'Japanese, Noodles',
          rating: 4.7,
          distance: '9 km',
          redeemedText: '420+ redeemed',
          tags: <String>['2-for-1 ramen bowls'],
        ),
      ],
    ),
    DealSectionModel(
      title: 'My Favorites',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'The Noodle House',
          subtitle: 'Asian, Noodles',
          rating: 4.8,
          distance: '12 km',
          redeemedText: '860+ redeemed',
          tags: <String>['2-for-1 noodle set'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/725991/pexels-photo-725991.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Bella Verona',
          subtitle: 'Italian, Pasta',
          rating: 4.8,
          distance: '17 km',
          redeemedText: '1.2k+ redeemed',
          tags: <String>['2-for-1 pasta plate'],
        ),
      ],
    ),
    DealSectionModel(
      title: 'Pizza',
      items: <FoodVenueCardModel>[
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Pizza Harbor',
          subtitle: 'Pizza, Delivery',
          rating: 4.7,
          distance: '10 km',
          redeemedText: '700+ redeemed',
          tags: <String>['2-for-1 Margherita'],
        ),
        FoodVenueCardModel(
          imageUrl:
              'https://images.pexels.com/photos/4109074/pexels-photo-4109074.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Stone Oven Co.',
          subtitle: 'Wood-fired Pizza',
          rating: 4.8,
          distance: '16 km',
          redeemedText: '980+ redeemed',
          tags: <String>['2-for-1 pizza slices'],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const _HomeView(categories: _categories, sections: _sections);
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({required this.categories, required this.sections});

  final List<HomeCategory> categories;
  final List<DealSectionModel> sections;

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  static const List<_CityOption> _cities = <_CityOption>[
    _CityOption(country: _CityCountry.switzerland, name: 'Zurich', deals: 626),
    _CityOption(country: _CityCountry.switzerland, name: 'Geneva', deals: 354),
    _CityOption(country: _CityCountry.switzerland, name: 'Basel', deals: 268),
    _CityOption(country: _CityCountry.switzerland, name: 'Bern', deals: 210),
    _CityOption(
      country: _CityCountry.switzerland,
      name: 'Lausanne',
      deals: 188,
    ),
    _CityOption(country: _CityCountry.switzerland, name: 'Lucerne', deals: 142),
    _CityOption(country: _CityCountry.switzerland, name: 'Freiburg', deals: 78),
    _CityOption(
      country: _CityCountry.switzerland,
      name: 'St. Gallen',
      deals: 100,
    ),
    _CityOption(
      country: _CityCountry.switzerland,
      name: 'Winterthur',
      deals: 104,
    ),
    _CityOption(country: _CityCountry.switzerland, name: 'Lugano', deals: 98),
    _CityOption(country: _CityCountry.switzerland, name: 'Zug', deals: 94),
    _CityOption(
      country: _CityCountry.germany,
      name: 'Freiburg im Breisgau',
      deals: 210,
    ),
    _CityOption(country: _CityCountry.germany, name: 'Konstanz', deals: 188),
    _CityOption(country: _CityCountry.germany, name: 'Loerrach', deals: 142),
    _CityOption(
      country: _CityCountry.germany,
      name: 'Weil am Rhein',
      deals: 104,
    ),
    _CityOption(
      country: _CityCountry.germany,
      name: 'Waldshut-Tiengen',
      deals: 96,
    ),
    _CityOption(country: _CityCountry.germany, name: 'Singen', deals: 94),
    _CityOption(
      country: _CityCountry.germany,
      name: 'Villingen-Schwenningen',
      deals: 100,
    ),
    _CityOption(country: _CityCountry.germany, name: 'Offenburg', deals: 78),
    _CityOption(
      country: _CityCountry.germany,
      name: 'Friedrichshafen',
      deals: 98,
    ),
  ];

  int _selectedCategory = 0;
  String _selectedCity = 'Freiburg';

  String _localizedSectionTitle(AppLocalizations t, String sourceTitle) {
    switch (sourceTitle) {
      case 'Nearby':
        return t.nearby;
      case 'Top 10 Highlights':
        return t.top10Highlights;
      case 'Trending':
        return t.trending;
      case 'Top Rated':
        return t.topRated;
      case 'New on Savora':
        return t.newOnSavora;
      case 'My Favorites':
        return t.myFavorites;
      case 'Pizza':
        return t.pizza;
      default:
        return sourceTitle;
    }
  }

  String _countryLabel(AppLocalizations t, _CityCountry country) {
    final bool isGerman = t.locale.languageCode == 'de';

    switch (country) {
      case _CityCountry.switzerland:
        return isGerman ? 'SCHWEIZ' : 'SWITZERLAND';
      case _CityCountry.germany:
        return isGerman ? 'DEUTSCHLAND' : 'GERMANY';
    }
  }

  Future<void> _openCityPicker(AppLocalizations t) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final TextTheme textTheme = Theme.of(context).textTheme;
        final double maxHeight = MediaQuery.of(context).size.height * 0.88;

        return SafeArea(
          top: false,
          child: Container(
            constraints: BoxConstraints(maxHeight: maxHeight + 65),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  width: 58,
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD5D5D5),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          t.cities,
                          style: textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF111111),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          color: const Color(0xFFF4F4F4),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => Navigator.of(context).pop(),
                            child: const SizedBox(
                              width: 44,
                              height: 44,
                              child: Icon(
                                Icons.close_rounded,
                                color: Color(0xFF777777),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                    children: <Widget>[
                      _CitySection(
                        label: _countryLabel(t, _CityCountry.switzerland),
                        countryCode: 'CH',
                        items: _cities
                            .where(
                              (_CityOption city) =>
                                  city.country == _CityCountry.switzerland,
                            )
                            .toList(),
                        selectedCity: _selectedCity,
                        dealsLabel: 'Deals',
                        onSelected: _selectCity,
                      ),
                      _CitySection(
                        label: _countryLabel(t, _CityCountry.germany),
                        countryCode: 'DE',
                        items: _cities
                            .where(
                              (_CityOption city) =>
                                  city.country == _CityCountry.germany,
                            )
                            .toList(),
                        selectedCity: _selectedCity,
                        dealsLabel: 'Deals',
                        onSelected: _selectCity,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectCity(_CityOption city) {
    setState(() {
      _selectedCity = city.name;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppLocalizations t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HomeHeader(
                      cityName: _selectedCity,
                      onCityTap: () => _openCityPicker(t),
                    ),
                    const SizedBox(height: 16),
                    CategorySelector(
                      categories: widget.categories,
                      selectedIndex: _selectedCategory,
                      onSelected: (int index) {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
              sliver: SliverList.separated(
                itemBuilder: (BuildContext context, int index) {
                  final DealSectionModel section = widget.sections[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _localizedSectionTitle(t, section.title),
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1C1F2D),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 306,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: section.items.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(width: 16),
                            itemBuilder: (BuildContext context, int index) {
                              return FoodVenueCard(item: section.items[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 26),
                itemCount: widget.sections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _CityCountry { switzerland, germany }

class _CityOption {
  const _CityOption({
    required this.country,
    required this.name,
    required this.deals,
  });

  final _CityCountry country;
  final String name;
  final int deals;
}

class _CitySection extends StatelessWidget {
  const _CitySection({
    required this.label,
    required this.countryCode,
    required this.items,
    required this.selectedCity,
    required this.dealsLabel,
    required this.onSelected,
  });

  final String label;
  final String countryCode;
  final List<_CityOption> items;
  final String selectedCity;
  final String dealsLabel;
  final ValueChanged<_CityOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 18),
          child: Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Text(
                  countryCode,
                  style: textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF111111),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF7A7A86),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE7E7E7)),
        for (final _CityOption city in items) ...<Widget>[
          InkWell(
            onTap: () => onSelected(city),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 38,
                    child: city.name == selectedCity
                        ? Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4BE289),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              size: 20,
                              color: Color(0xFF111111),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Text(
                        city.name,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: city.name == selectedCity
                              ? FontWeight.w800
                              : FontWeight.w700,
                          color: city.name == selectedCity
                              ? const Color(0xFF171A24)
                              : const Color(0xFF7C7D89),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${city.deals} $dealsLabel',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: city.name == selectedCity
                          ? const Color(0xFF6B6C78)
                          : const Color(0xFF7C7D89),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 84, right: 28),
            child: Divider(height: 1, color: Color(0xFFE7E7E7)),
          ),
        ],
      ],
    );
  }
}
