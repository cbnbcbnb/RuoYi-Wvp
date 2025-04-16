export const SEARCH_INDEX = [
  {
    "title": "Get Started",
    "headers": [
      {
        "level": 2,
        "title": "Pages",
        "slug": "pages",
        "link": "#pages",
        "children": []
      },
      {
        "level": 2,
        "title": "Content",
        "slug": "content",
        "link": "#content",
        "children": []
      },
      {
        "level": 2,
        "title": "Configuration",
        "slug": "configuration",
        "link": "#configuration",
        "children": []
      },
      {
        "level": 2,
        "title": "Layouts and customization",
        "slug": "layouts-and-customization",
        "link": "#layouts-and-customization",
        "children": []
      }
    ],
    "path": "/get-started.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "首页",
    "headers": [],
    "path": "/",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "接入设备",
    "headers": [
      {
        "level": 2,
        "title": "1.国标28181设备接入",
        "slug": "_1-国标28181设备接入",
        "link": "#_1-国标28181设备接入",
        "children": []
      },
      {
        "level": 2,
        "title": "大华摄像头配置信息",
        "slug": "大华摄像头配置信息",
        "link": "#大华摄像头配置信息",
        "children": []
      },
      {
        "level": 2,
        "title": "大华NVR配置信息",
        "slug": "大华nvr配置信息",
        "link": "#大华nvr配置信息",
        "children": []
      },
      {
        "level": 2,
        "title": "宇视科技配置信息",
        "slug": "宇视科技配置信息",
        "link": "#宇视科技配置信息",
        "children": []
      },
      {
        "level": 2,
        "title": "水星摄像头配置信息",
        "slug": "水星摄像头配置信息",
        "link": "#水星摄像头配置信息",
        "children": []
      },
      {
        "level": 2,
        "title": "海康摄像头配置信息",
        "slug": "海康摄像头配置信息",
        "link": "#海康摄像头配置信息",
        "children": []
      },
      {
        "level": 2,
        "title": "直播推流设备",
        "slug": "直播推流设备",
        "link": "#直播推流设备",
        "children": []
      },
      {
        "level": 2,
        "title": "接入非国标IPC设备或者其他流地址形式的设备",
        "slug": "接入非国标ipc设备或者其他流地址形式的设备",
        "link": "#接入非国标ipc设备或者其他流地址形式的设备",
        "children": []
      }
    ],
    "path": "/doc/device.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "捐赠支持",
    "headers": [],
    "path": "/doc/donate.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "",
    "headers": [],
    "path": "/doc/faq.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "更新日志",
    "headers": [
      {
        "level": 2,
        "title": "v1.0.0",
        "slug": "v1-0-0",
        "link": "#v1-0-0",
        "children": []
      }
    ],
    "path": "/doc/gxrz.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "介绍",
    "headers": [],
    "path": "/doc/",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "快速开始",
    "headers": [
      {
        "level": 2,
        "title": "1.准备工作",
        "slug": "_1-准备工作",
        "link": "#_1-准备工作",
        "children": []
      },
      {
        "level": 2,
        "title": "2.运行ZLMediaKit",
        "slug": "_2-运行zlmediakit",
        "link": "#_2-运行zlmediakit",
        "children": []
      },
      {
        "level": 2,
        "title": "3.修改配置文件",
        "slug": "_3-修改配置文件",
        "link": "#_3-修改配置文件",
        "children": []
      },
      {
        "level": 2,
        "title": "4.运行后端系统",
        "slug": "_4-运行后端系统",
        "link": "#_4-运行后端系统",
        "children": []
      },
      {
        "level": 2,
        "title": "5.运行前端系统",
        "slug": "_5-运行前端系统",
        "link": "#_5-运行前端系统",
        "children": []
      },
      {
        "level": 2,
        "title": "6.遇到问题",
        "slug": "_6-遇到问题",
        "link": "#_6-遇到问题",
        "children": []
      }
    ],
    "path": "/doc/kslj.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "",
    "headers": [],
    "path": "/doc/spjc.html",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "",
    "headers": [],
    "path": "/404.html",
    "pathLocale": "/",
    "extraFields": []
  }
]

if (import.meta.webpackHot) {
  import.meta.webpackHot.accept()
  if (__VUE_HMR_RUNTIME__.updateSearchIndex) {
    __VUE_HMR_RUNTIME__.updateSearchIndex(searchIndex)
  }
}

if (import.meta.hot) {
  import.meta.hot.accept(({ searchIndex }) => {
    __VUE_HMR_RUNTIME__.updateSearchIndex(searchIndex)
  })
}
