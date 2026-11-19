import { KdDialogController } from "./KdDialog"

export interface KdDialogTextArgs {
  value: string
  style?: KdDialogFontStyle
  padding?: Padding | Length | LocalizedPadding
}

export interface KdDialogFontStyle {
  font?: Font
  color?: ResourceColor
}

export interface KdDialogButtonArgs {
  value: string
  fontStyle?: KdDialogFontStyle
  padding?: Padding | Length | LocalizedPadding
  backgroundColor?: ResourceColor
  border?: BorderOptions
}

export interface KdDialogArgs {
  titleBuilder?: () => void
  contentBuilder?: () => void
  buttonBuilder?: (controller?: KdDialogController) => void
  titleArgs?: KdDialogTextArgs
  contentArgs?: KdDialogTextArgs
  leftButtonArgs?: KdDialogButtonArgs
  rightButtonArgs?: KdDialogButtonArgs
  dialogBorder?: BorderOptions
  dialogBgColor?: ResourceColor
  dialogDivider?: KdDialogDividerOptions
  isModal?: boolean
  showInSubWindow?: boolean
  autoCancel?: boolean
  alignment?: DialogAlignment
  offset?: Offset
  transition?: TransitionEffect
  maskColor?: ResourceColor
  onDidAppear?: VoidCallback
  onDidDisappear?: VoidCallback
  onLeftButtonClick?: (event: ClickEvent) => void
  onRightButtonClick?: (event: ClickEvent) => void
}

export class KdDialogParams {
  controller: KdDialogController
  titleBuilder?: () => void
  contentBuilder?: () => void
  buttonBuilder?: (controller?: KdDialogController) => void
  titleArgs?: KdDialogTextArgs
  contentArgs?: KdDialogTextArgs
  leftButtonArgs?: KdDialogButtonArgs
  rightButtonArgs?: KdDialogButtonArgs
  dialogBorder?: BorderOptions
  dialogBgColor?: ResourceColor
  dialogDivider?: KdDialogDividerOptions
  onLeftButtonClick?: (event: ClickEvent) => void
  onRightButtonClick?: (event: ClickEvent) => void

  constructor(controller: KdDialogController, args: KdDialogArgs) {
    this.controller = controller;
    this.titleBuilder = args.titleBuilder
    this.contentBuilder = args.contentBuilder
    this.buttonBuilder = args.buttonBuilder
    this.titleArgs = args.titleArgs
    this.contentArgs = args.contentArgs
    this.leftButtonArgs = args.leftButtonArgs
    this.rightButtonArgs = args.rightButtonArgs
    this.dialogBorder = args.dialogBorder
    this.dialogBgColor = args.dialogBgColor
    this.dialogDivider = args.dialogDivider
    this.onLeftButtonClick = args.onLeftButtonClick
    this.onRightButtonClick = args.onRightButtonClick
  }
}

export interface KdDialogDividerOptions {
  strokeWidth?: number | string
  color?: ResourceColor
  margin?: Margin | Length | LocalizedMargin
}