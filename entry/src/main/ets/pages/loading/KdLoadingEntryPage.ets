import { KdDotLoadingView, KdLoading, KdPageLoading } from '@kd-ui/kd_component';

@Builder
export function KdLoadingEntryPageBuilder() {
  KdLoadingEntryPage()
}

@Entry
@Component
struct KdLoadingEntryPage {
  @State loading: boolean = true;

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Text('正常Loading展示')
        KdPageLoading()
        Text('短文案Loading展示')
        KdPageLoading({ options: { content: '我是较短的的Loading' } })
        Text('长文案Loading展示')
        KdPageLoading({ options: {content: '我是较长的我是较长的我是较长的...' }})
        Text('四色圆点Loading展示')
        KdDotLoadingView({ loading: $loading })
        Button('点击开始/暂停loading')
          .onClick(() => {
            this.loading = !this.loading
          })
        Button('点击打开loading弹窗，持续2s')
          .onClick(() => {
            let loading = new KdLoading(this.getUIContext());
            loading.show()
            setTimeout(() => {
              loading.dismiss()
            }, 2000)
          })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }
    .title('Loading示例')
  }
}