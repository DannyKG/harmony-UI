import { KdResourceColor } from "./KdTheme";

export interface KdColorStyle {
  primary: KdResourceColor
  primaryColorWithOpacity: (opacity: number) => KdResourceColor;
}