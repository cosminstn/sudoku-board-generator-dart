import 'dart:math';

import 'models/board.dart';
import 'primitive_wrapper.dart';

///Checks if the generated board is completed, i.e. there are no zeroes left on the board.
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

///Generates the board with no elements removed (the solution).
Board _generateFilledBoard() {
  final board = Board.empty();

  // while (!checkBoard(board) && attempts < MAX_ATTEMPTS) {}
  var startTime = DateTime.now();
  _fill(board);
  var endTime = DateTime.now();
  print(
      'Generation took ${endTime.difference(startTime).inMilliseconds} millis');
  return board;
}

bool _fill(Board board, {int lastRow = 0, int lastCol = 0}) {
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
      if (_fill(board, lastRow: row, lastCol: col)) {
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

bool solve(Board board, PrimitiveWrapper counter,
    {int lastRow = 0, int lastCol = 0}) {
  var numbers = List.from([1, 2, 3, 4, 5, 6, 7, 8, 9]);

  for (var i = 0; i < 81; i++) {
    var row = i ~/ 9;
    var col = i % 9;
    if (board.matrix[row][col] != 0) {
      continue;
    }

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
        counter.value += 1;
        break; // ? De ce ar fi break aici si nu return?
      } else if (solve(board, counter, lastRow: row, lastCol: col)) {
        return true;
      }
    }

    break; // ? De ce sa facem break aici?
  }
  if (lastRow != 0 && lastCol != 0) {
    board.matrix[lastRow][lastCol] = 0;
  }
  return false;
}

/// Removes elements from the filled board, generating a single solution puzzle.
/// [attempts] - The bigger this number is the more chance that the number of clues left approaces 17.
///              However, if this parameter is to big than the runtime will certainly be affected.
Future<void> _puzzle(Board board, {attempts = 500}) async {
  assert(board != null);
  assert(attempts > 0);

  final rnd = Random();
  // Hard stop at 17 clues.
  // Any less than that and we can't guarantee that the board will have a single solution.
  while (attempts > 0 && board.getNoClues() > 17) {
    // Select a random cell that is not already empty to be cleared
    var row = rnd.nextInt(9);
    var col = rnd.nextInt(9);
    while (board.matrix[row][col] == 0) {
      row = rnd.nextInt(9);
      col = rnd.nextInt(9);
    }

    final backup = board.matrix[row][col];

    board.matrix[row][col] = 0;

    var boardCopy = board.clone();

    final counter = PrimitiveWrapper(0);
    solve(boardCopy, counter);

    if (counter.value != 1) {
      // Then the element we just removed causes the puzzle to have 2 different solutions. Rollback this change
      board.matrix[row][col] = backup;
      // We could stop here, but we can also have another attempt with a different cell just to try to remove more numbers
      attempts -= 1;
    }
  }
}

Future<Board> generate() async {
  final board = _generateFilledBoard();
  await _puzzle(board);

  return board;
}
