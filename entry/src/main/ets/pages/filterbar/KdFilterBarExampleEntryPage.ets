@Builder
export function KdFilterBarExampleEntryPageBuilder() {
  KdFilterBarExampleEntryPage()
}

@Entry
@Component
struct KdFilterBarExampleEntryPage {
  @Consume('pathStack') pathStack: NavPathStack;

  aboutToAppear(): void {

  }

  build() {
    NavDestination() {
      Column() {
        Button(`多列示例`)
          .onClick(() => {
            this.pathStack.pushPath({ name: 'KdFilterBarMultiListExamplePage' })
          })
        Button(`网格示例`)
          .onClick(() => {
            this.pathStack.pushPath({ name: 'KdFilterBarMultiGridExamplePage' })
          })
          .margin({ top: 10 })
        Button(`更多示例`)
          .onClick(() => {
            this.pathStack.pushPath({ name: 'KdFilterBarMoreExamplePage' })
          })
          .margin({ top: 10 })
        Button(`自定义类型示例`)
          .onClick(() => {
            this.pathStack.pushPath({ name: 'KdFilterBarCustomExamplePage' })
          })
          .margin({ top: 10 })
        Button(`自定义Menu示例`)
          .onClick(() => {
            this.pathStack.pushPath({ name: 'KdFilterBarMenuCustomExamplePage' })
          })
          .margin({ top: 10 })
        Button(`自定义样式`)
          .onClick(() => {
            this.pathStack.pushPath({ name: 'KdFilterBarStyleCustomExamplePage' })
          })
          .margin({ top: 10 })
      }
      .height('100%')
      .width('100%')
    }
    .title('筛选示例入口')

  }

  @Builder
  Title() {
    Text('筛选示例')
  }
}
