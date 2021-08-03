
///抖动监听
typedef ShakeListener = void Function(bool isOpen, int count);

///抖动动画控制器
class ShakeController {
  ///当前抖动动画的状态
  bool animationRunning = false;

  ///监听
  ShakeListener? _shakeListener;

  ///控制器中添加监听
  setShakeListener(ShakeListener listener) {
    _shakeListener = listener;
  }

  ///打开
  void start({int shakeCount = 1}) {
    if (_shakeListener != null) {
      animationRunning = true;
      _shakeListener!(true, shakeCount);
    }
  }

  ///关闭
  void stop() {
    if (_shakeListener != null) {
      animationRunning = false;
      _shakeListener!(false, 0);
    }
  }

  ///移除监听
  void removeListener() {
    _shakeListener = null;
  }
}
