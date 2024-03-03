import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/navigation/navigator.dart';

logOut() {
  SecureStorageUtils.deleteAnyDataFromStorage(SharedPrefKeys.accessToken);
  SecureStorageUtils.deleteAnyDataFromStorage(SharedPrefKeys.tokenResponse);
  SecureStorageUtils.deleteAnyDataFromStorage(SharedPrefKeys.profileResponse);
  SecureStorageUtils.deleteAnyDataFromStorage(SharedPrefKeys.refreshToken);
  AppNavigator.navigateToAndClear(loginRoute);
}
