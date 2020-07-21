import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahkama/data/models/settings_model.dart';
import 'package:mahkama/presentation/store/auth_store.dart';
import 'package:mahkama/presentation/widgets/waiting_widget.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:video_player/video_player.dart';
import 'package:mahkama/const/resource.dart';
import 'build_app_bar.dart';

class IntroVideoPage extends StatefulWidget {
  @override
  _IntroVideoPageState createState() => _IntroVideoPageState();
}

class _IntroVideoPageState extends State<IntroVideoPage> {
  static final String url =
      'https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4';
  VideoPlayerController videoCtrler = VideoPlayerController.network(url);
  bool get isPlaying => videoCtrler.value.isPlaying;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoCtrler.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoCtrler?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // videoCtrler.pause();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final rm = RM.get<AuthStore>();
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: <Widget>[
          BuildAppBar(height: size.height / 6),
          Container(
            height: size.height / 2,
            width: size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: videoCtrler.value.isPlaying
                ? VideoPlayer(videoCtrler)
                : InkWell(
                    onTap: () => videoCtrler.play().then(
                          (s) => setState(() {}),
                        ),
                    child: Center(child: Icon(Icons.play_circle_outline))),
          ),
          _Description()
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  bool get hasData => RM.get<AuthStore>().state.settingsModel != null;
  List<Setting> get settings => RM.get<AuthStore>().state.settingsModel?.data;
  RMKey<AuthStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      rmKey: _rmKey,
      initState: (_, __) => _rmKey
          .setState((s) => s.settingsModel == null ? s.getSettings() : null),
      onIdle: () =>
          _DescriptionOnData(detail: hasData ? settings.first.splash1 : ''),
      onWaiting: () => hasData
          ? _DescriptionOnData(detail: settings.first.splash1)
          : WaitingWidget(),
      onError: (e) =>
          _DescriptionOnData(detail: hasData ? settings.first.splash1 : ''),
      onData: (d) => _DescriptionOnData(detail: settings.first.splash1),
      observe: () => RM.get<AuthStore>(),
    );
  }
}

class _DescriptionOnData extends StatelessWidget {
  final String detail;

  const _DescriptionOnData({Key key, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Txt('${detail}', style: TxtStyle());
  }
}
