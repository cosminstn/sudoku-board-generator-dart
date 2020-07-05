import 'package:sudoku_board_generator_dart/board_generator.dart'
    as board_generator;

void main(List<String> arguments) {
  var board = board_generator.generateBoard();

  print('Board: ');
  for (var row in board.matrix) {
    var line = '';
    for (var number in row) {
      line += '${number} ';
    }
    print(line);
  }
}
