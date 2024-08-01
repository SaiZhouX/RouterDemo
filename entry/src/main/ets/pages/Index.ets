// Index.ets
// 导入页面路由模块
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct Index {
  @State message: string = 'skip'
  @State count: number = 5000
  @State myTimerModifier: MyTextTimerModifier = new MyTextTimerModifier()
  countDownTextTimerController: TextTimerController = new TextTimerController()

  build() {
    Stack() {
      Column() {
        Button(this.message)
          .margin({ top: 30, left: '70%' })
          .onClick(() => {
            routerFunc();
          });
        TextTimer({ isCountDown: true, controller: this.countDownTextTimerController })
          .contentModifier(this.myTimerModifier)
          .onTimer((utc: number, elapsedTime: number) => {
            console.info('textTimer onTimer utc is：' + utc + ', elapsedTime: ' + elapsedTime)
          })
        Image($r('app.media.gf2')).objectFit(ImageFit.Fill)
      }
    }
  }

  onDidBuild(): void {
    this.countDownTextTimerController.start();
  }
}

class MyTextTimerModifier implements ContentModifier<TextTimerConfiguration> {
  constructor() {
  }

  applyContent(): WrappedBuilder<[TextTimerConfiguration]> {
    return wrapBuilder(buildTextTimer)
  }
}

function routerFunc() {
  router.pushUrl({ url: 'pages/Second' })
    .catch((err: Error) => {
      console.log("router.pushUrl error:" + err);
    });
}

@Builder
function buildTextTimer(config: TextTimerConfiguration) {
  Text(((5000 - config.elapsedTime) / 1000).toFixed(0))
}

