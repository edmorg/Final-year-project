import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_hunter/states/users/states_notifier.dart';

import '../../database/shared_preference.dart';
import '../../models/authentication_entity.dart';
import '../onboarding/onboarding_states_notifiers.dart';
import 'authentication_repository.dart';
import 'authentication_states.dart';

/// authentication states notifiers
class AuthenticationStateNotifier extends StateNotifier<AuthenticationStates> {
  /// initialize authentication state notifier with the initial authentication state
  AuthenticationStateNotifier({required this.ref}) : super(AuthenticationInitial());
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  final Ref ref;

  /// perform email sign in
  Future<void> emailSignIn({required LoginRequestData data}) async {
    try {
      /// Set authentication state to loading
      state = AuthenticationLoading();

      /// attempt login with firebase via authentication repository
      final response = await _authenticationRepository.signInWithEmail(data: data);

      /// check if login attempt was successful
      if (response.status) {
        /// write user ID to local storage
        await LocalPreference.writeStringToStorage(
          key: LocalPreference.KEY_USER_ID,
          value: response.data!,
        );

        /// Set onboarding state state to onboarded
        await ref.read(onboardingProvider.notifier).setAuthenticated();

        /// fetch main page data if authentication is successful
        await ref.read(userStateProvider.notifier).getUserInfo();

        /// set authentication state to success afterwards
        state = AuthenticationSuccess();
      } else {
        /// set authentication state to failure if login attempt is unsuccessful
        state = AuthenticationFailure(error: response.message);
      }
    } catch (err) {
      /// set authentication state to failure if an unknown error occurs
      state = AuthenticationFailure(error: err.toString());
    }
  }

  /// perform email registration
  Future<void> emailRegistration({required RegistrationRequestData data}) async {
    try {
      /// Set authentication state to loading
      state = AuthenticationLoading();

      /// attempt login with firebase via authentication repository
      final response = await _authenticationRepository.registerWithEmail(data: data);

      /// check if login attempt was successful
      if (response.status) {
        /// write user ID to local storage
        await LocalPreference.writeStringToStorage(key: LocalPreference.KEY_USER_ID, value: response.data!);

        /// Set onboarding state state to onboarded
        await ref.read(onboardingProvider.notifier).setAuthenticated();

        /// fetch main page data if authentication is successful
        await ref.read(userStateProvider.notifier).getUserInfo();

        /// set authentication state to success afterwards
        state = AuthenticationSuccess();
      } else {
        /// set authentication state to failure if login attempt is unsuccessful
        state = AuthenticationFailure(error: response.message);
      }
    } catch (err) {
      /// set authentication state to failure if an unknown error occurs
      state = AuthenticationFailure(error: err.toString());
    }
  }

  Future<void> signOut() async {
    state = AuthenticationLoading();
    await _authenticationRepository.signOut();
    await ref.read(onboardingProvider.notifier).setUnAuthenticated();
    state = AuthenticationLogoutSuccess();
  }

  Future<void> forgotPassword({required String email}) async {
    state = AuthenticationLoading();
    final response = await _authenticationRepository.forgotPassword(email: email);
    if (response.status) {
      state = AuthenticationForgotPasswordSuccess();
    } else {
      state = AuthenticationForgotPasswordFailure(error: response.message);
    }
  }
}

final authenticationStateProvider =
    StateNotifierProvider.autoDispose<AuthenticationStateNotifier, AuthenticationStates>(
  (ref) => AuthenticationStateNotifier(ref: ref),
);
