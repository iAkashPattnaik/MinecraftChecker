// MinecraftChecker - @IndianBots - V0.0.1+a

import 'dart:io';
import 'dart:convert' show LineSplitter;

import 'package:minecraft_checker/main.dart';
import 'package:colorize/colorize.dart';

void main() async {
  print('\x1B[2J\x1B[0;0H');
  Process.runSync('title', ['MinecraftChecker', '-', '@IndianBots', '-', 'V0.0.1+a'], runInShell: true);
  print(
    Colorize(
      ' __  __  _                ____                __  _   \n'
      '|  \\/  |(_) _ __    ___  / ___| _ __   __ _  / _|| |_\n'
      "| |\\/| || || '_ \\  / _ \\| |    | '__| / _` || |_ | __|\n"
      '| |  | || || | | ||  __/| |___ | |   | (_| ||  _|| |_\n'
      '|_|  |_||_||_| |_| \\___| \\____||_|    \\__,_||_|   \\__|\n'
      '             github.com/BLUE-DEVIL1134\n\n'
    ).lightGreen()
  );
  var minecraftHits = [];
  stdout.write("Combo fileName : ${Colorize(Directory('.').absolute.uri.toFilePath()).lightMagenta()}");
  final inputName = stdin.readLineSync();
  if (inputName == null || inputName == '') {
    print(Colorize('Error: Invalid Inputs -> [$inputName]').red());
    print('Exit Code 1');
    exit(1);
  }
  final fileName = Directory('.').absolute.uri.toFilePath() + inputName;
  final file = File(fileName);
  if (!file.existsSync()) {
    print(Colorize('Error: File Not Found -> [$fileName]').red());
    print('Exit Code 1');
    exit(1);
  }
  final combos = LineSplitter().convert(file.readAsStringSync());
  for (var i in combos) {
    if (i.contains(':') && (i.startsWith(':') || i.endsWith(':'))) {
      combos.remove(i);
    }
  }
  print('${Colorize("Loaded").lightCyan()} • ${Colorize(combos.length.toString()).lightMagenta()}\n\n');
  for (var i in combos) {
    final checker = MinecraftChecker(i.split(':')[0], i.split(':')[1]);
    final isHit = await checker.check();
    if (!isHit) {
      print(Colorize('[ Failed ] • $i').red());
    } else {
      minecraftHits.add('[ Passed ] • $i');
      print(Colorize('[ Passed ] • $i').lightGreen());
    }
  }
  stdout.write(
    Colorize('Press enter key to save and exit . . . ').lightBlue()
  );
  stdin.readLineSync();
  final hitsFile = File(Directory('.').absolute.uri.toFilePath() + 'minecraftHits.txt');
  hitsFile.writeAsStringSync('Minecraft Hits By t.me/IndianBots\nGithub - github.com/BLUE-DEVIL1134\n\n');
  for (var i in minecraftHits) {
    hitsFile.writeAsStringSync('\n$i', mode: FileMode.append);
  }
}