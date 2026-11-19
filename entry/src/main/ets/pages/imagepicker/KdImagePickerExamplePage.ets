import {
  KdImagePickerTrigger
} from "@kd-ui/kd_component/src/main/ets/components/imagepicker/KdImagePickerTrigger";

@Builder
export function KdImagePickerExamplePageBuilder() {
  KdImagePickerExamplePage()
}

@Component
export struct KdImagePickerExamplePage {
  @Consume('pathStack') pageStack: NavPathStack;
  @State selectUris: Array<string> = new Array<string>();

  build() {
    NavDestination() {
      KdImagePickerTrigger({
        selectUris: $selectUris,
        goImagePicker: () => {
          this.pageStack.pushPathByName("KdImagePickerSelectExamplePage", null, (data: PopInfo) => {
            if (data.result instanceof Array) {
              data.result.forEach((url: string) => {
                this.selectUris.push(url)
              })
            }
          }, true)
        }
      })
    }
    .title("图片选择器示例")
  }
}