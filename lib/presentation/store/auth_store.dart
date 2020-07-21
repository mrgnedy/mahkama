import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mahkama/data/models/credentials_model.dart';
import 'package:mahkama/data/models/notification_model.dart';
import 'package:mahkama/data/models/send_msg_model.dart';
import 'package:mahkama/data/models/settings_model.dart';
import 'package:mahkama/data/repos/auth_repo.dart';
import 'package:mahkama/data/repos/occassions_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

enum AuthMode { login, register }

class AuthStore {
  bool get isAuth => credentialModel != null;
  AuthStore() {
    pageCtrler = PageController(initialPage: 1);
    SharedPreferences.getInstance().then(
      (p) {
        pref = p;
        final creds = p.getString('creds');
        if (creds != null)
          credentialModel = CredentialModel.fromJson(json.decode(creds));
      },
    );
  }
  AuthRepo authRepo = AuthRepo();
  SharedPreferences pref;
  CredentialModel credentialModel;
  AuthMode authMode;
  CredentialModel authModel = CredentialModel(data: Credentials());
  NotificationModel notificationModel;
  int currentNotifIndex;
  int currentPage = 1;
  RMKey<AuthStore> pageKey = RMKey();
  PageController pageCtrler;
  String code;
  SendMsgModel sendMsgModel = SendMsgModel();
  SettingsModel settingsModel;
  String deviceToken;

  Future<String> register() async {
    print('REGISTERING..');
    final temp = CredentialModel.fromJson(
      await authRepo.register(authModel..data.deviceToken=deviceToken),
    );
    return temp.code.toString();
  }

  Future<CredentialModel> phoneVerify(String code) async {
    print('VERIFYING..');
    final temp = CredentialModel.fromJson(
      await authRepo.verify(code, authModel.data.email),
    );
    if (temp != null) {
      pref.setString('creds', json.encode(temp.toJson()));
      credentialModel = temp;
    }
    return credentialModel;
  }

  Future getSavedCreds() async {
    return await SharedPreferences.getInstance().then(
      (p) {
        pref = p;
        final creds = p.getString('creds');
        if (creds != null)
          credentialModel = CredentialModel.fromJson(json.decode(creds));
      },
    ).then((value) => getSettings());
  }

  Future<CredentialModel> login() async {
    print('LOGGING IN..');
    final temp = CredentialModel.fromJson(
      await authRepo.login(authModel..data.deviceToken=deviceToken),
    );
    if (temp != null) {
      pref.setString('creds', json.encode(temp.toJson()));
      credentialModel = temp;
    }
    return credentialModel;
  }

  Future<NotificationModel> getNotification() async {
    notificationModel =
        NotificationModel.fromJson(await authRepo.getNotification());
    return notificationModel;
  }

  Future delNotification(notID) async {
    return await authRepo.delNotification(notID);
  }

  Future sendForgetPassword() async {
    code = (await authRepo.sendForgetPassword(authModel.data.email))['data']
            ['verifyNum']
        .toString();
    return code;
  }

  Future verifyForgetPassword(code) async {
    credentialModel = CredentialModel.fromJson(
        await authRepo.verifyForgetPassword(code, authModel.data.email));
    if (credentialModel != null)
      pref.setString('creds', json.encode(credentialModel.toJson()));
    return credentialModel;
  }

  Future resendPhoneVerify() async {
    code = CredentialModel.fromJson(
            await authRepo.resendVerify(authModel.data.email))
        .data
        .code
        .toString();
    return code;
  }

  Future rechangePW() async {
    return await authRepo.rechangePassword(
      authModel.data.password,
      authModel.data.confirmPassword,
      authModel.data.email,
    );
  }

  Future<CredentialModel> editProfile() async {
    (await authRepo.editProfile(credentialModel.data.edit()));
    credentialModel = authModel;
    pref.setString('creds', json.encode(credentialModel.toJson()));
    return credentialModel;
  }

  Future contactUs() async {
    return await authRepo.contactUs(sendMsgModel.msg, sendMsgModel.name);
  }

  Future<SettingsModel> getSettings() async {
    settingsModel = SettingsModel.fromJson(await authRepo.getSetting());
    print('I GOT THE SETTINGS ${settingsModel.data.first.toJson()}');
    return settingsModel;
  }
}
