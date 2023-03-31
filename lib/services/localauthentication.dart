import 'package:local_auth/local_auth.dart';

class localAuthentication {
  LocalAuthentication _LocalAuth = LocalAuthentication();
  Future<bool> authenticate({String reason = 'Please Authenticate'}) async {
    bool check = await _LocalAuth.canCheckBiometrics;
    if (check == true) {
      bool isauthenticated = await _LocalAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );
      return isauthenticated;
    }
    return false;
  }
}
