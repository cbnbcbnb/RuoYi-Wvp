import {defaultTheme} from '@vuepress/theme-default'
import {defineUserConfig} from 'vuepress/cli'
import {viteBundler} from '@vuepress/bundler-vite'
import {searchPlugin} from '@vuepress/plugin-search'

export default defineUserConfig({
    lang: 'en-US',

    title: 'ruoyi-wvp',
    description: '为简化对接监控而生',

    theme: defaultTheme({
        logo: 'https://vuejs.press/images/hero.png',

        navbar: ['/', {
            text: '文档',
            link: '/doc/index',
        }],
        sidebar: [
            {
                text: '文档',
                children: [
                    {
                        text: '介绍',
                        link: '/doc/index'
                    },
                    {
                        text: '快速开始',
                        link: '/doc/kslj'
                    }
                ]
            }
        ]
    }),

    plugins: [
        searchPlugin({
            locales: {
                '/': {
                    placeholder: '搜索文档',
                },
            }
        }),
    ],

    bundler: viteBundler(),
})
