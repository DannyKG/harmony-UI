import { KdPullDown, KdPullStatus } from './interface';
import { KdPullableController } from './KdPullableController';
import { RefreshLayout } from './core/RefreshLayout';
import { KdRefreshLayoutConfig } from './KdRefreshLayoutConfig';
import { _ContentView, _loadMoreView, _noMoreView } from './core/RefreshLayoutHelper';
import { KdDotLoadingView } from '../loading/KdDotLoadingView'
import web from '@ohos.web.webview';


@Component
export struct KdPullToRefreshLayout {
  // 状态相关
  @State status: KdPullStatus = KdPullStatus.DEF

  // 控制器相关属性
  public scroller: Scroller | undefined = undefined
  public webviewController: web.WebviewController | undefined = undefined
  public controller: KdPullableController = new KdPullableController()

  // 回调函数
  public onRefresh: () => void = () => {}             // 刷新回调
  public onLoad: () => void = () => {}                // 加载回调
  public onPullListener: (KdPullDown: KdPullDown) => void = () => {} // 下拉状态监听

  // 视图相关
  @Require @BuilderParam contentView: () => void = _ContentView  // 内容视图
  @BuilderParam viewLoading?: () => void    // 加载中视图
  @BuilderParam viewEmpty?: () => void      // 空状态视图
  @BuilderParam viewError?: () => void      // 错误状态视图
  @BuilderParam viewNoNetwork?: () => void  // 无网络视图

  // 配置相关
  public config: KdRefreshLayoutConfig = new KdRefreshLayoutConfig() // 下拉刷新配置

  @State topLoading: boolean = true;
  @State moreLoading: boolean = true;


  // 主要构建方法
  build() {
    RefreshLayout({
      scroller: this.scroller,
      webviewController: this.webviewController,
      controller: this.controller,
      config: this.config,
      headerView: () => {
        this.defHeaderView()
      },
      onCanPullRefresh: () => {
        if(!this.scroller) return false;
        if (!this.scroller.currentOffset()) return true;
        return this.scroller.currentOffset().yOffset <= 0
      },
      onCanPullLoad: () => {
        if (!this.config || !this.scroller || !this.config.loadMoreEnable) return false
        return this.scroller.isAtEnd()
      },
      onRefresh: () => {
        this.onRefresh()
      },
      onLoad: () => {
        this.onLoad()
      },
      contentView: () => {
        this.contentView()
      },
      loadView: () => {
        this.defFooterView()
      },
      noMoreView: () => {
        this.defFooterNoMoreView()
      },
      onPullListener: (KdPullDown: KdPullDown) => {
        this.status = KdPullDown.status
        this.onPullListener?.(KdPullDown)
        if (this.config.pullHeaderHeightRefresh <= KdPullDown.headerViewSize) {
          this.config.pullHeaderHeightRefresh = KdPullDown.headerViewSize * 1.5
        }
        if (this.config.pullFooterHeightLoad <= KdPullDown.footerViewSize) {
          this.config.pullFooterHeightLoad = KdPullDown.footerViewSize * 1.1
        }
      },
      viewLoading:this.viewLoading,
      viewEmpty:this.viewEmpty,
      viewError:this.viewError,
      viewNoNetwork:this.viewNoNetwork
    }).clip(true)
  }

  // 默认视图构建器
  @Builder
  defHeaderView() {
    Column(){
      KdDotLoadingView({ loading: $topLoading })
    }.height(50).width("100%")
  }

  @Builder
  defFooterView() {
    Column(){
      KdDotLoadingView({ loading: $moreLoading })
    }.height(50).width("100%")

  }

  @Builder
  defFooterNoMoreView() {
    Text("到底啦~")
      .textAlign(TextAlign.Center)
      .height(50)
      .width("100%")
      .fontColor("#666666")
  }
}

