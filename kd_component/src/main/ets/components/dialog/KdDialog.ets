import { ComponentContent, PromptAction } from "@kit.ArkUI"
import { buildDialog } from "./KdDialogBuilder"
import { KdDialogArgs, KdDialogParams } from "./KdDialogConstant"

export function generateId() {
  return Math.random().toString(36)
}

export class KdDialogManager {
  private static dialogMap: Map<string, KdDialog> = new Map();

  private constructor() {
  }

  public static put(dialog: KdDialog): string {
    const key = generateId()
    KdDialogManager.dialogMap.set(key, dialog);
    return key
  }

  public static dismiss(key: string) {
    KdDialogManager.dialogMap.get(key)?.dismiss();
  }
}

export class KdDialogController {
  private key: string

  constructor(key: string) {
    this.key = key;
  }

  public dismiss() {
    KdDialogManager.dismiss(this.key)
  }
}

export class KdDialog {
  private uiContext: UIContext
  private promptAction: PromptAction
  private compContent?: ComponentContent<KdDialogParams>

  constructor(uiContext: UIContext) {
    this.uiContext = uiContext
    this.promptAction = uiContext.getPromptAction()
  }

  public dismiss() {
    this.promptAction.closeCustomDialog(this.compContent).then(() => {
      this.compContent?.dispose()
    })
  }

  public show(args: KdDialogArgs) {
    let params = new KdDialogParams(new KdDialogController(KdDialogManager.put(this)), args)
    this.compContent = new ComponentContent(this.uiContext, wrapBuilder(buildDialog), params)

    this.promptAction.openCustomDialog(this.compContent, {
      showInSubWindow: args.showInSubWindow ?? false,
      autoCancel: args.autoCancel ?? true,
      alignment: args.alignment ?? DialogAlignment.Center,
      isModal: args.isModal ?? true,
      offset: args.offset ?? { dx: 0, dy: 0 },
      transition: args.transition,
      maskColor: args.maskColor,
      onDidAppear: args.onDidAppear,
      onDidDisappear: args.onDidDisappear
    })
  }
}