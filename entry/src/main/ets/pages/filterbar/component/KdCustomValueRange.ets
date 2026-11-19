import { KdFilterItemBean } from "@kd-ui/kd_component/src/main/ets/components/filterbar/bean/KdFilterItemBean"
import { KdFilterUtil } from "@kd-ui/kd_component/src/main/ets/components/filterbar/util/KdFilterUtil"

@Component
export struct KdFilterCustomValueRange {
  @ObjectLink item: KdFilterItemBean
  onConfirmAction?: () => void

  build() {
    List() {
      ForEach(this.item.children, (item: KdFilterItemBean, index: number) => {
        ListItem() {
          if (item.customMap) {
            Row() {
              Slider({
                style: SliderStyle.OutSet,
                value: 4000,
                min: item.customMap[`leftValue`],
                max: item.customMap[`rightValue`],
              })
                .selectedColor(0xFF552E)
                .trackColor(0xFF552E)
                .blockStyle({ type: SliderBlockType.DEFAULT })
                .layoutWeight(1)
            }
            .margin({ left: 20, right: 20 })
          } else {
            Column() {
              Text(`${item.title}`)
                .fontColor(this.tagTextColor(item))
            }
            .width("100%")
            .height(30)
            .onClick(() => {
              //内置工具类处理兄弟节点的选中状态（通用情况下），如有特殊逻辑需要自定义
              KdFilterUtil.processBrotherItemSelectStatus(item)
              this.onConfirmAction?.()
            })
          }
        }
        .margin({ top: 10 })
      }, (item: KdFilterItemBean, index: number) => item.generateListKey() + index)
    }
    .backgroundColor(Color.White)
  }

  private tagTextColor(item: KdFilterItemBean): ResourceColor {
    if (item.isSelected) {
      return 0xFF552E
    } else {
      return Color.Black
    }
  }
}