import 'package:smartfiber/error/firebase_auth_error_constants.dart';

String errorMessage(String code) {
  String errorMessage = "An error occurred. Please try again.";

  switch (code) {
    case FirebaseAuthError.emailAlreadyInUse:
      errorMessage = "The email address is already in use by another account.";
      break;
    case FirebaseAuthError.invalidCredential:
      errorMessage = "The email does'nt exists.";

      break;
    case FirebaseAuthError.invalidEmail:
      errorMessage = "The email address is invalid.";
      break;
    case FirebaseAuthError.weakPassword:
      errorMessage = "The password is too weak.";
      break;
    case FirebaseAuthError.userNotFound:
      errorMessage = "No user found with this email address.";
      break;
    case FirebaseAuthError.wrongPassword:
      errorMessage = "Incorrect password.";
      break;
    case FirebaseAuthError.tooManyRequests:
      errorMessage = "Too many requests. Please try again later.";
      break;
    case FirebaseAuthError.operationNotAllowed:
      errorMessage = "This operation is not allowed.";
      break;
    case FirebaseAuthError.userNotAuthenticated:
      errorMessage = "User not authenticated";
      break;
    default:
      errorMessage = code;
      break;
  }

  return errorMessage;
}
