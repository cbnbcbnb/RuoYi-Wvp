export const themeData = JSON.parse("{\"logo\":\"/images/logo/logo.png\",\"navbar\":[\"/\",{\"text\":\"文档\",\"link\":\"/doc/index\"}],\"sidebar\":[{\"text\":\"文档\",\"children\":[{\"text\":\"介绍\",\"link\":\"/doc/index\"},{\"text\":\"快速开始\",\"link\":\"/doc/kslj\"},{\"text\":\"视频教程\",\"link\":\"/doc/spjc\"},{\"text\":\"更新日志\",\"link\":\"/doc/gxrz\"}]},{\"text\":\"功能和使用\",\"children\":[{\"text\":\"接入设备\",\"link\":\"/doc/device\"}]},{\"text\":\"其他\",\"children\":[{\"text\":\"常见问题\",\"link\":\"/doc/faq\"},{\"text\":\"捐赠支持\",\"link\":\"/doc/donate\"}]}],\"locales\":{\"/\":{\"selectLanguageName\":\"English\"}},\"colorMode\":\"auto\",\"colorModeSwitch\":true,\"repo\":null,\"selectLanguageText\":\"Languages\",\"selectLanguageAriaLabel\":\"Select language\",\"sidebarDepth\":2,\"editLink\":true,\"editLinkText\":\"Edit this page\",\"lastUpdated\":true,\"contributors\":true,\"contributorsText\":\"Contributors\",\"notFound\":[\"There's nothing here.\",\"How did we get here?\",\"That's a Four-Oh-Four.\",\"Looks like we've got some broken links.\"],\"backToHome\":\"Take me home\",\"openInNewWindow\":\"open in new window\",\"toggleColorMode\":\"toggle color mode\",\"toggleSidebar\":\"toggle sidebar\"}")

if (import.meta.webpackHot) {
  import.meta.webpackHot.accept()
  if (__VUE_HMR_RUNTIME__.updateThemeData) {
    __VUE_HMR_RUNTIME__.updateThemeData(themeData)
  }
}

if (import.meta.hot) {
  import.meta.hot.accept(({ themeData }) => {
    __VUE_HMR_RUNTIME__.updateThemeData(themeData)
  })
}
