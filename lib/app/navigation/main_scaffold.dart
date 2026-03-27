import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
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

  final List<Widget> _pages = const <Widget>[
    HomeScreen(),
    FavouriteScreen(),
    DiscoverScreen(),
    BookingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context);
    final List<NavTab> tabs = <NavTab>[
      NavTab(label: t.homeTab, icon: Icons.home_filled),
      NavTab(label: t.favouriteTab, icon: Icons.favorite_outline_rounded),
      NavTab(label: t.discoverTab, icon: Icons.explore_outlined),
      NavTab(label: t.bookingsTab, icon: Icons.history_rounded),
      NavTab(label: t.profileTab, icon: Icons.person_outline_rounded),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        tabs: tabs,
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
