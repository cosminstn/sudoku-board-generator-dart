import 'package:sudoku_board_generator_dart/board_generator.dart';
import 'package:test/test.dart';

void performanceTest() {
  test('performance_generate_1000_boards', () {
    var startTime = DateTime.now();
    for (var i = 0; i < 100000; i++) {
      generateBoard();
    }
    var seconds = DateTime.now().difference(startTime).inSeconds;
    expect(seconds, lessThan(10));
    print('Time for 100000 boards: ${seconds}');
  });
}
