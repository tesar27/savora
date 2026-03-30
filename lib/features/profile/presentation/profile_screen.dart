import 'package:flutter/material.dart';

import '../../../core/di/repositories.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/services/anonymous_user_service.dart';
import '../../../core/settings/app_settings_controller.dart';
import '../../../core/settings/app_settings_scope.dart';
import '../../booking/data/repositories/local_booking_repository.dart';
import 'controllers/profile_controller.dart';
import 'controllers/profile_scope.dart';
import 'screens/edit_profile_screen.dart';
import 'widgets/profile_menu_tile.dart';
import 'widgets/profile_promo_banner.dart';
import 'widgets/profile_stat_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _dealsCount = 0;
  double _savingsEuros = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
    LocalBookingRepository.version.addListener(_onVersionChange);
  }

  @override
  void dispose() {
    LocalBookingRepository.version.removeListener(_onVersionChange);
    super.dispose();
  }

  void _onVersionChange() => _loadStats();

  Future<void> _loadStats() async {
    final String userId = await AnonymousUserService.ensureUserId();
    final int count =
        await Repositories.bookings.countRedeemed(userId: userId);
    final double savings =
        await Repositories.bookings.totalSavingsEuros(userId: userId);
    if (mounted) {
      setState(() {
        _dealsCount = count;
        _savingsEuros = savings;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context);
    final AppSettingsController settings = AppSettingsScope.of(context);

    final String savingsLabel = _savingsEuros == 0
        ? '0 €'
        : _savingsEuros == _savingsEuros.truncateToDouble()
            ? '${_savingsEuros.toInt()} €'
            : '${_savingsEuros.toStringAsFixed(0)} €';
    final ProfileController profile = ProfileScope.of(context);
    final List<({IconData icon, String value, String label})> stats =
        <({IconData icon, String value, String label})>[
          (icon: Icons.favorite_rounded, value: '2', label: t.favorites),
          (
            icon: Icons.account_balance_wallet_rounded,
            value: savingsLabel,
            label: t.savings,
          ),
          (
            icon: Icons.local_offer_rounded,
            value: '$_dealsCount',
            label: t.deals,
          ),
          (icon: Icons.emoji_events_rounded, value: '0', label: t.level),
          (icon: Icons.storefront_rounded, value: '12', label: t.restaurants),
          (icon: Icons.location_city_rounded, value: '3', label: t.cities),
          (icon: Icons.star_rounded, value: '4.8', label: t.rating),
          (
            icon: Icons.chat_bubble_outline_rounded,
            value: '7',
            label: t.reviews,
          ),
        ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
          children: <Widget>[
            Text(
              t.profileTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1C1F2D),
              ),
            ),
            const SizedBox(height: 28),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const EditProfileScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: const Color(0xFF50E88D),
                      backgroundImage: profile.avatarBytes != null
                          ? MemoryImage(profile.avatarBytes!)
                          : null,
                      child: profile.avatarBytes == null
                          ? Text(
                              profile.initials,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF146734),
                                  ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            profile.displayName,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF171A24),
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            t.editProfileSubtitle,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: const Color(0xFF5E6068),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, size: 34),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: stats.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 14),
                itemBuilder: (BuildContext context, int index) {
                  final ({IconData icon, String value, String label}) stat =
                      stats[index];

                  return ProfileStatCard(
                    icon: stat.icon,
                    value: stat.value,
                    label: stat.label,
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            ProfilePromoBanner(
              title: t.freeMonthBanner,
              buttonLabel: t.inviteFriendsBanner,
            ),
            const SizedBox(height: 28),
            ProfileMenuTile(icon: Icons.group_rounded, title: t.friends),
            const Divider(height: 1, color: Color(0xFFEAEAEA)),
            ProfileMenuTile(
              icon: Icons.workspace_premium_rounded,
              title: t.membership,
            ),
            const Divider(height: 1, color: Color(0xFFEAEAEA)),
            ProfileMenuTile(
              icon: Icons.chat_bubble_outline_rounded,
              title: t.helpSupport,
            ),
            const Divider(height: 1, color: Color(0xFFEAEAEA)),
            ProfileMenuTile(
              icon: Icons.card_giftcard_rounded,
              title: t.sendGiftCard,
            ),
            const Divider(height: 1, color: Color(0xFFEAEAEA)),
            ProfileMenuTile(
              icon: Icons.language_rounded,
              title: t.language,
              trailing: Theme(
                data: Theme.of(context).copyWith(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  canvasColor: Colors.white, // menu background
                ),
                child: DropdownButton<AppLanguage>(
                  value: settings.language,
                  underline: const SizedBox.shrink(),
                  onChanged: (AppLanguage? value) {
                    if (value != null) {
                      settings.updateLanguage(value);
                    }
                  },
                  items: <DropdownMenuItem<AppLanguage>>[
                    DropdownMenuItem<AppLanguage>(
                      value: AppLanguage.system,
                      child: Text(t.languageSystem),
                    ),
                    DropdownMenuItem<AppLanguage>(
                      value: AppLanguage.english,
                      child: Text(t.languageEnglish),
                    ),
                    DropdownMenuItem<AppLanguage>(
                      value: AppLanguage.german,
                      child: Text(t.languageGerman),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
