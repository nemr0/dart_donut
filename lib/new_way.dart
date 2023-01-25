// new way still under development
import 'dart:io';

/// This is a1k0n new optimized way of implementing c ascii donut
/// which is found here:
///
/// https://www.a1k0n.net/2021/01/13/optimizing-donut.html
///
/// this is not working yet.
Future<void> newWayToRender() async {
  int sA = 1024, cA = 0, sB = 1024, cB = 0, f;
  for (;;) {
    /// text buffer
    List<String> b = List.generate(1760, (index) => '');

    /// z buffer
    List<int> z = List.generate(1760, (index) => 0);
    int sj = 0, cj = 1024;

    for (int j = 0; j < 90; j++) {
      int si = 0, ci = 1024; // sine and cosine of angle i
      for (int i = 0; i < 324; i++) {
        int r1 = 1, r2 = 2048, k2 = 5120 * 1024;

        int x0 = r1 * cj + r2,
            x1 = ci * x0 >> 10,
            x2 = cA * sj >> 10,
            x3 = si * x0 >> 10,
            x4 = r1 * x2 - (sA * x3 >> 10),
            x5 = sA * sj >> 10,
            x6 = k2 + r1 * 1024 * x5 + cA * x3,
            x7 = cj * si >> 10,
            x = (40 + 30 * (cB * x1 - sB * x4) / x6).toInt(),
            y = (12 + 15 * (cB * x4 + sB * x1) / x6).toInt(),
            N = (-cA * x7 -
                            cB * ((-sA * x7 >> 10) + x2) -
                            ci * (cj * sB >> 10) >>
                        10) -
                    x5 >>
                7;

        int o = x + 80 * y;
        int zz = (x6 - k2) >> 15;
        if (22 > y && y > 0 && x > 0 && 80 > x && zz < z[o]) {
          z[o] = zz;
          b[o] = ".,-~:;=!*#\$@"[N > 0 ? N : 0];
        }
        List<int> ro2 = rotate(5, 8, ci, si); // rotate i
        ci = ro2[0];
        si = ro2[1];
      }
      List<int> ro1 = rotate(9, 7, cj, sj); // rotate j
      cj = ro1[0];
      sj = ro1[1];
    }

    for (int k = 0; k < 1760; k++) {
      if (k % 80 == 79) b[k] = ' ';
      if (k % 80 == 0) b[k] = ' ';
    }
    print(b.join(''));
    List<int> r01 = rotate(5, 7, cA, sA);
    cA = r01[0];
    sA = r01[1];
    List<int> r02 = rotate(5, 8, cB, sB);
    cB = r02[0];
    sB = r02[1];

    /// creating animation effect by delaying
    await Future.delayed(Duration(milliseconds: 100));

    /// Clearing terminal screen for next frame
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

/// Rotate two variables using a multiplier and a shifter.

List<int> rotate(mul, shift, x, y) {
  int f = x;
  x -= mul * y >> shift;
  y += mul * f >> shift;
  f = (3145728 - x * x - y * y).toInt() >> 11;
  x = x * f >> 10;
  y = y * f >> 10;
  return [x, y];
}
