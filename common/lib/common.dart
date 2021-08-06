library common;

/// 依赖本地 Library
export 'package:origin/origin.dart';
export 'package:entity/entity.dart';
export 'package:resources/resources.dart';
export 'package:request/request.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:transition/transition.dart';

/// 依赖第三方包
export 'package:oktoast/oktoast.dart';
export 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:url_launcher/link.dart';
export 'package:launch_review/launch_review.dart';
export 'package:path_provider/path_provider.dart';

/// 当前 module 内容
/// architecture
export 'src/architecture/architecture.dart';

export 'src/architecture/empty_status.dart';

export 'src/architecture/refresh_provider.dart';
export 'src/architecture/retry_provider.dart';

export 'src/architecture/refresh_actuator.dart';
export 'src/architecture/retry_actuator.dart';
export 'src/architecture/react_actuator.dart';

/// dialog
export 'src/dialog/message_dialog.dart';
export 'src/dialog/loading_dialog.dart';
export 'src/dialog/login_dialog.dart';

/// event
export 'src/event/bus_client.dart';
export 'src/event/bus_event.dart';

/// Manager
export 'src/manager/user_manager.dart';

/// Pages
export 'src/pages/base_web_page.dart';

/// route
export 'src/route/routes.dart';
export 'src/route/slide_switch_page_route.dart';

/// state
export 'src/state/refreshable_state.dart';
export 'src/state/retryable_state.dart';
export 'src/state/reactable_state.dart';

/// toast
export 'src/toast/toasty.dart';

/// widget
export 'src/widget/application_widget.dart';
export 'src/widget/empty/ball_beat_indicator.dart';
export 'src/widget/empty/ball_spin_fade_loader_indicator.dart';
export 'src/widget/empty/classics_empty_widget.dart';
export 'src/widget/empty/classics_loading_indicator.dart';
export 'src/widget/empty/classics_loading_widget.dart';
export 'src/widget/empty/empty_widget.dart';

/// toolbar
export 'src/widget/appbar/app_bar.dart';
export 'src/widget/appbar/app_bar_only_title.dart';

/// ios
export 'src/widget/appbar/app_navigation_bar.dart';
