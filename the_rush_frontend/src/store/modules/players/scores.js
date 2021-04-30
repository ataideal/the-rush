const moduleScore = {
  namespaced: true,
  state: () => ({
    scores: [
      {
        player: 'Player Name',
        team: 'Team',
        pos: 'Position',
        att_g: 2,
        att: 2,
        yds: 7,
        avg: 3.7,
        yds_g: 7,
        td: 0,
        lng: 7,
        first: 0,
        first_percent: 0,
        twenty_plus: 0,
        forty_plus: 0,
        fum: 0,
      }
    ]
  }),

  mutations: {
    SET_SCORES (state, scores) {
      state.scores = scores
    }
  },

  actions:{
    setScores ({ commit }, payload) {
      commit('SET_SCORES', payload)
    }
  },

  getters: {
    scores (state) {
      return state.scores
    }
  }
}
export default moduleScore;
