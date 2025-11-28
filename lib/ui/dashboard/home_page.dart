import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz_game/core/config/app_theme.dart';
import 'package:quizz_game/ui/common/balance_widget.dart';
import 'package:quizz_game/ui/common/custom_button.dart';
import 'package:quizz_game/store/user/user_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Observer l'état de l'utilisateur
    final user = ref.watch(userProvider);
    
    // 💡 Redirection de sécurité (si l'utilisateur se déconnecte depuis une autre page)
    if (user == null) {
      // Utilisation d'un PostFrameCallback pour éviter une erreur pendant le build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      // Affiche un conteneur vide ou un loader pendant la redirection
      return const Scaffold(body: Center(child: CircularProgressIndicator())); 
    }

    // 2. Si l'utilisateur est présent (user != null), afficher le contenu
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue, ${user.pseudo}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: secondaryColor), // Rouge Sang
            onPressed: () async {
              await ref.read(userProvider.notifier).logout();
              // La redirection vers /login sera gérée par l'état null du user.
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget d'affichage des Pièces et du Solde
            BalanceWidget(pieces: user.pieces, solde: user.solde),
            const SizedBox(height: 30),

            // Bouton Principal pour Démarrer le Jeu
            CustomButton(
              text: 'DÉMARRER UN NOUVEAU QUIZ',
              onPressed: () {
                // TODO: Naviguer vers la Page des Catégories
                // Navigator.of(context).pushNamed('/categories'); 
              },
              backgroundColor: secondaryColor, // Rouge Sang
            ),
            const SizedBox(height: 30),

            // Section Navigation Rapide
            const Text(
              'Mes Activités',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: lightTextColor,
              ),
            ),
            const Divider(color: Colors.white12),
            
            // Bouton Profil
            ListTile(
              leading: const Icon(Icons.person, color: accentColor),
              title: const Text('Mon Profil'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigator.of(context).pushNamed('/profile');
              },
            ),
            
            // Bouton Transactions/Recharges
            ListTile(
              leading: const Icon(Icons.history, color: accentColor),
              title: const Text('Historique des Transactions'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigator.of(context).pushNamed('/transactions');
              },
            ),
          ],
        ),
      ),
    );
  }
}