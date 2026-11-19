import { KdFilterItemBean, KdFilterBar } from '@kd-ui/kd_component'
import { KdFilterDataRoot } from '@kd-ui/kd_component/src/main/ets/components/filterbar/bean/KdFilterItemBean'
import util from '@ohos.util'
import { KdFilterController
} from '@kd-ui/kd_component/src/main/ets/components/filterbar/KdFilterBar'
import { JSON } from '@kit.ArkTS'
import ObjectUtil from '../../utils/utils'
import { KdFilterCustomValueRange } from './component/KdCustomValueRange'
import {
  KdFilterComponentRegistry,
  OnCloseAction,
  OnConfirmAction
} from '@kd-ui/kd_component/src/main/ets/components/filterbar/KdFilterComponentRegistry'

@Builder
export function KdFilterBarCustomExamplePageBuilder() {
  KdFilterBarCustomExamplePage()
}

@Entry
@Component
struct KdFilterBarCustomExamplePage {
  @State filterDataRoot?: KdFilterDataRoot = undefined
  @State selectedParams?: Map<string, string> = undefined
  private filterController: KdFilterController = new KdFilterController()
  private customComponentRegistry: KdFilterComponentRegistry = new KdFilterComponentRegistry()

  aboutToAppear(): void {
    getContext(this).resourceManager.getRawFileContent('custom_filter.json', (_err, value) => {
      let textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
      const result = textDecoder.decodeWithStream(value, { stream: false })
      this.filterDataRoot = new KdFilterDataRoot(KdFilterItemBean.convertJsonToObj(result)!)
    });
    //注册自定义Component
    this.customComponentRegistry.registerDropSlideComponent(`custom_value`, wrapBuilder(customLayout))
  }

  build() {
    NavDestination() {
      Column() {
        if (this.filterDataRoot) {
          KdFilterBar(
            {
              filterDataRoot: this.filterDataRoot,
              onFilterParamsChanged: (selectedParams: Map<string, string>) => {
                this.selectedParams = selectedParams
              },
              filterController: this.filterController,
              componentRegistry: this.customComponentRegistry
            }
          )
        }
        if (this.selectedParams) {
          Flex() {
            Column() {
              Text(`${JSON.stringify(ObjectUtil.ObjectFromEntries(this.selectedParams))}`)
            }
            .width(`100%`)
            .height(`100%`)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        }
      }
      .height('100%')
      .width('100%')
    }
    .title('筛选示例')
    .onWillDisappear(() => {
      console.log(``)
      this.filterController.close()
    })
  }

  @Builder
  Title() {
    Text('自定义筛选示例')
  }
}

@Builder
function customLayout(item: KdFilterItemBean, onConfirmAction: OnConfirmAction, onCloseAction: OnCloseAction) {
  KdFilterCustomValueRange({
    item: item,
    onConfirmAction: onConfirmAction
  })
}