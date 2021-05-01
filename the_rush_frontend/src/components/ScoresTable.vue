<template>
  <div>
  <h1>Scores table</h1>

  <div class="d-flex">
    <v-text-field
      solo
      label="Player Name"
      append-icon="mdi-magnify"
      v-model="player"
      @input="updatePlayerName"
    ></v-text-field>
    <v-btn
      :loading="loadingDownload"
      :disabled="loadingDownload"
      color="blue-grey"
      class="ma-2 white--text"
      @click="downloadCSV(options)"
    >
      Export to CSV
      <v-icon
        right
        dark
      >
        mdi-download
      </v-icon>
    </v-btn>
  </div>
  <v-data-table
    hide-default-footer
    class="elevation-1"
    :headers="headers"
    :items="scores"
    :itemsPerPage="options.itemsPerPage"
    :loading="loading"
    @update:options="updateOptions($event)"
  ></v-data-table>
  <div class="text-center pt-2">
    <v-pagination
      v-model="options.page"
      :length="pageCount"
      :total-visible="9"
    ></v-pagination>
  </div>
</div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import axios from 'axios'
  export default {
    name: 'scores-table',
    data: () => ({
      timeout: null,
      totalItems: 0,
      player: '',
      options: {
        page: 1,
        itemsPerPage: 10,
        sortBy: ['player'],
        sortDesc:  [false]
      },
      loading: false,
      headers: [
        {
          text: 'Player Name',
          value: 'player',
        },
        { text: 'Team', value: 'team' },
        { text: 'Position', value: 'pos' },
        { text: 'R.A. / Game (%)', value: 'att_g' },
        { text: 'R.A.', value: 'att' },
        { text: 'Total R.Y.', value: 'yds' },
        { text: 'R.Y. AVG / Attempt', value: 'avg' },
        { text: 'R.Y. / Game (%)', value: 'yds_g' },
        { text: 'Total R.T.', value: 'td' },
        { text: 'Longest Rush', value: 'lng' },
        { text: 'R. First Downs', value: 'first' },
        { text: 'R. First Downs (%)', value: 'first_percent' },
        { text: 'R. 20+ Yards Each', value: 'twenty_plus' },
        { text: 'R. 40+ Yards Each', value: 'forty_plus' },
        { text: 'R. Fumbles', value: 'fum' },
      ],
      loadingDownload: false
    }),
    methods: {
      fetchData(options){
        this.loading = true
        axios.get(`${process.env.VUE_APP_API_BASE_URL}/scores`, {
          params: {
            page: options.page || 1,
            per_page: options.itemsPerPage || 10,
            sort_by: options.sortBy[0] || "player",
            sort_desc: options.sortDesc[0] || false,
            player: this.player || ""
          }
        })
        .then(({data}) => {
          this.setScores(data.data)
          this.totalItems = data.pagination.total
        })
        .catch((err) => console.log(err))
        .finally(() => this.loading = false)
      },
      updateOptions(val){
        if(this.options.sortBy != val.sortBy || this.options.sortDesc != val.sortDesc) {
          this.options =  {...this.options, page: 1, sortBy:val.sortBy, sortDesc: val.sortDesc}
        }
      },
      updatePlayerName(){
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
          this.options = ({...this.options, page: 1})
        }, 300);
      },
      downloadCSV(options) {
        this.loadingDownload = true
        axios.get(`${process.env.VUE_APP_API_BASE_URL}/scores_csv`, {
          params: {
            page: options.page || 1,
            per_page: options.itemsPerPage || 10,
            sort_by: options.sortBy[0] || "player",
            sort_desc: options.sortDesc[0] || false,
            player: this.player || ""
          },
          responseType: 'blob'
        })
        .then(response => {
          const blob = new Blob([response.data], { type: 'text/csv' })
          const link = document.createElement('a')
          link.href = URL.createObjectURL(blob)
          link.download = "player_scores.csv"
          link.click()
          URL.revokeObjectURL(link.href)
        })
        .catch((err) => console.log(err))
        .finally(() => this.loadingDownload = false)
      },
      ...mapActions({setScores:'scores/setScores'})
    },
    computed: {
      pageCount(){
        return Math.ceil(this.totalItems/this.options.itemsPerPage)
      },
      ...mapGetters({scores: 'scores/scores'})
    },
    watch: {
      options: {
        handler (val) {
          if (val) {
            this.fetchData(val)
          }
        },
        deep: true,
      },
    },
  }
</script>
