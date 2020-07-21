import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/data/models/category_model.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/ui/mainSections/occasions/addOccassion/drop_down_btn.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SectionDropDownBtn extends StatefulWidget {
  @override
  _SectionDropDownBtnState createState() => _SectionDropDownBtnState();
}

class _SectionDropDownBtnState extends State<SectionDropDownBtn> {
  RMKey<OccassionsStore> _rmKey = RMKey();
  bool hasSections = RM.get<OccassionsStore>().state.sections != null;
  Widget dropDownBtn() {
    List<Category> list = _rmKey.state.sections.data;
    // return Container();
    return DropDownBtn(
      itemList: list,
      title: 'القسم',
      callback: (Category category) {
        RM.get<AuthStore>().state.authModel.data.sectionId =
            category.id.toString();
      },
    );
  }

  AuthMode get authMode => RM.get<AuthStore>().state.authMode;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: authMode == AuthMode.register,
      child: WhenRebuilder(
        rmKey: _rmKey,
        initState: (_, rm) => _rmKey.setState((s) => s.getSections()),
        onIdle:()=> dropDownBtn(),
        observe: () => RM.get<OccassionsStore>(),
        onWaiting: () => hasSections ? dropDownBtn() : WaitingWidget(),
        onError: (e) => hasSections ? dropDownBtn() : Txt('تعذر عرض الأقسام'),
        onData: (d) => dropDownBtn(),
      ),
    );
  }
}
