<template>
    <v-card class="jsonform">
        <json-forms 
            :data="data"
            :schema="schema"
            :uischema="uischema"
            :renderers="renderers"
            @change="onChange"
        />
    </v-card>
</template>
<script>
import { JsonForms } from '@jsonforms/vue2';
import { vuetifyRenderers } from '@jsonforms/vue2-vuetify';
import { defineComponent } from '@vue/composition-api';

const renderers = [
  ...vuetifyRenderers,
  // here you can add custom renderers
];

export default defineComponent({
  name: 'app',
  components: {
    JsonForms,
  },
  props: ['data', 'schema', 'uischema'],
  data() {
    return {
      renderers: Object.freeze(renderers)
    };
  },
  methods: {
    onChange(event) {
      if (event.errors.length == 0) {
        // Only emit input when the form data is valid
        this.$emit('input', event.data);
      }
    },
  },
});
</script>

<style scoped>
.jsonform {
    padding: 1em;
}
</style>

<style>
.jsonform .v-card {
    margin: 1em 0 0.5em 0;
}
</style>