import { KdResourceColor } from "../../theme/KdTheme"

export interface KdFilterStyle {
  menuStyle?: KdFilterMenuStyle
  gridStyle?: KdFilterGridStyle
  listStyle?: KdFilterListStyle
  bottomPanelStyle?: KdFilterBottomPanelStyle
}

export interface KdFilterMenuStyle {
  menuTextStyle?: KdFilterTextStyle //菜单文字常规样式
  menuSelectedTextStyle?: KdFilterTextStyle //菜单文字选中样式
}

export interface KdFilterListStyle {
  maxHeight?:number
  itemTextStyle?: KdFilterTextStyle; // 列表文字常规样式
  itemSelectedTextStyle?: KdFilterTextStyle; // 列表文字选中样式
  itemMultiSelectIconUnselected?: KdFilterIcon //多选icon
  itemMultiSelectIconSelected?: KdFilterIcon //多选icon（选中）
}

export interface KdFilterGridStyle {
  maxHeight?:number
  rowCount?:number//每行个数
  titleTextStyle?: KdFilterTextStyle //网格标题样式
  itemTextStyle?: KdFilterTextStyle //网格文字常规样式
  itemSelectedTextStyle?: KdFilterTextStyle //网格文字选中样式
  itemBgColor?: KdResourceColor //item背景色
  itemSelectedBgColor?: KdResourceColor //item背景色（选中）
}

export interface KdFilterBottomPanelStyle {
  resetText?:string
  resetTextStyle?: KdFilterTextStyle //重置文字样式
  resetIcon?: KdFilterIcon //重置图标
  confirmText?:string
  confirmTextStyle?: KdFilterTextStyle //确定文字样式
  confirmButtonColor?: KdResourceColor //确定按钮颜色
}

export declare type KdFilterIcon = PixelMap | ResourceStr | DrawableDescriptor | ImageContent

export interface KdFilterTextStyle {
  fontColor?: KdResourceColor //文字颜色
  fontSize?: number | string | Resource //文字大小
  fontWeight?: number | FontWeight | string //文字粗细
}
