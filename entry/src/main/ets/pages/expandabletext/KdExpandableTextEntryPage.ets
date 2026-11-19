import { KdExpandableText } from '@kd-ui/kd_component'

@Builder
export function KdExpandableTextEntryPageBuilder() {
  KdExpandableTextEntryPage()
}

@Preview
@Entry
@Component
struct KdExpandableTextEntryPage {
  @State content: string =
    '这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容' +
      '这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容' +
      '这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容' +
      '这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容这是正文内容'

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Text('示例一：默认样式')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(0x333333)
            .padding({
              top: 20,
              bottom: 20,
              right: 20,
              left: 20
            })
            .width('100%')
          KdExpandableText({
            content: this.content,
            maxLine: 5,
          }).margin(
            {
              left: 20,
              right: 20,
              bottom: 20
            }
          )
          Text('示例二：自定义样式')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(0x333333)
            .padding({
              top: 20,
              bottom: 20,
              right: 20,
              left: 20
            })
            .width('100%')
          KdExpandableText({
            content: this.content,
            maxLine: 6,
            contentFontColor: 0x333333,
            expandFontColor: 0xec623e
          })
            .margin({
              top: 20,
              bottom: 20,
              right: 20,
              left: 20
            })
        }
      }
    }.title('KdExpandableText示例')
  }
}