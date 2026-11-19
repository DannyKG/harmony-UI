import { ComponentContent, PromptAction } from "@kit.ArkUI"
import { KdTheme, KdThemeStyle } from "../../theme/KdTheme"

@Component
export struct KdPageLoading {
  @StorageLink(KdTheme.KEY)
  private baseStyle: KdThemeStyle = KdTheme.getDefaultStyle()
  @Prop options?: LoadingOptions = undefined

  build() {
    Row() {
      Progress({ value: 0, total: 100, type: ProgressType.Ring })
        .width(20)
        .color(Color.White)
        .style({ strokeWidth: 2, status: ProgressStatus.LOADING })
      Text(this.options?.content ?? '加载中...')
        .fontSize(this.options?.theme?.fontSize ?? this.baseStyle.fontSizeLg)
        .fontColor(this.options?.theme?.fontColor ?? Color.White)
        .fontWeight(this.options?.theme?.fontWeight ?? FontWeight.Medium)
        .margin({ left: 6 })
    }
    .backgroundColor(this.options?.theme?.backgroundColor ?? this.baseStyle.primary)
    .padding(10)
    .borderRadius(this.options?.theme?.borderRadius ?? 6)
  }
}

@Builder
function buildLoading(ops?: LoadingOptions) {
  KdPageLoading({
    options: ops
  })
}

export class KdLoading {
  private static DEFAULT_CONTENT = '加载中...'
  private uiContext: UIContext
  private promptAction: PromptAction
  private compContent?: ComponentContent<LoadingOptions>

  constructor(uiContext: UIContext) {
    this.uiContext = uiContext
    this.promptAction = uiContext.getPromptAction()
  }

  public show(options?: LoadingOptions) {
    if (this.compContent === undefined) {
      this.compContent =
        new ComponentContent(this.uiContext, wrapBuilder(buildLoading), options ?? { content: KdLoading.DEFAULT_CONTENT })
    } else {
      this.compContent.update(options ?? { content: KdLoading.DEFAULT_CONTENT })
    }

    // 显示 dialog
    this.promptAction.openCustomDialog(this.compContent, {
      isModal: true, // 弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。
      autoCancel: false, // 是否允许点击遮障层退出，true表示关闭弹窗。false表示不关闭弹窗。
      alignment: DialogAlignment.Center,
    })
  }

  public dismiss() {
    this.promptAction.closeCustomDialog(this.compContent).then(() => {
      this.compContent?.dispose()
    })
  }
}

export interface LoadingOptions {
  content?: string
  theme?: LoadingTheme
}

export interface LoadingTheme {
  fontSize?: number | string | Resource
  fontColor?: ResourceColor
  fontWeight?: FontWeight
  backgroundColor?: ResourceColor
  borderRadius?: Dimension | BorderRadiuses
}