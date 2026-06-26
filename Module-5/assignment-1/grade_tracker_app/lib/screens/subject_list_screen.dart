import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grade_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GradeProvider>(
      builder: (context, gradeProvider, child) {
        final subjects = gradeProvider.subjects;
        
        if (subjects.isEmpty) {
          return const Center(
            child: Text('No subjects added yet.'),
          );
        }

        return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            final colorScheme = Theme.of(context).colorScheme;
            
            return Dismissible(
              key: Key('${subject.name}_$index'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: colorScheme.error,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.delete, color: colorScheme.onError),
              ),
              onDismissed: (direction) {
                gradeProvider.removeSubject(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${subject.name} removed'),
                    backgroundColor: colorScheme.error,
                    action: SnackBarAction(
                      label: 'OK', 
                      textColor: colorScheme.onError,
                      onPressed: () {},
                    ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    subject.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Mark: ${subject.mark}'),
                  trailing: CircleAvatar(
                    backgroundColor: _getGradeColor(subject.grade, colorScheme),
                    child: Text(
                      subject.grade,
                      style: TextStyle(
                        color: colorScheme.onPrimary, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getGradeColor(String grade, ColorScheme colorScheme) {
    // Instead of hardcoded colors, use semantic colors from the theme if possible
    // Using variations from colorScheme
    switch (grade) {
      case 'A':
        return colorScheme.primary;
      case 'B':
        return colorScheme.secondary;
      case 'C':
        return colorScheme.tertiary ?? colorScheme.primary.withOpacity(0.7);
      case 'F':
      default:
        return colorScheme.error;
    }
  }
}
