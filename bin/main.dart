import 'package:sudoku_board_generator_dart/puzzle.dart' as board_generator;

Future<void> main(List<String> arguments) async {
  var startTime = DateTime.now();
  var game = await board_generator.generate();

  print('Puzzled board:');
  game.board.printBoard();
  print('Clues ${game.board.getNoClues()}');

  var endTime = DateTime.now();
  print(
      'Generation took ${endTime.difference(startTime).inMilliseconds} millis');
}
