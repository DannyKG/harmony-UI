import { window } from "@kit.ArkUI";
import immersionBar from "./utils/ImmersionBar";

export class KdComponent{
  static init(window:window.Window){
    immersionBar.init(window)
  }
}