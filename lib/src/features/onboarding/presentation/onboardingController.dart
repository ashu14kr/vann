import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/core/services/storage_service.dart';
import 'package:van_life/src/features/onboarding/data/model/onboardingStateModel.dart';
import 'package:van_life/src/features/profile/data/models/user_model.dart';

class Onboardingcontroller extends Notifier<OnboardingStateModel> {
  @override
  OnboardingStateModel build() {
    return OnboardingStateModel.intial();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addName({required String name, required BuildContext context}) {
    state = state.copyWith(name: name);
    context.push('/onboarding-age');
  }

  addAge({required String age, required BuildContext context}) {
    state = state.copyWith(age: age);
    context.push('/onboarding-gender');
  }

  addGender({required String gender, required BuildContext context}) {
    state = state.copyWith(gender: gender);
    context.push('/onboarding-interests');
  }

  addInterest({required List<String> interest, required BuildContext context}) {
    state = state.copyWith(interests: interest);
    context.push('/onboarding-travelStyle');
    // context.push('/onboarding-accountLoading');
  }

  navigateToHome({required BuildContext context}) async {
    String? uid = await StorageService().getUserId();
    String? email = await StorageService().getUserEmail();
    UserModel newUser = UserModel(
      uid: uid!,
      displayName: state.name,
      email: email!,
      isOnboarded: true,
      isVerified: false,
      verificationImageUrl: state.verificationImage,
      age: state.age,
      gender: state.gender,
      travelType: state.travelType,
      interests: state.interests,
      bio: "empty not implemented",
      currentCountry: "USA",
      visitedScratchMap: [],
      profileImages: [state.userImage],
      vehicleImages: [''],
      eventsHosted: [],
      eventsJoined: [],
      eventsSaved: [],
    );
    await _db.collection('users').doc(newUser.uid).set(newUser.toMap());
    await StorageService().setOnboardingStatus(true);
    Timer(const Duration(seconds: 3), () {
      context.go('/home');
    });
  }

  dummyUser({required BuildContext context, required String uid}) async {
    EasyLoading.show();
    UserModel newUser = UserModel(
      uid: uid,
      displayName: "Luna Rivera",
      email: "luna.rivera@example.com",
      isOnboarded: true,
      isVerified: true,
      verificationImageUrl: "https://i.pravatar.cc/300?u=luna",
      age: "24",
      gender: "Female",
      travelType: "Solo Backpacking / Van Life",
      interests: [
        "Photography",
        "Hiking",
        "Yoga",
        "Specialty Coffee",
        "Sustainable Living",
      ],
      bio:
          "Chasing sunsets and mountain peaks. 🏔️ Currently living in my converted 2019 Sprinter. Let's find the best hidden gems together!",
      currentCountry: "USA",
      visitedScratchMap: ["USA", "Mexico", "Canada", "Iceland"],
      profileImages: [
        "https://images.unsplash.com/photo-1524504388940-b1c1722653e1", // Aesthetic portrait
        "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f",
      ],
      vehicleImages: [
        "https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7", // Van interior photo
      ],
      eventsHosted: [],
      eventsJoined: [],
      eventsSaved: [],
    );
    await _db.collection('users').doc(newUser.uid).set(newUser.toMap());
    EasyLoading.dismiss();
  }
}
