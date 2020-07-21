import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mahkama/const/resource.dart';
import 'package:mahkama/core/utils.dart';
import 'package:mahkama/presentation/store/occasions_store.dart';
import 'package:mahkama/presentation/widgets/tet_field_with_title.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../../../../router.gr.dart';
import 'add_btn.dart';
import 'drop_down_btn.dart';

class AddOccasion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          title: "إضافة مناسبة",
          height: RM.mediaQuery.size.height / 8,
        ),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: <Widget>[
          _BuildImage(),
          _BuildOwnerName(),
          SelectOccassionType(),
          _BuildLocation(),
          _BuildDate(),
          _BuildTime(),
          SelectSection(),
          AddBtn()
        ],
      ),
    ));
  }
}

class _BuildImage extends StatefulWidget {
  @override
  __BuildImageState createState() => __BuildImageState();
}

class __BuildImageState extends State<_BuildImage> {
  File file;

  bool get hasImage => file != null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageStyle = ParentStyle()
      ..width(size.width * 0.85)
      ..height(size.height / 4)
      ..border(all: 1, color: Colors.amber)
      ..borderRadius(all: 16)
      ..alignmentContent.center();
    final gesture = Gestures()
      ..onTap(() async {
        file = await StylesD.getProfilePicture(context);
        RM.get<OccassionsStore>().state.occassion.image = file.path;
        setState(() {});
      });
    return Parent(
      gesture: gesture,
      style: imageStyle,
      child: hasImage
          ? Image.file(file)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(R.ASSETS_IMAGES_PHOTO_CAMERA_PNG),
                Txt('أضف صورة', style: TxtStyle()..textColor(ColorsD.main))
              ],
            ),
    );
  }
}

class _BuildOwnerName extends StatelessWidget {
  onChanging(String s) {
    RM.get<OccassionsStore>().state.occassion.nameOwner = s;
  }

  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
        title: 'إسم صاحب المناسبة', onChanging: onChanging);
  }
}

class _BuildDate extends StatelessWidget {
  onChanging(String s) {
    RM.get<OccassionsStore>().state.occassion.date = s;
  }

  getDate(context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 5)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    dateCtrler.text = date.toString().split(' ').first;
    RM.get<OccassionsStore>().state.occassion.date = dateCtrler.text;
  }

  Widget icon(context) {
    return InkWell(
      child: Icon(Icons.date_range, color: Colors.amber),
      onTap: () => getDate(context),
    );
  }

  TextEditingController dateCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
      title: 'تاريخ المناسبة',
      textEditingController: dateCtrler,
      icon: icon(context),
    );
  }
}

class _BuildTime extends StatelessWidget {
  getTime(context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    timeCtrler.text = time.format(context);
    RM.get<OccassionsStore>().state.occassion.time = timeCtrler.text;
  }

  Widget icon(context) {
    return InkWell(
      child: Icon(Icons.timer, color: Colors.amber),
      onTap: () => getTime(context),
    );
  }

  TextEditingController timeCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
      title: 'وقت المناسبة',
      textEditingController: timeCtrler,
      icon: icon(context),
    );
  }
}

class _BuildLocation extends StatefulWidget {
  @override
  __BuildLocationState createState() => __BuildLocationState();
}

class __BuildLocationState extends State<_BuildLocation> {
  onChanging(String s) {
    RM.get<OccassionsStore>().state.occassion.address =s;
  }

  Position position;

  getLocations() async {
    // final geoState = await Geolocator().checkGeolocationPermissionStatus();
    // if (geoState == GeolocationStatus.disabled) {
    //   final isOK = await AlertDialogs.failed(context: context, content: 'من فضلك فعل خدمة ال GPS');
    //   if (isOK == true) {
    //     AppSettings.openLocationSettings();
    //   }

    // } else {
    position = (await ExtendedNavigator.rootNavigator
        .pushNamed(Routes.mapScreen, arguments: MapScreenArguments(setLocation: (){}))) as Position;
    if (position != null)
      locationCtrler.text = (await Geocoder.local.findAddressesFromCoordinates(
                  Coordinates(position.latitude, position.longitude)))
              ?.first
              ?.addressLine ??
          locationCtrler.text;
    RM.get<OccassionsStore>().state.occassion.address = locationCtrler.text;
    RM.get<OccassionsStore>().state.occassion.lat = position?.latitude ?? 0;
    RM.get<OccassionsStore>().state.occassion.lng = position?.longitude ?? 0;

    setState(() {});
    // }
  }

  Widget icon() {
    return InkWell(
      child: Icon(Icons.location_on, color: Colors.amber),
      onTap: getLocations,
      
    );
  }

  TextEditingController locationCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TetFieldWithTitle(
      title: 'مكان المناسبة',
      textEditingController: locationCtrler,
      onChanging: onChanging,
      icon: icon(),
    );
  }
}
