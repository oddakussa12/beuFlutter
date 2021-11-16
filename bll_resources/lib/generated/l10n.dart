// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `beU Delivery`
  String get app_name {
    return Intl.message(
      'beU Delivery',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `You\'ve got a friend request from beU.`
  String get push_addfriend {
    return Intl.message(
      'You\\\'ve got a friend request from beU.',
      name: 'push_addfriend',
      desc: '',
      args: [],
    );
  }

  /// `Sent you a new message.`
  String get push_newmessage {
    return Intl.message(
      'Sent you a new message.',
      name: 'push_newmessage',
      desc: '',
      args: [],
    );
  }

  /// `Why?`
  String get allpage_why {
    return Intl.message(
      'Why?',
      name: 'allpage_why',
      desc: '',
      args: [],
    );
  }

  /// `Please download the videos you like, after 24 hours it would be deleted.`
  String get allpage_download {
    return Intl.message(
      'Please download the videos you like, after 24 hours it would be deleted.',
      name: 'allpage_download',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get allpage_loading {
    return Intl.message(
      'Loading',
      name: 'allpage_loading',
      desc: '',
      args: [],
    );
  }

  /// `Network unavailable, try again later.`
  String get allpage_loading_faild {
    return Intl.message(
      'Network unavailable, try again later.',
      name: 'allpage_loading_faild',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to quit?`
  String get allpage_loading_exit {
    return Intl.message(
      'Confirm to quit?',
      name: 'allpage_loading_exit',
      desc: '',
      args: [],
    );
  }

  /// `Not shop found`
  String get allpage_shopnofind {
    return Intl.message(
      'Check your internet access',
      name: 'allpage_shopnofind',
      desc: '',
      args: [],
    );
  }

  /// `Not products found`
  String get allpage_productnofind {
    return Intl.message(
      'Check your internet access',
      name: 'allpage_productnofind',
      desc: '',
      args: [],
    );
  }

  /// `This category is empty`
  String get allpage_no_product {
    return Intl.message(
      'This category is empty',
      name: 'allpage_no_product',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get reminder_search {
    return Intl.message(
      'Search',
      name: 'reminder_search',
      desc: '',
      args: [],
    );
  }

  /// `Nikename`
  String get reminder_nickname {
    return Intl.message(
      'Nikename',
      name: 'reminder_nickname',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get reminder_bio {
    return Intl.message(
      'Bio',
      name: 'reminder_bio',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your ID`
  String get reminder_username {
    return Intl.message(
      'Please enter your ID',
      name: 'reminder_username',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get reminder_enterphone {
    return Intl.message(
      'Enter phone number',
      name: 'reminder_enterphone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get reminder_enterpassword {
    return Intl.message(
      'Password',
      name: 'reminder_enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get reminder_country {
    return Intl.message(
      'Select country',
      name: 'reminder_country',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get reminder_message {
    return Intl.message(
      'Message',
      name: 'reminder_message',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get textview_edit {
    return Intl.message(
      'Edit',
      name: 'textview_edit',
      desc: '',
      args: [],
    );
  }

  /// `Creat`
  String get textview_creat {
    return Intl.message(
      'Creat',
      name: 'textview_creat',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get textview_update {
    return Intl.message(
      'Update',
      name: 'textview_update',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get textview_useragree {
    return Intl.message(
      'User Agreement',
      name: 'textview_useragree',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Agreement`
  String get textview_secret {
    return Intl.message(
      'Privacy Agreement',
      name: 'textview_secret',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get button_confirm {
    return Intl.message(
      'Confirm',
      name: 'button_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message(
      'Cancel',
      name: 'button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Turn on`
  String get button_turnon {
    return Intl.message(
      'Turn on',
      name: 'button_turnon',
      desc: '',
      args: [],
    );
  }

  /// `Add friend`
  String get button_addfriend {
    return Intl.message(
      'Add friend',
      name: 'button_addfriend',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get button_send {
    return Intl.message(
      'Send',
      name: 'button_send',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get button_invite {
    return Intl.message(
      'Invite',
      name: 'button_invite',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get button_completed {
    return Intl.message(
      'Completed',
      name: 'button_completed',
      desc: '',
      args: [],
    );
  }

  /// `Next step`
  String get button_nextstep {
    return Intl.message(
      'Next step',
      name: 'button_nextstep',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get button_submit {
    return Intl.message(
      'Submit',
      name: 'button_submit',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get button_edit {
    return Intl.message(
      'Edit',
      name: 'button_edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get button_save {
    return Intl.message(
      'Save',
      name: 'button_save',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to delete?`
  String get popall_delete {
    return Intl.message(
      'Confirm to delete?',
      name: 'popall_delete',
      desc: '',
      args: [],
    );
  }

  /// `Turn on notifications so you won\'t miss any messages.`
  String get popall_notific {
    return Intl.message(
      'Turn on notifications so you won\\\'t miss any messages.',
      name: 'popall_notific',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to delete this friend?`
  String get popall_deletefriend {
    return Intl.message(
      'Confirm to delete this friend?',
      name: 'popall_deletefriend',
      desc: '',
      args: [],
    );
  }

  /// `Please log in again.`
  String get popall_loginagain {
    return Intl.message(
      'Please log in again.',
      name: 'popall_loginagain',
      desc: '',
      args: [],
    );
  }

  /// `Your beU account is trying to log in to a new device. This device will be forced to log out.`
  String get popall_offline {
    return Intl.message(
      'Your beU account is trying to log in to a new device. This device will be forced to log out.',
      name: 'popall_offline',
      desc: '',
      args: [],
    );
  }

  /// `Due to violation of beU\'s Terms of Use, your account is now suspended.`
  String get popall_violation {
    return Intl.message(
      'Due to violation of beU\\\'s Terms of Use, your account is now suspended.',
      name: 'popall_violation',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get alltip_loading {
    return Intl.message(
      'Loading',
      name: 'alltip_loading',
      desc: '',
      args: [],
    );
  }

  /// `Loading error, try again later`
  String get alltip_loading_error {
    return Intl.message(
      'Loading error, try again later',
      name: 'alltip_loading_error',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get alltip_sended {
    return Intl.message(
      'Sent',
      name: 'alltip_sended',
      desc: '',
      args: [],
    );
  }

  /// `Sending`
  String get alltip_sending {
    return Intl.message(
      'Sending',
      name: 'alltip_sending',
      desc: '',
      args: [],
    );
  }

  /// `Network error, try again later`
  String get alltip_nonetwork {
    return Intl.message(
      'Network error, try again later',
      name: 'alltip_nonetwork',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get alltip_copied {
    return Intl.message(
      'Copied',
      name: 'alltip_copied',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get alltip_nodata {
    return Intl.message(
      'No data',
      name: 'alltip_nodata',
      desc: '',
      args: [],
    );
  }

  /// `{param1} {param2}`
  String alltip_formatOrderPrice(Object param1, Object param2) {
    return Intl.message(
      '$param1 $param2',
      name: 'alltip_formatOrderPrice',
      desc: '',
      args: [param1, param2],
    );
  }

  /// `Maximum 20 products in your shopping cart!`
  String get alltip_maxshop_product {
    return Intl.message(
      'Maximum 20 products in your shopping cart!',
      name: 'alltip_maxshop_product',
      desc: '',
      args: [],
    );
  }

  /// `Press again to exit beU!`
  String get alltip_exit {
    return Intl.message(
      'Press again to exit beU!',
      name: 'alltip_exit',
      desc: '',
      args: [],
    );
  }

  /// `Failed, try again later`
  String get alltip_failed {
    return Intl.message(
      'Failed, try again later',
      name: 'alltip_failed',
      desc: '',
      args: [],
    );
  }

  /// `Select at most one video`
  String get alltip_maxonevideo {
    return Intl.message(
      'Select at most one video',
      name: 'alltip_maxonevideo',
      desc: '',
      args: [],
    );
  }

  /// `Reply should be within 1 to 2000 characters`
  String get alltip_replyrule {
    return Intl.message(
      'Reply should be within 1 to 2000 characters',
      name: 'alltip_replyrule',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get alltip_idsuccessed {
    return Intl.message(
      'Saved',
      name: 'alltip_idsuccessed',
      desc: '',
      args: [],
    );
  }

  /// `Username should be within 3－24 characters, can only be English or numbers.`
  String get alltip_usernamerule {
    return Intl.message(
      'Username should be within 3－24 characters, can only be English or numbers.',
      name: 'alltip_usernamerule',
      desc: '',
      args: [],
    );
  }

  /// `Name should be between 2 to 32 characters`
  String get alltip_nikenamerule {
    return Intl.message(
      'Name should be between 2 to 32 characters',
      name: 'alltip_nikenamerule',
      desc: '',
      args: [],
    );
  }

  /// `Bio should be between 1 to 100 characters`
  String get alltip_biorule {
    return Intl.message(
      'Bio should be between 1 to 100 characters',
      name: 'alltip_biorule',
      desc: '',
      args: [],
    );
  }

  /// `Cover picture cannot be empty`
  String get alltip_coverphotorule {
    return Intl.message(
      'Cover picture cannot be empty',
      name: 'alltip_coverphotorule',
      desc: '',
      args: [],
    );
  }

  /// `Profile picture cannot be empty`
  String get alltip_headpic {
    return Intl.message(
      'Profile picture cannot be empty',
      name: 'alltip_headpic',
      desc: '',
      args: [],
    );
  }

  /// `Business username should be within 3－24 characters, can only be English or numbers.`
  String get alltip_shopusernamerule {
    return Intl.message(
      'Business username should be within 3－24 characters, can only be English or numbers.',
      name: 'alltip_shopusernamerule',
      desc: '',
      args: [],
    );
  }

  /// `Business name should be between 2 to 32 characters`
  String get alltip_shopnikenamerule {
    return Intl.message(
      'Business name should be between 2 to 32 characters',
      name: 'alltip_shopnikenamerule',
      desc: '',
      args: [],
    );
  }

  /// `Business address should be between 10 to 100 characters`
  String get alltip_shopaddressrule {
    return Intl.message(
      'Business address should be between 10 to 100 characters',
      name: 'alltip_shopaddressrule',
      desc: '',
      args: [],
    );
  }

  /// `Business phone should be between 7 to 14 characters`
  String get alltip_shopphonerule {
    return Intl.message(
      'Business phone should be between 7 to 14 characters',
      name: 'alltip_shopphonerule',
      desc: '',
      args: [],
    );
  }

  /// `Business bio should be between 1 to 300 characters`
  String get alltip_shopbiorule {
    return Intl.message(
      'Business bio should be between 1 to 300 characters',
      name: 'alltip_shopbiorule',
      desc: '',
      args: [],
    );
  }

  /// `Product Images cannot be empty`
  String get alltip_product_imagerule {
    return Intl.message(
      'Product Images cannot be empty',
      name: 'alltip_product_imagerule',
      desc: '',
      args: [],
    );
  }

  /// `Product name should be between 6 to 32 characters`
  String get alltip_product_namerule {
    return Intl.message(
      'Product name should be between 6 to 32 characters',
      name: 'alltip_product_namerule',
      desc: '',
      args: [],
    );
  }

  /// `Product Price cannot be empty`
  String get alltip_product_pricerule {
    return Intl.message(
      'Product Price cannot be empty',
      name: 'alltip_product_pricerule',
      desc: '',
      args: [],
    );
  }

  /// `Business bio should be between 1 to 300 characters`
  String get alltip_product_descriptionrule {
    return Intl.message(
      'Business bio should be between 1 to 300 characters',
      name: 'alltip_product_descriptionrule',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login_log_in {
    return Intl.message(
      'Log in',
      name: 'login_log_in',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_login {
    return Intl.message(
      'Login',
      name: 'login_login',
      desc: '',
      args: [],
    );
  }

  /// `Password Retrival`
  String get login_forgot {
    return Intl.message(
      'Password Retrival',
      name: 'login_forgot',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get login_creat_new_accont {
    return Intl.message(
      'Create New Account',
      name: 'login_creat_new_accont',
      desc: '',
      args: [],
    );
  }

  /// `Have a Shop?`
  String get login_have_shop {
    return Intl.message(
      'Have a Shop?',
      name: 'login_have_shop',
      desc: '',
      args: [],
    );
  }

  /// `Join Us`
  String get login_join_us {
    return Intl.message(
      'Join Us',
      name: 'login_join_us',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password`
  String get forget_newpassword {
    return Intl.message(
      'Enter a new password',
      name: 'forget_newpassword',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has been sent to`
  String get forget_verificationsend {
    return Intl.message(
      'Verification code has been sent to',
      name: 'forget_verificationsend',
      desc: '',
      args: [],
    );
  }

  /// `Password recovery`
  String get forgrt_password {
    return Intl.message(
      'Password recovery',
      name: 'forgrt_password',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get forget_code {
    return Intl.message(
      'Verification code',
      name: 'forget_code',
      desc: '',
      args: [],
    );
  }

  /// `Receive code`
  String get forget_getcode {
    return Intl.message(
      'Receive code',
      name: 'forget_getcode',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get forget_changesuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'forget_changesuccess',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get forget_vernone {
    return Intl.message(
      'Enter verification code',
      name: 'forget_vernone',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get login_signup {
    return Intl.message(
      'Sign up',
      name: 'login_signup',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get login_haveaccount {
    return Intl.message(
      'Already have an account?',
      name: 'login_haveaccount',
      desc: '',
      args: [],
    );
  }

  /// `Login info`
  String get login_login_info {
    return Intl.message(
      'Login info',
      name: 'login_login_info',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get login_username {
    return Intl.message(
      'Username',
      name: 'login_username',
      desc: '',
      args: [],
    );
  }

  /// `Your Name is`
  String get login_your_name {
    return Intl.message(
      'Your Name is',
      name: 'login_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Write your name`
  String get login_write_name {
    return Intl.message(
      'Write your name',
      name: 'login_write_name',
      desc: '',
      args: [],
    );
  }

  /// `Create shop`
  String get login_creat_shop {
    return Intl.message(
      'Create shop',
      name: 'login_creat_shop',
      desc: '',
      args: [],
    );
  }

  /// `Write your name for your shop`
  String get login_write_shop_name {
    return Intl.message(
      'Write your name for your shop',
      name: 'login_write_shop_name',
      desc: '',
      args: [],
    );
  }

  /// `Shop\'s name`
  String get login_shop_name_title {
    return Intl.message(
      'Shop\\\'s name',
      name: 'login_shop_name_title',
      desc: '',
      args: [],
    );
  }

  /// `Done!`
  String get login_done {
    return Intl.message(
      'Done!',
      name: 'login_done',
      desc: '',
      args: [],
    );
  }

  /// `Your shop will be approved {param}`
  String login_shop_approved(Object param) {
    return Intl.message(
      'Your shop will be approved $param',
      name: 'login_shop_approved',
      desc: '',
      args: [param],
    );
  }

  /// `will be approved {param}`
  String login_shop_approved_error(Object param) {
    return Intl.message(
      'will be approved $param',
      name: 'login_shop_approved_error',
      desc: '',
      args: [param],
    );
  }

  /// `soon`
  String get login_shop_approved_soon {
    return Intl.message(
      'soon',
      name: 'login_shop_approved_soon',
      desc: '',
      args: [],
    );
  }

  /// `Your shop`
  String get login_error_shop_tip_title {
    return Intl.message(
      'Your shop',
      name: 'login_error_shop_tip_title',
      desc: '',
      args: [],
    );
  }

  /// `Let our team call you within`
  String get login_our_team_call_shop {
    return Intl.message(
      'Let our team call you within',
      name: 'login_our_team_call_shop',
      desc: '',
      args: [],
    );
  }

  /// `24 hours`
  String get login_finish_shop_tip {
    return Intl.message(
      '24 hours',
      name: 'login_finish_shop_tip',
      desc: '',
      args: [],
    );
  }

  /// `should be between 6 to 24 characters`
  String get loginerror_password {
    return Intl.message(
      'should be between 6 to 24 characters',
      name: 'loginerror_password',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is invalid`
  String get loginerror_phone {
    return Intl.message(
      'Phone number is invalid',
      name: 'loginerror_phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone number has been registered.`
  String get loginerror_phonerepeat {
    return Intl.message(
      'Phone number has been registered.',
      name: 'loginerror_phonerepeat',
      desc: '',
      args: [],
    );
  }

  /// `TRY AGAIN`
  String get loginerror_tryagain {
    return Intl.message(
      'TRY AGAIN',
      name: 'loginerror_tryagain',
      desc: '',
      args: [],
    );
  }

  /// `New version`
  String get setting_newversion {
    return Intl.message(
      'New version',
      name: 'setting_newversion',
      desc: '',
      args: [],
    );
  }

  /// `Help and feedback`
  String get setting_feedback {
    return Intl.message(
      'Help and feedback',
      name: 'setting_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get setting_privacy {
    return Intl.message(
      'Privacy',
      name: 'setting_privacy',
      desc: '',
      args: [],
    );
  }

  /// `About beU`
  String get setting_about {
    return Intl.message(
      'About beU',
      name: 'setting_about',
      desc: '',
      args: [],
    );
  }

  /// `Clean up local cache`
  String get setting_cleancache {
    return Intl.message(
      'Clean up local cache',
      name: 'setting_cleancache',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get setting_logout {
    return Intl.message(
      'Log out',
      name: 'setting_logout',
      desc: '',
      args: [],
    );
  }

  /// `Already the latest version`
  String get setupdata_mostnew {
    return Intl.message(
      'Already the latest version',
      name: 'setupdata_mostnew',
      desc: '',
      args: [],
    );
  }

  /// `Update now`
  String get setupdata_updateapp {
    return Intl.message(
      'Update now',
      name: 'setupdata_updateapp',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions`
  String get sethelp_suggestions {
    return Intl.message(
      'Suggestions',
      name: 'sethelp_suggestions',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get sethelp_feeback {
    return Intl.message(
      'Feedback',
      name: 'sethelp_feeback',
      desc: '',
      args: [],
    );
  }

  /// `Picture`
  String get sethelp_upphoto {
    return Intl.message(
      'Picture',
      name: 'sethelp_upphoto',
      desc: '',
      args: [],
    );
  }

  /// `Who can see my firend\'s list`
  String get setpermission_myfriend {
    return Intl.message(
      'Who can see my firend\\\'s list',
      name: 'setpermission_myfriend',
      desc: '',
      args: [],
    );
  }

  /// `Who can see my shops`
  String get setpermission_myshop {
    return Intl.message(
      'Who can see my shops',
      name: 'setpermission_myshop',
      desc: '',
      args: [],
    );
  }

  /// `Everyone`
  String get setpermission_everyone {
    return Intl.message(
      'Everyone',
      name: 'setpermission_everyone',
      desc: '',
      args: [],
    );
  }

  /// `Friends only`
  String get setpermission_friendsonly {
    return Intl.message(
      'Friends only',
      name: 'setpermission_friendsonly',
      desc: '',
      args: [],
    );
  }

  /// `Only me`
  String get setpermission_mine {
    return Intl.message(
      'Only me',
      name: 'setpermission_mine',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clean up the local cache?`
  String get setcache_confirm {
    return Intl.message(
      'Are you sure you want to clean up the local cache?',
      name: 'setcache_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to log out?`
  String get setout_confirm {
    return Intl.message(
      'Confirm to log out?',
      name: 'setout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get otherprofile_addfriend {
    return Intl.message(
      'Add',
      name: 'otherprofile_addfriend',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get otherprofile_contacts {
    return Intl.message(
      'Contacts',
      name: 'otherprofile_contacts',
      desc: '',
      args: [],
    );
  }

  /// `See {param}\'s shops`
  String otherprofile_seeshop(Object param) {
    return Intl.message(
      'See $param\\\'s shops',
      name: 'otherprofile_seeshop',
      desc: '',
      args: [param],
    );
  }

  /// `Added`
  String get otherprofile_added {
    return Intl.message(
      'Added',
      name: 'otherprofile_added',
      desc: '',
      args: [],
    );
  }

  /// `{param}\'s Friends`
  String otherprofile_hisfriends(Object param) {
    return Intl.message(
      '$param\\\'s Friends',
      name: 'otherprofile_hisfriends',
      desc: '',
      args: [param],
    );
  }

  /// `My shops`
  String get profile_shop {
    return Intl.message(
      'My shops',
      name: 'profile_shop',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get profile_account {
    return Intl.message(
      'Account',
      name: 'profile_account',
      desc: '',
      args: [],
    );
  }

  /// `My Friends`
  String get profile_myfriend {
    return Intl.message(
      'My Friends',
      name: 'profile_myfriend',
      desc: '',
      args: [],
    );
  }

  /// `Profile picture`
  String get profilechange_head {
    return Intl.message(
      'Profile picture',
      name: 'profilechange_head',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get profilechange_headfailed {
    return Intl.message(
      'Failed',
      name: 'profilechange_headfailed',
      desc: '',
      args: [],
    );
  }

  /// `Nikename`
  String get profilechange_nikename {
    return Intl.message(
      'Nikename',
      name: 'profilechange_nikename',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get profilechange_username {
    return Intl.message(
      'Username',
      name: 'profilechange_username',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get profilechange_gender {
    return Intl.message(
      'Gender',
      name: 'profilechange_gender',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get profilechange_birthday {
    return Intl.message(
      'Birthday',
      name: 'profilechange_birthday',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get profilechange_bio {
    return Intl.message(
      'Bio',
      name: 'profilechange_bio',
      desc: '',
      args: [],
    );
  }

  /// `Create an unique username.`
  String get profilechange_usernametip {
    return Intl.message(
      'Create an unique username.',
      name: 'profilechange_usernametip',
      desc: '',
      args: [],
    );
  }

  /// `(Note: username can only be changed once.)`
  String get profilechange_usernamerule {
    return Intl.message(
      '(Note: username can only be changed once.)',
      name: 'profilechange_usernamerule',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get profilechange_male {
    return Intl.message(
      'Male',
      name: 'profilechange_male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get profilechange_female {
    return Intl.message(
      'Female',
      name: 'profilechange_female',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get shopcenter_account {
    return Intl.message(
      'Account',
      name: 'shopcenter_account',
      desc: '',
      args: [],
    );
  }

  /// `Manage`
  String get shopcenter_manage {
    return Intl.message(
      'Manage',
      name: 'shopcenter_manage',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get shopcenter_follow {
    return Intl.message(
      'Follow',
      name: 'shopcenter_follow',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get shopcenter_contact {
    return Intl.message(
      'Contact',
      name: 'shopcenter_contact',
      desc: '',
      args: [],
    );
  }

  /// `Delivery fee`
  String get shopcenter_fee {
    return Intl.message(
      'Delivery fee',
      name: 'shopcenter_fee',
      desc: '',
      args: [],
    );
  }

  /// `Buy now`
  String get shopcenter_buy {
    return Intl.message(
      'Buy now',
      name: 'shopcenter_buy',
      desc: '',
      args: [],
    );
  }

  /// `Manage activity`
  String get shopmanage_activity {
    return Intl.message(
      'Manage activity',
      name: 'shopmanage_activity',
      desc: '',
      args: [],
    );
  }

  /// `Manage product`
  String get shopmanage_product {
    return Intl.message(
      'Manage product',
      name: 'shopmanage_product',
      desc: '',
      args: [],
    );
  }

  /// `Cover Picture`
  String get shopinfo_coverphoto {
    return Intl.message(
      'Cover Picture',
      name: 'shopinfo_coverphoto',
      desc: '',
      args: [],
    );
  }

  /// `Profile picture`
  String get shopinfo_headpic {
    return Intl.message(
      'Profile picture',
      name: 'shopinfo_headpic',
      desc: '',
      args: [],
    );
  }

  /// `Business username`
  String get shopinfo_username {
    return Intl.message(
      'Business username',
      name: 'shopinfo_username',
      desc: '',
      args: [],
    );
  }

  /// `Business nikename`
  String get shopinfo_nikename {
    return Intl.message(
      'Business nikename',
      name: 'shopinfo_nikename',
      desc: '',
      args: [],
    );
  }

  /// `Business Address`
  String get shopinfo_address {
    return Intl.message(
      'Business Address',
      name: 'shopinfo_address',
      desc: '',
      args: [],
    );
  }

  /// `Business phone number`
  String get shopinfo_phone {
    return Intl.message(
      'Business phone number',
      name: 'shopinfo_phone',
      desc: '',
      args: [],
    );
  }

  /// `Business description`
  String get shopinfo_bio {
    return Intl.message(
      'Business description',
      name: 'shopinfo_bio',
      desc: '',
      args: [],
    );
  }

  /// `{param} people liked {param1}`
  String activity_numberlike(Object param, Object param1) {
    return Intl.message(
      '$param people liked $param1',
      name: 'activity_numberlike',
      desc: '',
      args: [param, param1],
    );
  }

  /// `{param} liked it.`
  String activity_wholike(Object param) {
    return Intl.message(
      '$param liked it.',
      name: 'activity_wholike',
      desc: '',
      args: [param],
    );
  }

  /// `Product images`
  String get changeproduct_image {
    return Intl.message(
      'Product images',
      name: 'changeproduct_image',
      desc: '',
      args: [],
    );
  }

  /// `Product pame`
  String get changeproduct_name {
    return Intl.message(
      'Product pame',
      name: 'changeproduct_name',
      desc: '',
      args: [],
    );
  }

  /// `Product price`
  String get changeproduct_price {
    return Intl.message(
      'Product price',
      name: 'changeproduct_price',
      desc: '',
      args: [],
    );
  }

  /// `Product discount price`
  String get changeproduct_discount {
    return Intl.message(
      'Product discount price',
      name: 'changeproduct_discount',
      desc: '',
      args: [],
    );
  }

  /// `Product description`
  String get changeproduct_description {
    return Intl.message(
      'Product description',
      name: 'changeproduct_description',
      desc: '',
      args: [],
    );
  }

  /// `In stock?`
  String get changeproduct_instock {
    return Intl.message(
      'In stock?',
      name: 'changeproduct_instock',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get changeproduct_yes {
    return Intl.message(
      'yes',
      name: 'changeproduct_yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get changeproduct_no {
    return Intl.message(
      'no',
      name: 'changeproduct_no',
      desc: '',
      args: [],
    );
  }

  /// `Create product`
  String get changeproduct_create {
    return Intl.message(
      'Create product',
      name: 'changeproduct_create',
      desc: '',
      args: [],
    );
  }

  /// `Update product`
  String get changeproduct_update {
    return Intl.message(
      'Update product',
      name: 'changeproduct_update',
      desc: '',
      args: [],
    );
  }

  /// `Write a review`
  String get product_write_review {
    return Intl.message(
      'Write a review',
      name: 'product_write_review',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get product_reviews {
    return Intl.message(
      'Reviews',
      name: 'product_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get product_description {
    return Intl.message(
      'Description',
      name: 'product_description',
      desc: '',
      args: [],
    );
  }

  /// `What people think of {param}？`
  String review_shop_star_title(Object param) {
    return Intl.message(
      'What people think of $param？',
      name: 'review_shop_star_title',
      desc: '',
      args: [param],
    );
  }

  /// `View full review`
  String get review_view_full_review {
    return Intl.message(
      'View full review',
      name: 'review_view_full_review',
      desc: '',
      args: [],
    );
  }

  /// `Message shop`
  String get product_messageshop {
    return Intl.message(
      'Message shop',
      name: 'product_messageshop',
      desc: '',
      args: [],
    );
  }

  /// `How did you like shopping at {param}？`
  String review_commont_title(Object param) {
    return Intl.message(
      'How did you like shopping at $param？',
      name: 'review_commont_title',
      desc: '',
      args: [param],
    );
  }

  /// `Awful`
  String get review_emoji_awful {
    return Intl.message(
      'Awful',
      name: 'review_emoji_awful',
      desc: '',
      args: [],
    );
  }

  /// `Bad`
  String get review_emoji_bad {
    return Intl.message(
      'Bad',
      name: 'review_emoji_bad',
      desc: '',
      args: [],
    );
  }

  /// `So-so`
  String get review_emoji_so_so {
    return Intl.message(
      'So-so',
      name: 'review_emoji_so_so',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get review_emoji_good {
    return Intl.message(
      'Good',
      name: 'review_emoji_good',
      desc: '',
      args: [],
    );
  }

  /// `OMG`
  String get review_emoji_omg {
    return Intl.message(
      'OMG',
      name: 'review_emoji_omg',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get review_service {
    return Intl.message(
      'Service',
      name: 'review_service',
      desc: '',
      args: [],
    );
  }

  /// `quality`
  String get review_quality {
    return Intl.message(
      'quality',
      name: 'review_quality',
      desc: '',
      args: [],
    );
  }

  /// `Your experience`
  String get review_your_experience {
    return Intl.message(
      'Your experience',
      name: 'review_your_experience',
      desc: '',
      args: [],
    );
  }

  /// `Your experience in a few words`
  String get review_experience_words {
    return Intl.message(
      'Your experience in a few words',
      name: 'review_experience_words',
      desc: '',
      args: [],
    );
  }

  /// `Hi! Share your feelings with us:)`
  String get review_emoji_required {
    return Intl.message(
      'Hi! Share your feelings with us:)',
      name: 'review_emoji_required',
      desc: '',
      args: [],
    );
  }

  /// `Review should be within 0 to 2000 characters`
  String get review_reviewrule {
    return Intl.message(
      'Review should be within 0 to 2000 characters',
      name: 'review_reviewrule',
      desc: '',
      args: [],
    );
  }

  /// `Average rating`
  String get review_average_rating {
    return Intl.message(
      'Average rating',
      name: 'review_average_rating',
      desc: '',
      args: [],
    );
  }

  /// `most people have a {param} opinion`
  String review_all_shop_most(Object param) {
    return Intl.message(
      'most people have a $param opinion',
      name: 'review_all_shop_most',
      desc: '',
      args: [param],
    );
  }

  /// `No review`
  String get review_no_review {
    return Intl.message(
      'No review',
      name: 'review_no_review',
      desc: '',
      args: [],
    );
  }

  /// `Most recent reviews`
  String get review_recent_reviews {
    return Intl.message(
      'Most recent reviews',
      name: 'review_recent_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Write a reply`
  String get review_write_reply {
    return Intl.message(
      'Write a reply',
      name: 'review_write_reply',
      desc: '',
      args: [],
    );
  }

  /// `Replies`
  String get review_reply {
    return Intl.message(
      'Replies',
      name: 'review_reply',
      desc: '',
      args: [],
    );
  }

  /// `Add friend`
  String get myfriend_searchfriend {
    return Intl.message(
      'Add friend',
      name: 'myfriend_searchfriend',
      desc: '',
      args: [],
    );
  }

  /// `New group`
  String get myfriend_creatgroup {
    return Intl.message(
      'New group',
      name: 'myfriend_creatgroup',
      desc: '',
      args: [],
    );
  }

  /// `My groups`
  String get myfriend_mygroup {
    return Intl.message(
      'My groups',
      name: 'myfriend_mygroup',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to beU`
  String get myfriend_nofriend_title {
    return Intl.message(
      'Welcome to beU',
      name: 'myfriend_nofriend_title',
      desc: '',
      args: [],
    );
  }

  /// `Add some friends now!`
  String get myfriend_nofriend_content {
    return Intl.message(
      'Add some friends now!',
      name: 'myfriend_nofriend_content',
      desc: '',
      args: [],
    );
  }

  /// `Add friend`
  String get myfriend_nofriend_button {
    return Intl.message(
      'Add friend',
      name: 'myfriend_nofriend_button',
      desc: '',
      args: [],
    );
  }

  /// `New friend`
  String get myfriend_newfriend {
    return Intl.message(
      'New friend',
      name: 'myfriend_newfriend',
      desc: '',
      args: [],
    );
  }

  /// `My friend:`
  String get myfriend_myfriend {
    return Intl.message(
      'My friend:',
      name: 'myfriend_myfriend',
      desc: '',
      args: [],
    );
  }

  /// `Search product`
  String get searchproduct_title {
    return Intl.message(
      'Search product',
      name: 'searchproduct_title',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get addfriend_invite {
    return Intl.message(
      'Invite',
      name: 'addfriend_invite',
      desc: '',
      args: [],
    );
  }

  /// `New friend`
  String get addfriend_newfriend {
    return Intl.message(
      'New friend',
      name: 'addfriend_newfriend',
      desc: '',
      args: [],
    );
  }

  /// `May Know`
  String get addfriend_mayknow {
    return Intl.message(
      'May Know',
      name: 'addfriend_mayknow',
      desc: '',
      args: [],
    );
  }

  /// `User doesn\'t exist.`
  String get searchresult_nouser {
    return Intl.message(
      'User doesn\\\'t exist.',
      name: 'searchresult_nouser',
      desc: '',
      args: [],
    );
  }

  /// `From same school`
  String get searchresult_sameschool {
    return Intl.message(
      'From same school',
      name: 'searchresult_sameschool',
      desc: '',
      args: [],
    );
  }

  /// `From same country`
  String get searchresult_samecountry {
    return Intl.message(
      'From same country',
      name: 'searchresult_samecountry',
      desc: '',
      args: [],
    );
  }

  /// `You have mutual friends`
  String get searchresult_samefriend {
    return Intl.message(
      'You have mutual friends',
      name: 'searchresult_samefriend',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get searchresult_contacts {
    return Intl.message(
      'Contacts',
      name: 'searchresult_contacts',
      desc: '',
      args: [],
    );
  }

  /// `### maximum`
  String get imagepicker_maximum {
    return Intl.message(
      '### maximum',
      name: 'imagepicker_maximum',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get imagepicker_all {
    return Intl.message(
      'All',
      name: 'imagepicker_all',
      desc: '',
      args: [],
    );
  }

  /// `All videos`
  String get imagepicker_allvideo {
    return Intl.message(
      'All videos',
      name: 'imagepicker_allvideo',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get imagepicker_photos {
    return Intl.message(
      'Photos',
      name: 'imagepicker_photos',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get imagepicker_preview {
    return Intl.message(
      'Preview',
      name: 'imagepicker_preview',
      desc: '',
      args: [],
    );
  }

  /// `Take a picture`
  String get imagepicker_takephoto {
    return Intl.message(
      'Take a picture',
      name: 'imagepicker_takephoto',
      desc: '',
      args: [],
    );
  }

  /// `{param} invited you to the group`
  String c_invited_xxx_to_the_group(Object param) {
    return Intl.message(
      '$param invited you to the group',
      name: 'c_invited_xxx_to_the_group',
      desc: '',
      args: [param],
    );
  }

  /// `Group members`
  String get c_group_members {
    return Intl.message(
      'Group members',
      name: 'c_group_members',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get c_group_subject {
    return Intl.message(
      'Group Name',
      name: 'c_group_subject',
      desc: '',
      args: [],
    );
  }

  /// `Delete and leave`
  String get c_delete_and_leave {
    return Intl.message(
      'Delete and leave',
      name: 'c_delete_and_leave',
      desc: '',
      args: [],
    );
  }

  /// `Delete the group`
  String get c_group_deleted {
    return Intl.message(
      'Delete the group',
      name: 'c_group_deleted',
      desc: '',
      args: [],
    );
  }

  /// `You have been removed from the group.`
  String get c_removed_you_from_the_group {
    return Intl.message(
      'You have been removed from the group.',
      name: 'c_removed_you_from_the_group',
      desc: '',
      args: [],
    );
  }

  /// `Group deleted`
  String get c_group_deleted_1 {
    return Intl.message(
      'Group deleted',
      name: 'c_group_deleted_1',
      desc: '',
      args: [],
    );
  }

  /// `Group created.`
  String get c_group_created {
    return Intl.message(
      'Group created.',
      name: 'c_group_created',
      desc: '',
      args: [],
    );
  }

  /// `Group no longer exists`
  String get c_group_no_longer_exists {
    return Intl.message(
      'Group no longer exists',
      name: 'c_group_no_longer_exists',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to remove {param} from group?`
  String c_do_you_want_to_remove_from_gro(Object param) {
    return Intl.message(
      'Do you want to remove $param from group?',
      name: 'c_do_you_want_to_remove_from_gro',
      desc: '',
      args: [param],
    );
  }

  /// `No group yet.`
  String get c_no_group_yet {
    return Intl.message(
      'No group yet.',
      name: 'c_no_group_yet',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 100 members!`
  String get c_maximum_members {
    return Intl.message(
      'Maximum 100 members!',
      name: 'c_maximum_members',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! Add some friends first before creating a group chat.`
  String get c_add_some_friends_first_before_creating {
    return Intl.message(
      'Sorry! Add some friends first before creating a group chat.',
      name: 'c_add_some_friends_first_before_creating',
      desc: '',
      args: [],
    );
  }

  /// `You\'ve created a new group chat. ### `
  String get c_created_a_new_group_chat {
    return Intl.message(
      'You\\\'ve created a new group chat. ### ',
      name: 'c_created_a_new_group_chat',
      desc: '',
      args: [],
    );
  }

  /// `Go name it :D`
  String get c_go_name_it {
    return Intl.message(
      'Go name it :D',
      name: 'c_go_name_it',
      desc: '',
      args: [],
    );
  }

  /// `Group Picture`
  String get c_group_picture {
    return Intl.message(
      'Group Picture',
      name: 'c_group_picture',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get c_not_set {
    return Intl.message(
      'Not set',
      name: 'c_not_set',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get c_not_set_1 {
    return Intl.message(
      'Not set',
      name: 'c_not_set_1',
      desc: '',
      args: [],
    );
  }

  /// `Edit your alias in group`
  String get c_edit_your_alias_in_group {
    return Intl.message(
      'Edit your alias in group',
      name: 'c_edit_your_alias_in_group',
      desc: '',
      args: [],
    );
  }

  /// `Delete and leave this group?`
  String get c_delete_and_leave_1 {
    return Intl.message(
      'Delete and leave this group?',
      name: 'c_delete_and_leave_1',
      desc: '',
      args: [],
    );
  }

  /// `Group name needs to be 2 to 25 characters`
  String get c_group_name_needs_to_be {
    return Intl.message(
      'Group name needs to be 2 to 25 characters',
      name: 'c_group_name_needs_to_be',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get c_members_1 {
    return Intl.message(
      'Members',
      name: 'c_members_1',
      desc: '',
      args: [],
    );
  }

  /// `No more friends to add`
  String get c_no_more_friends_to_add {
    return Intl.message(
      'No more friends to add',
      name: 'c_no_more_friends_to_add',
      desc: '',
      args: [],
    );
  }

  /// `Turn on notifications. Stay connected.`
  String get chatlist_notific {
    return Intl.message(
      'Turn on notifications. Stay connected.',
      name: 'chatlist_notific',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chatlist_chat {
    return Intl.message(
      'Chat',
      name: 'chatlist_chat',
      desc: '',
      args: [],
    );
  }

  /// `Friend request received`
  String get chatlist_friend_request {
    return Intl.message(
      'Friend request received',
      name: 'chatlist_friend_request',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to beU.\nAdd friends and start chatting.`
  String get chatlist_nodata {
    return Intl.message(
      'Welcome to beU.\\nAdd friends and start chatting.',
      name: 'chatlist_nodata',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get chatlist_justnow {
    return Intl.message(
      'Just now',
      name: 'chatlist_justnow',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get chatlist_yesterday {
    return Intl.message(
      'Yesterday',
      name: 'chatlist_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get chatlist_today {
    return Intl.message(
      'Today',
      name: 'chatlist_today',
      desc: '',
      args: [],
    );
  }

  /// `2 days ago`
  String get chatlist_daysago {
    return Intl.message(
      '2 days ago',
      name: 'chatlist_daysago',
      desc: '',
      args: [],
    );
  }

  /// `Connecting`
  String get chatlist_connect {
    return Intl.message(
      'Connecting',
      name: 'chatlist_connect',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get chatlist_title {
    return Intl.message(
      'Message',
      name: 'chatlist_title',
      desc: '',
      args: [],
    );
  }

  /// `Hold to talk`
  String get chatdetail_holdonsay {
    return Intl.message(
      'Hold to talk',
      name: 'chatdetail_holdonsay',
      desc: '',
      args: [],
    );
  }

  /// `Message seller`
  String get offlineshop_call {
    return Intl.message(
      'Message seller',
      name: 'offlineshop_call',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Shops`
  String get discover_delivery_shops {
    return Intl.message(
      'Delivery Shops',
      name: 'discover_delivery_shops',
      desc: '',
      args: [],
    );
  }

  /// `Live Shops`
  String get discover_live_shops {
    return Intl.message(
      'Live Shops',
      name: 'discover_live_shops',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get discover_product {
    return Intl.message(
      'Product',
      name: 'discover_product',
      desc: '',
      args: [],
    );
  }

  /// `Shops`
  String get discover_shops {
    return Intl.message(
      'Shops',
      name: 'discover_shops',
      desc: '',
      args: [],
    );
  }

  /// `Order delivery`
  String get discover_order_delivery {
    return Intl.message(
      'Order delivery',
      name: 'discover_order_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Market place`
  String get discover_marketplace {
    return Intl.message(
      'Market place',
      name: 'discover_marketplace',
      desc: '',
      args: [],
    );
  }

  /// `Most popular`
  String get discover_popular {
    return Intl.message(
      'Most popular',
      name: 'discover_popular',
      desc: '',
      args: [],
    );
  }

  /// `Top rated`
  String get discover_rated {
    return Intl.message(
      'Top rated',
      name: 'discover_rated',
      desc: '',
      args: [],
    );
  }

  /// `Newly added`
  String get discover_added {
    return Intl.message(
      'Newly added',
      name: 'discover_added',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get discover_price {
    return Intl.message(
      'Price',
      name: 'discover_price',
      desc: '',
      args: [],
    );
  }

  /// `Sorting options`
  String get discover_filter_title {
    return Intl.message(
      'Sorting options',
      name: 'discover_filter_title',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get discover_filter_by {
    return Intl.message(
      'Sort by',
      name: 'discover_filter_by',
      desc: '',
      args: [],
    );
  }

  /// `Low to High`
  String get discover_filter_ascending {
    return Intl.message(
      'Low to High',
      name: 'discover_filter_ascending',
      desc: '',
      args: [],
    );
  }

  /// `High to Low`
  String get discover_filter_descending {
    return Intl.message(
      'High to Low',
      name: 'discover_filter_descending',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get discover_filter_apply {
    return Intl.message(
      'Apply',
      name: 'discover_filter_apply',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get confirm_order {
    return Intl.message(
      'Confirm order',
      name: 'confirm_order',
      desc: '',
      args: [],
    );
  }

  /// `In your order`
  String get confirm_your_order {
    return Intl.message(
      'In your order',
      name: 'confirm_your_order',
      desc: '',
      args: [],
    );
  }

  /// `Your information`
  String get confirm_information {
    return Intl.message(
      'Your information',
      name: 'confirm_information',
      desc: '',
      args: [],
    );
  }

  /// `Check your information before placing an order`
  String get confirm_check_information {
    return Intl.message(
      'Check your information before placing an order',
      name: 'confirm_check_information',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get confirm_name {
    return Intl.message(
      'Name',
      name: 'confirm_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get confirm_phone_number {
    return Intl.message(
      'Phone Number',
      name: 'confirm_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get confirm_address {
    return Intl.message(
      'Address',
      name: 'confirm_address',
      desc: '',
      args: [],
    );
  }

  /// `Billing Info`
  String get confirm_billing_info {
    return Intl.message(
      'Billing Info',
      name: 'confirm_billing_info',
      desc: '',
      args: [],
    );
  }

  /// `Fill your delivery info`
  String get confirm_fill_your_info {
    return Intl.message(
      'Fill your delivery info',
      name: 'confirm_fill_your_info',
      desc: '',
      args: [],
    );
  }

  /// `Name should be within 2 to 32 characters`
  String get confirm_name_rule {
    return Intl.message(
      'Name should be within 2 to 32 characters',
      name: 'confirm_name_rule',
      desc: '',
      args: [],
    );
  }

  /// `Phone should be within 7 to 14 characters`
  String get confirm_phone_rule {
    return Intl.message(
      'Phone should be within 7 to 14 characters',
      name: 'confirm_phone_rule',
      desc: '',
      args: [],
    );
  }

  /// `Address should be within 10 to 100 characters`
  String get confirm_address_rule {
    return Intl.message(
      'Address should be within 10 to 100 characters',
      name: 'confirm_address_rule',
      desc: '',
      args: [],
    );
  }

  /// `Address cannot be empty`
  String get confirm_address_no {
    return Intl.message(
      'Address cannot be empty',
      name: 'confirm_address_no',
      desc: '',
      args: [],
    );
  }

  /// `Your Order`
  String get orderdone_order {
    return Intl.message(
      'Your Order',
      name: 'orderdone_order',
      desc: '',
      args: [],
    );
  }

  /// `has been submited {param}`
  String orderdone_submited(Object param) {
    return Intl.message(
      'has been submited $param',
      name: 'orderdone_submited',
      desc: '',
      args: [param],
    );
  }

  /// `Let our team call you within {param} for confirmation`
  String orderdone_confirmation(Object param) {
    return Intl.message(
      'Let our team call you within $param for confirmation',
      name: 'orderdone_confirmation',
      desc: '',
      args: [param],
    );
  }

  /// `a few minutes`
  String get orderdone_few_minutes {
    return Intl.message(
      'a few minutes',
      name: 'orderdone_few_minutes',
      desc: '',
      args: [],
    );
  }

  /// `successfully`
  String get orderdone_successfully {
    return Intl.message(
      'successfully',
      name: 'orderdone_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Your Receipt`
  String get orderdone_your_receipt {
    return Intl.message(
      'Your Receipt',
      name: 'orderdone_your_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for shopping with us`
  String get orderdone_thanks {
    return Intl.message(
      'Thank you for shopping with us',
      name: 'orderdone_thanks',
      desc: '',
      args: [],
    );
  }

  /// `What you\'ve ordered?`
  String get orderdone_ordered {
    return Intl.message(
      'What you\\\'ve ordered?',
      name: 'orderdone_ordered',
      desc: '',
      args: [],
    );
  }

  /// `All you need to get started with BeU delivery service and shop discovery is a single account.`
  String get nologin_popo {
    return Intl.message(
      'All you need to get started with BeU delivery service and shop discovery is a single account.',
      name: 'nologin_popo',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get nologin_login {
    return Intl.message(
      'Log in',
      name: 'nologin_login',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get nologin_creat_accont {
    return Intl.message(
      'Create New Account',
      name: 'nologin_creat_accont',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get nologin_title {
    return Intl.message(
      'Welcome',
      name: 'nologin_title',
      desc: '',
      args: [],
    );
  }

  /// `Come and play with me on beU. \nTry the fastest delivery!`
  String get sendsms_playwithme {
    return Intl.message(
      'Come and play with me on beU. \\nTry the fastest delivery!',
      name: 'sendsms_playwithme',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopcart_shopping {
    return Intl.message(
      'Shopping Cart',
      name: 'shopcart_shopping',
      desc: '',
      args: [],
    );
  }

  /// `My Bag`
  String get shopcart_my_bag {
    return Intl.message(
      'My Bag',
      name: 'shopcart_my_bag',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get shopcart_my_orders {
    return Intl.message(
      'My Orders',
      name: 'shopcart_my_orders',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get shopcart_progress {
    return Intl.message(
      'In progress',
      name: 'shopcart_progress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get shopcart_completed {
    return Intl.message(
      'Completed',
      name: 'shopcart_completed',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get shopcart_canceled {
    return Intl.message(
      'Canceled',
      name: 'shopcart_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get shopcart_buy {
    return Intl.message(
      'Buy',
      name: 'shopcart_buy',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 50`
  String get shopcart_product_rule {
    return Intl.message(
      'Maximum 50',
      name: 'shopcart_product_rule',
      desc: '',
      args: [],
    );
  }

  /// `Please select the product`
  String get shopcart_choose_product {
    return Intl.message(
      'Please select the product',
      name: 'shopcart_choose_product',
      desc: '',
      args: [],
    );
  }

  /// `Order N.{param}`
  String order_how_many(Object param) {
    return Intl.message(
      'Order N.$param',
      name: 'order_how_many',
      desc: '',
      args: [param],
    );
  }

  /// `Order Info`
  String get order_info {
    return Intl.message(
      'Order Info',
      name: 'order_info',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get order_subtotal {
    return Intl.message(
      'Subtotal',
      name: 'order_subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Cost`
  String get order_delivery_coast {
    return Intl.message(
      'Delivery Cost',
      name: 'order_delivery_coast',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get order_total {
    return Intl.message(
      'Total',
      name: 'order_total',
      desc: '',
      args: [],
    );
  }

  /// `Your Info`
  String get order_beneficiary {
    return Intl.message(
      'Your Info',
      name: 'order_beneficiary',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get order_number {
    return Intl.message(
      'Order Number',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get order_payment_method {
    return Intl.message(
      'Payment Method',
      name: 'order_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get order_delivery_address {
    return Intl.message(
      'Delivery Address',
      name: 'order_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get order_checkout {
    return Intl.message(
      'Checkout',
      name: 'order_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get order_delivery_fee {
    return Intl.message(
      'Delivery Fee',
      name: 'order_delivery_fee',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get order_summary {
    return Intl.message(
      'Order Summary',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery`
  String get order_cash {
    return Intl.message(
      'Cash on Delivery',
      name: 'order_cash',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get category_manage {
    return Intl.message(
      'Categories',
      name: 'category_manage',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get category_name {
    return Intl.message(
      'Add Category',
      name: 'category_name',
      desc: '',
      args: [],
    );
  }

  /// `In this category`
  String get category_in_this {
    return Intl.message(
      'In this category',
      name: 'category_in_this',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get category_add {
    return Intl.message(
      'Add product',
      name: 'category_add',
      desc: '',
      args: [],
    );
  }

  /// `中文`
  String get language_cn {
    return Intl.message(
      '中文',
      name: 'language_cn',
      desc: '',
      args: [],
    );
  }

  /// `ENGLISH`
  String get language_en {
    return Intl.message(
      'ENGLISH',
      name: 'language_en',
      desc: '',
      args: [],
    );
  }

  /// `auto`
  String get language_auto {
    return Intl.message(
      'auto',
      name: 'language_auto',
      desc: '',
      args: [],
    );
  }

  /// `繁體`
  String get language_traditional {
    return Intl.message(
      '繁體',
      name: 'language_traditional',
      desc: '',
      args: [],
    );
  }

  /// `日本語`
  String get language_Japanese {
    return Intl.message(
      '日本語',
      name: 'language_Japanese',
      desc: '',
      args: [],
    );
  }

  /// `한국어`
  String get language_Korean {
    return Intl.message(
      '한국어',
      name: 'language_Korean',
      desc: '',
      args: [],
    );
  }

  /// `Bahasa Indonesia`
  String get language_Indonesia {
    return Intl.message(
      'Bahasa Indonesia',
      name: 'language_Indonesia',
      desc: '',
      args: [],
    );
  }

  /// `Русский`
  String get language_Russian {
    return Intl.message(
      'Русский',
      name: 'language_Russian',
      desc: '',
      args: [],
    );
  }

  /// `Việt nam`
  String get language_Vietnam {
    return Intl.message(
      'Việt nam',
      name: 'language_Vietnam',
      desc: '',
      args: [],
    );
  }

  /// `español`
  String get language_Spain {
    return Intl.message(
      'español',
      name: 'language_Spain',
      desc: '',
      args: [],
    );
  }

  /// `Deutsch`
  String get language_Germany {
    return Intl.message(
      'Deutsch',
      name: 'language_Germany',
      desc: '',
      args: [],
    );
  }

  /// `En français`
  String get language_French {
    return Intl.message(
      'En français',
      name: 'language_French',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get language_Arab {
    return Intl.message(
      'العربية',
      name: 'language_Arab',
      desc: '',
      args: [],
    );
  }

  /// `हिन्दी`
  String get language_yindu {
    return Intl.message(
      'हिन्दी',
      name: 'language_yindu',
      desc: '',
      args: [],
    );
  }

  /// `ไทย`
  String get language_taiyu {
    return Intl.message(
      'ไทย',
      name: 'language_taiyu',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get button_delect {
    return Intl.message(
      'Delete',
      name: 'button_delect',
      desc: '',
      args: [],
    );
  }

  /// `Oh no! File does not exist`
  String get alltip_nofile {
    return Intl.message(
      'Oh no! File does not exist',
      name: 'alltip_nofile',
      desc: '',
      args: [],
    );
  }

  /// `Category should be between 1 to 20 characters`
  String get alltip_category_namerule {
    return Intl.message(
      'Category should be between 1 to 20 characters',
      name: 'alltip_category_namerule',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting_title {
    return Intl.message(
      'Setting',
      name: 'setting_title',
      desc: '',
      args: [],
    );
  }

  /// `Please give your kind feedback`
  String get sethelp_nofeedback {
    return Intl.message(
      'Please give your kind feedback',
      name: 'sethelp_nofeedback',
      desc: '',
      args: [],
    );
  }

  /// `Followed`
  String get shopcenter_followed {
    return Intl.message(
      'Followed',
      name: 'shopcenter_followed',
      desc: '',
      args: [],
    );
  }

  /// `Uncategorized`
  String get shopcenter_uncategorized {
    return Intl.message(
      'Uncategorized',
      name: 'shopcenter_uncategorized',
      desc: '',
      args: [],
    );
  }

  /// `Order using`
  String get discover_order_using {
    return Intl.message(
      'Order using',
      name: 'discover_order_using',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get button_apply {
    return Intl.message(
      'Apply',
      name: 'button_apply',
      desc: '',
      args: [],
    );
  }

  /// `Please open the location permission to get an order at the correct price for you`
  String get alltip_position_noopen {
    return Intl.message(
      'Please open the location permission to get an order at the correct price for you',
      name: 'alltip_position_noopen',
      desc: '',
      args: [],
    );
  }

  /// `Please open the location permission, let us accurately locate your location, otherwise the price of your order will be higher than the correct price`
  String get alltip_position_closeopen {
    return Intl.message(
      'Please open the location permission, let us accurately locate your location, otherwise the price of your order will be higher than the correct price',
      name: 'alltip_position_closeopen',
      desc: '',
      args: [],
    );
  }

  /// `Please turn on GPS to get accurate positioning and let us serve you better`
  String get alltip_gps_noopen {
    return Intl.message(
      'Please turn on GPS to get accurate positioning and let us serve you better',
      name: 'alltip_gps_noopen',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Promo Code`
  String get alltip_promonotues {
    return Intl.message(
      'Invalid Promo Code',
      name: 'alltip_promonotues',
      desc: '',
      args: [],
    );
  }

  /// `Package fee`
  String get changeproduct_packagefee {
    return Intl.message(
      'Package fee',
      name: 'changeproduct_packagefee',
      desc: '',
      args: [],
    );
  }

  /// `Promo Code`
  String get changeproduct_promocode {
    return Intl.message(
      'Promo Code',
      name: 'changeproduct_promocode',
      desc: '',
      args: [],
    );
  }

  String get number_of_orders_in_amharic {
    return Intl.message(
      ' በወር ትዕዛዞች',
      name: 'number_of_orders_in_amharic',
      desc: '',
      args: [],
    );
  }

  String get average_price_in_amharic {
    return Intl.message(
      ' ብር አማካይ ዋጋ',
      name: 'average_price_in_amharic',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'in'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
