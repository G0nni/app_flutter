import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AfterWidget extends StatefulWidget {
  const AfterWidget({super.key});

  @override
  State<AfterWidget> createState() => _AfterWidgetState();
}

class _AfterWidgetState extends State<AfterWidget> {
  final List<String> textes = [
    'Hmmmmmm',
    "Des réponses incroyables n'est ce pas ?",
    "Merci d'avoir pris le temps d'y répondre !",
    "Je les lirai pas.",
    "J'ai pas le temps en fait.",
    "Merci !!",
    "..",
    ".........",
    "........................",
    "Ceci étant dit,\nEn fait, j'aimerai bien organisé ce fameux week end idéal dont je parlais plus tôt\nJe me disais que peut être, je pouvais faire ce week end de folie en compagnie de mes potes\nPour mes 25 ans !",
  ];

  int index = 0;
  bool fini = false;
  bool? accepte; // null = pas répondu, true = oui, false = refus
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _afficherSuite();
  }

  void _afficherSuite() {
    // on est sur le dernier texte : on le laisse lire, PUIS on montre les boutons
    if (index >= textes.length - 1) {
      final dureeFinale = Duration(
        milliseconds: 1500 + textes[index].length * 60,
      );
      timer = Timer(dureeFinale, () {
        if (!mounted) return;
        setState(() => fini = true);
      });
      return;
    }

    // cas normal : on attend puis on passe au texte suivant
    final duree = Duration(milliseconds: 1500 + textes[index].length * 60);
    timer = Timer(duree, () {
      if (!mounted) return;
      setState(() => index++);
      _afficherSuite();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _ouvrirLien() async {
    final url = Uri.parse('https://docs.google.com/document/d/REMPLACE_MOI');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Widget _contenu() {
    // L'utilisateur a refusé
    if (accepte == false) {
      return const Text(
        "Pas de soucis !\nMerci d'avoir pris le temps de participer au QCM !",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      );
    }

    // Les textes défilent encore
    if (!fini) {
      return Text(
        textes[index],
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      );
    }

    // Textes finis, on propose les deux boutons
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Si jamais ca t'intéresse, tu peux cliquer sur le lien juste en dessous, pour répondre à un formulaire GoogleForm pour qu'on puisse organiser tout ca !\n\nJ'attends vos réponses avec impatiences !\n\nJ'espère pouvoir passer un week end inoubliable avec vous dans tout les cas ou que vous êtes.",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _ouvrirLien,
              child: const Text('Répondre au formulaire'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => setState(() => accepte = false),
              child: const Text('Non désolé'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            key: ValueKey('$index-$fini-$accepte'),
            padding: const EdgeInsets.all(24.0),
            child: _contenu(),
          ),
        ),
      ),
    );
  }
}
