// Désactive les avertissements pour les membres publics non documentés et l'ordre des constructeurs.
// ignore_for_file: public_member_api_docs, sort_constructors_first

// Importe le package Material de Flutter pour les widgets de conception Material.
import 'package:flutter/material.dart';

// --------------------------------------------------------------------------
// 1. Widget de la Page d'Accueil (HomePage)
// --------------------------------------------------------------------------

/// Widget sans état représentant la page principale de la calculatrice.
class HomePage extends StatelessWidget {
  /// Constructeur de la HomePage.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // SafeArea garantit que le contenu n'empiète pas sur les zones du système d'exploitation
    // telles que la barre de notification (encoche, etc.).
    return SafeArea(
      // Padding ajoute un espace de 16.0 de tous les côtés du contenu.
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Material est utilisé ici pour définir la couleur d'arrière-plan principale.
        child: Material(
          color: Colors
              .black, // Définit l'arrière-plan de la calculatrice en noir.
          // Column organise les widgets verticalement.
          child: Column(
            // Le contenu de la colonne (l'interface de la calculatrice).
            children: [
              // Première ligne : Icône de paramètres et indicateur "DEG".
              Row(
                // spaceBetween pour placer les enfants aux extrémités.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  // Icône de paramètres, colorée en orange.
                  Icon(Icons.settings, color: Colors.orange),
                  // Texte "DEG" (probablement pour 'Degré', indiquant le mode de calcul), en gris.
                  Text("DEG", style: TextStyle(color: Colors.grey)),
                ],
              ),

              // Espace vertical entre l'en-tête et l'affichage principal.
              const SizedBox(height: 130),

              // Deuxième ligne : Affichage du résultat actuel.
              Row(
                // end pour aligner les enfants à droite (comme sur une calculatrice).
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  // Texte du résultat principal (actuellement "0").
                  Text(
                    "0",
                    style: TextStyle(color: Colors.white, fontSize: 70),
                  ),
                  // Espace horizontal.
                  SizedBox(width: 10),
                  // Icône de menu vertical (trois points), colorée en orange.
                  Icon(Icons.more_vert, color: Colors.orange),
                ],
              ),

              // Troisième ligne : Affichage de l'entrée/historique.
              Row(
                // end pour aligner les enfants à droite.
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  // Texte de l'entrée/historique (actuellement "0"), en gris et plus petit.
                  Text("0", style: TextStyle(color: Colors.grey, fontSize: 30)),
                  // Espace horizontal.
                  SizedBox(width: 10),
                  // Icône pour effacer ou supprimer, colorée en orange et plus grande.
                  Icon(
                    Icons.keyboard_double_arrow_left_rounded,
                    color: Colors.orange,
                    size: 40,
                  ),
                ],
              ),

              // Quatrième ligne : Les boutons du clavier de la calculatrice.
              // Utilise Row pour organiser les colonnes des boutons horizontalement.
              Row(
                // spaceAround pour répartir l'espace autour des colonnes de boutons.
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Première Colonne de boutons
                  Column(
                    children: [
                      // AC (Clear All - Effacer Tout)
                      const KeyboardCard(),
                      // Chiffres et +/-
                      const KeyboardCard(valeurKey: "7"),
                      const KeyboardCard(valeurKey: "4"),
                      const KeyboardCard(valeurKey: "1"),
                      const KeyboardCard(valeurKey: "+/-"),
                    ],
                  ),
                  // Deuxième Colonne de boutons
                  Column(
                    children: [
                      // % (Pourcentage)
                      const KeyboardCard(valeurKey: "%"),
                      // Chiffres
                      const KeyboardCard(valeurKey: "8"),
                      const KeyboardCard(valeurKey: "5"),
                      const KeyboardCard(valeurKey: "2"),
                      const KeyboardCard(valeurKey: "0"),
                    ],
                  ),
                  // Troisième Colonne de boutons
                  Column(
                    children: [
                      // ÷ (Division)
                      const KeyboardCard(valeurKey: "÷"),
                      // Chiffres et . (Point décimal)
                      const KeyboardCard(valeurKey: "9"),
                      const KeyboardCard(valeurKey: "6"),
                      const KeyboardCard(valeurKey: "3"),
                      const KeyboardCard(valeurKey: "."),
                    ],
                  ),
                  // Quatrième Colonne de boutons (Opérations)
                  Column(
                    children: [
                      // x (Multiplication)
                      const KeyboardCard(valeurKey: "x"),
                      // - (Soustraction)
                      const KeyboardCard(valeurKey: "-"),
                      // + (Addition)
                      const KeyboardCard(valeurKey: "+"),
                      // = (Égalité) - Note: Ce bouton a une tailleKey différente (plus grand).
                      const KeyboardCard(
                        valeurKey: "=",
                        couleurKey:
                            Colors.orange, // Couleur du bouton en orange
                        tailleKey: 165, // Taille verticale plus grande
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// 2. Widget de la Carte du Clavier (KeyboardCard)
// --------------------------------------------------------------------------

/// Widget sans état représentant un seul bouton du clavier de la calculatrice.
class KeyboardCard extends StatelessWidget {
  /// Valeur du texte affiché sur le bouton (ex: "7", "+", "=").
  final String valeurKey;

  /// Couleur de fond du bouton.
  final Color couleurKey;

  /// Hauteur du bouton.
  final double tailleKey;

  /// Constructeur de la KeyboardCard avec des valeurs par défaut.
  const KeyboardCard({
    super.key,
    // Valeur par défaut : "AC" (si non spécifiée, c'est le bouton "AC").
    this.valeurKey = "AC",
    // Couleur par défaut : noir très foncé (Colors.black87).
    this.couleurKey = Colors.black87,
    // Taille (hauteur) par défaut : 80.
    this.tailleKey = 80,
  });

  @override
  Widget build(BuildContext context) {
    // Card est un conteneur avec des coins arrondis et une élévation (ombre).
    return Card(
      elevation: 10, // Ajoute une ombre pour un effet 3D.
      child: Container(
        color: couleurKey, // Utilise la couleur de fond spécifiée.
        width: 80, // Largeur fixe pour les boutons.
        height:
            tailleKey, // Hauteur spécifiée (80 par défaut, ou plus pour '=').
        // Center pour centrer le texte dans le conteneur.
        child: Center(
          child: Text(
            valeurKey, // Affiche la valeur du bouton.
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ), // Texte blanc de grande taille.
          ),
        ),
      ),
    );
  }
}
