import "dart:io";
import 'package:dart_donut/old_way.dart';

void main(List<String> arguments) async {
  /// keeps animating in terminal forever
  /// to stop ctrl+c or terminate the app
  while (true) {
    /// prints a single frame
    print(Donut().oldWayToRender());

    /// creating animation effect by delaying
    await Future.delayed(Duration(milliseconds: 100));

    /// Clearing terminal screen for next frame
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
