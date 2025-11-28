import 'package:flutter/material.dart';

// ---------------------- PALETTE DE COULEURS ----------------------
// Les valeurs hexadécimales standard pour ces couleurs sont suggérées ici :

// Bleu Marin Profond (Primaire)
const Color primaryColor = Color(0xFF001F3F); 

// Rouge Sang (Secondaire / Danger / Alerte)
const Color secondaryColor = Color(0xFF8B0000); 

// Jaune Vif (Accent / Pièces / Bonus)
const Color accentColor = Color(0xFFFFD700); 

// Texte clair sur fond sombre
const Color lightTextColor = Colors.white70;


// ---------------------- THÈME DARK ----------------------

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  
  // Couleurs principales
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
    primary: primaryColor,
    secondary: secondaryColor,
    surface: const Color(0xFF121212), // Fond général du Dark Mode
    onSurface: lightTextColor,
  ),
  
  // Arrière-plan (Corps de l'application)
  scaffoldBackgroundColor: Colors.black, // Noir pur pour un dark mode intense

  // AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: lightTextColor,
    centerTitle: true,
  ),

  // Boutons (Personnalisé ci-dessous, mais basé sur le thème)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  
  // Cartes pour les catégories/questions
  cardTheme: CardThemeData(
    color: const Color(0xFF1E1E1E), // Gris très foncé
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: const BorderSide(color: primaryColor, width: 1), // Bordure pour le style
    ),
  ),
);