import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/chat/domain/entities/group.dart';

class GroupModel extends Group {
  const GroupModel({
    required super.id,
    required super.name,
    required super.courseId,
    required super.members,
    super.lastMessage,
    super.groupImageUrl,
    super.lastMessageTimestamp,
    super.lastMessageSenderName,
  });

  factory GroupModel.fromMap(DataMap map) {
    return GroupModel(
      id: map['id'] as String,
      name: map['name'] as String,
      courseId: map['courseId'] as String,
      members: List<String>.from(map['members'] as List<dynamic>),
      lastMessage: map['lastMessage'] as String,
      groupImageUrl: map['groupImageUrl'] as String,
      lastMessageTimestamp: map['lastMessageTimestamp'] as DateTime,
      lastMessageSenderName: map['lastMessageSenderName'] as String,
    );
  }

  const GroupModel.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          courseId: '_empty.courseId',
          members: const [],
          lastMessage: null,
          groupImageUrl: null,
          lastMessageTimestamp: null,
          lastMessageSenderName: null,
        );

  GroupModel copyWith({
    String? id,
    String? name,
    String? courseId,
    List<String>? members,
    String? lastMessage,
    String? groupImageUrl,
    DateTime? lastMessageTimestamp,
    String? lastMessageSenderName,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      courseId: courseId ?? this.courseId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'courseId': courseId,
      'members': members,
      'lastMessage': lastMessage,
      'groupImageUrl': groupImageUrl,
      'lastMessageTimestamp': lastMessageTimestamp,
      'lastMessageSenderName': lastMessageSenderName,
    };
  }
}
