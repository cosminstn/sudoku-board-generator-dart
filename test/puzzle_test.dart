import 'package:sudoku_board_generator_dart/puzzle.dart';
import 'package:test/test.dart';

void main() {
  test('performance_generate_5_puzzles_default_options', () async {
    const NO_TESTS = 5;

    var startTime = DateTime.now();
    for (var i = 0; i < NO_TESTS; i++) {
      await generate();
    }
    var seconds = DateTime.now().difference(startTime).inSeconds;
    expect(seconds, lessThan(10));
    print('Time for ${NO_TESTS} boards: ${seconds}s');
  });

  test('performance_generate_100_puzzles_eazy_options', () async {
    const NO_TESTS = 100;

    var startTime = DateTime.now();
    for (var i = 0; i < NO_TESTS; i++) {
      await generate(attempts: 30);
    }
    var seconds = DateTime.now().difference(startTime).inSeconds;
    expect(seconds, lessThan(10));
    print('Time for eazy ${NO_TESTS} games: ${seconds}s');
  });

  test('generate_low_max_time_millis', () async {
    var startTime = DateTime.now();
    await generate(maxTimeMillis: 500);
    final timeEffort = DateTime.now().difference(startTime).inMilliseconds;

    print('Time effort in millis: ${timeEffort}ms');
  });
}
