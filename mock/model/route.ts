export const routeModel: Record<Auth.RoleType, AuthRoute.Route[]> = {
  super: [
    {
      name: 'dashboard',
      path: '/dashboard',
      component: 'basic',
      children: [
        {
          name: 'dashboard_analysis',
          path: '/dashboard/analysis',
          component: 'self',
          meta: {
            title: '建模页',
            requiresAuth: true,
            icon: 'icon-park-outline:analysis'
          }
        },
        {
          name: 'dashboard_workbench',
          path: '/dashboard/workbench',
          component: 'self',
          meta: {
            title: '绘图页',
            requiresAuth: true,
            icon: 'icon-park-outline:workbench'
          }
        }
      ],
      meta: {
        title: '仿真工作台',
        icon: 'mdi:monitor-dashboard',
        order: 1
      }
    },
    {
      name: 'document',
      path: '/document',
      component: 'basic',
      children: [
        {
          name: 'document_project',
          path: '/document/project',
          component: 'self',
          meta: {
            title: '项目文档',
            requiresAuth: true,
            localIcon: 'logo'
          }
        },
        {
          name: 'document_ai4edocs',
          path: '/document/ai4edocs',
          component: 'self',
          meta: {
            title: 'Ai4E基础文档',
            requiresAuth: true,
            localIcon: 'ai4edocs'
          }
        },
        {
          name: 'document_ai4emetapse',
          path: '/document/ai4emetapse',
          component: 'self',
          meta: {
            title: '解析器文档',
            requiresAuth: true,
            localIcon: 'ai4emetapse'
          }
        },
        {
          name: 'document_ai4eserver',
          path: '/document/ai4eserver',
          component: 'self',
          meta: {
            title: '后端框架文档',
            requiresAuth: true,
            localIcon: 'ai4eserver'
          }
        },
        {
          name: 'document_ai4ecomponentlib',
          path: '/document/ai4ecomponentlib',
          component: 'self',
          meta: {
            title: '组件库文档',
            requiresAuth: true,
            localIcon: 'ai4ecomponentlib'
          }
        },
        {
          name: 'document_vue',
          path: '/document/vue',
          component: 'self',
          meta: {
            title: 'vue文档',
            requiresAuth: true,
            icon: 'logos:vue'
          }
        },
        {
          name: 'document_naive',
          path: '/document/naive',
          component: 'self',
          meta: {
            title: 'naive文档',
            requiresAuth: true,
            icon: 'logos:naiveui'
          }
        }
      ],
      meta: {
        title: '文档',
        icon: 'mdi:file-document-multiple-outline',
        order: 2
      }
    },
    {
      name: 'about',
      path: '/about',
      component: 'self',
      meta: {
        title: '关于',
        requiresAuth: true,
        singleLayout: 'basic',
        icon: 'fluent:book-information-24-regular',
        order: 10
      }
    }
  ]
};
