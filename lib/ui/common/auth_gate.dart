import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/store/user/user_notifier.dart';
import 'package:quizz_game/ui/dashboard/login_page.dart';

// Ce widget est un "garde-fou" qui s'assure qu'un utilisateur est connecté
class AuthGate extends ConsumerWidget {
  final Widget authenticatedChild;

  const AuthGate({required this.authenticatedChild, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Observer l'état de l'utilisateur
    final user = ref.watch(userProvider);
    
    // 2. Observer si le processus d'auto-login a déjà été tenté
    // (Nous utiliserons un futur provider ou un flag pour suivre cet état,
    // mais pour l'instant, nous supposons que user == null signifie non connecté
    // une fois l'initialisation passée.)
    
    // 💡 Débogage/Amélioration : Dans un vrai scénario, vous voulez un état 'LOADING_APP' 
    // distinct de 'UNAUTHENTICATED'. Pour simplifier, nous utilisons le loader.
    
    // 3. Logique de redirection
    if (user == null) {
      // Si l'utilisateur est null, rediriger vers la page de connexion
      // Utiliser un Navigator.pushReplacement pour empêcher le retour arrière
      
      // On affiche le loader une fraction de seconde pour éviter un "flash"
      // entre la vérification du token et la redirection.
      return const LoginPage(); 
      
    } else {
      // L'utilisateur est authentifié, afficher le contenu de la page demandée
      return authenticatedChild;
    }
  }
}