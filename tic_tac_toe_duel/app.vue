<template>
  <div class="container">
    <h1 class="title">TicTacToe Duel</h1>
    <div class="turn-indicator">
      <span v-if="winner">
        <span v-if="winner === 'draw'">It's a Draw!</span>
        <span v-else>Player {{ winner === 'X' ? '1' : '2' }} ({{ winner }}) Wins!</span>
      </span>
      <span v-else>
        Player <span :class="['player', currentPlayer === 'X' ? 'player-x' : 'player-o']">{{ currentPlayer === 'X' ? '1' : '2' }}</span>
        's Turn ({{ currentPlayer }})
      </span>
    </div>
    <div class="board">
      <div
        v-for="(cell, idx) in board"
        :key="idx"
        class="cell"
        :class="{
          clickable: !winner && !cell,
          occupied: !!cell
        }"
        @click="handleCellClick(idx)"
      >
        <span v-if="cell" :class="cell === 'X' ? 'cell-x' : 'cell-o'">{{ cell }}</span>
      </div>
    </div>
    <button class="reset-btn" @click="resetGame">Reset</button>
  </div>
</template>

<script setup>
// PUBLIC_INTERFACE
import { ref } from 'vue'

const EMPTY_BOARD = () => Array(9).fill('')

const board = ref(EMPTY_BOARD())
const currentPlayer = ref('X') // Player 1: 'X', Player 2: 'O'
const winner = ref(null) // 'X', 'O', or 'draw'

/**
 * Check for win or draw.
 * @returns {'X' | 'O' | 'draw' | null}
 */
function checkGameResult() {
  const winPatterns = [
    // Rows
    [0,1,2], [3,4,5], [6,7,8],
    // Cols
    [0,3,6], [1,4,7], [2,5,8],
    // Diags
    [0,4,8], [2,4,6]
  ]
  for (const [a, b, c] of winPatterns) {
    if (
      board.value[a] &&
      board.value[a] === board.value[b] &&
      board.value[b] === board.value[c]
    ) {
      return board.value[a]
    }
  }
  if (board.value.every(cell => !!cell)) {
    return 'draw'
  }
  return null
}

/**
 * Handle cell click by current player.
 * @param {number} idx
 */
const handleCellClick = (idx) => {
  if (winner.value || board.value[idx]) return // Do nothing if over or occupied
  board.value[idx] = currentPlayer.value
  const result = checkGameResult()
  if (result) {
    winner.value = result
  } else {
    currentPlayer.value = currentPlayer.value === 'X' ? 'O' : 'X'
  }
}

/**
 * Reset the game state.
 */
const resetGame = () => {
  board.value = EMPTY_BOARD()
  winner.value = null
  currentPlayer.value = 'X'
}
</script>

<style scoped>
.container {
  min-height: 100vh;
  background: #fff;
  color: #000;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.title {
  margin-bottom: 1rem;
  font-size: 2rem;
  letter-spacing: 0.02em;
  color: #2196f3;
  font-weight: bold;
}

.turn-indicator {
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
  min-height: 1.2em;
  text-align: center;
}

.player {
  font-weight: 600;
}

.player-x {
  color: #2196f3;
}
.player-o {
  color: #000;
}

.board {
  width: 312px;
  height: 312px;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(3, 1fr);
  gap: 4px;
  margin-bottom: 1.5rem;
  background: #e3eaf5;
  border-radius: 12px;
  box-shadow: 0 2px 8px 0 rgba(33,150,243,0.06);
}

.cell {
  background: #fff;
  border-radius: 6px;
  box-shadow: 0 1px 4px 0 rgba(33,150,243,0.11);
  aspect-ratio: 1/1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2.6rem;
  font-weight: 700;
  cursor: pointer;
  transition: background 0.15s;
  user-select: none;
  border: none;
}
.cell.clickable:hover {
  background: #f0f8ff;
}
.cell.occupied {
  cursor: not-allowed;
}

.cell-x {
  color: #2196f3;
  text-shadow: 0 1px 2px #c7dffc7c;
}
.cell-o {
  color: #000;
  text-shadow: 0 1px 2px #eee;
}

.reset-btn {
  margin-top: 4px;
  padding: 6px 20px;
  font-size: 1rem;
  background: #2196f3;
  color: #fff;
  border-radius: 6px;
  border: none;
  cursor: pointer;
  font-weight: 600;
  transition: background 0.15s;
}
.reset-btn:hover {
  background: #1565c0;
}

@media (max-width: 370px) {
  .board {
    width: 90vw;
    height: 90vw;
    min-width: 0;
    min-height: 0;
  }
  .cell {
    font-size: 1.5rem;
  }
  .title {
    font-size: 1.2rem;
  }
}
</style>
