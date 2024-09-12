import 'package:education/core/commons/views/page_under_construction.dart';
import 'package:education/core/extensions/context_extension.dart';
import 'package:education/core/services/injection_container.dart';
import 'package:education/src/auth/data/models/user_model.dart';
import 'package:education/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:education/src/auth/presentation/views/sign_in_screen.dart';
import 'package:education/src/auth/presentation/views/sign_up_screen.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:education/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education/src/course/features/exams/presentation/views/add_exam_view.dart';
import 'package:education/src/course/features/materials/presentation/cubit/material_cubit.dart';
import 'package:education/src/course/features/materials/presentation/views/add_materials_view.dart';
import 'package:education/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:education/src/course/features/videos/presentation/views/add_video_view.dart';
import 'package:education/src/course/presentation/cubit/course_cubit.dart';
import 'package:education/src/course/presentation/views/course_details_screen.dart';
import 'package:education/src/dashboard/presentation/views/dashboard.dart';
import 'package:education/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
