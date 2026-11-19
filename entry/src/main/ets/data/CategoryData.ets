import { CategoryItem } from './CategoryItem'

export const CATEGORY_DATA: CategoryItem[] = [
  {
    icon: $r('app.media.icon_category_theme_style'),
    title: "主题",
    components: [
      {
        title: "样式设置",
        url: "KdThemeDemoPage"
      }
    ]
  },
  {
    icon: $r('app.media.icon_category_view'),
    title: "视图",
    components: [
      {
        title: "标签Tag",
        url: "KdTagEntryPage"
      },
      {
        title: "富文本RichText",
        url: 'KdRichTextExamplePage'
      },
      {
        title: "图片浏览Gallery",
        url: 'KdGalleryExamplePage'
      },
      {
        title: "图片概览Summary",
        url: 'KdSummaryExamplePage'
      },
      {
        title: "下拉刷新PullToRefresh",
        url: 'KdPullableExamplePage'
      },
      {
        title: "步骤条StepBar",
        url: 'KdStepLineExamplePage'
      },
      {
        title: "筛选FilterBar",
        url: 'KdFilterBarExampleEntryPage'
      },
      {
        title: "日历Calendar",
        url: 'KdCalendarExamplePage'
      },
      {
        title: "引导Guide",
        url: 'KdGuideExamplePage'
      },
      {
        title: "可折叠文本ExpandableText",
        url: 'KdExpandableTextEntryPage'
      },
      {
        title: "自动换行布局AutoLineGrid",
        url: 'KdAutoLineGridEntryPage'
      }
    ]
  },
  {
    icon: $r('app.media.icon_category_form'),
    title: "表单",
    components: [
      {
        title: "单选/多选选择器DataPicker",
        url: 'KdDataPickerEntryPage'
      },
      {
        title: "图片选择ImagePicker",
        url: 'KdImagePickerExamplePage'
      },
      {
        title: "搜索框SearchBar",
        url: 'KdSearchExamplePage'
      }
    ]
  },
  {
    icon: $r('app.media.icon_category_operatefeedback'),
    title: "操作反馈",
    components: [
      {
        title: "吐司Toast",
        url: 'KdToastEntryPage'
      },
      {
        title: "加载框Loading",
        url: 'KdLoadingEntryPage'
      },
      {
        title: "对话框Dialog",
        url: 'KdDialogEntryPage'
      }
    ]
  },
  {
    icon: $r('app.media.icon_category_navigation'),
    title: "导航",
    components: [
      {
        title: "导航栏NavigationBar",
        url: 'KdNavigationBarPageExample'
      },
      {
        title: "选项卡Tabs",
        url: "KdTabExamplePage"
      },
      {
        title: "底部导航BottomBar",
        url: "KdBottomBarExamplePage"
      },
      {
        title: "锚点Anchor",
        url: 'KdAnchorExamplePage'
      },
    ]
  },
  {
    icon: $r('app.media.icon_category_chart'),
    title: "图表",
    components: [
      {
        title: "柱状图ProgressBar",
        url: "KdProgressBarChartExamplePage"
      },
      {
        title: "折线图BrokenLine",
        url: "KdLineChartExamplePage"
      },
      {
        title: "雷达图Radar",
        url: "KdRadarChartExamplePage"
      },
      {
        title: "环状图Doughnut",
        url: "KdPieChartExamplePage"
      },
      {
        title: "漏斗图Funnel",
        url: 'KdFunnelChartExamplePage'
      }
    ]
  }
]