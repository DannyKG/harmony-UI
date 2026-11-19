import { KdColorStyle } from "./KdColorStyle";
import { FONT_SIZE, KdFontStyle } from "./KdFontStyle";
import { KdThemeUtil } from "./KdThemeUtil";

export enum KdColor{
  PRIMARY_COLOR = -1
};

export type KdResourceColor = number | string ;

export interface KdThemeStyle extends KdColorStyle, KdFontStyle {}

export class KdTheme {
  static KEY = 'KD_THEME_KEY'
  static DEFAULT_PRIMARY_COLOR = "#296DFF"

  static init() {
    AppStorage.setOrCreate(KdTheme.KEY, KdTheme.getDefaultStyle())
  }

  static getDefaultStyle(): KdThemeStyle {
    const data: KdThemeStyle = {
      primary: KdTheme.DEFAULT_PRIMARY_COLOR,
      primaryColorWithOpacity: (opacity: number) => KdThemeUtil.colorWithOpacity(data.primary, opacity),
      fontSizeXs: FONT_SIZE.XS,
      fontSizeSm: FONT_SIZE.SM,
      fontSizeMd: FONT_SIZE.MD,
      fontSizeLg: FONT_SIZE.LG,
      fontSizeXl: FONT_SIZE.XL,
    }
    return data;
  }

  static setThemeStyle(styleData?: Partial<KdThemeStyle>) {
    const newStyleData = KdTheme.getDefaultStyle();
    if (typeof styleData === 'object' && styleData !== null) {
      Object.keys(styleData).forEach(item => {
        if ((newStyleData as object)[item]) {
          (newStyleData as object)[item] = (styleData as object)[item] ?? (newStyleData as object)[item]
        }
      })
    }
    AppStorage.setOrCreate(KdTheme.KEY, newStyleData)
  }
}