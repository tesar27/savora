import 'package:flutter/material.dart';

import 'custom_bottom_nav_bar.dart';
import 'nav_tab.dart';
import '../../features/bookings/presentation/bookings_screen.dart';
import '../../features/discover/presentation/discover_screen.dart';
import '../../features/favourite/presentation/favourite_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const List<NavTab> _tabs = <NavTab>[
    NavTab(label: 'Home', icon: Icons.home_filled),
    NavTab(label: 'Favourite', icon: Icons.favorite_outline_rounded),
    NavTab(label: 'Discover', icon: Icons.explore_outlined),
    NavTab(label: 'Bookings', icon: Icons.history_rounded),
    NavTab(label: 'Profile', icon: Icons.person_outline_rounded),
  ];

  final List<Widget> _pages = const <Widget>[
    HomeScreen(),
    FavouriteScreen(),
    DiscoverScreen(),
    BookingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        tabs: _tabs,
        currentIndex: _currentIndex,
        onSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
