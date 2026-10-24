import 'package:flutter/material.dart';
import 'package:quizapp1/questions_summary/summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: summaryData.map((data) {
          return SummaryItem(data);
        }).toList(),
      ),
    );
  }
}
