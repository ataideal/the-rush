<template>
  <v-container>
    <scores-table/>
  </v-container>

</template>

<script>
// @ is an alias to /src
import ScoresTable from "@/components/ScoresTable"

export default {
  name: 'Home',
  components: {
    ScoresTable
  }
}
</script>
