// Désactive les avertissements pour les membres publics non documentés et l'ordre des constructeurs.
// ignore_for_file: public_member_api_docs, sort_constructors_first

// Importe le package Material de Flutter pour les widgets de conception Material.
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// --------------------------------------------------------------------------
// 1. Widget de la Page d'Accueil (HomePage)
// --------------------------------------------------------------------------

/// Widget sans état représentant la page principale de la calculatrice.
class HomePage extends StatefulWidget {
  /// Constructeur de la HomePage.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String expression = "0";
  String historique = "";
  void onButtonTap(String valeur) {
    setState(() {
      if (expression == "0") {
        expression = valeur;
      } else {
        expression += valeur;
      }
    });
  }

  void resetScreen() {
    setState(() {
      expression = "0";
      historique = "0";
    });
  }

  void deleteLast() {
    setState(() {
      if (historique.length == 1 || historique == "0") {
        historique = "0"; // On remet à zéro
      } else {
        // Sinon, on coupe le dernier chiffre
        // Exemple : "123" devient "12"
        historique = historique.substring(0, historique.length - 1);
      }
    });
  }

  void calculateResult() {
    String finalInput = expression;
    finalInput = finalInput.replaceAll('x', '*');
    finalInput = finalInput.replaceAll('÷', '/');

    try {
      ShuntingYardParser p = ShuntingYardParser();

      historique = expression;

      Expression exp = p.parse(finalInput);

      ContextModel cm = ContextModel();

      // ignore: deprecated_member_use
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        expression = eval.toString();
      });
    } catch (e) {
      setState(() {
        expression = "Erreur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color grisChiffre = Color(0xFF616161);
    const Color grisPrincipal = Color(0xFF303030);
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

              // Le Spacer agit comme un ressort. Il pousse le contenu vers le bas
              // en occupant tout l'espace vide disponible.
              const Spacer(),

              // Deuxième ligne : Affichage du résultat actuel.
              Row(
                // end pour aligner les enfants à droite (comme sur une calculatrice).
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Texte du résultat principal (actuellement "0").
                  Text(
                    expression,
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
                children: [
                  // Texte de l'entrée/historique (actuellement "0"), en gris et plus petit.
                  Text(
                    historique,
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                  // Espace horizontal.
                  SizedBox(width: 15),
                  // Icône pour effacer ou supprimer, colorée en orange et plus grande.
                  IconButton(
                    icon: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.orange,
                      size: 30,
                    ),
                    onPressed: deleteLast,
                  ),
                ],
              ),

              // Quatrième ligne : Les boutons du clavier de la calculatrice.
              // Utilise Row pour organiser les colonnes des boutons horizontalement.
              Row(
                // spaceAround pour répartir l'espace autour des colonnes de boutons.
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Première Colonne de boutons
                  Column(
                    children: [
                      // AC (Clear All - Effacer Tout)
                      KeyboardCard(
                        valeurKey: "AC",
                        couleurKey: grisPrincipal,
                        onPressed: resetScreen,
                      ),
                      // Chiffres et +/-
                      KeyboardCard(
                        valeurKey: "7",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("7");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "4",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("4");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "1",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("1");
                        },
                      ),
                      const KeyboardCard(
                        valeurKey: "+/-",
                        couleurKey: grisChiffre,
                      ),
                    ],
                  ),
                  // Deuxième Colonne de boutons
                  Column(
                    children: [
                      // % (Pourcentage)
                      KeyboardCard(
                        valeurKey: "%",
                        couleurKey: grisPrincipal,
                        onPressed: () {
                          onButtonTap("%");
                        },
                      ),
                      // Chiffres
                      KeyboardCard(
                        valeurKey: "8",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("8");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "5",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("5");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "2",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("2");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "0",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("0");
                        },
                      ),
                    ],
                  ),
                  // Troisième Colonne de boutons
                  Column(
                    children: [
                      // ÷ (Division)
                      KeyboardCard(
                        valeurKey: "÷",
                        couleurKey: grisPrincipal,
                        onPressed: () {
                          onButtonTap("÷");
                        },
                      ),
                      // Chiffres et . (Point décimal)
                      KeyboardCard(
                        valeurKey: "9",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("9");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "6",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("6");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: "3",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap("3");
                        },
                      ),
                      KeyboardCard(
                        valeurKey: ".",
                        couleurKey: grisChiffre,
                        onPressed: () {
                          onButtonTap(".");
                        },
                      ),
                    ],
                  ),
                  // Quatrième Colonne de boutons (Opérations)
                  Column(
                    children: [
                      // x (Multiplication)
                      KeyboardCard(
                        valeurKey: "x",
                        couleurKey: grisPrincipal,
                        onPressed: () {
                          onButtonTap("x");
                        },
                      ),
                      // - (Soustraction)
                      KeyboardCard(
                        valeurKey: "-",
                        couleurKey: grisPrincipal,
                        onPressed: () {
                          onButtonTap("-");
                        },
                      ),
                      // + (Addition)
                      KeyboardCard(
                        valeurKey: "+",
                        couleurKey: grisPrincipal,
                        onPressed: () {
                          onButtonTap("+");
                        },
                      ),
                      // = (Égalité) - Note: Ce bouton a une tailleKey différente (plus grand).
                      KeyboardCard(
                        valeurKey: "=",
                        couleurKey:
                            Colors.orange, // Couleur du bouton en orange
                        tailleKey: 165,
                        onPressed:
                            calculateResult, // Taille verticale plus grande
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
  final VoidCallback? onPressed;

  /// Constructeur de la KeyboardCard avec des valeurs par défaut.
  const KeyboardCard({
    super.key,
    // Valeur par défaut : "AC" (si non spécifiée, c'est le bouton "AC").
    this.valeurKey = "AC",
    // Couleur par défaut : noir très foncé (Colors.black87).
    this.couleurKey = Colors.black87,
    // Taille (hauteur) par défaut : 80.
    this.tailleKey = 80,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Card est un conteneur avec des coins arrondis et une élévation (ombre).
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: couleurKey,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
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
                fontWeight: FontWeight.bold,
              ), // Texte blanc de grande taille.
            ),
          ),
        ),
      ), // Ajoute une ombre pour un effet 3D.
    );
  }
}
