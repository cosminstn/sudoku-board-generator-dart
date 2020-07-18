import 'package:sudoku_board_generator_dart/puzzle.dart';
import 'package:test/test.dart';

void main() {
  test('performance_generate_1000_puzzles', () {
    const NO_TESTS = 10000;

    var startTime = DateTime.now();
    for (var i = 0; i < NO_TESTS; i++) {
      generate();
    }
    var seconds = DateTime.now().difference(startTime).inSeconds;
    expect(seconds, lessThan(10));
    print('Time for ${NO_TESTS} boards: ${seconds}');
  });
}
