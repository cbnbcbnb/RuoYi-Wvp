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
    "title": "介绍",
    "headers": [],
    "path": "/doc/",
    "pathLocale": "/",
    "extraFields": []
  },
  {
    "title": "1",
    "headers": [],
    "path": "/doc/kslj.html",
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
