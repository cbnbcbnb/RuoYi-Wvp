import { CodeTabs } from "C:/Users/17988/Desktop/ruoyi/RuoYi-Wvp/vuepress/node_modules/@vuepress/plugin-markdown-tab/lib/client/components/CodeTabs.js";
import { Tabs } from "C:/Users/17988/Desktop/ruoyi/RuoYi-Wvp/vuepress/node_modules/@vuepress/plugin-markdown-tab/lib/client/components/Tabs.js";
import "C:/Users/17988/Desktop/ruoyi/RuoYi-Wvp/vuepress/node_modules/@vuepress/plugin-markdown-tab/lib/client/styles/vars.css";

export default {
  enhance: ({ app }) => {
    app.component("CodeTabs", CodeTabs);
    app.component("Tabs", Tabs);
  },
};
