import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education/core/errors/failures.dart';
import 'package:education/src/auth/data/models/user_model.dart';
import 'package:education/src/auth/domain/usescases/forgot_password.dart';
import 'package:education/src/auth/domain/usescases/sign_in.dart';
import 'package:education/src/auth/domain/usescases/sign_up.dart';
import 'package:education/src/auth/domain/usescases/update_user.dart';
import 'package:education/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  const tSignInParams = SignInParams.empty();
  const tSignUpParams = SignUpParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();
  const tEmail = 'forgot@mail.com';

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tUpdateUserParams);
  });

  tearDown(() => authBloc.close());

  test('initialState should be [AuthInitial]', () {
    expect(authBloc.state, const AuthInitial());
  });

  final tServerFailure = ServerFailure(
    message: 'user-not-found',
    statusCode: 'There is no user record corresponding to this identifier. '
        'The user may have been deleted.',
  );

  group('SignInEvent', () {
    const tUser = LocalUserModel.empty();

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedIn] when '
      '[SignInEvent] is added',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedIn(tUser),
      ],
      verify: (_) {
        verify(
          () => signIn(tSignInParams),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when signIn fails',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signIn(tSignInParams),
        ).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('SignUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedUp] when '
      '[SignUpEvent] is added',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedUp(),
      ],
      verify: (_) {
        verify(
          () => signUp(tSignUpParams),
        ).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when sign up fails',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignInParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => signUp(tSignUpParams),
        ).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('ForgotPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, ForgotPasswordSent] when '
      '[SignUpEvent] is added',
      build: () {
        when(() => forgotPassword(any())).thenAnswer(
          (_) async => const Right(null),
        );

        return authBloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(tEmail),
      ),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (_) {
        verify(
          () => forgotPassword(tEmail),
        ).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when forgot password fails',
      build: () {
        when(() => forgotPassword(any()))
            .thenAnswer((_) async => Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(tEmail),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => forgotPassword(tEmail),
        ).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });

  group('UpdateUserEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserUpdated] when '
      '[UpdateUserEvent] is added',
      build: () {
        when(() => updateUser(any())).thenAnswer(
          (_) async => const Right(null),
        );

        return authBloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          userData: tUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const UserUpdated(),
      ],
      verify: (_) {
        verify(
          () => updateUser(tUpdateUserParams),
        ).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when forgot password fails',
      build: () {
        when(() => updateUser(any()))
            .thenAnswer((_) async => Left(tServerFailure));

        return authBloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          userData: tUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(
          () => updateUser(tUpdateUserParams),
        ).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });
}
