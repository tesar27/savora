import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import 'models/home_models.dart';
import 'widgets/category_selector.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<HomeCategory> _categories = <HomeCategory>[
    HomeCategory(icon: Icons.local_fire_department_rounded, label: 'Popular'),
    HomeCategory(icon: Icons.local_pizza_rounded, label: 'Western'),
    HomeCategory(icon: Icons.coffee_rounded, label: 'Drinks'),
    HomeCategory(icon: Icons.emoji_food_beverage_rounded, label: 'Local'),
    HomeCategory(icon: Icons.icecream_rounded, label: 'Dessert'),
  ];

  static const List<RecipeCardModel> _popularRecipes = <RecipeCardModel>[
    RecipeCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=700&q=80',
      title: 'Chicken Curry',
      cuisine: 'Asian',
      duration: '15 mins',
      rating: 4.8,
    ),
    RecipeCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?auto=format&fit=crop&w=700&q=80',
      title: 'Crepes with Orange',
      cuisine: 'Western',
      duration: '35 mins',
      rating: 4.5,
    ),
    RecipeCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1613145993481-8c89f0212578?auto=format&fit=crop&w=700&q=80',
      title: 'Meatball Pasta',
      cuisine: 'Italian',
      duration: '28 mins',
      rating: 4.7,
    ),
    RecipeCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=700&q=80',
      title: 'Shrimp Bowl',
      cuisine: 'Seafood',
      duration: '20 mins',
      rating: 4.9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const _HomeView(
      categories: _categories,
      popularRecipes: _popularRecipes,
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({
    required this.categories,
    required this.popularRecipes,
  });

  final List<HomeCategory> categories;
  final List<RecipeCardModel> popularRecipes;

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
                AppSpacing.md,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const HomeHeader(),
                    const SizedBox(height: 18),
                    const HomeSearchBar(),
                    const SizedBox(height: 20),
                    CategorySelector(
                      categories: widget.categories,
                      selectedIndex: _selectedCategory,
                      onSelected: (int index) {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Popular Recipes', style: textTheme.titleMedium),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemCount: widget.popularRecipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeCard(recipe: widget.popularRecipes[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
