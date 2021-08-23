import 'dart:convert';
import 'dart:io';

import 'package:centre/src/centre_config.dart';
import 'package:centre/src/model/app_version_scope.dart';
import 'package:common/common.dart';

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

  void checkAppVersion(UpdateCallback call) {
    AppVersionScope scope = AppVersionScope();
    scope.checkVersion(context, call, showToast: true);
  }

  /// 计算缓存大小
  Future<Null> loadCacheSize({bool? cleaned}) async {
    Directory temporaryDir = await getTemporaryDirectory();
    double value = 0;
    if (cleaned == null || !cleaned) {
      value = await calculateTotalSizeOfFiles(temporaryDir);
    }

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
    try {
      Directory temporaryDir = await getTemporaryDirectory();
      await deleteDir(temporaryDir);
      await loadCacheSize();
    } on Error catch (e) {
      SentryHelper.caught(e);
      LogDog.w("cleanCache, error: ", e, e.stackTrace);
    } finally {
      loadCacheSize(cleaned: true);
    }
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
