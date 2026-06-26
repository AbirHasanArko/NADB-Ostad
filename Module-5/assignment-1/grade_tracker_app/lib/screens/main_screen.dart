import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grade_provider.dart';
import 'add_subject_screen.dart';
import 'subject_list_screen.dart';
import 'summary_screen.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = const [
      AddSubjectScreen(),
      SubjectListScreen(),
      SummaryScreen(),
    ];

    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Consumer2<NavigationProvider, GradeProvider>(
        builder: (context, navProvider, gradeProvider, child) {
          final theme = Theme.of(context);
          
          return Scaffold(
            appBar: AppBar(
              title: const Text('Grade Tracker'),
              actions: [
                IconButton(
                  icon: Icon(
                    gradeProvider.themeMode == ThemeMode.light 
                        ? Icons.dark_mode 
                        : Icons.light_mode
                  ),
                  onPressed: () {
                    gradeProvider.toggleTheme();
                  },
                ),
              ],
            ),
            body: screens[navProvider.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navProvider.currentIndex,
              onTap: navProvider.setIndex,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box),
                  label: 'Add Subject',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Subjects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Summary',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
