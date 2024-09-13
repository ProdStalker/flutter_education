import 'package:education/core/commons/widgets/nested_back_button.dart';
import 'package:education/core/commons/widgets/popup_item.dart';
import 'package:education/core/extensions/context_extension.dart';
import 'package:education/core/res/colours.dart';
import 'package:education/src/chat/domain/entities/group.dart';
import 'package:education/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({required this.group, super.key});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const NestedBackButton(),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(group.groupImageUrl!),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(group.name),
        ],
      ),
      foregroundColor: Colors.white,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.green,
            ],
          ),
        ),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          icon: const Icon(Icons.more_horiz),
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (_) => <PopupMenuItem<PopupItem>>[
            PopupMenuItem(
              child: const PopupItem(
                title: 'Exit group',
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colours.redColour,
                ),
              ),
              onTap: () async {
                final chatCubit = context.read<ChatCubit>();
                final user = context.currentUser!;
                final quitGroup = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text('Exit group'),
                      content: const Text(
                        'Are you sure you want to leave the group?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text(
                            'Exit group',
                            style: TextStyle(
                              color: Colours.redColour,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (quitGroup ?? false) {
                  await chatCubit.leaveGroup(
                    groupId: group.id,
                    userId: user.uid,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
