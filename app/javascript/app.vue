<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
    import Vue from 'vue';
    import VueRouter from 'vue-router';

    Vue.use(VueRouter);
    export default {
      data: function () {
        return {
        }
      }
    }
</script>

