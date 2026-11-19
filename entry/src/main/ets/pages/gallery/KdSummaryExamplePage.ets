import { KdGalleryTabConfig, KdGalleyConfig, KdSummary, KdSummaryItem } from "@kd-ui/kd_component"

@Builder
export function KdSummaryExamplePageBuilder() {
  KdSummaryExamplePage()
}

@Component
export struct KdSummaryExamplePage {
  @Consume('pathStack') pathStack: NavPathStack;

  build() {
    NavDestination() {
      KdSummary({
        config: {
          countPerRow: 4,
          items: [
            {
              title: '这是标题',
              images: [
                'http://m.360buyimg.com/mobilecms/s1600x1120_jfs/t19540/272/1542853502/335716/5ef8759b/5acc6c5bN988cd3d9.jpg',
                'http://gips3.baidu.com/it/u=4283915297,3700662292&fm=3028&app=3028&f=JPEG&fmt=auto?w=1440&h=2560',
                'http://gips2.baidu.com/it/u=2055042668,1190219470&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
                'http://m.360buyimg.com/mobilecms/s1600x1120_jfs/t19540/272/1542853502/335716/5ef8759b/5acc6c5bN988cd3d9.jpg',
                'http://gips3.baidu.com/it/u=4283915297,3700662292&fm=3028&app=3028&f=JPEG&fmt=auto?w=1440&h=2560',
                'http://gips2.baidu.com/it/u=2055042668,1190219470&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
              ]
            },
            {
              title: '这是标题2',
              images: [
                'http://gips3.baidu.com/it/u=4283915297,3700662292&fm=3028&app=3028&f=JPEG&fmt=auto?w=1440&h=2560',
                'http://m.360buyimg.com/mobilecms/s1600x1120_jfs/t19540/272/1542853502/335716/5ef8759b/5acc6c5bN988cd3d9.jpg',
                'http://gips2.baidu.com/it/u=2055042668,1190219470&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
              ]
            },
            {
              title: '这是标题3',
              images: [
                'http://gips3.baidu.com/it/u=4283915297,3700662292&fm=3028&app=3028&f=JPEG&fmt=auto?w=1440&h=2560',
                'http://gips2.baidu.com/it/u=2055042668,1190219470&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
                'http://m.360buyimg.com/mobilecms/s1600x1120_jfs/t19540/272/1542853502/335716/5ef8759b/5acc6c5bN988cd3d9.jpg',
              ]
            },
            {
              title: '这是标题4',
              images: [
                'http://gips3.baidu.com/it/u=4283915297,3700662292&fm=3028&app=3028&f=JPEG&fmt=auto?w=1440&h=2560',
                'http://gips2.baidu.com/it/u=2055042668,1190219470&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
              ]
            }
          ]
        },
        onItemClick: ((index: number, items: KdSummaryItem[]) => {
          let galleryConfig: KdGalleyConfig = {
            selectedIndex: index,
            tabConfig: items.map<KdGalleryTabConfig>((i: KdSummaryItem, index: number, array: KdSummaryItem[]) => {
              return {
                tabBarTitle: i.title,
                tabContentData: {
                  imageUrls: i.images,
                  name: "",
                  desc: ""
                }
              }
            })
          }

          this.pathStack.pushPath({
            name: 'KdGalleryExamplePage', param: JSON.stringify(galleryConfig)
          })
        })
      })
    }.title('Summary示例')
  }
}