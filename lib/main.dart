import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_hunter/screens/screens.dart';
import 'package:skill_hunter/states/authentication/authentication_states_notifier.dart';

import 'database/shared_preference.dart';
import 'firebase_options.dart';
import 'states/onboarding/onboarding_states_notifiers.dart';
import 'states/service/service_state_notifier.dart';
import 'states/users/states_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalPreference.init();
  final ProviderContainer container = ProviderContainer();
  container.read(onboardingProvider.notifier).checkOnboardingState();
  if (LocalPreference.isLoggedIn) {
    await container.read(userStateProvider.notifier).getUserInfo();
    await container.read(serviceStateProvider.notifier).getServices();
  }
  container.listen(userStateProvider, (previous, state) async {
    if (state is UserFailure) {
      await container.read(authenticationStateProvider.notifier).signOut();
    }
  });
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SkillHunterRoot(),
    ),
  );
}

class SkillHunterRoot extends StatelessWidget {
  const SkillHunterRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(
        scheme: FlexScheme.sakura,
        surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
        blendLevel: 2,
        subThemesData: const FlexSubThemesData(
          blendTextTheme: true,
          useM2StyleDividerInM3: true,
          textButtonRadius: 8.0,
          filledButtonRadius: 10.0,
          outlinedButtonRadius: 10.0,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          outlinedButtonPressedBorderWidth: 2.0,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          popupMenuRadius: 6.0,
          popupMenuElevation: 8.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 8.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorOpacity: 1.00,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.sakura,
        surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
        blendLevel: 8,
        subThemesData: const FlexSubThemesData(
          blendTextTheme: true,
          useM2StyleDividerInM3: true,
          textButtonRadius: 8.0,
          filledButtonRadius: 10.0,
          outlinedButtonRadius: 10.0,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          outlinedButtonPressedBorderWidth: 2.0,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          popupMenuRadius: 6.0,
          popupMenuElevation: 8.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 8.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorOpacity: 1.00,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: RootPageWrapper(),
    );
  }
}

class RootPageWrapper extends ConsumerWidget {
  const RootPageWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardState = ref.watch(onboardingProvider);
    if (onboardState is Authenticated) {
      return const NavigationBase();
    } else {
      return const SplashScreen();
    }
  }
}
