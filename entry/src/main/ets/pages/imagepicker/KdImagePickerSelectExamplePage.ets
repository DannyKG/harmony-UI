import { KdImagePicker } from '@kd-ui/kd_component'
import { AlbumInfo } from '@kit.MediaLibraryKit';

@Builder
export function KdImagePickerSelectExamplePageBuilder() {
  KdImagePickerSelectExamplePage()
}
@Component
export struct KdImagePickerSelectExamplePage {
  @Consume('pathStack') pageStack: NavPathStack;

  @State currentAlbumUrl?: string = ""
  @State currentAlbumName?: string = "照片和视频"
  build() {
    NavDestination() {
      KdImagePicker({
        currentAlbumUrl: this.currentAlbumUrl,
        onFinished: (result: Object) => {
          this.pageStack.pop(result)
        },
        goAlbumPicker: () => {
          this.pageStack.pushPathByName("KdImageAlbumPickerPage", null, (popInfo: PopInfo) => {
            if (popInfo.result instanceof AlbumInfo) {
              this.currentAlbumUrl = popInfo.result.uri
              this.currentAlbumName = popInfo.result.albumName
            }
          }, true)
        }
      })
    }
    .title(this.currentAlbumName)
  }
}