import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const LandingScreen(),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.quiz,
              size: 100,
              color: Color(0xFF6A5AE0),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quiz App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 48),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizHomeScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                side: const BorderSide(color: Color(0xFFE5E5E5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Enter',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6A5AE0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Quiz Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Choose Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildChip('Science', true),
                    const SizedBox(width: 8),
                    _buildChip('Math', false),
                    const SizedBox(width: 8),
                    _buildChip('History', false),
                    const SizedBox(width: 8),
                    _buildChip('Sports', false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildQuizCard(context, 'Flutter Basics', '10 Questions', flutterQuestions),
                  _buildQuizCard(context, 'General Knowledge', '20 Questions', generalQuestions),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('hello world'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: const Color(0xFF8B85FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? Colors.black : Colors.grey.shade300,
          width: 1,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, String title, String subtitle, List<QuizQuestion> questions) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black, size: 28),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizDetailScreen(
                title: title,
                questions: questions,
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizQuestion {
  final String text;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({required this.text, required this.options, required this.correctAnswer});
}

class QuizDetailScreen extends StatefulWidget {
  final String title;
  final List<QuizQuestion> questions;

  const QuizDetailScreen({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  int _currentIndex = 0;
  String? _selectedOption;
  int _score = 0;

  void _nextQuestion() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an option first'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedOption == widget.questions[_currentIndex].correctAnswer) {
      _score++;
    }

    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Quiz Completed!'),
          content: Text('Your score: $_score / ${widget.questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to Home
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _prevQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedOption = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Question ${_currentIndex + 1}/${widget.questions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  question.text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Flexible(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    final option = question.options[index];
                    return _buildOptionCard(option);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _currentIndex > 0 ? _prevQuestion : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: _currentIndex > 0 ? Colors.black : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 16,
                          color: _currentIndex > 0 ? const Color(0xFF6A5AE0) : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _nextQuestion,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _currentIndex == widget.questions.length - 1 ? 'Submit' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6A5AE0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(String text) {
    bool isSelected = _selectedOption == text;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF6A5AE0) : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? const Color(0xFF6A5AE0) : Colors.black,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? const Color(0xFF6A5AE0) : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.info, color: Colors.black),
        onTap: () {
          setState(() {
            _selectedOption = text;
          });
        },
      ),
    );
  }
}

// ----------------- Data -----------------

final List<QuizQuestion> flutterQuestions = [
  QuizQuestion(
    text: 'What is Flutter?',
    options: ['Framework', 'Database', 'Language', 'IDE'],
    correctAnswer: 'Framework',
  ),
  QuizQuestion(
    text: 'Which language is used by Flutter?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswer: 'Dart',
  ),
  QuizQuestion(
    text: 'What is the main building block of Flutter UI?',
    options: ['Widget', 'Component', 'Element', 'View'],
    correctAnswer: 'Widget',
  ),
  QuizQuestion(
    text: 'Which company developed Flutter?',
    options: ['Apple', 'Microsoft', 'Google', 'Facebook'],
    correctAnswer: 'Google',
  ),
  QuizQuestion(
    text: 'How do you run a Flutter app from the terminal?',
    options: ['flutter run', 'flutter build', 'flutter start', 'flutter test'],
    correctAnswer: 'flutter run',
  ),
  QuizQuestion(
    text: 'What is a StatefulWidget?',
    options: ['A widget with no state', 'A widget that can change its state', 'A stateless function', 'A routing class'],
    correctAnswer: 'A widget that can change its state',
  ),
  QuizQuestion(
    text: 'What does the pubspec.yaml file do?',
    options: ['Manages app routing', 'Defines the UI', 'Manages dependencies and assets', 'Compiles the code'],
    correctAnswer: 'Manages dependencies and assets',
  ),
  QuizQuestion(
    text: 'Which command is used to get dependencies?',
    options: ['flutter get', 'pub fetch', 'flutter pub get', 'flutter sync'],
    correctAnswer: 'flutter pub get',
  ),
  QuizQuestion(
    text: 'What widget is used to create a material design app?',
    options: ['CupertinoApp', 'MaterialApp', 'Scaffold', 'MaterialDesignApp'],
    correctAnswer: 'MaterialApp',
  ),
  QuizQuestion(
    text: 'What is the equivalent of a flexbox container in Flutter?',
    options: ['Container', 'Row/Column', 'Stack', 'Align'],
    correctAnswer: 'Row/Column',
  ),
];

final List<QuizQuestion> generalQuestions = [
  QuizQuestion(
    text: 'What is the capital of France?',
    options: ['London', 'Berlin', 'Paris', 'Madrid'],
    correctAnswer: 'Paris',
  ),
  QuizQuestion(
    text: 'Which planet is known as the Red Planet?',
    options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
    correctAnswer: 'Mars',
  ),
  QuizQuestion(
    text: 'Who wrote "Romeo and Juliet"?',
    options: ['Charles Dickens', 'William Shakespeare', 'Mark Twain', 'Jane Austen'],
    correctAnswer: 'William Shakespeare',
  ),
  QuizQuestion(
    text: 'What is the largest ocean on Earth?',
    options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
    correctAnswer: 'Pacific',
  ),
  QuizQuestion(
    text: 'Which element has the chemical symbol "O"?',
    options: ['Gold', 'Oxygen', 'Osmium', 'Oganesson'],
    correctAnswer: 'Oxygen',
  ),
  QuizQuestion(
    text: 'In which year did the Titanic sink?',
    options: ['1905', '1912', '1918', '1923'],
    correctAnswer: '1912',
  ),
  QuizQuestion(
    text: 'What is the hardest natural substance on Earth?',
    options: ['Gold', 'Iron', 'Diamond', 'Platinum'],
    correctAnswer: 'Diamond',
  ),
  QuizQuestion(
    text: 'What is the tallest mammal?',
    options: ['Elephant', 'Giraffe', 'Rhinoceros', 'Hippopotamus'],
    correctAnswer: 'Giraffe',
  ),
  QuizQuestion(
    text: 'Which country is known as the Land of the Rising Sun?',
    options: ['China', 'Japan', 'South Korea', 'Thailand'],
    correctAnswer: 'Japan',
  ),
  QuizQuestion(
    text: 'Who painted the Mona Lisa?',
    options: ['Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet'],
    correctAnswer: 'Leonardo da Vinci',
  ),
  QuizQuestion(
    text: 'How many continents are there?',
    options: ['5', '6', '7', '8'],
    correctAnswer: '7',
  ),
  QuizQuestion(
    text: 'Which gas do plants absorb from the atmosphere?',
    options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
    correctAnswer: 'Carbon Dioxide',
  ),
  QuizQuestion(
    text: 'What is the currency of the United Kingdom?',
    options: ['Euro', 'Dollar', 'Pound Sterling', 'Yen'],
    correctAnswer: 'Pound Sterling',
  ),
  QuizQuestion(
    text: 'Who is known as the father of modern physics?',
    options: ['Isaac Newton', 'Albert Einstein', 'Galileo Galilei', 'Nikola Tesla'],
    correctAnswer: 'Albert Einstein',
  ),
  QuizQuestion(
    text: 'What is the longest river in the world?',
    options: ['Amazon', 'Nile', 'Yangtze', 'Mississippi'],
    correctAnswer: 'Nile',
  ),
  QuizQuestion(
    text: 'Which of these is not a primary color?',
    options: ['Red', 'Blue', 'Green', 'Yellow'],
    correctAnswer: 'Green',
  ),
  QuizQuestion(
    text: 'What is the smallest country in the world?',
    options: ['Monaco', 'Vatican City', 'San Marino', 'Liechtenstein'],
    correctAnswer: 'Vatican City',
  ),
  QuizQuestion(
    text: 'Which continent is the Sahara Desert located on?',
    options: ['Asia', 'Africa', 'Australia', 'South America'],
    correctAnswer: 'Africa',
  ),
  QuizQuestion(
    text: 'What is the main ingredient in guacamole?',
    options: ['Tomato', 'Onion', 'Avocado', 'Pepper'],
    correctAnswer: 'Avocado',
  ),
  QuizQuestion(
    text: 'How many bones are in the adult human body?',
    options: ['206', '208', '210', '212'],
    correctAnswer: '206',
  ),
];
