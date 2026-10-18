import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';

class FlashcardProvider extends ChangeNotifier {
  final Box box = Hive.box('flashcards');

  late List<Map<String, String>> cards;

  int currentIndex = 0;
  bool showAnswer = false;

  FlashcardProvider() {
    final savedCards = box.get('cards');

    if (savedCards != null) {
      cards = (savedCards as List)
          .map((card) => Map<String, String>.from(card as Map))
          .toList();
    } else {
      cards = [
        {'question': 'What is Flutter?', 'answer': 'A UI toolkit by Google.'},
        {'question': 'What is Dart?', 'answer': 'A programming language.'},
        {
          'question': 'What is Firebase?',
          'answer': 'A development platform by Google.',
        },
      ];

      box.put('cards', cards);
    }
  }

  void toggleAnswer() {
    showAnswer = !showAnswer;
    notifyListeners();
  }

  void nextCard() {
    if (currentIndex < cards.length - 1) {
      currentIndex++;
      showAnswer = false;
      notifyListeners();
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      currentIndex--;
      showAnswer = false;
      notifyListeners();
    }
  }

  void addCard(String question, String answer) {
    cards.add({'question': question, 'answer': answer});

    box.put('cards', cards);

    currentIndex = cards.length - 1;
    showAnswer = false;
    notifyListeners();
  }

  void editCard(int index, String question, String answer) {
    if (index < 0 || index >= cards.length) return;

    cards[index] = {'question': question, 'answer': answer};

    box.put('cards', cards);
    showAnswer = false;
    notifyListeners();
  }

  void deleteCard(int index) {
    if (index < 0 || index >= cards.length) return;

    cards.removeAt(index);

    if (cards.isEmpty) {
      currentIndex = 0;
    } else if (currentIndex >= cards.length) {
      currentIndex = cards.length - 1;
    }

    showAnswer = false;
    box.put('cards', cards);
    notifyListeners();
  }
}
