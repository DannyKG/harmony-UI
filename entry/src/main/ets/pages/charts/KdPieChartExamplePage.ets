import { KdPieChart, Options } from "@kd-ui/kd_component"
import { PieDataType } from "@kd-ui/kd_component/src/main/ets/components/chart/utils/DrawPieViewModel"

@Builder
export function KdPieChartExamplePageBuilder() {
  KdPieChartExamplePage()
}

@Component
export struct KdPieChartExamplePage {
  @State defOption: Options<PieDataType> = new Options({
    series:[
      {
        name:'最高气温',
        data: [
          {value:435, name:'直接访问'},
          {value:310, name:'邮件营销'},
          {value:234, name:'联盟广告'},
          {value:135, name:'视频广告'},
          {value:1548, name:'搜索引擎'}
        ]
      }
    ]
  })
  build() {
    NavDestination() {
      Column(){
        KdPieChart({
          options: this.defOption
        })
      }
      .height('50%')
    }
    .title("环状图示例")
  }
}