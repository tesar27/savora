import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: <Widget>[
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 24, color: const Color(0xFF111111)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF171A24),
                    ),
              ),
            ),
            trailing ?? const Icon(Icons.chevron_right_rounded, size: 34),
          ],
        ),
      ),
    );
  }
}
