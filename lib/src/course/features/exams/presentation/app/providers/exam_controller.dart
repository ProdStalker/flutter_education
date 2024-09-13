import 'dart:async';

import 'package:education/src/course/features/exams/data/models/user_choice_model.dart';
import 'package:education/src/course/features/exams/data/models/user_exam_model.dart';
import 'package:education/src/course/features/exams/domain/entities/exam.dart';
import 'package:education/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education/src/course/features/exams/domain/entities/question_choice.dart';
import 'package:education/src/course/features/exams/domain/entities/user_choice.dart';
import 'package:education/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:flutter/foundation.dart';

class ExamController extends ChangeNotifier {
  ExamController({
    required Exam exam,
    required List<ExamQuestion> questions,
  })  : _exam = exam,
        _questions = questions,
        _userExam = UserExamModel(
          examId: exam.id,
          courseId: exam.courseId,
          answers: const [],
          examTitle: exam.title,
          totalQuestions: exam.questions?.length ?? 0,
          dateSubmitted: DateTime.now(),
        ),
        _remainingTime = exam.timeLimit;

  final Exam _exam;

  Exam get exam => _exam;

  final List<ExamQuestion> _questions;

  List<ExamQuestion> get questions => _questions;

  int get totalQuestions => _questions.length;

  late UserExam _userExam;

  UserExam get userExam => _userExam;

  late int _remainingTime;

  bool get isTimeUp => _remainingTime == 0;
  bool _examStarted = false;

  bool get examStarted => _examStarted;

  Timer? _timer;

  String get remainingTime {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  ExamQuestion get currentQuestion => _questions[_currentIndex];

  void startTimer() {
    _examStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  UserChoice? get userAnswer {
    final answers = _userExam.answers;
    var noAnswer = false;
    final questionId = currentQuestion.id;
    final userChoice = answers.firstWhere(
      (answer) => answer.questionId == questionId,
      orElse: () {
        noAnswer = true;
        return const UserChoiceModel.empty();
      },
    );
    return null;
  }

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (!_examStarted) {
      startTimer();
    }
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
  }

  void answer(QuestionChoice choice) {
    if (!_examStarted && currentIndex == 0) {
      startTimer();
    }

    final answers = List<UserChoice>.of(_userExam.answers);
    final userChoice = UserChoiceModel(
      questionId: choice.questionId,
      correctChoice: currentQuestion.correctAnswer!,
      userChoice: choice.identifier,
    );

    if (answers.any((answer) => answer.questionId == userChoice.questionId)) {
      final index = answers
          .indexWhere((answer) => answer.questionId == userChoice.questionId);
      answers[index] = userChoice;
    } else {
      answers.add(userChoice);
    }
    _userExam = (_userExam as UserExamModel).copyWith(answers: answers);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
