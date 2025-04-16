import comp from "C:/Users/17988/Desktop/ruoyi/RuoYi-Wvp/vuepress/docs/.vuepress/.temp/pages/get-started.html.vue"
const data = JSON.parse("{\"path\":\"/get-started.html\",\"title\":\"Get Started\",\"lang\":\"en-US\",\"frontmatter\":{},\"git\":{\"updatedTime\":1744792144000,\"contributors\":[{\"name\":\"fengcheng\",\"username\":\"\",\"email\":\"2929004360@qq.com\",\"commits\":1}],\"changelog\":[{\"hash\":\"523782997b11cd935d2edad45314a3be3c7e47d0\",\"time\":1744792144000,\"email\":\"2929004360@qq.com\",\"author\":\"fengcheng\",\"message\":\"添加文档\"}]},\"filePathRelative\":\"get-started.md\"}")
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
