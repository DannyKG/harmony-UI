import {
  BubbleBean,
  BubbleIndicator,
  BubblePosition,
  Controller,
  GuidePage,
  KdGuide,
  KdGuideBuilder
} from '@kd-ui/kd_component';

@Builder
export function KdGuideExamplePageBuilder() {
  KdGuideExampleIndex()
}

@Entry
@Component
export struct KdGuideExampleIndex {
  @Consume('pathStack') pathStack: NavPathStack;
  private builder: KdGuideBuilder | null = null;
  private controller: Controller | null = null;

  aboutToAppear() {
    this.builder = new KdGuideBuilder()
      .setLabel('KdGuideExampleIndex')
      .alwaysShow(true)
      .addGuidePage(GuidePage.newInstance()
        .addHighLight('Simple')
        .setBubbleIndicator(
          new BubbleIndicator(
            'Simple',
            new BubbleBean('标题栏', '这里是副标题栏，这是一个简单的演示'),
            BubblePosition.BOTTOM
          )
        )
      )
  }

  build() {
    NavDestination() {
      Column() {
        Stack() {
          KdGuide({
            content: this.content,
            builder: this.builder,
            onReady: (controller: Controller) => {
              this.controller = controller;
            }
          })
        }
      }
      .width('100%')
    }.title('KdGuide 示例')
  }

  @Builder
  private content() {
    Column() {
      Button($r('app.string.just_use_it_simply'))
        .onClick(() => {
          if (this.controller) {
            this.controller.show();
          }
        }).id('Simple')
        .margin(10)
        .width('50%')

      Button($r('app.string.multi_guide_page'))
        .onClick(() => {
          this.pathStack.pushPath({ name: 'KdGuideMultiPageExample' })
        })
        .margin(10)
        .width('50%')
    }.alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%');
  }
}