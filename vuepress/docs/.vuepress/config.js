import {defaultTheme} from '@vuepress/theme-default'
import {defineUserConfig} from 'vuepress/cli'
import {viteBundler} from '@vuepress/bundler-vite'
import {searchPlugin} from '@vuepress/plugin-search'

export default defineUserConfig({
    lang: 'en-US',
    port: '12999',
    plugins: [
        searchPlugin({
            locales: {
                '/': {
                    placeholder: '搜索文档',
                },
            }
        }),
    ],
    title: 'ruoyi-wvp',
    description: '为简化对接监控而生',
    theme: defaultTheme({
        logo: '/images/logo/logo.png',

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
                    },
                    {
                        text: '视频教程',
                        link: '/doc/spjc'
                    },
                    {
                        text: '更新日志',
                        link: '/doc/gxrz'
                    }
                ]
            },
            {
                text: '功能和使用',
                children: [
                    {
                        text: '接入设备',
                        link: '/doc/device'
                    },
                ]
            },
            {
                text: '其他',
                children: [
                    {
                        text: '常见问题',
                        link: '/doc/faq'
                    },
                    {
                        text: '捐赠支持',
                        link: '/doc/donate'
                    },
                ]
            }
        ]
    }),
    bundler: viteBundler(),
})
