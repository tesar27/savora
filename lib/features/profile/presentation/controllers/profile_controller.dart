import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {
  ProfileController();

  final ImagePicker _imagePicker = ImagePicker();

  Uint8List? _avatarBytes;
  String _firstName = 'Yerbolat';
  String _lastName = '';
  String _email = 'yerbolat@example.com';
  String _password = 'password123';

  Uint8List? get avatarBytes => _avatarBytes;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;

  String get displayName {
    final String combined = '$_firstName $_lastName'.trim();
    return combined.isEmpty ? 'Savora User' : combined;
  }

  String get initials {
    final List<String> segments = <String>[_firstName, _lastName]
        .where((String value) => value.trim().isNotEmpty)
        .toList();

    if (segments.isEmpty) {
      return 'SU';
    }

    return segments
        .take(2)
        .map((String part) => part.characters.first.toUpperCase())
        .join();
  }

  Future<void> pickAvatarImage() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );

    if (file == null) {
      return;
    }

    _avatarBytes = await file.readAsBytes();
    notifyListeners();
  }

  void updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    _firstName = firstName.trim();
    _lastName = lastName.trim();
    _email = email.trim();
    _password = password;
    notifyListeners();
  }
}
