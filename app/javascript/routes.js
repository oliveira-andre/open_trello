import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import LoginIndex from './components/login/index';
import HomeIndex from './components/home/index';
import ProjectIndex from './components/project/index';

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/login', component: LoginIndex },
    { path: '/', component: HomeIndex },
    { path: '/projects/:title', component: ProjectIndex },
  ],
});
