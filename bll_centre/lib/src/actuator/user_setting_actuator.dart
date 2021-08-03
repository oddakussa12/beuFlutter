import 'dart:io';

import 'package:centre/src/centre_config.dart';
import 'package:common/common.dart';

/// 版本更新回调
typedef UpdateVersionCall = void Function(VersionInfo info);

/**
 * UserSettingActuator
 *
 * @author: Ruoyegz
 * @date: 2021/7/29
 */
class UserSettingActuator extends ReactActuator {
  static final NONE_CACHE = "0.00 Bits";

  /// 缓存大小
  String cacheSize = NONE_CACHE;

  /// 默认版本信息
  VersionInfo version = VersionInfo.none();

  @override
  void dispose() {
    super.dispose();
  }

  void checkAppVersion(UpdateVersionCall call) {
    /// 没有更新到最新版
    if (!version.isNone! && (version.isUpgrade || version.mustUpgrade)) {
      call.call(version);
      return;
    }

    String url = CentreUrl.appVersion(Constants.appVersion);
    DioClient().get(url, (response) => VersionBody.fromJson(response.data),
        success: (VersionBody body) {
      if (body != null && body.data != null) {
        version = body.data;
        version.isNone = false;
      }
    }, complete: () {
      /// 需要更新版本
      if (version.isUpgrade || version.mustUpgrade) {
        call.call(version);
      } else {
        notifyToasty(S.of(context).setupdata_mostnew);
      }
    });
  }

  /// 计算缓存大小
  Future<Null> loadCacheSize() async {
    Directory temporaryDir = await getTemporaryDirectory();
    double value = await calculateTotalSizeOfFiles(temporaryDir);

    notifySetState(() {
      cacheSize = formatFileSize(value);
      LogDog.d("loadCacheSize, cacheSize: ${cacheSize}");
    });
  }

  /**
   *
   */
  Future<double> calculateTotalSizeOfFiles(
      final FileSystemEntity entity) async {
    if (entity is File) {
      int length = await entity.length();
      return double.parse(length.toString());
    }
    if (entity is Directory) {
      final List<FileSystemEntity> children = entity.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await calculateTotalSizeOfFiles(child);
      return total;
    }
    return 0;
  }

  String formatFileSize(double value) {
    if (null == value) {
      return NONE_CACHE;
    }

    List<String> unitArr = []..add(' Bits')..add(' KB')..add(' MB')..add(' GB');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  void isNeedClean(Success<String> success) {
    if (!TextHelper.isEqual(cacheSize, NONE_CACHE)) {
      success.call(cacheSize);
    }
  }

  /**
   * 清理缓存
   */
  void cleanCache() async {
    Directory temporaryDir = await getTemporaryDirectory();
    await deleteDir(temporaryDir);
    await loadCacheSize();
  }

  /// 删除目录
  Future<Null> deleteDir(FileSystemEntity dir) async {
    if (dir is Directory) {
      final List<FileSystemEntity> children = dir.listSync();
      for (final FileSystemEntity child in children) {
        await deleteDir(child);
      }
    }
    await dir.delete();
  }
}
