import 'package:flutter/material.dart';

import 'profile_controller.dart';

class ProfileScope extends InheritedNotifier<ProfileController> {
  const ProfileScope({
    required ProfileController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static ProfileController of(BuildContext context) {
    final ProfileScope? scope = context
        .dependOnInheritedWidgetOfExactType<ProfileScope>();

    assert(scope != null, 'ProfileScope not found in widget tree.');
    return scope!.notifier!;
  }
}
