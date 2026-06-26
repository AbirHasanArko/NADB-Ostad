import 'package:flutter/material.dart';
import '../models/subject.dart';

class GradeProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];
  ThemeMode _themeMode = ThemeMode.light;

  List<Subject> get subjects => _subjects;
  ThemeMode get themeMode => _themeMode;

  void addSubject(String name, int mark) {
    _subjects.add(Subject(name: name, mark: mark));
    notifyListeners();
  }

  void removeSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    int totalMarks = _subjects.map((s) => s.mark).fold(0, (sum, mark) => sum + mark);
    return totalMarks / _subjects.length;
  }

  String get overallGrade {
    if (_subjects.isEmpty) return 'N/A';
    double avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  // Example requirement: use .where() 
  int get passingSubjectsCount {
    return _subjects.where((s) => s.mark >= 50).length;
  }
}
