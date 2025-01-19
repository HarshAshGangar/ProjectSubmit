import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizController {
  List<dynamic> questions = [];
  List<List<bool>> userAnswers = []; // User's selected answers

  Future<void> fetchQuizData() async {
    final url = Uri.parse('https://api.jsonserve.com/Uw5CrX');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        questions = data['questions'];
        userAnswers = List.generate(
          questions.length,
              (questionIndex) =>
              List.filled(
                questions[questionIndex]['options'].length,
                false,
              ),
        );
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Map<String, int> evaluateAnswers() {
    int right = 0;
    int wrong = 0;

    for (int i = 0; i < questions.length; i++) {
      final correctOptions = questions[i]['options']
          .asMap()
          .entries
          .where((entry) => entry.value['is_correct'] == true)
          .map((entry) => entry.key)
          .toList();

      // User's selected options for this question
      final selectedOptions = userAnswers[i]
          .asMap()
          .entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList();

      // Log debug information
      print('Question $i:');
      print('Correct Options: $correctOptions');
      print('Selected Options: $selectedOptions');

      // Compare selected options with correct options
      if (selectedOptions.isNotEmpty) {
        if (selectedOptions.length == correctOptions.length &&
            selectedOptions.every((index) => correctOptions.contains(index))) {
          right += 4; // Correct answer
          print('Answer is correct, +4 points.');
        } else {
          wrong += 1; // Incorrect answer
          print('Answer is incorrect, -1 point.');
        }
      }
    }

    print(
        'Final Results: Right: $right, Wrong: $wrong, Total: ${right - wrong}');
    return {'right': right, 'wrong': wrong, 'total': right - wrong};
  }
}