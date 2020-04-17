import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import HomeIndex from './components/home/index';

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: HomeIndex },
  ],
});
