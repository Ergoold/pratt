import 'dart:io';

import 'flatten.dart';
import 'parser.dart';

void main() {
  while (true) {
    stdout.write('> ');
    print('${flatten(parse())}\n');
  }
}
