<template>
  <div id="home">
    <div class="container">
      {{ this.projects }}
    </div>
  </div>
</template>

 <script>
  import toastr from 'toastr/toastr';

  export default {
    data() {
      return {
        projects: [],
        token: localStorage.getItem('token'),
      }
    },
    created: function() {
      this.$http.get('/api/v1/projects', {
        headers: { token: this.token }
      }).then(response => {
        if(response.status == 200) {
          console.log(response.body)
          this.projects = response.body
        }
      }, response => {
        toastr.error('Something got wrong');
      });
    }
  }     
</script>
