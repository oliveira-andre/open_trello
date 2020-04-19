<template>
  <div id="project">
    <div class="columns">
      <div class="column is-3" v-for="list in lists">
        <div class="card">
          <div class="card-content">
            <p class="title is-size-5">{{ list.title }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data: function() {
      return {
        token: localStorage.getItem('token'),
        lists: [],
      }
    },
    created: function() {
      this.$http.get(`/api/v1/projects/${this.$route.params.title}/lists`, { 
        headers: { token: this.token }
      }).then(response => {
        this.lists = response.body;
      }, response => { toastr.error('May accour a problem') });
    }
  }
</script>
