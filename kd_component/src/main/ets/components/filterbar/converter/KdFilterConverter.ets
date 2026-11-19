import { KdFilterItemBean, KdFilterShowType, KdFilterType } from '../bean/KdFilterItemBean';
import HashMap from '@ohos.util.HashMap';
import { TextUtils } from '../../../utils/TextUtils';
import { KdFilterUtil } from '../util/KdFilterUtil';

// 筛选项数据转换器接口
export interface KdFilterConverterDelegate {
  convertSelectedData(selectedResults: KdFilterItemBean[]): Map<string, string>;
}

// 默认筛选项数据转换器
export class DefaultFilterConverter implements KdFilterConverterDelegate {
  constructor() {
  }

  // 将选中的数据转换为 Map<string, string>
  convertSelectedData(selectedResults: KdFilterItemBean[]): Map<string, string> {
    return getFilterParams(selectedResults);
  }
}

function getFilterParams(selectedResults: KdFilterItemBean[] | null): Map<string, string> {
  const params = new Map<string, string>();

  if (!selectedResults) return params;

  for (const menuItemEntity of selectedResults) {
    if (menuItemEntity.showType === KdFilterShowType.more) {
      //TODO 更多的结构是否区别
      const childParams = getFilterParams(menuItemEntity.children);
      childParams.forEach((value, key) => params.set(key, value));
    } else {

      // 2. 查找层级为 1、2、3 的选中项的参数
      const levelCount = KdFilterUtil.getTotalLevel(menuItemEntity);
      if (levelCount === 1) {
        mergeMap(params, getCurrentSelectedFilterParams(menuItemEntity));
      } else if (levelCount === 2) {
        mergeMap(params, getCurrentSelectedFilterParams(menuItemEntity));
        menuItemEntity.children.forEach(firstLevelItem => {
          mergeMap(params, getCurrentSelectedFilterParams(firstLevelItem));
        });
      } else if (levelCount === 3) {
        mergeMap(params, getCurrentSelectedFilterParams(menuItemEntity));
        menuItemEntity.children.forEach(firstLevelItem => {
          mergeMap(params, getCurrentSelectedFilterParams(firstLevelItem));
          firstLevelItem.children.forEach(secondLevelItem => {
            mergeMap(params, getCurrentSelectedFilterParams(secondLevelItem));
          });
        });
      }
    }
  }

  return params;
}

// 获取当前选中项的筛选数据
function getCurrentSelectedFilterParams(filterItem: KdFilterItemBean): Map<string, string> {
  const params = new Map<string, string>();
  const parentKey = filterItem.key;

  const selectedEntities = filterItem.children
    .filter(child => child.isSelected && !TextUtils.isBlank(child.value))
    .map(child => child.value);

  const selectedParams = selectedEntities.length > 0 ? selectedEntities.join(",") : "";

  if (!TextUtils.isBlank(selectedParams) && !TextUtils.isBlank(parentKey)) {
    params.set(parentKey!, selectedParams);
  }

  return params;
}

// 合并 Map
function mergeMap(target: Map<string, string>, source: Map<string, string>) {
  source.forEach((value, key) => target.set(key, value));
}