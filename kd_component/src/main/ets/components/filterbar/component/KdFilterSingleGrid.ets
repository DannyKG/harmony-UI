import { KdFilterItemBean } from "../bean/KdFilterItemBean"
import { LengthMetrics } from "@kit.ArkUI"
import { KdFilterGridItem } from "./KdFilterGridItem"
import { KdFilterUtil } from "../util/KdFilterUtil"
import { GridAttr, GridEventBus } from "./KdFilterGridGroup"
import { KdFilterStyle } from "../KdFilterThemeConfig"
import { KdTheme, KdThemeStyle } from "../../../theme/KdTheme"

@Component
@Preview
export struct KdFilterSingleGrid {
  @StorageLink(KdTheme.KEY)
  baseStyle: KdThemeStyle = KdTheme.getDefaultStyle()
  @ObjectLink item: KdFilterItemBean
  @State childrens?: KdFilterItemBean[] = undefined
  @State focusIndex: number = -1
  @Prop componentWidth:number = 0
  @Consume filterStyle: KdFilterStyle
  gridEventBus?: GridEventBus

  aboutToAppear(): void {
    this.childrens = this.item.children
    this.focusIndex = this._getInitialSelectIndex(this.childrens)
    this.gridEventBus?.registerObserver(() => {
      this.focusIndex = this._getInitialSelectIndex(this.childrens)
    })
  }

build() {
    Column() {
      Text(this.item.title)
        .alignSelf(ItemAlign.Start)
        .fontColor(this.filterStyle?.gridStyle?.titleTextStyle?.fontColor ?? Color.Black)
        .fontWeight(this.filterStyle?.gridStyle?.titleTextStyle?.fontWeight ?? FontWeight.Bold)
        .fontSize(this.filterStyle?.gridStyle?.titleTextStyle?.fontSize ?? this.baseStyle.fontSizeLg)
        .margin({
          bottom: 20
        })
      Flex({
        wrap: FlexWrap.Wrap,
        alignItems: ItemAlign.Center,
        space: {
          main: LengthMetrics.vp(12),
          cross: LengthMetrics.vp(10)
        }
      }) {
        ForEach(this.childrens, (item: KdFilterItemBean, index: number) => {
          KdFilterGridItem({
            item: item,
            focusedIndex: this.focusIndex,
            listIndex: index,
            componentWidth:this.componentWidth,
            gridItemSelect: () => {
              KdFilterUtil.processBrotherItemSelectStatus(item)
              this.focusIndex = this._getInitialSelectIndex(this.childrens)
            }
          })
        }, (item: KdFilterItemBean, index: number) => item.generateListKey() + index)
      }
    }
  }

  private _getInitialSelectIndex(levelList: KdFilterItemBean[] | undefined): number {
    let index = -1;
    if (!levelList || levelList.length == 0) {
      return index;
    }
    for (let entity of levelList) {
      if (entity.isSelected) {
        index = levelList.indexOf(entity);
        break;
      }
    }
    /// 非跨区域选择时，走此方法设置默认选择 index
    if (index < 0) {
      for (let entity of levelList) {
        if (entity.isUnLimit() &&
          KdFilterUtil.getTotalLevel(entity) > 1 &&
          !(entity.parent?.hasCheckBoxBrother() ?? false)) {
          index = levelList.indexOf(entity);
          break;
        }
      }
    }
    return index;
  }
}