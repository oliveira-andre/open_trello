require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';
import TurbolinksAdapter from 'vue-turbolinks';
import VueResource from 'vue-resource';
import VueRouter from 'vue-router';

Vue.use(TurbolinksAdapter);
Vue.use(VueResource);
Vue.use(VueRouter);

import router from '../routes';

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const app = new Vue({
    el: '#app',
    router: router,
    render: h => h(App)
  });
});
