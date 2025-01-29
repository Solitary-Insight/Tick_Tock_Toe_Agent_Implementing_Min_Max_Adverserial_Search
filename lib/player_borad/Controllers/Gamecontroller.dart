import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  static GameController get instance => Get.find();

  //TODO: VARIABLE INITIALIZATION

  String PLAYER_X = 'X';
  String PLAYER_O = 'O';
  String EMPTY = '';
  RxString Heading_message = ''.obs;
  late RxList<RxList<String>> board;
  RxString Winner = ''.obs;
  RxBool GameStarted = false.obs;
  RxMap<String, int> rounds_record =
      <String, int>{"X": 0, "O": 0, "Draw": 0}.obs;
  RxList<List<int>> Winner_indexs = [
    [-1, -1],
    [-1, -1],
    [-1, -1]
  ].obs;

  RxString Player_Turn = "".obs;
  RxInt BOARD_ROWS = 0.obs;
  RxInt BOARD_COLS = 0.obs;

  // functions

  GameController(int Rows, int Columns) {
    BOARD_ROWS.value = Rows;
    BOARD_COLS.value = Columns;
    initializBoard();
    Player_Turn.listen((next_move) {
      delayandExecute(() {
        if (next_move == "X") {
          if (checkIfBoardIsEmpty()) {
            int x = getRandomDigit();
            int y = getRandomDigit();
            updateBoard(x, y, Player_Turn.value);
          } else {
            playAsBot();
          }

          updatePlayerTurn();
        }
      }, 1);
    });
  }

  // initialize board with '' values

  void initializBoard() {
    board = [
      for (int i = 0; i < BOARD_ROWS.value; i++)
        [for (int j = 0; j < BOARD_COLS.value; j++) ''].obs
    ].obs;
  }

  //  reset board again with blanks
  void resetBoard() {
    for (int i = 0; i < BOARD_ROWS.value; i++) {
      for (int j = 0; j < BOARD_COLS.value; j++) {
        board[i][j] = '';
      }
    }
    GameStarted.value = false;
    Winner_indexs.value = [
      [-1, -1],
      [-1, -1],
      [-1, -1]
    ];
  }

  // generates random value for initial move

  int getRandomDigit() {
    Random random = Random();
    return random.nextInt(3);
  }

// Start game reset all variables for newgae

  void startGame() {
    Winner.value = '';
    resetBoard();
    GameStarted.value = true;
    Player_Turn.value = '';
    Random random = Random();
    bool player = random.nextBool();
    Player_Turn.value = player ? "X" : 'O';
    Heading_message.value = !player ? "Your Turn" : "Bot Turn";
  }

// delay in action of bot to make it humane like
  Future<void> delayandExecute(VoidCallback task, int duration) async {
    await Future.delayed(Duration(seconds: duration));

    task();
  }

  // update player turn on UI

  void updatePlayerTurn() {
    if (GameStarted.value) {
      Player_Turn.value = Player_Turn.value == "X" ? "O" : "X";
      Heading_message.value =
          Player_Turn.value == "O" ? "Your Turn" : "Bot Turn";
    }
  }

// check if any  box is exist in winning triple
  bool isWinnerBox(int x, int y) {
    bool result = false;
    Winner_indexs.forEach((box) {
      int row = box[0];
      int col = box[1];
      if (x == row && y == col) {
        result = true;
      }
    });
    return result;
  }

  // set new value  at given indexe of board

  void updateBoard(int row, int col, String newValue) {
    if (GameStarted.value == false) {
      return;
    }

    if (board[row][col] == '') {
      board[row][col] = newValue;
    }

    Winner.value = checkWinner(board, notified: true);
    if (Winner == '') {
      return;
    } else {
      rounds_record[Winner.value] = rounds_record[Winner.value]! + 1;

      GameStarted.value = false;
      Heading_message.value = Winner.value == "X"
          ? "Bot Won"
          : Winner.value == "0"
              ? "You Won"
              : "Match Draw";

      // print("------------winner is -------");
      // print(Winner);
    }
  }

  List<int> findBestMove(List<List<String>> board) {
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
  // check if board is empty 
  bool checkIfBoardIsEmpty() {
    for (int i = 0; i < BOARD_ROWS.value; i++) {
      for (int j = 0; j < BOARD_COLS.value; j++) {
        if (board[i][j] != '') {
          return false;
        }
        ;
      }
    }
    return true;
  }


  // checks Winner in board 
  String checkWinner(List<List<String>> board, {notified = false}) {
    for (int row = 0; row < BOARD_ROWS.value; row++) {
      if (board[row][0] == board[row][1] &&
          board[row][1] == board[row][2] &&
          board[row][0] != EMPTY) {
        if (notified) {
          Winner_indexs.value = [
            [row, 0],
            [row, 1],
            [row, 2]
          ];
        }
        return board[row][0];
      }
    }
    for (int col = 0; col < BOARD_COLS.value; col++) {
      if (board[0][col] == board[1][col] &&
          board[1][col] == board[2][col] &&
          board[0][col] != EMPTY) {
        if (notified) {
          Winner_indexs.value = [
            [0, col],
            [1, col],
            [2, col]
          ];
        }
        return board[0][col];
      }
    }
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != EMPTY) {
      if (notified) {
        Winner_indexs.value = [
          [0, 0],
          [1, 1],
          [2, 2]
        ];
      }
      return board[0][0];
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != EMPTY) {
      if (notified) {
        Winner_indexs.value = [
          [0, 2],
          [1, 1],
          [2, 0]
        ];
      }
      return board[0][2];
    }

    // Check if board is full (draw)
    if (board.every((row) => row.every((cell) => cell != EMPTY))) {
      return 'Draw';
    }

    return ''; // No winner yet
  }

  int minimax(List<List<String>> board, int depth, bool isMaximizing) {
    final winner = checkWinner(board);

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


  // Player move case 
  void playAsBot() {
    List<int> bestMove = findBestMove(board);
    print("---------Best move for bot----" + bestMove.toString());
    int x = bestMove[0];
    int y = bestMove[1];
    if (x >= 0 && y >= 0) {
      updateBoard(x, y, Player_Turn.value);
    }
  }
}
