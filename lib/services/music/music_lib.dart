import 'package:cookie_jar/cookie_jar.dart';
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
    required this.dio,
    required this.cookieJar,
  });

  final Dio dio;
  final PersistCookieJar cookieJar;

  static Future<MusicSDK> initializeMusicSDK() async {
    final dataDirectory = await PathManager().getAppStoragePath();
    talker.info("ChatSDK initialize at: $dataDirectory");

    final networkPack = await createMusicNetwork("https://example.com");

    _instance = MusicSDK._initialize(
      dio: networkPack.dio,
      cookieJar: networkPack.cookieJar,
    );
    return _instance!;
  }
}