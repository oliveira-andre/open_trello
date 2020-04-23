<template>
  <nav class="navbar black-background" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item title is-size-5 has-text-centered" href="/">
        Open Trello
      </a>
      <button class="button is-danger is-small" v-on:click.stop.prevent="logout()">Logout</button>
    </div>
  </nav>
</template>

<script>
  export default {
    data () {
      return {
      }
    },
    methods: {
      logout: function() {
        localStorage.clear();
        Turbolinks.visit('/login');
      }
    }
  }
</script>
