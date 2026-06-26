import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grade_provider.dart';

class AddSubjectProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController markController = TextEditingController();
  String? errorMessage;

  void validate() {
    errorMessage = null;
    notifyListeners();
  }

  bool validateForm() {
    final name = nameController.text.trim();
    final markText = markController.text.trim();

    if (name.isEmpty) {
      errorMessage = 'Name cannot be empty';
      notifyListeners();
      return false;
    }
    
    int? parsedMark = int.tryParse(markText);
    if (parsedMark == null || parsedMark < 0 || parsedMark > 100) {
      errorMessage = 'Mark must be a valid number between 0 and 100';
      notifyListeners();
      return false;
    }
    
    errorMessage = null;
    notifyListeners();
    return true;
  }

  void clear() {
    nameController.clear();
    markController.clear();
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    markController.dispose();
    super.dispose();
  }
}

class AddSubjectScreen extends StatelessWidget {
  const AddSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return ChangeNotifierProvider(
      create: (_) => AddSubjectProvider(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AddSubjectProvider>(
          builder: (context, formProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add New Subject',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: formProvider.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => formProvider.validate(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: formProvider.markController,
                  decoration: const InputDecoration(
                    labelText: 'Mark (0-100)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => formProvider.validate(),
                ),
                if (formProvider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      formProvider.errorMessage!,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (formProvider.validateForm()) {
                      Provider.of<GradeProvider>(context, listen: false)
                          .addSubject(
                            formProvider.nameController.text.trim(), 
                            int.parse(formProvider.markController.text.trim())
                          );
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${formProvider.nameController.text.trim()} added successfully!'),
                          backgroundColor: colorScheme.secondary,
                          action: SnackBarAction(
                            label: 'OK',
                            textColor: colorScheme.onSecondary,
                            onPressed: () {},
                          ),
                        ),
                      );
                      
                      formProvider.clear();
                    }
                  },
                  child: const Text('Add Subject'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
