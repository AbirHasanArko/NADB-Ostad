import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grade_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, child) {
        final totalSubjects = gradeProvider.totalSubjects;
        final averageMark = gradeProvider.averageMark;
        final overallGrade = gradeProvider.overallGrade;
        final passingCount = gradeProvider.passingSubjectsCount;
        
        final theme = Theme.of(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Result Summary',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      _buildSummaryRow(
                        'Total Subjects:', 
                        totalSubjects.toString(),
                        theme
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        'Passing Subjects:', 
                        passingCount.toString(),
                        theme
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        'Average Mark:', 
                        averageMark.toStringAsFixed(2),
                        theme
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        'Overall Grade:', 
                        overallGrade,
                        theme,
                        isHighlight: true
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, ThemeData theme, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            value,
            style: isHighlight 
                ? theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)
                : theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
