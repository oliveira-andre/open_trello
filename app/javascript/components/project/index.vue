<template>
  <div id="project">
    <div class="columns">
      <draggable v-model="lists" ghost-class="ghost" draggable=".column" class="draggable-column">
      <div class="column is-3" v-for="list in lists">
        <div class="card has-background-grey-darker">
          <div class="card-header">
            <p class="card-header-title">{{ list.title }}</p>
          </div>
          <div class="card-content">
            <draggable v-model="list.tasks" ghost-class="ghost" draggable=".draggable-card">
            <div class="card draggable-card has-background-grey-dark" v-for="task in list.tasks" v-on:click="showDescription">
              <div class="card-header">
                <p class="card-header-title" :data-id="task.id" :data-description="task.description" :data-title="task.title" :data-list-id="list.id" :data-list-title="list.title">
                {{ task.title }}
                </p>
              </div>
            </div>
            </draggable>
            <button class="button is-primary is-outlined is-fullwidth" v-on:click="addTask" :data-list-id="list.id">
              New task
            </button>
          </div>
        </div>
      </div>
      </draggable>
      <div class="column is-3"> 
        <button class="button is-primary is-fullwidth" v-on:click="addList">
          New list
        </button>
      </div>
    </div>
  <div class="modal" id="description-modal">
    <div class="modal-background" v-on:click="closeModal"></div>
    <div class="modal-card">
      <section class="modal-card-header has-background-grey-darker">
        <input type="text" class="input" v-model="currentTitle" v-on:keyup="saveTitle">
      </section>
      <section class="modal-card-body has-background-grey-darker">
        <div class="columns">
          <div class="column is-8">
            <editor-menu-bar :editor="descriptionEditor" v-slot="{ commands, isActive }">
              <div>
                <button :class="{ 'is-active': isActive.bold() }" @click="commands.bold">
                  Bold
                </button>
                <button :class="{ 'is-active': isActive.italic() }" @click="commands.italic">
                  Italic
                </button>
              </div>
            </editor-menu-bar>
            <editor-content :editor="descriptionEditor" />
          </div>
          <div class="column is-4">
            <div class="select">
              <select v-model="currentListId" v-on:change="updateList">
                <option :value="list.id" v-for="list in lists" :checked="currentListId == list.id">
                  {{ list.title }}
                </option>
              </select>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
  </div>
</template>

<script>
import draggable from 'vuedraggable';
import { Editor, EditorContent, EditorMenuBar } from 'tiptap';
import {
  Bold,
  Italic,
} from 'tiptap-extensions';
import toastr from 'toastr/toastr';

  export default {
    data: function() {
      return {
        token: localStorage.getItem('token'),
        lists: [],
        currentDescription: '',
        currentTitle: '',
        currentListId: '',
        currentTaskId: '',
        descriptionEditor: null,
      }
    },
    components: {
      draggable,
      EditorMenuBar,
      EditorContent,
    },
    beforeCreate: function() {
      let token = localStorage.getItem('token');
      if(token == null) {
        this.$router.push('/login');
      }
    },
    created: function() {
      const vm = this;
      vm.$http.get(`/api/v1/projects/${this.$route.params.title}/lists`, { 
        headers: { token: this.token }
      }).then(response => {
        this.lists = response.body;
      }, response => { toastr.error('May accour a problem') });
      this.descriptionEditor = new Editor({extensions: [
        new Bold(),
        new Italic(),
      ],
        onUpdate: function(event) {
          setTimeout(function(){
          vm.$http.put(
            `/api/v1/projects/${vm.currentTitle}/lists/${vm.currentListId}/tasks/${vm.currentTaskId}`, {}, {
              headers: { token: vm.token },
              tasks: {
                description: event.getHTML(),
              }
            }).then(response => {
              if(response.status == 202) {
                toastr.success('Saved!');
              }
            }, response => { toastr.error('May accour a problem') });
          }, 1000)
        },
      });
    },
    methods: {
      showDescription: function() {
        this.descriptionEditor.setContent(event.target.dataset.description);
        this.currentTaskId = event.target.dataset.id;
        this.currentDescription = event.target.dataset.description;
        this.currentTitle = event.target.dataset.title;
        this.currentListId = event.target.dataset.listId;
        let modal = document.getElementById('description-modal');
        modal.classList.add('is-active');
      },
      closeModal: function() { 
        Turbolinks.visit(`/projects/${this.$route.params.title}`);
      },
      updateList: function() { 
        this.$http.put(
          `/api/v1/projects/${this.currentTitle}/lists/${this.currentListId}/tasks/${this.currentTaskId}`, {}, {
            headers: { token: this.token },
            tasks: {
              list_id: this.currentListId,
            }
          }).then(response => {
            if(response.status == 202) {
              toastr.success('Moved with success');
            }
          });
      },
      saveTitle: function() { 
        const vm = this;
        setTimeout(function(){
          vm.$http.put(
            `/api/v1/projects/${vm.currentTitle}/lists/${vm.currentListId}/tasks/${vm.currentTaskId}`, {}, {
              headers: { token: this.token },
              tasks: {
                title: vm.currentTitle
              }
            }).then(response => {
              if(response.status == 202) {
                toastr.success('Saved!');
              }
            }, response => { toastr.error('May accour a problem') });
          }, 1000)
      },
      addTask: function() {
        let listId = event.target.dataset.listId;
        this.$http.post(
          `/api/v1/projects/${this.$route.params.title}/lists/${listId}/tasks`, {}, {
            headers: { token: this.token },
          }).then(response => {
            if(response.status == 201) {
              Turbolinks.visit(`/projects/${this.$route.params.title}`);
            }
        });
      },
      addList: function() { 
        this.$http.post(
          `/api/v1/projects/${this.$route.params.title}/lists`, {}, {
            headers: { token: this.token },
        }).then(response => {
            if(response.status == 201) {
              Turbolinks.visit(`/projects/${this.$route.params.title}`);
            }
        });
      },
    },
  }
  </script>
