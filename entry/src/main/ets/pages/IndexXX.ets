import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'skip'
  // 滑块验证显示/隐藏状态
  @State sliderVisibility: Visibility = Visibility.None;
  @State canClick:boolean =  false;

  // 页面即将消失时的回调函数
  aboutToDisappear() {
    // 清除验证码倒计时定时器
    clearInterval(globalThis.captchaTimerId);
  }

  // 构建组件树
  build() {
    Stack() {
      Column() {
        Button(this.message)
          .margin({ top: 30, left: '70%' })
          .enabled(this.canClick)
          .onClick(() => {
            routerFunc();
          });
        Image($r('app.media.gf2')).objectFit(ImageFit.Fill)
      }
    }
  }

  onDidBuild(): void {
    this.startCountDown();
  }

  private startCountDown() {
    // 设置初始倒计时时间为6秒
    globalThis.remainingSeconds = 6;
    // 更新验证码按钮文本为剩余秒数
    this.message = globalThis.remainingSeconds + 's';

    // 清除已存在的定时器
    clearInterval(globalThis.captchaTimerId);

    // 创建新的倒计时定时器
    globalThis.captchaTimerId = setInterval(() => {
      console.log('==== 定时器执行：', this.message);
      // 减少一秒
      globalThis.remainingSeconds--;
      // 更新验证码按钮文本
      this.message = globalThis.remainingSeconds + 's';

      // 倒计时结束，恢复初始状态
      if (globalThis.remainingSeconds <= 0) {
        this.message = 'skip';
        this.canClick = true;
        // 清除定时器
        clearInterval(globalThis.captchaTimerId);
      }
    }, 1000);
  }
}

function routerFunc() {
  router.pushUrl({ url: 'pages/Second' })
    .catch((err: Error) => {
      console.log("router.pushUrl error:" + err);
    });
}