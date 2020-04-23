<template>
  <div id="login">
    <div class="container">
      <section class="section">
        <div class="columns is-multiline">
          <div class="column is-3-desktop is-4-tablet is-offset-5 is-offset-4-tablet">
            <p class="title has-text-centered">
              Open Trello
            </p>
            <div class="card">
              <form v-on:submit.prevent.stop="onSubmit">
                <div class="column is-12">
                  <p class="subtitle has-text-weight-bold has-text-centered has-text-grey-dark">
                    Fazer login no Open Trello
                  </p>
                </div>
                <div class="column is-12">
                  <div class="field">
                    <div class="control">
                      <input class="input" type="email" id="email" placeholder="Insert your email" v-model="email">
                    </div>
                  </div>
                </div>
                <div class="column is-12">
                  <div class="field">
                    <div class="control">
                      <input class="input" type="password" id="password" placeholder="Insert your password" v-model="password">
                    </div>
                  </div>
                </div>
                <div class="column is-12">
                  <button class="button is-success is-fullwidth">
                    Entrar
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
  import toastr from 'toastr/toastr';

  export default {
    data: function() {
      return {
        email: '',
        password: ''
      }
    },
    beforeCreate: function() {
      let token = localStorage.getItem('token');
      if(token != null) {
        this.$router.push('/');
      }
    },
    methods: {
      onSubmit: function () {
        this.$http.post('/api/v1/sessions', {
          users: {
            email: this.email,
            password: this.password
          }
        }).then(response => {
          if(response.status == 201) {
            toastr.success('You are signed in');
            localStorage.setItem('token', response.body.authentication_token);
            this.$router.push('/'); 
          }
        }, response => {
          toastr.error('Invalid email or password');
        });
      }
    }
  }
</script>
