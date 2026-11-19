import ArrayList from "@ohos.util.ArrayList"
import { JSON } from "@kit.ArkTS"
import { TextUtils } from "../../../utils/TextUtils"
import { KdFilterUtil } from "../util/KdFilterUtil";

export enum KdFilterType {
  none,
  radio,
  checkbox,
  unLimit
}

export class KdFilterShowType {
  static readonly dropList = "dropList";
  static readonly dropGrid = "dropGrid";
  static readonly more = "more";

  // 获取所有常量值的数组
  static values(): string[] {
    return [KdFilterShowType.dropList, KdFilterShowType.dropGrid, KdFilterShowType.more];
  }
}

@Observed
export class KdFilterDataRoot {
  items: KdFilterItemBean[]

  constructor(items: KdFilterItemBean[]) {
    this.items = items;
  }
}

@Observed
export class KdFilterItemBean {
  type: KdFilterType = KdFilterType.none
  showType: string = KdFilterShowType.dropList
  title: string
  key?: string
  value?: string
  defaultValue?: string
  children: KdFilterItemBean[]
  parent?: KdFilterItemBean
  ///自定义数据
  customMap?: Map<string, string | object>
  ///状态属性
  isSelected: boolean = false

  constructor(type: KdFilterType, title: string, key: string, value: string, defaultValue: string,
    children: KdFilterItemBean[]) {
    this.type = type
    this.title = title
    this.key = key
    this.value = value
    this.defaultValue = defaultValue
    this.children = children
  }

  static convertJsonToObj(json: string | object[],
    parent: KdFilterItemBean | undefined = undefined): KdFilterItemBean[] | undefined {
    if (!json) {
      return undefined
    }
    let filterJson: object
    if (typeof json === 'string') {
      let r = JSON.parse(json)
      if (r) {
        filterJson = r
      } else {
        //TODO 解析失败抛异常
        throw new Error(`解析异常`)
      }
    } else {
      filterJson = json
    }
    let result: ArrayList<KdFilterItemBean> = new ArrayList()
    if (Array.isArray(filterJson)) {
      let filterJsonArray: object[] = filterJson
      for (const itemJson of filterJsonArray) {
        let children: KdFilterItemBean[] = KdFilterItemBean.convertJsonToObj(itemJson['children']) ?? []
        let itemObj = new KdFilterItemBean(
          KdFilterItemBean.convertFilterType(itemJson['type']),
          itemJson['title'],
          itemJson['key'],
          itemJson['value'],
          itemJson['defaultValue'],
          children
        );
        if (itemJson['showType']) {
          itemObj.showType = itemJson['showType']
        }
        if (itemJson['customMap']) {
          itemObj.customMap = itemJson['customMap']
        }
        if (parent) {
          itemObj.parent = parent
        }
        result.add(itemObj)
      }
    }
    result.forEach((item) => {
      item.configRelationshipAndDefaultValue()
    })
    return result.convertToArray();
  }

  static convertFilterType(type: string | undefined): KdFilterType {
    if (type) {
      switch (type.toLowerCase()) { // 转换为小写以支持大小写不敏感的匹配
        case "radio":
          return KdFilterType.radio;
        case "checkbox":
          return KdFilterType.checkbox;
        case "unlimit":
          return KdFilterType.unLimit;
        default:
          return KdFilterType.none;
      }
    } else {
      return KdFilterType.none;
    }
  }

  configRelationshipAndDefaultValue() {
    this.configRelationship();
    this.configDefaultValue();
  }

  private configRelationship() {
    if (this.children.length > 0) {
      for (let entity of this.children) {
        entity.parent = this;
      }
      for (let entity of this.children) {
        entity.configRelationship();
      }
    }
  }

  private configDefaultValue() {
    if (this.children.length > 0) {
      for (let entity of this.children) {
        if (!TextUtils.isBlank(this.defaultValue)) {
          let values = this.defaultValue!.split(',');
          if (entity.value) {
            entity.isSelected = values.includes(entity.value);
          }
        }
      }

      for (const entity of this.children) {
        entity.configDefaultValue();
      }

      if (this.hasCheckBoxBrother()) {
        this.isSelected = this.children.some((_) => _.isSelected);
      } else {
        this.isSelected = this.isSelected || this.children.some((_) => _.isSelected);
      }
    }
  }

  /**
   * 是否不限
   * @returns true 是 false 不是
   */
  isUnLimit(): boolean {
    return this.type == KdFilterType.unLimit;
  }

  // 检查自己的兄弟节点是否存在 checkbox 类型。
  hasCheckBoxBrother(): boolean {
    const count = this.parent?.children?.filter(
      (f) => f.type === KdFilterType.checkbox
    ).length;
    return count !== undefined && count > 0;
  }

  /// 是否在筛选数据的最后一层。 如果最大层次为 3；某个筛选数据层次为 2，但其无子节点。此时认为不在最后一层。
  isInLastLevel(): boolean {
    if (this.parent == null || this.parent!.children.length == 0) {
      return true;
    }
    for (let entity of this.parent!.children) {
      if (entity.children.length > 0) {
        return false;
      }
    }
    return true;
  }

  generateListKey(): string {
    let listKey: string = `${this.parentKey()}--${this.key}--${this.value}--${this.isSelected}`
    if (!this.isInLastLevel()) {
      listKey += this.selectedList()
        .filter(item => item.isSelected)// 筛选出选中的项
        .map(item => item.value)// 提取选中项的 value
        .join("-");
    }
    return listKey
  }

  private parentKey(): string {
    let key: string | undefined = ""
    if (this.parent) {
      key = `${this.parent.parentKey()}--${this.key}`
    } else {
      key = this.key
    }
    return key ?? ``;
  }

  // 清空子节点的选中状态
  clearChildSelectedStatus(): void {
    if (this.children.length > 0) {
      for (const child of this.children) {
        child.isSelected = false;
        child.clearChildSelectedStatus(); // 递归清空子节点
      }
    }
  }

  /// 获取当前节点的所有选中的子节点，支持 more 类型
  selectedList(): KdFilterItemBean[] {
    //TODO 更多类型（更多类型可不同子项间多选，这里需要特殊处理）
    let results: KdFilterItemBean[] = [];
    let firstColumn =
      KdFilterUtil.currentSelectListForEntity(this);
    results = results.concat(firstColumn);
    if (firstColumn.length > 0) {
      for (let firstEntity of firstColumn) {
        let secondColumn =
          KdFilterUtil.currentSelectListForEntity(firstEntity);
        results = results.concat(secondColumn);
        if (secondColumn.length > 0) {
          for (let secondEntity of secondColumn) {
            let thirdColumn =
              KdFilterUtil.currentSelectListForEntity(secondEntity);
            results = results.concat(thirdColumn);
          }
        }
      }
    }
    return results;
  }

  selectedListWithoutUnlimit(): KdFilterItemBean[] {
    const selected = this.selectedList();
    return selected.filter(entity =>!entity.isUnLimit());
  }
}