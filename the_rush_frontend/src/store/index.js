import Vue from 'vue'
import Vuex from 'vuex'
import scores from './modules/players/scores'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
  },
  mutations: {
  },
  actions: {
  },
  modules: {
    scores: scores
  }
})
