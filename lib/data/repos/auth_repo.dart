import 'package:mahkama/core/api_utils.dart';
import 'package:mahkama/data/models/credentials_model.dart';

class AuthRepo {
  Future register(CredentialModel credentialModel) async {
    String url = APIs.registerEP;
    Map<String, dynamic> body = credentialModel.data?.register();
    return await APIs.postRequest(url, body);
  }

  Future login(CredentialModel credentialModel) async {
    String url = APIs.loginEP;
    Map<String, dynamic> body = credentialModel.data.login();
    return await APIs.postRequest(url, body);
  }

  Future verify(code, email) async {
    String url = APIs.phoneVerifyEP;
    Map<String, dynamic> body = {
      'code': "$code",
      'email': "$email",
    };
    return await APIs.postRequest(url, body);
  }

  Future editProfile(Map<String, dynamic> body) async {
    String url = APIs.editprofileEP;
    return await APIs.postRequest(url, body);
  }


  Future resendVerify(email) async {
    String url = APIs.resendPhoneVerifyEP;
    Map<String, dynamic> body = {'email': '$email'};
    return await APIs.postRequest(url, body);
  } 

  Future sendForgetPassword(email) async {
    String url = APIs.sendVerifyForgetPasswordNumEP;
    Map<String, dynamic> body = {'email': "$email"};
    return await APIs.postRequest(url, body);
  }

  Future verifyForgetPassword(code, email) async {
    String url = APIs.verifyForgetPasswordEP;
    Map<String, dynamic> body = {
      'code': "$code",
      'email': "$email",
    };
    return await APIs.postRequest(url, body);
  }

  Future rechangePassword(newPassword, confirmPassword, email) async {
    String url = APIs.rechangepassEP;
    Map<String, dynamic> body = {
      'new_pass': "$newPassword",
      'confirm_pass': "$confirmPassword",
      'email': "$email",
    };
    return await APIs.postRequest(url, body);
  }

  Future getNotification() async {
    String url = APIs.notificationEP;
    return await APIs.getRequest(url);
  }

  Future delNotification(notID) async {
    String url = APIs.delNotificationEP;
    Map<String, dynamic> body = {'not_id': "$notID"};
    return await APIs.postRequest(url, body);
  }

  Future contactUs(msg, name)async {
    String url = APIs.contactUsEP;
    Map<String, dynamic> body = {
      'name': "$name",
      'msg': "$msg"
    };
    return await APIs.postRequest(url, body);
  }

  Future getSetting()async {
    String url = APIs.settinginfoEP;
    return await APIs.getRequest(url);
  }
}
