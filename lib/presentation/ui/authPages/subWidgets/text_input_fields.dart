import 'package:flutter/material.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/widgets/tet_field_with_title.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildFirstName extends StatelessWidget {
  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  onChanged(String s) {
    RM.get<AuthStore>().state.authModel.data.firstName = s;
  }

 String validator(String s){}

  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
        title: 'الإسم الأول',
        isVisible: authMode == AuthMode.register,
        validator: validator,
        onChanging: onChanged);
  }
}

class BuildLastName extends StatelessWidget {
  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  onChanged(String s) {
    RM.get<AuthStore>().state.authModel.data.lastName = s;
  }

  String validator(String s) {}

  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
        title: 'الإسم الأخير',
        isVisible: authMode == AuthMode.register,
        validator: validator,
        onChanging: onChanged);
  }
}

class BuildEmail extends StatelessWidget {
  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  onChanged(String s) {
    RM.get<AuthStore>().state.authModel.data.email = s;
  }

  String validator(String s) {}

  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
        title: 'البريد الاكترونى', validator: validator, onChanging: onChanged);
  }
}

class BuildPassword extends StatelessWidget {
  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  onChanged(String s) {
    RM.get<AuthStore>().state.authModel.data.password = s;
    print(RM.get<AuthStore>().state.authModel?.data?.register() );
  }

  String validator(String s){}

  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
        title: 'كلمة المرور',
        isPassword: true,
        validator: validator,
        onChanging: onChanged);
  }
}

class BuildConfirmPW extends StatelessWidget {
  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  onChanged(String s) {
    // RM.get<AuthStore>().state.authModel.data. = s;
  }

  String validator(String s) {
    if (s != RM.get<AuthStore>().state.authModel.data.password)
      return "كلمة المرور غير مطابقة";
  }

  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
        title: 'تأكيد كلمة المرور',
        isPassword: true,
        validator: validator,
        isVisible: authMode == AuthMode.register,
        onChanging: onChanged);
  }
}
