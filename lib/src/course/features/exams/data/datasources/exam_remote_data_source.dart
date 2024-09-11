import 'package:education/src/course/features/exams/data/models/exam_model.dart';
import 'package:education/src/course/features/exams/data/models/exam_question_model.dart';
import 'package:education/src/course/features/exams/data/models/user_exam_model.dart';
import 'package:education/src/course/features/exams/domain/entities/exam.dart';
import 'package:education/src/course/features/exams/domain/entities/user_exam.dart';

abstract class ExamRemoteDataSource {
  Future<List<ExamModel>> getExams(String courseId);

  Future<List<ExamQuestionModel>> getExamQuestions(Exam exam);

  Future<void> uploadExam(Exam exam);

  Future<void> updateExam(Exam exam);

  Future<void> submitExam(UserExam exam);

  Future<List<UserExamModel>> getUserExams();

  Future<List<UserExamModel>> getUserCourseExams(String courseId);
}
