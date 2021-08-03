import 'package:common/common.dart';
import 'package:common/src/state/reactable_state.dart';
import 'package:flutter/material.dart';

import '../architecture/architecture.dart';
import '../architecture/retry_actuator.dart';

/**
 * retryable state
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
abstract class RetryableState<A extends RetryActuator, T extends StatefulWidget>
    extends ReactableState<A, T> implements Viewer {
  RetryableState(A actuator) : super(actuator);

  EmptyWidget buildEmptyWidget(BuildContext context, {String? message}) {
    return EmptyWidget.classics(
      state: actuator.emptyStatus,
      alignment: Alignment.topCenter,
      emptyMessage: message ?? S.of(context).alltip_nodata,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.618),
      onTapEmpty: () {
        actuator.tapRetry();
      },
    );
  }
}
