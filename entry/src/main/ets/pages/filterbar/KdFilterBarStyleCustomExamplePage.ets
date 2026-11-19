import { KdFilterItemBean, KdFilterBar } from '@kd-ui/kd_component'
import { KdFilterDataRoot } from '@kd-ui/kd_component/src/main/ets/components/filterbar/bean/KdFilterItemBean'
import util from '@ohos.util'
import { KdFilterController } from '@kd-ui/kd_component/src/main/ets/components/filterbar/KdFilterBar'
import { JSON } from '@kit.ArkTS'
import ObjectUtil from '../../utils/utils'
import { KdThemeUtil } from '@kd-ui/kd_component/src/main/ets/theme/KdThemeUtil'

@Builder
export function KdFilterBarStyleCustomExamplePageBuilder() {
  KdFilterBarStyleCustomExamplePage()
}

@Entry
@Component
struct KdFilterBarStyleCustomExamplePage {
  @State filterDataRoot?: KdFilterDataRoot = undefined
  @State selectedParams?: Map<string, string> = undefined
  private filterController: KdFilterController = new KdFilterController()

  aboutToAppear(): void {
    getContext(this).resourceManager.getRawFileContent('more_filter.json', (_err, value) => {
      let textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
      const result = textDecoder.decodeWithStream(value, { stream: false })
      this.filterDataRoot = new KdFilterDataRoot(KdFilterItemBean.convertJsonToObj(result)!)
    });
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
              filterStyle: {
                menuStyle: {
                  menuSelectedTextStyle: {
                    fontColor: Color.Blue,
                    fontWeight: FontWeight.Bold
                  }
                },
                listStyle: {
                  itemSelectedTextStyle: {
                    fontColor: Color.Blue,
                    fontSize: 16,
                    fontWeight: FontWeight.Bold
                  },
                },
                gridStyle: {
                  titleTextStyle: {
                    fontColor: Color.Red,
                    fontSize: 20,
                  },
                  itemSelectedTextStyle: {
                    fontColor: Color.Blue,
                    fontWeight: FontWeight.Bold
                  },
                  itemSelectedBgColor: KdThemeUtil.colorWithOpacity(Color.Blue, 0.3)
                },
                bottomPanelStyle: {
                  resetText: `Reset`,
                  resetIcon: $r('app.media.icon_filter_reset_custom'),
                  confirmText: `OK`,
                  confirmButtonColor: Color.Blue
                }
              }
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
    .title('自定义样式')
    .onWillDisappear(() => {
      console.log(``)
      this.filterController.close()
    })
  }

  @Builder
  Title() {
    Text('自定义样式')
  }
}
