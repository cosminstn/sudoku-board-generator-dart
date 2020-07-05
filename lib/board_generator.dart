import 'models/board.dart';

int calculate() {
  return 6 * 7;
}

///Checks if the generated board is final, i.e. there are no zeroes left on the board.
bool checkBoard(Board board) {
  for (var row in board.matrix) {
    for (var number in row) {
      if (number == 0) {
        return false;
      }
    }
  }
  return true;
}

Board generateBoard() {
  final board = Board.empty();

  const MAX_ATTEMPTS = 10;
  var attempts = 0;
  // while (!checkBoard(board) && attempts < MAX_ATTEMPTS) {}
  var startTime = DateTime.now();
  fillBoard(board);
  var endTime = DateTime.now();
  print(
      'Generation took ${endTime.difference(startTime).inMilliseconds} millis');
  return board;
}

bool fillBoard(Board board, {int lastRow = 0, int lastCol = 0}) {
  // if (attempts > 0) {
  //   print('Optimal solution not found yet, attempts: ${attempts}');
  // }
  // attempts++;
  var numbers = List.from([1, 2, 3, 4, 5, 6, 7, 8, 9]);

  for (var i = 0; i < 81; i++) {
    var row = i ~/ 9;
    var col = i % 9;
    if (board.matrix[row][col] != 0) {
      continue;
    }

    numbers.shuffle();
    for (var number in numbers) {
      // Find a number that isn't already on the column or on the row
      if (board.isNumberOnRow(number, row) ||
          board.isNumberOnColumn(number, col)) {
        continue;
      }
      // check that the number does not appear in the current region
      if (board.getRegion(row, col).contains(number)) {
        continue;
      }
      board.matrix[row][col] = number;
      if (checkBoard(board)) {
        return true;
      }
      if (fillBoard(board, lastRow: row, lastCol: col)) {
        return true;
      }
    }

    break; // de ce sa facem break aici
  }
  if (lastRow != 0 && lastCol != 0) {
    board.matrix[lastRow][lastCol] = 0;
  }
  return false;
}
