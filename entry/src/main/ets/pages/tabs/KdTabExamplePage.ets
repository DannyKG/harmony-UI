import { KdTabConfig, KdTabController, KdTabItemConfig, KdTabMode, KdTabs } from "@kd-ui/kd_component"
import { KdToast } from "@kd-ui/kd_component/src/main/ets/components/toast/KdToast"

@Builder
export function KdTabExamplePageBuilder() {
  KdTabExamplePage()
}

@Component
export struct KdTabExamplePage {
  private tabCtrl = new KdTabController()
  private tabConfig: KdTabConfig = {
    mode: KdTabMode.Scrollable,
    labelColor: '#0090ff'
  }
  private tabConfig1: KdTabConfig = {
    mode: KdTabMode.Fix,
    labelColor: '#ff552e',
    indicatorColor: '#ff552e'
  }
  @State
  tabs: KdTabItemConfig[] = [
    new KdTabItemConfig("tab0"),
    new KdTabItemConfig("tab1", "", $r('app.media.tag_heart_fill'), ""),
    new KdTabItemConfig("tab2", "", "", "", true),
    new KdTabItemConfig("tab3", "", "", $r('app.media.tag_heart')),
    new KdTabItemConfig("tab4"),
    new KdTabItemConfig("tab5"),
    new KdTabItemConfig("tab6"),
    new KdTabItemConfig("tab7"),
  ]


  build() {
    NavDestination() {
      Column() {
        KdTabs({
          tabs: this.tabs,
          tabConfig: this.tabConfig,
          onTabClick: (index: number) => {
            KdToast.showText({
              msg: `click tab ${index}`
            })
          }
        })

        KdTabs({
          tabs: this.tabs,
          tabConfig: this.tabConfig1,
          tabController: this.tabCtrl
        })
          .margin({
            top: 20
          })

        Button('Tab改变index')
          .margin({
            top: 30
          })
          .onClick(() => {
            this.tabCtrl.changeIndex(3)
          })

        Button('添加小红点')
          .margin({
            top: 20
          })
          .onClick(() => {
            this.tabs[0].badgeText = "New"
          })
        Button('取消小红点')
          .margin({
            top: 20
          })
          .onClick(() => {
            this.tabs[0].badgeText = ""
          })

      }
      .height('100%')
      .width('100%')
    }
    .title('Tabs示例')

  }

  onDidBuild(): void {

  }

}