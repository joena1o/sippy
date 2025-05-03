import 'package:flutter/material.dart';
import 'package:sippy_ca/core/config/get_it_setup.dart';
import 'package:sippy_ca/data/local_storage.dart';
import 'package:sippy_ca/features/auth/data/models/user_model.dart';
import 'package:sippy_ca/features/auth/data/repository/auth_repository.dart';
import 'package:sippy_ca/utils/dialog_services.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.authRepository});
  final AuthRepository authRepository;

  UserModel? currentUserState;

  bool isLoading = false;
  bool get isLoadingAuth => isLoading;

  void signUpUser(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required Function callback}) async {
    isLoading = true;
    notifyListeners();
    try {
      currentUserState = await authRepository.signUpWithEmailAndPassword(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName);
      SharedPrefService.saveItem("email", email);
      SharedPrefService.saveItem("password", password);
      callback();
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void signInUser(
      String email, String password, Function callback, bool returning) async {
    isLoading = true;
    if (!returning) {
      notifyListeners();
    }
    try {
      currentUserState =
          await authRepository.signInWithEmailAndPassword(email, password);
      SharedPrefService.saveItem("email", email);
      SharedPrefService.saveItem("password", password);
      callback();
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
