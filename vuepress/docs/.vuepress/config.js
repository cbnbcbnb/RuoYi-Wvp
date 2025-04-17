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

// {
//     text: '演示',
//         link: 'http://wvp.ruoyi.vip:8080/doc'
// },

    theme: defaultTheme({
        logo: '/images/logo/logo.png',

        navbar: ['/', {
            text: '文档',
            link: '/doc/index',
        }, {
            text: '💖赞助💖',
            link: '/donate'
        }, {
            text: '源码',
            children: [
                {
                    text: 'gitee',
                    link: 'https://gitee.com/chenjianhua/ruoyi-wvp'
                },
                {
                    text: 'github',
                    link: 'https://gitee.com/chenjianhua/ruoyi-wvp'
                },
                {
                    text: 'gitcode',
                    link: 'https://gitee.com/chenjianhua/ruoyi-wvp'
                },
            ]
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
                    {
                        text: '国标设备',
                        link: '/doc/device_use'
                    },
                    {
                        text: '推流列表',
                        link: '/doc/push'
                    },
                    {
                        text: '拉流代理',
                        link: '/doc/proxy'
                    },
                    {
                        text: '云端录像',
                        link: '/doc/record'
                    },
                    {
                        text: '节点管理',
                        link: '/doc/node'
                    },
                    {
                        text: '通道管理',
                        link: '/doc/channel'
                    },
                    {
                        text: '国标级联',
                        link: '/doc/platform'
                    },
                    {
                        text: '录像计划',
                        link: '/doc/recordPlan'
                    },
                    {
                        text: '行政分组',
                        link: '/doc/administrativeGrouping'
                    },
                    {
                        text: '分配监控',
                        link: '/doc/wvpLive'
                    },
                ]
            },
            {
                text: 'onvif协议',
                children: [
                    {
                        text: '添加摄像头',
                        link: '/doc/onvifAddCamera'
                    },
                    {
                        text: '摄像头管理',
                        link: '/doc/onvifCameraManage'
                    },
                ]
            },
            {
                text: 'ISUP协议（后续支持）',
                children: [

                ]
            },
            {
                text: 'RTMP协议（后续支持）',
                children: [

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
                    {
                        text: '免责声明',
                        link: '/doc/disclaimers'
                    },
                    {
                        text: '反馈bug',
                        link: '/doc/bug'
                    },
                    {
                        text: '如何参与开发',
                        link: '/doc/development'
                    },
                ]
            },
        ]
    }),
    bundler: viteBundler(),
    head: [
        [
            'link', { rel: 'icon', href: '/images/logo/logo.png' }
        ]
    ],
})
