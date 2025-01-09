import 'package:cookie_jar/cookie_jar.dart';
import 'package:dart_music_api/music_api.dart';
import 'package:dio/dio.dart';
import 'package:flt_template/services/music/network/dio.dart';
import 'package:flt_template/utils/common/logger.dart';
import 'package:flt_template/utils/common/path_manager.dart';

class MusicSDK {
  // singleton
  static MusicSDK? _instance;

  factory MusicSDK() {
    if (_instance == null) {
      throw Exception('You must call MusicSDK.initializeMusicSDK() before using it');
    }
    return _instance!;
  }

  MusicSDK._initialize({
    required this.netease,
  });

  final MusicApi netease;

  static Future<MusicSDK> initializeMusicSDK() async {
    final dataDirectory = await PathManager().getAppStoragePath();
    talker.info("ChatSDK initialize at: $dataDirectory");

    final netease = MusicPlatform.netEasy.api..configureDio(configureMusicDio);

    _instance = MusicSDK._initialize(
      netease: netease,
    );
    return _instance!;
  }
}