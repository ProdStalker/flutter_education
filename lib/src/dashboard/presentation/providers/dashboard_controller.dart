import 'package:education/core/commons/app/providers/tab_navigator.dart';
import 'package:education/core/commons/views/persistent_view.dart';
import 'package:education/core/services/injection_container.dart';
import 'package:education/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:education/src/course/presentation/cubit/course_cubit.dart';
import 'package:education/src/home/presentation/views/home_view.dart';
import 'package:education/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education/src/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<CourseCubit>(),
              ),
              BlocProvider(
                create: (_) => sl<VideoCubit>(),
              ),
              BlocProvider(
                create: (_) => sl<NotificationCubit>(),
              ),
            ],
            child: const HomeView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ProfileView(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 3;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) {
      return;
    }
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) {
      return;
    }
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
