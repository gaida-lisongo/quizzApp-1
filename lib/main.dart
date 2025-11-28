import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizz_game/core/config/app_theme.dart';
import 'package:quizz_game/ui/dashboard/home_page.dart';
import 'package:quizz_game/ui/dashboard/login_page.dart';
import 'package:quizz_game/ui/common/loading_indicator.dart';

Future<void> main() async {
  // S'assurer que les liaisons Flutter sont initialisées pour les plugins (comme flutter_secure_storage)
  WidgetsFlutterBinding.ensureInitialized();
  
  // Charger les variables d'environnement depuis .env
  await dotenv.load(fileName: ".env");
  
  runApp(
    // Envelopper l'application avec ProviderScope pour activer Riverpod
    const ProviderScope(
      child: QuizApp(),
    ),
  );
}

class QuizApp extends ConsumerWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Définir le routing
    return MaterialApp(
      title: 'Quiz Game (Dark)',
      theme: darkTheme, // Thème sombre
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialLoaderScreen(), 
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(), 
      },
    );
  }
}

// ------------------------------------------------------------------
// L'écran de démarrage : Gère l'Auto-Login et la Redirection
// ------------------------------------------------------------------

class InitialLoaderScreen extends ConsumerStatefulWidget {
  const InitialLoaderScreen({super.key});

  @override
  ConsumerState<InitialLoaderScreen> createState() => _InitialLoaderScreenState();
}

class _InitialLoaderScreenState extends ConsumerState<InitialLoaderScreen> {
  bool _isInit = false; 

  @override
  void initState() {
    super.initState();
    
    // ⏩ BYPASS AUTO-LOGIN PENDANT LE DEVELOPPEMENT
    // Lance directement vers la login page après 500ms pour simuler le chargement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInit) {
        _isInit = true;
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Affiche un indicateur de chargement
    return const Scaffold(
      backgroundColor: Colors.black, 
      body: Center(child: LoadingIndicator()),
    );
  }
}