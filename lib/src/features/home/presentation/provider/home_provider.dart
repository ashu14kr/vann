import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/home/data/models/home_state_model.dart';
import 'package:van_life/src/features/home/presentation/home_controller.dart';

final homeProvider = NotifierProvider<HomeController, HomeStateModel>(() {
  return HomeController();
});
