/**
 * The board is a 9 by 9 matrix containing values from 1 to 9. 
 * If a position is considered empty then it will contain the value 0.
 */
class Board {
  List<List<int>> matrix;

  Board(this.matrix);

  ///Initializes a 9x9 board with 0 all over.
  Board.empty() {
    matrix = <List<int>>[];
    for (var i = 0; i < 9; i++) {
      var row = <int>[];
      for (var j = 0; j < 9; j++) {
        row.add(0);
      }
      matrix.add(row);
    }
  }

  bool isNumberOnRow(int number, int row) {
    return matrix[row].contains(number);
  }

  bool isNumberOnColumn(int number, int col) {
    for (var row in matrix) {
      if (row[col] == number) {
        return true;
      }
    }
    return false;
  }

  Region getRegion(int row, int col) {
    return Region(this, row - (row % 3), col - (col % 3));
  }
}

/**
 * The region is a 3 by 3 section on the Board. 
 * The board contains 9 regions. 
 * Any number should appear only once in a region.
 */
class Region {
  List<List<int>> _matrix;

  Region(Board board, int rowStart, int colStart) {
    assert(rowStart == 0 || rowStart == 3 || rowStart == 6);
    assert(colStart == 0 || colStart == 3 || colStart == 6);
    _matrix = <List<int>>[];
    for (var row = rowStart; row < rowStart + 3; row++) {
      _matrix.add([
        board.matrix[row][colStart],
        board.matrix[row][colStart + 1],
        board.matrix[row][colStart + 2]
      ]);
    }
  }

  bool contains(int number) {
    assert(number >= 1 && number <= 9);
    for (var row in _matrix) {
      for (var el in row) {
        if (el != 0 && el == number) {
          return true;
        }
      }
    }
    return false;
  }
}
