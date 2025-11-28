import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/ui/common/custom_button.dart';
import 'package:quizz_game/core/config/app_theme.dart';
import 'package:quizz_game/store/user/user_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController(text: 'test@example.com');
  final _passwordController = TextEditingController(text: 'password123');
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Appel de l'action de connexion via le Notifier
      // Le service retournera des fake data si l'API ne répond pas
      await ref.read(userProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
          );

      // Si succès, naviguer vers home
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }

    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion : ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleDemoLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Utilise des credentials de démo pour charger les fake data
      await ref.read(userProvider.notifier).login('demo', 'demo');
      
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur démo : ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quiz Game',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor, // Bleu Marin
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Champ Email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: accentColor), // Jaune
                    ),
                    validator: (v) => v!.isEmpty ? 'Veuillez entrer votre email' : null,
                  ),
                  const SizedBox(height: 16),

                  // Champ Mot de passe
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Mot de passe',
                      prefixIcon: Icon(Icons.lock, color: accentColor),
                    ),
                    validator: (v) => v!.isEmpty ? 'Veuillez entrer votre mot de passe' : null,
                  ),
                  const SizedBox(height: 30),

                  // Message d'erreur
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: secondaryColor, fontWeight: FontWeight.bold), // Rouge Sang
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Bouton de Connexion
                  CustomButton(
                    text: 'SE CONNECTER',
                    onPressed: _handleLogin,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 12),

                  // Bouton DEMO (charge fake data)
                  CustomButton(
                    text: '🎮 DEMO MODE',
                    onPressed: _handleDemoLogin,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 20),

                  // Lien Inscription (à coder plus tard)
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/register');
                    },
                    child: const Text(
                      "Pas encore de compte ? S'inscrire",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}