import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'models/home_models.dart';
import 'widgets/category_selector.dart';
import 'widgets/home_header.dart';
import 'widgets/recipe_card.dart';

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
      items: <DealCardModel>[
        DealCardModel(
          imageUrl:
              'https://images.pexels.com/photos/5938/food-salad-healthy-lunch.jpg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Fino',
          subtitle: 'Cafe, Ice Cream, Drinks',
          rating: 4.8,
          distance: '70 km',
          redeemedText: '100+ redeemed',
          tags: <String>['2-for-1 cakes', '2-for-1 winery deal'],
        ),
        DealCardModel(
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
      items: <DealCardModel>[
        DealCardModel(
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
        DealCardModel(
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
      items: <DealCardModel>[
        DealCardModel(
          imageUrl:
              'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Golden Slice',
          subtitle: 'Pizza, Casual Dining',
          rating: 4.7,
          distance: '18 km',
          redeemedText: '2k+ redeemed',
          tags: <String>['2-for-1 family pizza'],
        ),
        DealCardModel(
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
      items: <DealCardModel>[
        DealCardModel(
          imageUrl:
              'https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Rosso Trattoria',
          subtitle: 'Italian, Fine Dining',
          rating: 4.9,
          distance: '11 km',
          redeemedText: '1.1k+ redeemed',
          tags: <String>['2-for-1 tasting menu'],
        ),
        DealCardModel(
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
      items: <DealCardModel>[
        DealCardModel(
          imageUrl:
              'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'The Brunch Lab',
          subtitle: 'Brunch, Coffee',
          rating: 4.6,
          distance: '8 km',
          redeemedText: '350+ redeemed',
          tags: <String>['2-for-1 brunch combo'],
        ),
        DealCardModel(
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
      items: <DealCardModel>[
        DealCardModel(
          imageUrl:
              'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'The Noodle House',
          subtitle: 'Asian, Noodles',
          rating: 4.8,
          distance: '12 km',
          redeemedText: '860+ redeemed',
          tags: <String>['2-for-1 noodle set'],
        ),
        DealCardModel(
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
      items: <DealCardModel>[
        DealCardModel(
          imageUrl:
              'https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?auto=compress&cs=tinysrgb&w=1200',
          title: 'Pizza Harbor',
          subtitle: 'Pizza, Delivery',
          rating: 4.7,
          distance: '10 km',
          redeemedText: '700+ redeemed',
          tags: <String>['2-for-1 Margherita'],
        ),
        DealCardModel(
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
  int _selectedCategory = 0;

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
                    HomeHeader(cityName: t.cityFreiburg),
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
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
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
                              return RecipeCard(item: section.items[index]);
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
