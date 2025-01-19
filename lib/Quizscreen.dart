import 'package:flutter/material.dart';
import 'Scorescreen.dart';
import 'quizcontroller.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController _controller = QuizController();
  bool isLoading = true;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    await _controller.fetchQuizData();
    setState(() {
      isLoading = false;
    });
  }

  void _submitQuiz() {
    final result = _controller.evaluateAnswers();
    final right = result['right'] ?? 0;
    final wrong = result['wrong'] ?? 0;
    final total = right - wrong;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
          right: right,
          wrong: wrong,
          total: total,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz App',
          style: TextStyle(color: Color(0xFF779ECB)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF333333),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        color: Color(0xFF333333),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question navigation bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffF5F5DD)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: List.generate(
                        _controller.questions.length,
                            (index) => Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentQuestionIndex = index;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: currentQuestionIndex == index
                                    ? const Color(0xFF779ECB)
                                    : const Color(0xFFBDBDBD),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Question and options
            SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Q${currentQuestionIndex + 1}: ${_controller.questions[currentQuestionIndex]['description']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (_controller.questions[currentQuestionIndex]['options']
                        as List<dynamic>)
                            .length,
                        itemBuilder: (context, optionIndex) {
                          final option = _controller.questions[currentQuestionIndex]['options']
                          [optionIndex];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _controller.userAnswers[
                                      currentQuestionIndex][optionIndex],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _controller.userAnswers[currentQuestionIndex]
                                          [optionIndex] = value!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Expanded(
                                      child: Text(
                                        option['description'],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: currentQuestionIndex <
                        _controller.questions.length - 1
                        ? () {
                      setState(() {
                        currentQuestionIndex++;
                      });
                    }
                        : null,
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFF779ECB),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFF779ECB),
                        width: 3,
                      ),
                      minimumSize: const Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submitQuiz,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF779ECB),
                      minimumSize: const Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
