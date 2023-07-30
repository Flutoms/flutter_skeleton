import 'dart:async';

import 'package:midlr/api_service/service.dart';
import 'package:midlr/database/database.dart';
import 'package:midlr/dependency/navigation/navigator_routes.dart';
import 'package:midlr/utils/helpers.dart';
import 'package:midlr/utils/loader_dialog.dart';

abstract class AuthService {
  Future<void> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String phone,
      required String accountVerification});

  Future<void> verifyOtp({required String otp, required String emailOrPhone});

  Future<void> verifyLostPasswordOtp(
      {required String otp, required String emailOrPhone});

  Future<void> signIn({required String emailOrPhone, required String password});

  Future<void> resendOtp({required String emailOrPhone});

  Future<void> forgotPassword({required String emailOrPhone});

  Future<void> resetPassword(
      {required String newPassword,
      required String emailOrPhone,
      required String otp});

  Future<void> addDeviceToken({required String token});
}

class AuthServiceImp extends AuthService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  AuthServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<void> resetPassword(
      {required String newPassword,
      required String emailOrPhone,
      required String otp}) async {
    showLoaderDialog();

    var body = {
      'password': newPassword,
      'confirmPassword': newPassword,
      'emailOrPhone': emailOrPhone,
      'otp': otp
    };

    var response = await serviceHelpersImp.post(
        endPointUrl: '/auth/reset-password', body: body);

    globalPop();
    globalToast(response?.data['message']);
    if (response?.statusCode == 200 && response?.data != null) {
      // globalNavigateUntil(route: Routes.login);
    }
  }

  @override
  Future<void> signIn(
      {required String emailOrPhone, required String password}) async {
    showLoaderDialog();

    var body = {'emailOrPhone': emailOrPhone, 'password': password};

    var response =
        await serviceHelpersImp.post(endPointUrl: '/auth/signin', body: body);

    globalPop();
    globalToast(response?.data['message']);
    if (response?.statusCode == 200 && response?.data != null) {
      var userToken = response?.data['data']['loginUser']['token'];
      tempDatabaseImpl.saveUserToken(token: userToken);
      // globalNavigateTo(route: Routes.domain);
    }
  }

  @override
  Future<void> forgotPassword({required String emailOrPhone}) async {
    showLoaderDialog();

    var body = {'emailOrPhone': emailOrPhone};

    var response = await serviceHelpersImp.post(
        endPointUrl: '/auth/lost-password', body: body);

    globalPop();
    globalToast(response?.data['message']);
    if (response?.statusCode == 200 && response?.data != null) {
      // globalNavigateTo(route: Routes.otp);
    }
  }

  @override
  Future<void> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password,
      required String accountVerification}) async {
    showLoaderDialog();

    var body = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'confirmPassword': password,
      'accountVerification': accountVerification
    };

    var response =
        await serviceHelpersImp.post(endPointUrl: '/auth/signup', body: body);

    globalPop();
    globalToast(response?.data['message']);
    if (response?.statusCode == 201 && response?.data != null) {
      // globalNavigateTo(route: Routes.otp);
    }
  }

  @override
  Future<void> verifyOtp(
      {required String otp, required String emailOrPhone}) async {
    showLoaderDialog();

    var body = {'emailOrPhone': emailOrPhone, 'otp': otp};
    var response =
        await serviceHelpersImp.post(endPointUrl: '/auth/verify', body: body);

    globalPop();
    globalToast(response?.data['message']);
    if (response?.statusCode == 201 && response?.data != null) {
      // globalNavigateUntil(route: Routes.domain);
    }
  }

  @override
  Future<void> verifyLostPasswordOtp(
      {required String otp, required String emailOrPhone}) async {
    showLoaderDialog();

    var body = {'emailOrPhone': emailOrPhone, 'otp': otp};
    var response = await serviceHelpersImp.post(
        endPointUrl: '/auth/verify-password-otp', body: body);

    globalPop();
    globalToast(response?.data['message']);
    if (response?.statusCode == 200 && response?.data != null) {
      // globalNavigateTo(route: Routes.resetPassword);
    }
  }

  @override
  Future<void> resendOtp({required String emailOrPhone}) async {
    var body = {'emailOrPhone': emailOrPhone};
    var response = await serviceHelpersImp.post(
        endPointUrl: '/auth/request-otp', body: body);
    globalToast(response?.data['message']);
  }

  @override
  Future<void> addDeviceToken({required String token}) {
    // TODO: implement addDeviceToken
    throw UnimplementedError();
  }
}
