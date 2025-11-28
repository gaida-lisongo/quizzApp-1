import 'package:flutter/material.dart';
import 'package:quizz_game/core/config/app_theme.dart';

class BalanceWidget extends StatelessWidget {
  final int pieces;
  final double solde;

  const BalanceWidget({
    required this.pieces,
    required this.solde,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // 1. Affiche les Pièces (utilise la couleur d'Accent Jaune)
        _buildItem(
          icon: Icons.monetization_on,
          label: 'Pièces',
          value: pieces.toString(),
          color: accentColor,
        ),
        
        // 2. Affiche le Solde (utilise la couleur Primaire/Bleu)
        _buildItem(
          icon: Icons.account_balance_wallet,
          label: 'Solde',
          value: '${solde.toStringAsFixed(2)} \$',
          color: primaryColor,
        ),
      ],
    );
  }

  Widget _buildItem({required IconData icon, required String label, required String value, required Color color}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}