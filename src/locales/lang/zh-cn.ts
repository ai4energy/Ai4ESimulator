import type { LocaleMessages } from 'vue-i18n';

const locale: LocaleMessages<I18nType.Schema> = {
  message: {
    system: {
      title: 'Ai4ESimulator'
    },
    routes: {
      dashboard: {
        dashboard: '仿真绘图页',
        analysis: '建模页',
        workbench: '绘图页'
      },
      about: {
        about: '关于'
      }
    }
  }
};

export default locale;
