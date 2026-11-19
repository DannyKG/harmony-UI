import { KdStepItemConfig, KdSteps, KdStepState, KdStepsType } from "@kd-ui/kd_component"

@Builder
export function KdStepLineExamplePageBuilder() {
  KdStepLineExamplePage()
}

@Component
struct KdStepLineExamplePage {
  @State private stepsNum: number = 5
  @State private currentIndex: number = 0
  @State private stepsType: KdStepsType = KdStepsType.Horizontal
  @State private steps: KdStepItemConfig[] = [
    {
      state: KdStepState.Indexed,
      title: '第一步',
      desc: '辅助信息1'
    },
    {
      state: KdStepState.Indexed,
      title: '第二步',
      desc: '辅助信息2'
    },
    {
      state: KdStepState.Indexed,
      title: '第三步',
      desc: '辅助信息3'
    },
    {
      state: KdStepState.Indexed,
      title: '第四步',
      desc: '辅助信息4'
    },
    {
      state: KdStepState.Indexed,
      title: '第五步',
      desc: '辅助信息5'
    }
  ]

  build() {
    NavDestination() {

      Column() {
        KdSteps({
          config: {
            stepsType: this.stepsType,
            stepsCount: this.stepsNum,
            steps: this.steps,
            currentIndex: this.currentIndex
          }
        })

        Divider().strokeWidth(25).color(Color.Transparent)

        Text(`当前步骤数量 ${this.stepsNum}`)
        Slider({
          value: $$this.stepsNum,
          step: 1,
          min: 1,
          max: 5,
        })
          .showSteps(true)// 是否显示步长刻度
          .blockSize({ width: 15, height: 15 })// 滑块大小
          .blockColor($r('sys.color.background_primary'))// 滑块颜色
          .trackBorderRadius(2)// 底板圆角半径
          .selectedBorderRadius(2)// 已滑动部分圆角半径
          .onChange((value: number) => {
            this.stepsNum = value
          })

        Divider().strokeWidth(10).color(Color.Transparent)

        Row() {
          Button('上一步').onClick(() => {
            this.steps[this.currentIndex].state = KdStepState.Indexed
            if (this.currentIndex >= 1) {
              this.currentIndex -= 1
              this.steps[this.currentIndex].state = KdStepState.Doing
            }

          }).width(100)
          Button('下一步').onClick(() => {
            this.steps[this.currentIndex].state = KdStepState.Completed
            if (this.currentIndex + 1 < this.steps.length) {
              this.currentIndex += 1
              if (this.currentIndex == this.steps.length - 1) {
                this.steps[this.currentIndex].state = KdStepState.Completed
              } else {
                this.steps[this.currentIndex].state = KdStepState.Doing
              }
            }

          }).width(100)
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%')

        Divider().strokeWidth(10).color(Color.Transparent)

        Row() {
          Button('横向').onClick(() => {
            this.stepsType = KdStepsType.Horizontal
          }).width(100)
          Button('纵向').onClick(() => {
            this.stepsType = KdStepsType.Vertical
          }).width(100)
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%')

      }.height('100%')
      .width('100%')

    }.title('Steps示例')
  }
}