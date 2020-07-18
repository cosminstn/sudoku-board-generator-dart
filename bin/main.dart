import 'package:sudoku_board_generator_dart/board_generator.dart'
    as board_generator;

void main(List<String> arguments) {
  var board = board_generator.generateBoard();

  var startTime = DateTime.now();

  print('Board: ');
  for (var row in board.matrix) {
    var line = '';
    for (var number in row) {
      line += '${number} ';
    }
    print(line);
  }

  board_generator.puzzle(board);
  print('Puzzled board:');
  board.printBoard();
  print('Clues ${board.getNoClues()}');

  var endTime = DateTime.now();
  print(
      'Generation took ${endTime.difference(startTime).inMilliseconds} millis');
}
