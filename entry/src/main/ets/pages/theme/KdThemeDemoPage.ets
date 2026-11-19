import { KdFilterBar, KdPageLoading } from "@kd-ui/kd_component";
import {
  KdFilterDataRoot,
  KdFilterItemBean
} from "@kd-ui/kd_component/src/main/ets/components/filterbar/bean/KdFilterItemBean";
import { KdTheme, KdThemeStyle } from "@kd-ui/kd_component/src/main/ets/theme/KdTheme";
import { util } from "@kit.ArkTS";
import { KdFilterController } from "@kd-ui/kd_component/src/main/ets/components/filterbar/KdFilterBar";

@Builder
export function KdThemeDemoPageBuilder() {
  KdThemeDemoPage()
}

@Entry
@Component
struct KdThemeDemoPage {
  @Consume('pathStack') pathStack: NavPathStack;
  @State filterDataRoot?: KdFilterDataRoot = undefined
  private filterController: KdFilterController = new KdFilterController()
  colorText: string = '#44C2FF';
  @StorageLink(KdTheme.KEY)
  baseStyle: KdThemeStyle = KdTheme.getDefaultStyle()

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
        ThemeSection({ title: `修改主题颜色` }) {
          Row() {
            TextInput({ placeholder: '输入色值，如:#ff552e', text: this.colorText })
              .fontSize(12)
              .layoutWeight(1)
              .margin({
                left: 10,
              })
              .onChange(value => {
                this.colorText = value
              })
            Column() {
              Button(`确定`)
                .backgroundColor(this.baseStyle.primary)
                .onClick(() => {
                  KdTheme.setThemeStyle({
                    primary: this.colorText
                  })
                })
              Button(`重置`)
                .onClick(() => {
                  KdTheme.setThemeStyle({
                    primary: KdTheme.getDefaultStyle().primary
                  })
                })
                .margin({
                  top: 10,
                })
            }
            .margin({
              left: 10,
              right: 10
            })
          }
        }

        //筛选+Theme示例
        ThemeSection({ title: `筛选` }) {
          if (this.filterDataRoot) {
            KdFilterBar(
              {
                filterDataRoot: this.filterDataRoot,
                filterController: this.filterController,
              }
            )
          }
        }

        //Loading+Theme示例
        ThemeSection({ title: `Loading` }) {
          KdPageLoading()
        }

      }
      .alignItems(HorizontalAlign.Start)
      .height('100%')
      .width('100%')
    }
    .title('主题示例')
    .onWillDisappear(() => {
      this.filterController.close()
    })
  }
}

@Component
struct ThemeSection {
  title?: string
  @Require @BuilderParam defaultBuilder: CustomBuilder
  @StorageLink(KdTheme.KEY)
  baseStyle: KdThemeStyle = KdTheme.getDefaultStyle()

  build() {
    Column() {
      Text(this.title)
        .fontSize(this.baseStyle.fontSizeLg)
        .margin({
          bottom: 10
        })
        .textAlign(TextAlign.Start)
        .fontColor(Color.Gray)
      if (typeof this.defaultBuilder === 'function') {
        this.defaultBuilder()
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({
      left: 10,
      top: 10,
      bottom: 10
    })
  }
}