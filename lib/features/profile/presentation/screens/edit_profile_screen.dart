import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../controllers/profile_controller.dart';
import '../controllers/profile_scope.dart';
import '../widgets/profile_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _initialized = false;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }

    final ProfileController profile = ProfileScope.of(context);

    _firstNameController = TextEditingController(text: profile.firstName);
    _lastNameController = TextEditingController(text: profile.lastName);
    _emailController = TextEditingController(text: profile.email);
    _passwordController = TextEditingController(text: profile.password);
    _initialized = true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context);
    final ProfileController profile = ProfileScope.of(context);
    final Uint8List? avatarBytes = profile.avatarBytes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          t.editProfile,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF161922),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: <Widget>[
          Align(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 52,
                  backgroundColor: const Color(0xFF50E88D),
                  backgroundImage: avatarBytes != null
                      ? MemoryImage(avatarBytes)
                      : null,
                  child: avatarBytes == null
                      ? Text(
                          profile.initials,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF156A35),
                              ),
                        )
                      : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await profile.pickAvatarImage();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF161922),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: TextButton(
              onPressed: () async {
                await profile.pickAvatarImage();
                if (mounted) {
                  setState(() {});
                }
              },
              child: Text(t.changePhoto),
            ),
          ),
          const SizedBox(height: 18),
          ProfileFormField(
            label: t.firstName,
            controller: _firstNameController,
          ),
          const SizedBox(height: 16),
          ProfileFormField(label: t.lastName, controller: _lastNameController),
          const SizedBox(height: 16),
          ProfileFormField(
            label: t.emailAddress,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          ProfileFormField(
            label: t.password,
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF50E88D),
                foregroundColor: const Color(0xFF10202C),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                profile.updateProfile(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text(
                t.saveChanges,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
