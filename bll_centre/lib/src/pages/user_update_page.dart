import 'package:centre/src/actuator/user_update_actuator.dart';
import 'package:centre/src/dialog/photo_select_dialog.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * UserUpdatePage
 * 更新用户信息
 * @author: Ruoyegz
 * @date:
 */
class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({Key? key}) : super(key: key);

  @override
  _UserUpdateState createState() => _UserUpdateState(UpdateUserActuator());
}

class _UserUpdateState
    extends ReactableState<UpdateUserActuator, UserUpdatePage> {
  _UserUpdateState(UpdateUserActuator actuator) : super(actuator);

  void tapSelectBackground(int index) {
    if (index == 1) {
      actuator.pickBgFromAlbum();
    } else {
      actuator.pickBgFromCamera();
    }
  }

  void tapSelectAvatar(int index) {
    if (index == 1) {
      actuator.pickAvatarFromAlbum();
    } else {
      actuator.pickAvatarFromCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorFE,
        appBar: Toolbar(title: S.of(context).profile_account),

        /// 更新按钮
        bottomNavigationBar: buildUpdateButton(context),
        body: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  /// 背景标题
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      S.of(context).shopinfo_coverphoto,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// 背景图片
                  buildUserBackground(context),

                  Container(
                    height: AppSizes.divider,
                    color: AppColor.color08000,
                    margin: EdgeInsets.only(top: 16),
                  ),

                  /// 头像
                  buildAvatarLayout(),

                  Container(
                    height: AppSizes.divider,
                    color: AppColor.color08000,
                    margin: EdgeInsets.only(top: 10),
                  ),

                  /// 用户名
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      S.of(context).profilechange_username,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// 用户名编辑框
                  buildUsernameFiled(context),

                  Container(
                    height: AppSizes.divider,
                    color: AppColor.color08000,
                    margin: EdgeInsets.only(top: 16),
                  ),

                  /// 用户昵称
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      S.of(context).confirm_name,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// 用户名编辑框
                  buildNickNameFiled(context),

                  Container(
                    height: AppSizes.divider,
                    color: AppColor.color08000,
                    margin: EdgeInsets.only(top: 16),
                  ),

                  /// 用户描述
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      S.of(context).product_description,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// 用户描述编辑框
                  buildUserDescriptionFiled(context),
                ],
              ),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ));
  }

  /**
   * 构建背景
   */
  Widget buildUserBackground(BuildContext context) {
    return GestureDetector(
      child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: 10, left: 16, right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 100),
              imageUrl: TextHelper.clean(actuator.user.bg),
              placeholder: (context, url) => Image.asset(
                  "res/images/def_cover_8_5.png",
                  package: 'resources',
                  fit: BoxFit.fitWidth,
                  height: 176,
                  gaplessPlayback: true,
                  width: MediaQuery.of(context).size.width),
              errorWidget: (context, url, error) => Container(
                height: 176,
                color: AppColor.color0D000,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "res/icons/ic_gray_camera.png",
                  package: 'resources',
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  height: 32,
                  width: 36,
                ),
              ),
              height: 176,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          )),
      onTap: () {
        PhotoSelectDialog.showDialog(context,
            title: S.of(context).shopinfo_coverphoto,
            itemTap: (index) => tapSelectBackground(index));
      },
    );
  }

  /// 头像布局
  Widget buildAvatarLayout() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 10, left: 16, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.of(context).profilechange_head,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 头像
          buildUserAvatar(),

          GestureDetector(
              child: Container(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColor.color99,
                  size: 26,
                ),
              ),
              onTap: () {
                PhotoSelectDialog.showDialog(context,
                    title: S.of(context).profilechange_head,
                    itemTap: (index) => tapSelectAvatar(index));
              })
        ],
      ),
    );
  }

  /**
   * 构建头像
   */
  Widget buildUserAvatar() {
    return GestureDetector(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(40)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: FadeInImage.assetNetwork(
              fadeInDuration: const Duration(milliseconds: 100),
              placeholder: "packages/resources/res/images/def_avatar.png",
              imageErrorBuilder: (context, error, stackTrace) => Container(
                height: 40,
                color: AppColor.color0D000,
                alignment: Alignment.center,
                width: 40,
                child: Image.asset(
                  "res/icons/ic_gray_camera.png",
                  package: 'resources',
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  height: 12,
                  width: 14,
                ),
              ),
              image: TextHelper.clean(actuator.user.avatarLink),
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            ),
          ),
        ),
        onTap: () {
          PhotoSelectDialog.showDialog(context,
              title: S.of(context).profilechange_head,
              itemTap: (index) => tapSelectAvatar(index));
        });
  }

  /// 用户昵称编辑框
  /// Name should be between 2 to 32 characters
  Widget buildUsernameFiled(BuildContext context) {
    return Container(
      height: 44,
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      decoration: BoxDecoration(
          color: AppColor.color08000,
          border: Border.all(color: AppColor.color1A000, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            counterText: "",
            hintText: "",
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 1,
        maxLength: 24,
        cursorWidth: 2,
        cursorColor: AppColor.colorF7551D,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        keyboardType: TextInputType.text,

        /// 只支持英文字母和数字
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Za-z]'))
        ],
        onChanged: (text) {
          if (!TextHelper.isEqual(actuator.name, text)) {
            actuator.name = text;
          }
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            text: '${this.actuator.name == null ? "" : this.actuator.name}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.name}'.length)))),
      ),
    );
  }

  /// 用户昵称编辑框
  Widget buildNickNameFiled(BuildContext context) {
    return Container(
      height: 44,
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      decoration: BoxDecoration(
          color: AppColor.color08000,
          border: Border.all(color: AppColor.color1A000, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            counterText: "",
            hintText: "",
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 1,
        maxLength: 32,
        cursorColor: AppColor.colorF7551D,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          if (!TextHelper.isEqual(actuator.nickName, text)) {
            actuator.nickName = text;
          }
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            text:
                '${this.actuator.nickName == null ? "" : this.actuator.nickName}',
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.nickName}'.length)))),
      ),
    );
  }

  /// 用户描述编辑框
  Widget buildUserDescriptionFiled(BuildContext context) {
    return Container(
      height: 126,
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      decoration: BoxDecoration(
          color: AppColor.color08000,
          border: Border.all(color: AppColor.color1A000, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            counterText: "",
            hintText: "",
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 5,
        maxLength: 100,
        cursorWidth: 2,
        cursorColor: AppColor.colorF7551D,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          if (!TextHelper.isEqual(actuator.description, text)) {
            actuator.description = text;
          }
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            text:
                '${this.actuator.description == null ? "" : this.actuator.description}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.description}'.length)))),
      ),
    );
  }

  //// 更新按钮
  Widget buildUpdateButton(BuildContext context) {
    return Container(
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
              color: AppColor.bg,
              offset: Offset(2.0, 2.0),
              blurRadius: 5.0,
              spreadRadius: 0.6),
          BoxShadow(color: AppColor.bg, offset: Offset(1.0, 1.0)),
          BoxShadow(color: AppColor.bg)
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              gradient: LinearGradient(
                  colors: [Color(0xFFFF7B22), Color(0xFFFF2222)],
                  begin: FractionalOffset(1, 0),
                  end: FractionalOffset(0, 1))),
          child: Text(S.of(context).textview_update,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
        onTap: () {
          if (actuator != null) {
            actuator.tabUpdate();
          }
        },
      ),
    );
  }
}
