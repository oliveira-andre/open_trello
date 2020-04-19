<template>
  <div id="home">
    <div class="container">
      <section class="section">
        <div class="columns is-multiline">
          <div class="column is-2" v-for="(project, index) in projects" :key="index">
            <div class="box">
              <div class="media-content">
                <router-link class="title is-size-5" :to="`/projects/${project.title}`">
                  {{ project.title }}
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

 <script>
  import toastr from 'toastr/toastr';
  import VueRouter from 'vue-router';

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
          this.projects = response.body
        }
      }, response => {
        toastr.error('Something got wrong');
      });
    },
  }     
</script>
