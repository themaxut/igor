// Interface for auth providers
import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> sendEmailVerification();

  Future<void> sendPasswordReset({
    required String toEmail,
  });
}
