import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class APIs {
  static String baseUrl = 'http://tawasol.online/api/';
  static String imageBaseUrl = 'http://tawasol.online/public/pictures/occasions/';
//AIzaSyDyZS1lXwrSQfLucsqjh2_XrTlm-ZkHjNU
  static String homeEP = '${baseUrl}home';
  static String categoriesEP = '${baseUrl}showcategory';
  static String subCategoryEP = '${baseUrl}showsubcategory';
  static String sectionsEP = '${baseUrl}sections';
  static String addoccasionEP = '${baseUrl}addoccasion';
  static String initialoccasionsEP = '${baseUrl}initialoccasions';
  static String finishoccasionsEP = '${baseUrl}finishoccasions';
  static String makeoccasionfinishEP = '${baseUrl}makeoccationfinish';


  static String loginEP = '${baseUrl}login';
  static String registerEP = '${baseUrl}register';
  static String phoneVerifyEP = '${baseUrl}phoneVerify';
  static String resendPhoneVerifyEP = '${baseUrl}resendPhoneVerify';
  static String sendVerifyForgetPasswordNumEP = '${baseUrl}sendVerifyForgetPasswordNum';
  static String rechangepassEP = '${baseUrl}rechangepass';
  static String verifyForgetPasswordEP = '${baseUrl}verifyForgetPassword';
  static String notificationEP = '${baseUrl}notifications';
  static String delNotificationEP = '${baseUrl}delnotification';

  static String profileEP = '${baseUrl}profile';
  static String contactUsEP = '${baseUrl}addcontact';
  static String editprofileEP = '${baseUrl}editprofile';
  static String settinginfoEP = '${baseUrl}setting';
  
  

  static String editpassEP = '${baseUrl}editpass';
  static String addcontactEP = '${baseUrl}addcontact';
  static String paymentsEP = '${baseUrl}payments';

  static Future getRequest(url,
      {String token = '', BuildContext context}) async {
    String _token = RM.get<AuthStore>().state.credentialModel?.data?.apiToken;
        // 'Y5n8CTAweRHoQxJHYlqUPX3Pybvz3gtnyLafwfEvV6y6NGNKZBgrYv57OiqojEGgaSP00xi8fe0w9RSciIWpdOjWVG6ny43NNd3P'; // = reactiveModel.state.credentialsModel?.data?.apiToken;

    // = reactiveModel.state.credentialsModel?.data?.apiToken;
    // _token = _token?? reactiveModel.state.unConfirmedcredentialsModel?.data?.apiToken;
    // _token=
    //     'OTHHGYD6PFOiPu8EIkiSQc4yCBZ0VCk1PwGfxhOqUXl35wbbXQcxkqP3MysjalV2BY9XlIDhCT6IKGyr6kTQtsnPVcFOVhjE9cbh';

    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      return checkResponse(response);
    } on SocketException catch (e) {
      print(e);
      throw 'تحقق من اتصالك بالانترنت';
    } on HttpException catch (e) {
      print(e);
      throw 'تعذر الاتصال بالخادم';
    } on FormatException catch (e) {
      print(e);
      throw 'Bad response';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future postRequest(String url, Map<String, dynamic> body,
      {BuildContext context}) async {
    // final reactiveModel = Injector.getAsReactive<AuthStore>();
    String _token = RM.get<AuthStore>().state.credentialModel?.data?.apiToken;
    // 'Q1o5wTXcDz238AlUfb39Dh6XOfegjkp8CuOa1ExEwKTDhp0NSUD2qJNW63VgYzuS0B86wivlnasuNHXB9oqxN42BUjvHR7IlOOuy'; // = reactiveModel.state.credentialsModel?.data?.apiToken;
    // _token = _token?? reactiveModel.state.unConfirmedcredentialsModel?.data?.apiToken;
    // _token= _token??
    //     'dGA9CYRHlfGhvjryhD0STklwm3fOqIh7XAYimPheEiKI265b1pjSZJUIHZteeC4hkqSFMlQ4M4XDaSOPSOPmSdbko8UAY2HXCNFG';

    print('Posting request');
    print(body);

    try {
      final response = await http
          .post(url, body: body, headers: {'Authorization': 'Bearer $_token'});
      return checkResponse(response);
    } on SocketException catch (e) {
      print(e);
      throw 'تحقق من اتصالك بالانترنت';
    } on HttpException catch (e) {
      print(e);
      throw 'تعذر الاتصال بالخادم';
    } on FormatException catch (e) {
      print(e);
      throw 'Bad response';
    } catch (e) {
      print('post request eror $e');
      rethrow;
    }
  }

  static postWithFile(
    String urlString,
    Map<String, String> body, {
    String filePath,
    String fileName,
    List additionalData,
    String additionalDataField,
    List additionalFiles,
    List additionalFilesNames,
    String additionalFilesField,
  }) async {
    print('Posting with files');
    
    String _token = RM.get<AuthStore>().state.credentialModel?.data?.apiToken;
        // 'Y5n8CTAweRHoQxJHYlqUPX3Pybvz3gtnyLafwfEvV6y6NGNKZBgrYv57OiqojEGgaSP00xi8fe0w9RSciIWpdOjWVG6ny43NNd3P'; // = reactiveModel.state.credentialsModel?.data?.apiToken;
    // _token = _token??
    //     'c8GoLrSvefAfqfb2BJ5VXUOUJrSybNAcAd2LeQsNFPGHN60ejuDEV64sSQNblAx75eDpEvz8zFJwe2p6DUkrYjk3LNsimclr6b2v';

    Uri url = Uri.parse(urlString);
    // String image = savedOccasion['image'];
    // Map<String, String> body = (savedOccasion); //.toJson();
    Map<String, String> header = {
      'Authorization': 'Bearer $_token',
      "Accept": 'application/json'
    };
    http.MultipartRequest request = http.MultipartRequest('post', url);
    request.fields.addAll(body);
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      print('Had File');
    }
    if (additionalFiles != null && additionalFiles.isNotEmpty)
      for (int i = 0; i < additionalFiles.length; i++) {
        print('additionalFiles[i]');
        request.files.add(http.MultipartFile.fromBytes(
            '$additionalFilesField[$i]', additionalFiles[i],
            filename: '${additionalFilesNames[i]}'));
      }
    if (additionalData != null && additionalData.isNotEmpty)
      for (int i = 0; i < additionalData.length; i++) {
        request.fields['$additionalDataField[$i]'] =
            additionalData[i].toString();
      }
    request.headers.addAll(header);
    print(body);
    try {
      final response = await request.send();
      final responseData =
          json.decode(utf8.decode(await response.stream.first));

      print('Response from post with image $responseData}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        // final responseData = (json.decode(utf8.decode(onData)));

        print(responseData);
        if (responseData['msg'].toString().toLowerCase() == 'success') {
          print(responseData);
          return (responseData);
        } else {
          if (responseData['msg'].toString().contains('unauth'))
            throw 'من فضلك تأكد من تسجيل الدخول';
          else
            throw responseData['data'];
        }
      } else
        throw 'تعذر الإتصال';

      // return SaveOccasionModel.fromJson(
      //     APIs.checkResponse(json.decode(utf8.decode(onData))));

    } on SocketException catch (e) {
      print(e);
      throw 'تحقق من اتصالك بالانترنت';
    } on HttpException catch (e) {
      print(e);
      throw 'تعذر الاتصال بالخادم';
    } on FormatException catch (e) {
      print(e);
      throw 'Bad response';
    } catch (e) {
      print(e);
      throw '$e';
    }
  }

  static checkResponse(http.Response response) {
    print('checking response');
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);

      print(responseData);
      if (responseData['msg'].toString().toLowerCase() == 'success')
        return responseData;
      else {
        if (responseData['msg'].toString().contains('unauth'))
          throw 'من فضلك تأكد من تسجيل الدخول';
        else
          throw responseData['data'];
      }
    } else
      throw 'تعذر الإتصال';
  }
}
