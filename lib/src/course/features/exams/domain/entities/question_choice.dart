import 'package:equatable/equatable.dart';

class QuestionChoice extends Equatable {
  const QuestionChoice({
    required this.questionId,
    required this.identifier,
    required this.choiceAnswer,
  });

  const QuestionChoice.empty()
      : this(
          questionId: 'Test String',
          identifier: 'Test String',
          choiceAnswer: 'Test String',
        );

  final String questionId;
  final String identifier;
  final String choiceAnswer;

  @override
  List<Object?> get props => [questionId, identifier, choiceAnswer];
}
