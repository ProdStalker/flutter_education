import 'package:education/core/commons/app/providers/user_provider.dart';
import 'package:education/core/res/media_res.dart';
import 'package:education/src/home/presentation/widgets/notification_bell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Classes'),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        const NotificationBell(),
        Consumer<UserProvider>(
          builder: (_, provider, __) {
            return provider.user == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: provider.user!.profilePic != null
                          ? NetworkImage(provider.user!.profilePic!)
                          : const AssetImage(MediaRes.user) as ImageProvider,
                    ),
                  );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
