import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/shared_preference.dart';

part 'onbaording_states.dart';

class OnboardingStateNotifier extends StateNotifier<OnboardingStates> {
  OnboardingStateNotifier() : super(UnAuthenticated());
  void checkOnboardingState() {
    if (LocalPreference.isLoggedIn) {
      state = Authenticated();
    } else if (!LocalPreference.isLoggedIn) {
      state = UnAuthenticated();
    } else {
      state = UnAuthenticated();
    }
  }

  Future<void> setAuthenticated() async {
    await LocalPreference.writeBoolToStorage(
      key: LocalPreference.KEY_IS_LOGIN,
      value: true,
    );
    checkOnboardingState();
  }

  Future<void> setUnAuthenticated() async {
    await LocalPreference.writeBoolToStorage(
      key: LocalPreference.KEY_IS_LOGIN,
      value: false,
    );
    checkOnboardingState();
  }
}

final onboardingProvider = StateNotifierProvider(
  (ref) => OnboardingStateNotifier(),
);
