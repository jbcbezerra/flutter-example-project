import 'dart:io';

String fixtures(String filename) =>
    File('test/fixtures/$filename').readAsStringSync();
