import 'dart:math';

class Minmaxalgorithem {
 static String PLAYER_X = 'X';
  static String PLAYER_O = 'O';
  static String EMPTY = '';

  
  static int minimax(List<List<String>> board, int depth, bool isMaximizing) {
    final winner = Minmaxalgorithem.findBestMove(board);

    // If the game is over (win, draw)
    if (winner == PLAYER_X) {
      return 10 - depth; // Maximizing player (AI) score
    }
    if (winner == PLAYER_O) {
      return depth - 10; // Minimizing player (Opponent) score
    }
    if (winner == 'Draw') {
      return 0; // Draw
    }

    if (isMaximizing) {
      int best = -99999;
      // Maximizing Player (AI)
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (board[row][col] == EMPTY) {
            board[row][col] = PLAYER_X;
            best = max(best, minimax(board, depth + 1, false));
            board[row][col] = EMPTY;
          }
        }
      }
      return best;
    } else {
      int best = 99999;
      // Minimizing Player (Opponent)
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (board[row][col] == EMPTY) {
            board[row][col] = PLAYER_O;
            best = min(best, minimax(board, depth + 1, true));
            board[row][col] = EMPTY;
          }
        }
      }
      return best;
    }
}


  static List<int> findBestMove(List<List<String>> board) {
    int bestVal = -99999;
    List<int> bestMove = [-1, -1];

    // Loop through all possible moves
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == EMPTY) {
          board[row][col] = PLAYER_X;
          int moveVal = minimax(board, 0, false); // Minimize opponent's score
          board[row][col] = EMPTY;
          if (moveVal > bestVal) {
            bestMove = [row, col];
            bestVal = moveVal;
          }
        }
      }
    }
    return bestMove;
  }
}