<template>
  <div>
    <Header v-if="loggedIn"/>
      <div>
        <router-view></router-view>
      </div>
  </div>
</template>

<script>
    import Vue from 'vue';
    import VueRouter from 'vue-router';
    import Header from './components/header/index';

    Vue.use(VueRouter);
    export default {
      data: function () {
        return {
         loggedIn: localStorage.getItem('token') != null
        }
      },
      created: function(){ 
         this.loggedIn = (localStorage.getItem('token') != null);
      },
      updated: function() {
         this.loggedIn = (localStorage.getItem('token') != null);
      },
      components: {
        'Header': Header,
      }
    }
</script>

