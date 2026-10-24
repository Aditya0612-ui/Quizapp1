import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizapp1/Data/question.dart';
import 'package:quizapp1/quiz.dart';

void main() {
  test('QuizQuestion getShuffledAnswers does not mutate original answers', () {
    final originalFirstAnswer = questions[0].answers[0];
    final shuffled = questions[0].getShuffledAnswers();

    // Contains all original items
    expect(shuffled.length, equals(questions[0].answers.length));
    expect(shuffled.toSet(), equals(questions[0].answers.toSet()));

    // Original list remains unchanged
    expect(questions[0].answers[0], equals(originalFirstAnswer));
  });

  testWidgets(
      'Full quiz flow: start, answer all questions correctly, view results, and restart',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Quiz());

    // 1. Verify Start Screen is rendered
    expect(find.text('Learn Flutter the fun way!'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);

    // 2. Tap "Start Quiz" button
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // 3. Answer every question with the CORRECT answer (index 0 of original answers list)
    for (var i = 0; i < questions.length; i++) {
      expect(find.text(questions[i].text), findsOneWidget);
      final correctAnswer = questions[i].answers[0];
      final correctButton = find.widgetWithText(ElevatedButton, correctAnswer);
      expect(correctButton, findsOneWidget);
      await tester.tap(correctButton);
      await tester.pumpAndSettle();
    }

    // 4. Verify Results Screen shows 6 out of 6 correctly
    expect(
      find.text('You answered 6 out of 6 questions correctly!'),
      findsOneWidget,
    );
    expect(find.text('Restart Quiz!'), findsOneWidget);

    // 5. Tap "Restart Quiz!"
    await tester.tap(find.text('Restart Quiz!'));
    await tester.pumpAndSettle();

    // 6. Verify back to question screen (first question)
    expect(find.text(questions[0].text), findsOneWidget);
  });
}
