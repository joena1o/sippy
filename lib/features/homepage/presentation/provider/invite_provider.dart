import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sippy_ca/core/config/get_it_setup.dart';
import 'package:sippy_ca/features/auth/data/models/user_model.dart';
import 'package:sippy_ca/features/homepage/data/models/shopping_invite_model.dart';
import 'package:sippy_ca/features/homepage/data/repositories/invite_repository.dart';
import 'package:sippy_ca/utils/dialog_services.dart';

class InviteProvider extends ChangeNotifier {
  final InviteRepository inviteRepository;

  InviteProvider({required this.inviteRepository});

  bool _isLoading = false;
  bool get getLoadingStatus => _isLoading;
  TextEditingController nameController = TextEditingController();

  bool _fetchingCollabList = false;
  bool get fetchedCollabList => _fetchingCollabList;

  List<ShoppingInviteModel> collabList = [];
  List<ShoppingInviteModel> get getCollabList => collabList;

  bool _loadingRequest = false;
  bool get loadingRequestStatus => _loadingRequest;

  void createInvite(UserModel user, String name, List<String> emails,
      Function callback) async {
    _isLoading = true;
    notifyListeners();
    try {
      String id =
          await inviteRepository.createShoppingInvite(user, name, emails);
      callback();
      nameController.clear();
      getIt<DialogServices>().showMessageWithActionAndDuration(
          "Collaborative shopping created", () {
        Share.share(
          'Join my shopping collab! ${"https://joenadev.netlify.app/invite/$id"}',
          subject: 'You\'re invited!',
        );
      }, "Share Link", Colors.green, 6);
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchCollabs(String email, Function callback, Function fallback) async {
    _fetchingCollabList = true;
    try {
      collabList = await inviteRepository.fetchCollabShops(email);
      if (collabList.isNotEmpty) {
        callback();
      } else {
        fallback();
      }
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      _fetchingCollabList = false;
      notifyListeners();
    }
  }

  void acceptOrDeclineInvite(
      ShoppingInviteModel invite, String email, bool accept) async {
    _loadingRequest = true;
    try {
      await inviteRepository.acceptOrDeclineInvite(invite, email, accept);
    } catch (e) {
      getIt<DialogServices>().showMessageError(e.toString());
    } finally {
      _loadingRequest = false;
      notifyListeners();
    }
  }
}
