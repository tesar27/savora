import 'package:flutter/material.dart';

class ProfilePromoBanner extends StatelessWidget {
  const ProfilePromoBanner({
    required this.title,
    required this.buttonLabel,
    super.key,
  });

  final String title;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: SizedBox(
        height: 244,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              'https://images.pexels.com/photos/1267320/pexels-photo-1267320.jpeg?auto=compress&cs=tinysrgb&w=1200',
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stack) {
                    return Container(color: const Color(0xFF123E23));
                  },
            ),
            Container(color: const Color(0xB3123E23)),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF50E88D),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      buttonLabel,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF0D1D1B),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
