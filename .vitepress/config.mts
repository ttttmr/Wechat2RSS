import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "微信公众号转RSS",
  description: "微信公众号转RSS服务",
  sitemap: {
    hostname: 'https://wechat2rss.xlab.app'
  },
  lastUpdated: true,
  themeConfig: {
    editLink: {
      pattern: 'https://github.com/ttttmr/Wechat2RSS/edit/master/:path',
      text: 'Edit this page on GitHub'
    },
    logo: '/favicon.ico',
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "免费公众号", link: "/list/" },
      { text: "私有部署", link: "/deploy/" },
      { text: "博客", link: "https://blog.xlab.app" },
    ],

    sidebar: {
      '/list/': [
        {
          text: '免费公众号',
          items: [
            { text: '合集订阅', link: '/list/' },
            { text: '完整列表', link: '/list/list' },
          ]
        },
      ],
      '/deploy/': [
        {
          text: '私有部署',
          items: [
            { text: '定价', link: '/deploy/' },
            { text: '使用指南', link: '/deploy/guide' },
            { text: '参数配置', link: '/deploy/config' },
            { text: 'API参考', link: '/deploy/api' },
            { text: '常见问题', link: '/deploy/qa' },
            { text: '发布记录', link: '/deploy/changelog' },
          ]
        }
      ]
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ttttmr/wechat2rss' }
    ]
  }
})
