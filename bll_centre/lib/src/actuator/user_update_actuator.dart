/*
import 'package:centre/src/centre_config.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateType {
  static final String BG = "user_bg";
  static final String AVATAR = "user_avatar";
  static final String NICK_NAME = "user_nick_name";
}

*/
/**
 * UpdateUserActuator
 * 更新用户信息
 * @author: Ruoyegz
 * @date: 2021/7/27
 *//*

class UpdateUserActuator extends ReactActuator {
  /// 待更新的 昵称
  String nickName = "";

  /// 待更新的 用户名
  String name = "";

  /// 待更新的 用户名
  String description = "";

  User user = UserManager().getUser();

  /// 是否需要更新用户信息
  bool isNeedNotifyUpdate = false;

  /// 更新用户名成功
  bool successForName = false;

  /// 更新其他信息成功
  bool successForOther = false;

  Dio uploadDio = new Dio();

  ImagePicker picker = ImagePicker();

  UpdateUserActuator() {
    uploadDio
      ..options = new BaseOptions(
        connectTimeout: 1000 * 60,
        receiveTimeout: 1000 * 60 * 60 * 24,
        responseType: ResponseType.json,
      )
      ..interceptors.add(HttpLogDogInterceptor());

    name = user.name ?? "";
    nickName = user.nickName ?? "";
    description = user.about ?? "";
  }

  @override
  void dispose() {
    /// 通知外部用户信息更新
    if (isNeedNotifyUpdate) {
      BusClient().fire(UpdateUserEvent());
    }
    super.dispose();
  }

  /// 从图库选择背景
  void pickBgFromAlbum() async {
    List<Media>? medias = await ImagesPicker.pick(
      count: 1,
      quality: 0.7,
      pickType: PickType.image,
      language: Language.System,
      cropOpt: CropOption(
        cropType: CropType.rect,
        aspectRatio: CropAspectRatio.wh16x9,
      ),
    );
    if (medias != null && medias.isNotEmpty) {
      String imagePath = medias[0].path;
      if (TextHelper.isNotEmpty(imagePath)) {
        String name =
            imagePath.substring(imagePath.lastIndexOf(RegExp(r'/')) + 2);
        prepareUploadImage(UpdateType.BG, name, imagePath);
      }
    }
  }

  /// 从相机拍摄背景
  void pickBgFromCamera() async {
    List<Media>? medias = await ImagesPicker.openCamera(
      pickType: PickType.image,
      quality: 0.6,
      cropOpt: CropOption(
        cropType: CropType.circle,
        aspectRatio: CropAspectRatio.wh16x9,
      ),
    );
    if (medias != null && medias.isNotEmpty) {
      String imagePath = medias[0].path;
      if (TextHelper.isNotEmpty(imagePath)) {
        String name =
            imagePath.substring(imagePath.lastIndexOf(RegExp(r'/')) + 2);
        prepareUploadImage(UpdateType.BG, name, imagePath);
      }
    }
  }

  /// 从图库选择头像
  void pickAvatarFromAlbum() async {
    List<Media>? medias = await ImagesPicker.pick(
      count: 1,
      quality: 0.7,
      pickType: PickType.image,
      language: Language.System,
      cropOpt: CropOption(
        cropType: CropType.rect,
        aspectRatio: CropAspectRatio(1, 1),
      ),
    );
    if (medias != null && medias.isNotEmpty) {
      String imagePath = medias[0].path;
      if (TextHelper.isNotEmpty(imagePath)) {
        String name =
            imagePath.substring(imagePath.lastIndexOf(RegExp(r'/')) + 2);
        prepareUploadImage(UpdateType.AVATAR, name, imagePath);
      }
    }
  }

  /// 从相机拍摄头像
  void pickAvatarFromCamera() async {
    List<Media>? medias = await ImagesPicker.openCamera(
      pickType: PickType.image,
      quality: 0.6,
      cropOpt: CropOption(
        cropType: CropType.circle,
        aspectRatio: CropAspectRatio(1, 1),
      ),
      // maxTime: 60,
    );
    if (medias != null && medias.isNotEmpty) {
      String imagePath = medias[0].path;
      if (TextHelper.isNotEmpty(imagePath)) {
        String name =
            imagePath.substring(imagePath.lastIndexOf(RegExp(r'/')) + 2);
        prepareUploadImage(UpdateType.AVATAR, name, imagePath);
      }
    }
  }

  /// 上传图片之前先向服务器请求桶服务参数
  void prepareUploadImage(String type, String name, String path) async {
    String url = CentreUrl.awsApi("avatar", path);
    DioClient().get(url, (response) => UploadResBody.fromJson(response.data),
        success: (UploadResBody body) {
      LogDog.i("uploadImage, UploadResBody: ${body.toJson()}");

      if (body != null &&
          TextHelper.isNotEmpty(body.action) &&
          body.form != null) {
        uploadImage(type, name, path, body);
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {});
  }

  */
/**
   * 上传图片到桶
   *//*

  void uploadImage(
      String type, String name, String path, UploadResBody resBody) async {
    FormData requestBody = FormData();

    String amzDomain = "";

    /// 转换表单信息
    resBody.form!.forEach((key, value) {
      requestBody.fields.add(MapEntry(key, value));
      if ("x-amz-domain" == key) {
        amzDomain = value;
      }

      LogDog.i("uploadImage-form, ${key}: ${value}");
    });

    /// "multipart/form-data"
    requestBody.files.add(
        MapEntry("file", MultipartFile.fromFileSync(path, filename: name)));

    try {
      Response response =
          await uploadDio.post(resBody.action!, data: requestBody);
      if (response != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        XmlDocument document = XmlDocument.parse(response.data);
        String key =
            document.getElement("PostResponse")!.getElement("Key")!.text;

        LogDog.i("uploadImage, uploadResponse-key: ${key}");
        LogDog.i("uploadImage, uploadResponse-url: ${amzDomain}${key}");

        String finalUrl = "";
        if (TextHelper.isNotEmpty(amzDomain) && TextHelper.isNotEmpty(key)) {
          finalUrl = "${amzDomain}${key}";
          Map<String, String> params = {type: finalUrl};
          updateUserInfo(false, params);
        }
      }
    } on DioError catch (e) {
      LogDog.e("uploadImage, uploadResponse-err", e, e.stackTrace);
    }
  }

  /// 点击更新
  void tabUpdate({Actioned? start, Actioned? end}) {
    successForName = false;
    successForOther = false;
    Map<String, String> params = {};

    bool needUpdateName = false;

    /// 名称
    if (!TextHelper.isEqual(name, user.name)) {
      /// Username should be within 3－24 characters, can only be English or numbers.
      if (TextHelper.isEmpty(name) || name.length < 3 || name.length > 24) {
        toast(message: S.of(context).alltip_usernamerule);
        return;
      } else {
        needUpdateName = true;
        if (start != null) {
          start.call();
        }
        updateUserName(end: end);
      }
    } else {
      successForName = true;
    }

    /// 昵称
    if (!TextHelper.isEqual(nickName, user.nickName)) {
      /// Name should be between 2 to 32 characters
      if (TextHelper.isEmpty(nickName) ||
          nickName.length < 2 ||
          nickName.length > 32) {
        toast(message: S.of(context).alltip_nikenamerule);
        successForOther = true;
        return;
      } else {
        params["user_nick_name"] = nickName;
      }
    }

    /// 描述
    if (!TextHelper.isEqual(description, user.about)) {
      /// Bio should be between 1 to 100 characters
      if (TextHelper.isEmpty(description) ||
          description.length < 1 ||
          description.length >= 100) {
        toast(message: S.of(context).alltip_biorule);
        successForOther = true;
        return;
      } else {
        params["user_about"] = description;
      }
    }

    /// 用户名和其他信息都没有变化就不更新
    if (params.isNotEmpty) {
      if (!needUpdateName) {
        if (start != null) {
          start.call();
        }
      }

      /// 更新用户信息
      updateUserInfo(!needUpdateName, params, end: end);
    }
  }

  */
/**
   * 更新用户昵称
   *//*

  void updateUserName({Actioned? end}) async {
    isNeedNotifyUpdate = true;
    Map<String, String> params = {"user_name": name};
    DioClient().patch(CentreUrl.updateName, (response) => response,
        body: params, success: (Response body) {
      if (body != null && body.statusCode! >= 200 && body.statusCode! < 300) {
        user.name = name;
        UserManager().saveUser(user);
        successForName = true;
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {
      if (end != null) {
        end.call();
      }

      notifySetState();

      if (successForName && successForOther) {
        Navigator.pop(context);
      }
    });
  }

  */
/**
   * 更新用户信息
   *//*

  void updateUserInfo(bool needHideLoading, Map<String, String> params,
      {Actioned? end}) async {
    if (params.isEmpty) {
      return;
    }
    isNeedNotifyUpdate = true;

    DioClient().put(
        CentreUrl.updateUser, (response) => UserBody.fromJson(response.data),
        body: params, success: (UserBody body) {
      if (body != null && body.data != null) {
        UserManager().saveUser(body.data);
        user = UserManager().getUser();
        nickName = user.nickName!;
        description = user.about!;
        successForOther = true;
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {
      if (needHideLoading && end != null) {
        end.call();
      }

      notifySetState();

      if (successForName && successForOther) {
        Navigator.pop(context);
      }
    });
  }
}
*/
