import 'dart:io';


List<String> board = List.filled(9, ' ');


String player1 = 'X';
String player2 = 'O';


String currentPlayer = player1;


void displayBoard() {
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('-----------');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('-----------');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
}


int getPlayerMove() {
  int move;
  while (true) {
    try {
      print('Player $currentPlayer, enter your move (1-9): ');
      move = int.parse(stdin.readLineSync()!);
      if (move < 1 || move > 9 || board[move - 1] != ' ') {
        throw FormatException();
      }
      break;
    } catch (FormatException) {
      print('Invalid move. Please enter a valid move.');
    }
  }
  return move;
}


bool checkForWin() {

  for (int i = 0; i < 3; i++) {
    if ((board[i * 3] == currentPlayer && board[i * 3 + 1] == currentPlayer && board[i * 3 + 2] == currentPlayer) ||
        (board[i] == currentPlayer && board[i + 3] == currentPlayer && board[i + 6] == currentPlayer)) {
      return true; 
    }
  }
  if ((board[0] == currentPlayer && board[4] == currentPlayer && board[8] == currentPlayer) ||
      (board[2] == currentPlayer && board[4] == currentPlayer && board[6] == currentPlayer)) {
    return true;
  }
  return false;
}


bool checkForDraw() {
  return !board.contains(' ');
}


void resetGame() {
  board = List.filled(9, ' ');
  currentPlayer = player1;
}


void main() {
  bool gameWon = false;
  bool gameDrawn = false;

  print('Welcome to Tic-Tac-Toe!\n');

  do {
    displayBoard();
    int move = getPlayerMove();
    board[move - 1] = currentPlayer;

    gameWon = checkForWin();
    gameDrawn = checkForDraw();

    if (gameWon) {
      displayBoard();
      print('Player $currentPlayer wins!');
    } else if (gameDrawn) {
      displayBoard();
      print('The game is a draw!');
    } else {
      
      currentPlayer = (currentPlayer == player1) ? player2 : player1;
    }
  } while (!gameWon && !gameDrawn);


  print('Do you want to play again? (yes/no): ');
  String rematchAnswer = stdin.readLineSync()!.toLowerCase();

  if (rematchAnswer == 'yes') {
    resetGame();
    main(); 
  } else {
    print('Thanks for playing!');
  }
}
