import 'dart:math';

import 'package:password_generator/features/password_store/models/password_model.dart';
import 'package:sqflite/sqflite.dart';

List<PasswordModel> listData = [];

String generatePassword() {
  final length = 20;
  final lettersLowerCase = 'abcdefghijklmnopqrstuvwxyz';
  final lettersUpperCase = 'ABCDEFGHIJKLMNOPQURSTUVWXYZ';
  final number = '1234567890';
  final special = '!@#\$%^&*(){}=+';

  String char = '';
  char += '$lettersUpperCase$number$special$lettersLowerCase';

  return List.generate(length, (index) {
    final indexRandom = Random().nextInt(char.length);

    return char[indexRandom];
  }).join();
}

late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE password (id INTEGER PRIMARY KEY, password TEXT)');
    },
  );
}

Future<void> addPassword(PasswordModel modeldata) async {
  await _db.rawInsert(
      'INSERT INTO password (password) VALUES(?)', [modeldata.password]);
  getAllData();
}

Future<List<PasswordModel>> getAllData() async {
  final value = await _db.rawQuery('SELECT * FROM password');
  listData.clear();
  value.forEach((map) {
    final passwordData = PasswordModel.fromMap(map);
    listData.add(passwordData);
  });
  for (var element in listData) {
    print(element.password);
  }
  return listData;
}

Future<void> deletePassword(int id) async {
  _db.rawDelete('DELETE FROM password WHERE id = ?', [id]);
  getAllData();
}
