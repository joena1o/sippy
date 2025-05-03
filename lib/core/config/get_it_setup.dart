import 'package:get_it/get_it.dart';
import 'package:sippy_ca/core/data/data_sources/firebase_auth_service.dart';
import 'package:sippy_ca/core/data/data_sources/firestore_service.dart';
import 'package:sippy_ca/utils/dialog_services.dart';

final GetIt getIt = GetIt.instance;

void setUpLocator() {
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<DialogServices>(() => DialogServices());
}
