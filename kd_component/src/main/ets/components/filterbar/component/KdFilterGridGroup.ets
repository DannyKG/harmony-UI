import { KdFilterItemBean } from "../bean/KdFilterItemBean"
import { KdFilterSingleGrid } from "./KdFilterSingleGrid"
import { KdFilterBottomPanel } from "./KdFilterBottomPanel"
import { KdFilterUtil } from "../util/KdFilterUtil"
import { KdFilterStyle } from "../KdFilterThemeConfig"

export interface GridAttr {
  rowCount: number
  baseWidth: number
  maxHeight: number
}

@Component
@Preview
export struct KdFilterGridGroup {
  private static DEFAULT_MAX_HEIGHT = 400 ///默认最大高度，可从filterStyle中自定义
  @Consume filterStyle: KdFilterStyle
  @ObjectLink item: KdFilterItemBean
  @State childrens?: KdFilterItemBean[] = undefined
  @State componentWidth: number = 0
  isDrop: boolean = false
  onConfirmAction?: () => void
  ///私有，外部不要传入
  @State private _originalSelectedItemsList: KdFilterItemBean[] = []
  private _isConfirmClick = false; //是否确认过（没确认过则重置数据）
  private gridEventBus: GridEventBus = new GridEventBus()

  aboutToAppear(): void {
    this.childrens = this.item.children
    // 生成筛选节点树
    this._originalSelectedItemsList = this.item.selectedList();
  }

  aboutToDisappear(): void {
    if (!this._isConfirmClick) {
      this._resetFilterData(this.item);
      this._restoreOriginalData();
    }
  }

  build() {
    Column() {
      if (this.isDrop) {
        Column() {
          this._buildGrid()
        }
        .width(`100%`)
        .constraintSize({
          maxHeight: this.filterStyle?.gridStyle?.maxHeight ?? KdFilterGridGroup.DEFAULT_MAX_HEIGHT
        })
      } else {
        Column() {
          this._buildGrid()
        }
        .width(`100%`)
        .layoutWeight(1)
      }

      this._buildBottom()
    }
    .backgroundColor(Color.White)
  }

  @Builder
  _buildGrid() {
    Scroll() {
      Column() {
        ForEach(this.childrens, (item: KdFilterItemBean, index: number) => {
          ListItem() {
            KdFilterSingleGrid({
              item: item,
              componentWidth: this.componentWidth,
              gridEventBus: this.gridEventBus
            })
          }
          .width("100%")
          .padding({
            left: 20,
            right: 20,
            top: 20,
            bottom: this.childrens?.length == index + 1 ? 20 : 10
          })
        }, (item: KdFilterItemBean, index: number) => item.generateListKey() + index)
      }
      .width(`100%`)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.componentWidth = KdFilterUtil.lengthToNumber(newValue.width)
      })
    }
  }

  @Builder
  _buildBottom() {
    KdFilterBottomPanel({
      onResetClick: () => {
        this._clearAllSelectedItems()
        this.gridEventBus.notifyObservers()
      },
      onConfirmClick: () => {
        this._confirmButtonClickEvent()
      }
    })
  }

  private _clearAllSelectedItems() {
    this._resetFilterData(this.item);
  }

  ///还原数据选中状态
  private _resetFilterData(entity: KdFilterItemBean) {
    entity.isSelected = false;
    for (let subEntity of entity.children) {
      this._resetFilterData(subEntity);
    }
  }

  private _confirmButtonClickEvent() {
    this._isConfirmClick = true
    /// 确认回调前 根据规则，统一处理筛选数据选择状态
    this._processFilterDataOnConfirm()
    this.onConfirmAction?.()
  }

  // 提交前对筛选数据做进一步处理
  private _processFilterDataOnConfirm(): void {
    this._processSelectedStatus(this.item);
  }

  // 递归处理筛选项的选中状态
  private _processSelectedStatus(entity: KdFilterItemBean): void {
    if (entity.children.length > 0) {
      entity.children.forEach(child => this._processSelectedStatus(child));

      if (entity.hasCheckBoxBrother()) {
        entity.isSelected = entity.children.some(child => child.isSelected);
      }
    }
  }

  ///数据还原
  private _restoreOriginalData() {
    for (let commonEntity of this._originalSelectedItemsList) {
      commonEntity.isSelected = true;
    }
  }
}

export class GridEventBus {
  observerList: (() => void)[] = []

  // 注册观察者
  registerObserver(observer: () => void) {
    this.observerList.push(observer);
  }

  // 通知所有观察者
  notifyObservers() {
    this.observerList.forEach((observer) => observer());
  }

  // 取消注册观察者
  unregisterObserver(observer: () => void) {
    this.observerList = this.observerList.filter((obs) => obs !== observer);
  }
}