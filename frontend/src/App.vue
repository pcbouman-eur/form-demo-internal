<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div class="d-flex align-center">
        Form Demo
      </div>
      <v-spacer></v-spacer>
    </v-app-bar>

    <v-main>
      <v-container class="compact">
        <v-col>
          <v-row>
            <v-select v-if="courses != null" outlined label="Choose a course" :items="courses" @change="changeCourse" />
          </v-row>
          <v-row>
            <v-select v-if="workflows != null" outlined label="Choose a workflow" :items="workflows" @change="changeWorkflow" />
          </v-row>
          <v-row>
            <v-select v-if="years != null" outlined label="Choose a year" :items="years" @change="changeYear" />
          </v-row>
          <v-row v-if="data != null">
            <v-card>
              <VuetifyForm :data="data" :schema="schema" @input="changeForm" />
            </v-card>
          </v-row>
        </v-col>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import VuetifyForm from './components/VuetifyForm';

export default {
  name: 'App',

  components: {
    VuetifyForm,
  },
  mounted() {
    fetch('/api/courses')
    .then(resp => resp.ok ? resp.json() : null)
    .then(json => this.courses = json);
  },
  data: () => ({
    courses: null,
    course: null,
    workflows: null,
    workflow: null,
    years: null,
    year: null,
    data: null,
    schema: null,
    uischema: null
  }),
  methods: {
    changeCourse(newCourse) {
      if (this.course != newCourse) {
        this.changeWorkflow(null);
      }
      this.course = newCourse;
      this.workflows = null;
      if (this.course != null) {
        fetch(`/api/courses/${this.course}/workflows`)
        .then(resp => resp.ok ? resp.json() : null)
        .then(json => this.workflows = json);
      }
    },
    changeWorkflow(newWorkflow) {
      if (this.workflow != newWorkflow) {
        this.changeYear(null);
      }
      this.workflow = newWorkflow;
      this.years = null;
      if (this.workflow != null) {
        fetch(`/api/courses/${this.course}/workflows/${this.workflow}/years`)
        .then(resp => resp.ok ? resp.json() : null)
        .then(json => this.years = json);
      }
    },
    changeYear(newYear) {
      if (this.year != newYear) {
        this.changeFormData(null);
      }
      this.year = newYear;
      if (newYear != null) {
        fetch(`/api/courses/${this.course}/workflows/${this.workflow}/years/${this.year}/formdata`)
        .then(resp => resp.ok ? resp.json() : null)
        .then(json => this.changeFormData(json));
      }
    },
    changeFormData(newForm) {
      if (newForm == null) {
        this.data = null;
        this.schema = null;
        this.uischema = null;
      }
      else {
        this.data = newForm.data;
        this.schema = newForm.schema;
        this.uischema = newForm.schema;
      }
    },
    changeForm(newData) {
      fetch(`/api/courses/${this.course}/workflows/${this.workflow}/years/${this.year}/store`, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(newData)
      })
    }
  }
};
</script>
<style scoped>
.compact {
  max-width: 60em;
}
</style>