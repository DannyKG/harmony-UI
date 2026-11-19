import { KdTheme, KdThemeStyle } from "../../theme/KdTheme"

@Component
export struct KdSummary {
  /**
   * 组件入参，必填参数
   */
  @Prop @Require config: KdSummaryConfig
  /**
   * item的点击事件，如查看大图
   */
  onItemClick?: (index: number, items: KdSummaryItem[]) => void
  @State private columnsTemplate: string = ''

  @StorageLink(KdTheme.KEY)
  baseStyle: KdThemeStyle = KdTheme.getDefaultStyle()

  aboutToAppear(): void {
    for (let i = 0; i < this.config.countPerRow; i++) {
      this.columnsTemplate += '1fr '
    }
    this.columnsTemplate.trimEnd()
  }

  @Builder
  buildSummaryItem(item: KdSummaryItem, pIndex: number) {
    Column() {
      Text(`${item.title}(${item.images.length})`)
        .fontSize(20)
        .fontColor('#1F2326')
        .margin({ bottom: 20 })
        .fontWeight(FontWeight.Bold)

      Grid() {
        ForEach(item.images, (image: string) => {
          GridItem() {
            Image(image)
              .width('100%')
              .aspectRatio(1)
              .objectFit(ImageFit.Cover)
              .draggable(false)
              .animation({ curve: Curve.Sharp, duration: 300 })
              .onClick(() => {
                this.onItemClick?.(pIndex, this.config.items)
              })
          }
        }, (item: string, index: number) => item + index)
      }
      .width('100%')
      .editMode(false)
      .columnsGap(12)
      .rowsGap(12)
      .scrollBar(BarState.Off)
      .supportAnimation(true)
      .enableScrollInteraction(true)
      .columnsTemplate(this.columnsTemplate)
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 20 })
  }

  build() {
    Scroll() {
      List() {
        ForEach(this.config.items, (item: KdSummaryItem, index: number) => {
          ListItem() {
            this.buildSummaryItem(item, index)
          }
        })
      }.divider({
        strokeWidth: 15,
        color: '#ffffffff'
      })
    }.nestedScroll({
      scrollForward: NestedScrollMode.SELF_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }
}

interface KdSummaryConfig {
  items: KdSummaryItem[],
  countPerRow: number
}

export interface KdSummaryItem {
  title: string
  images: string[]
}