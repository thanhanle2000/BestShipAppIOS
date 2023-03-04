part of 'login_bloc.dart';

class LoginState {
  final bool successful;
  final String? error;
  final bool isUserNameValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isPasswordResetMailSent;
  final bool isPasswordResetFailure;

  bool get isFormValid => isUserNameValid && isPasswordValid;

  LoginState(
      {required this.successful,
      required this.error,
      required this.isUserNameValid,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      required this.isPasswordResetMailSent,
      required this.isPasswordResetFailure});

  factory LoginState.empty() {
    return LoginState(
      successful: true,
      error: null,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordResetMailSent: false,
      isPasswordResetFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      successful: true,
      error: null,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isPasswordResetMailSent: false,
      isPasswordResetFailure: false,
    );
  }

  factory LoginState.failure(String error) {
    return LoginState(
      successful: true,
      error: error,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isPasswordResetMailSent: false,
      isPasswordResetFailure: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      successful: true,
      error: null,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isPasswordResetMailSent: false,
      isPasswordResetFailure: false,
    );
  }

  factory LoginState.passwordResetMailSent() {
    return LoginState(
      successful: true,
      error: null,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordResetMailSent: true,
      isPasswordResetFailure: false,
    );
  }

  factory LoginState.passwordResetFailure() {
    return LoginState(
        successful: true,
        error: null,
        isUserNameValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isPasswordResetMailSent: false,
        isPasswordResetFailure: true);
  }

  LoginState update({
    bool? isValid,
    bool? isPasswordValid,
  }) {
    return copyWith(
      isUserNameValid: isValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordResetMailSent: false,
      isPasswordResetFailure: false,
    );
  }

  LoginState copyWith(
      {bool? successful,
      String? error,
      bool? isUserNameValid,
      bool? isPasswordValid,
      bool? isSubmitEnabled,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      bool? isPasswordResetFailure,
      bool? isPasswordResetMailSent}) {
    return LoginState(
      successful: successful ?? this.successful,
      error: error ?? this.error,
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isPasswordResetMailSent:
          isPasswordResetMailSent ?? this.isPasswordResetMailSent,
      isPasswordResetFailure:
          isPasswordResetFailure ?? this.isPasswordResetFailure,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isUserNameValid: $isUserNameValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPasswordResetMailSent: $isPasswordResetMailSent
      isPasswordResetFailure: $isPasswordResetFailure
    }''';
  }
}
