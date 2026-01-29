import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/onboarding/data/model/onboardingStateModel.dart';
import 'package:van_life/src/features/onboarding/presentation/onboardingController.dart';

final onboardingProvider =
    NotifierProvider<Onboardingcontroller, OnboardingStateModel>(() {
      return Onboardingcontroller();
    });
