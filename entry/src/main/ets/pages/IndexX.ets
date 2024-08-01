@Entry
@Component
struct Index {
  // 验证码按钮显示信息状态
  @State captchaButtonText: string = '获取验证码';

  // 滑块验证显示/隐藏状态
  @State sliderVisibility: Visibility = Visibility.None;

  // 页面即将消失时的回调函数
  aboutToDisappear() {
    // 清除验证码倒计时定时器
    clearInterval(globalThis.captchaTimerId);
  }

  // 构建组件树
  build() {
    // 主要布局
    Column() {
      // 验证码按钮
      Text(this.captchaButtonText)
        .fontSize('32lpx')
        .fontColor('#FF1919')
        .width('50%')
        .onClick(() => {
          // 判断是否开始倒计时
          if (this.captchaButtonText === '获取验证码') {
            // 设置初始倒计时时间为60秒
            globalThis.remainingSeconds = 60;
            // 更新验证码按钮文本为剩余秒数
            this.captchaButtonText = globalThis.remainingSeconds + 's';

            // 清除已存在的定时器
            clearInterval(globalThis.captchaTimerId);

            // 创建新的倒计时定时器
            globalThis.captchaTimerId = setInterval(() => {
              console.log('==== 定时器执行：', this.captchaButtonText);
              // 减少一秒
              globalThis.remainingSeconds--;
              // 更新验证码按钮文本
              this.captchaButtonText = globalThis.remainingSeconds + 's';

              // 倒计时结束，恢复初始状态
              if (globalThis.remainingSeconds <= 0) {
                this.captchaButtonText = '获取验证码';
                // 清除定时器
                clearInterval(globalThis.captchaTimerId);
              }
            }, 1000);
          }
        });
    }
    .width('100%');
  }
}