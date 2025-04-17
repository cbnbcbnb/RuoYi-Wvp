import comp from "C:/Users/17988/Desktop/ruoyi/RuoYi-Wvp/vuepress/docs/.vuepress/.temp/pages/doc/gxrz.html.vue"
const data = JSON.parse("{\"path\":\"/doc/gxrz.html\",\"title\":\"更新日志\",\"lang\":\"en-US\",\"frontmatter\":{},\"git\":{\"updatedTime\":1744797587000,\"contributors\":[{\"name\":\"fengcheng\",\"username\":\"\",\"email\":\"2929004360@qq.com\",\"commits\":1}],\"changelog\":[{\"hash\":\"8988deadbb5cfb6e6f692d740e042e10ea8bc39f\",\"time\":1744797587000,\"email\":\"2929004360@qq.com\",\"author\":\"fengcheng\",\"message\":\"添加文档\"}]},\"filePathRelative\":\"doc/gxrz.md\"}")
export { comp, data }

if (import.meta.webpackHot) {
  import.meta.webpackHot.accept()
  if (__VUE_HMR_RUNTIME__.updatePageData) {
    __VUE_HMR_RUNTIME__.updatePageData(data)
  }
}

if (import.meta.hot) {
  import.meta.hot.accept(({ data }) => {
    __VUE_HMR_RUNTIME__.updatePageData(data)
  })
}
