import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/appwrite_config.dart';
import 'package:appwrite/appwrite.dart';
import 'app/app.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  // 2. Initialize Supabase
  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!,
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  Client()
    ..setEndpoint(AppwriteConfig.endpoint)
    ..setProject(AppwriteConfig.projectId)
    ..setSelfSigned(
      status: false,
    ); // For development only, allows self-signed certificates
  runApp(SavoraApp());
}
