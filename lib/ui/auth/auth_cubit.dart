
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';

class AuthState {
  String phone, firstName, lastName, email, password, verificationMeans, otp;
  bool isEmail, isChecked, isResetPassword;
  double passwordStrength;

  AuthState({
    required this.phone,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.otp,
    required this.isEmail,
    required this.isChecked,
    required this.verificationMeans,
    required this.isResetPassword,
    required this.passwordStrength,
  });
}

class AuthCubit extends Cubit<AuthState> {
  AuthServiceImp authServiceImp;

  AuthCubit({required this.authServiceImp})
      : super(AuthState(
            phone: '',
            email: '',
            firstName: '',
            lastName: '',
            password: '',
            otp: '',
            verificationMeans: '',
            isEmail: true,
            isChecked: false,
            isResetPassword: false,
            passwordStrength: 0));

  void _emitState() => emit(AuthState(
        phone: state.phone,
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
        password: state.password,
        otp: state.otp,
        isEmail: state.isEmail,
        verificationMeans: state.verificationMeans,
        isChecked: state.isChecked,
        isResetPassword: state.isResetPassword,
        passwordStrength: state.passwordStrength,
      ));

  void resetState() => emit(AuthState(
      phone: '',
      email: '',
      firstName: '',
      lastName: '',
      password: '',
      verificationMeans: '',
      otp: '',
      isEmail: true,
      isChecked: false,
      isResetPassword: false,
      passwordStrength: 0));

  void holdDetail(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password}) async {
    state.firstName = firstName;
    state.lastName = lastName;
    state.email = email;
    state.phone = phone;
    state.password = password;
    _emitState();

  }

  void signUp({required String verification}) async {
    state.verificationMeans = verification;
    authServiceImp.signUp(
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        phone: state.phone,
        password: state.password,
        accountVerification: verification.toUpperCase());
    _emitState();
  }

  void signIn({required String email, required String password}) async {
    authServiceImp.signIn(emailOrPhone: email, password: password);
    _emitState();
  }

  void forgotPassword({required String emailOrPhone}) async {
    resetState();
    state.email = emailOrPhone;
    state.isResetPassword = true;
    state.verificationMeans = state.email.isEmpty ? 'Phone' : 'Email';
    await authServiceImp.forgotPassword(
        emailOrPhone: state.email.isEmpty ? state.phone : state.email);
    _emitState();
  }

  void resendOtp() async {
    await authServiceImp.resendOtp(
        emailOrPhone: state.verificationMeans.toLowerCase() == 'email'
            ? state.email
            : state.phone);
  }

  void verifyOtp({required String otp}) async {
    state.otp = otp;
    state.isResetPassword
        ? authServiceImp.verifyLostPasswordOtp(
            otp: otp,
            emailOrPhone: state.verificationMeans.toLowerCase() == 'email'
                ? state.email
                : state.phone)
        : authServiceImp.verifyOtp(
            otp: otp,
            emailOrPhone: state.verificationMeans.toLowerCase() == 'email'
                ? state.email
                : state.phone);
    _emitState();
  }

  void resetPassword({required String newPassword}) async {
    authServiceImp.resetPassword(
        newPassword: newPassword,
        emailOrPhone: state.email.isEmpty ? state.phone : state.email,
        otp: state.otp);
  }

  void isEmail({required bool isEmail}) {
    state.isEmail = isEmail;
    _emitState();
  }

  void isChecked() {
    state.isChecked = !state.isChecked;
    _emitState();
  }

  void checkPassword({required String value}) {
    var password = value.trim();

    if (password.isEmpty) {
      state.passwordStrength = 0;
    } else if (password.contains(RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')) &&
        value.length >= 8) {
      state.passwordStrength = 5;
    } else if (password
            .contains(RegExp(r'(?=.*[a-z])(?=.*?[0-9])(?=.*[A-Z])\w+')) &&
        value.length > 7) {
      state.passwordStrength = 4;
    } else if (password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])\w+')) &&
        value.length > 5) {
      state.passwordStrength = 3;
    } else if (password.length < 6) {
      state.passwordStrength = 2;
    }
    _emitState();
  }
}
