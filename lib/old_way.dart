import 'dart:io';
import 'dart:math';

class Donut {
  static double A = 1, B = 1;

  /// An Implementation of Donut.c in dart
  ///
  /// this uses the exact same logic implemented in
  ///
  /// https://www.a1k0n.net/2011/07/20/donut-math.html
  String oldWayToRender() {
    List<String> output = [];
    List<double> zBuffer = [];
    A += 0.07;
    B += 0.03;
    var cA = cos(A), sA = sin(A), cB = cos(B), sB = sin(B);
    for (var k = 0; k < 1760; k++) {
      String bInsert = (k % 80) == 79 ? "\n" : " ";
      output.insert(k, bInsert);
      zBuffer.insert(k, 0);
    }
    for (double j = 0; j < 6.28; j += 0.07) {
// j <=> theta
      var ct = cos(j), st = sin(j);
      for (double i = 0; i < 6.28; i += 0.02) {
// i <=> phi
        var sp = sin(i),
            cp = cos(i),
            h = ct + 2, // R1 + R2*cos(theta)
            D = 1 / (sp * h * sA + st * cA + 5), // this is 1/z
            t = sp * h * cA -
                st *
                    sA; // this is a clever factoring of some of the terms in x' and y'
        int xVariant = (40 + 30 * D * (cp * h * cB - t * sB)).toInt(),
            yVariant = (12 + 15 * D * (cp * h * sB + t * cB)).toInt(),
            nVariant = (8 *
                    ((st * sA - sp * ct * cA) * cB -
                        sp * ct * sA -
                        st * cA -
                        cp * ct * sB))
                .toInt();
        int x = (0 | xVariant), y = (0 | yVariant);

        int o = (x + 80 * y).round(), N = (0 | nVariant);
        if (y < 22 && y >= 0 && x >= 0 && x < 79 && D > zBuffer[o]) {
          zBuffer[o] = D;
          output[o] = ".,-~:;=!*#\$@"[N > 0 ? N : 0];
        }
      }
    }

    return output.join('');
  }
}
