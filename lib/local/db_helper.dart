import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:littafy/constant/optionType.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AssetDbHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "setup.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", "setup.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb;
    if (kIsWeb) {
      var factory = databaseFactoryFfiWeb;
      // Change default factory on the web
      var databaseFactory = databaseFactoryFfiWeb;
      path = 'assets/db/setup.db';
      var theDb = openDatabase(path);
    } else {
      theDb = await openDatabase(path, version: 1);
    }

    return theDb;
  }

  Future<List<OptionClass>> getOptions() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient!.rawQuery('SELECT * FROM generator_option');
    List<OptionClass> optionList =
        List<OptionClass>.from(list.map((x) => OptionClass.fromJson(x)));
    print(list);
    print(optionList);
    // for (int i = 0; i < list.length; i++) {
    //   employees.add( Employee(list[i]["First_Name"], list[i]["Last_Name"]));
    // }
    return optionList;
  }

  Future<List<OptionClass>> searchItem(
      tableName, String queryParam, dynamic keyword) async {
    var dbClient = await db;
    // final db = await SQLHelper.db();
    // List<Map<String, dynamic>> list = await dbClient!.rawQuery('SELECT * FROM generator_option2');
    //
    List<Map<String, dynamic>> list = await dbClient!.rawQuery(
        "SELECT * FROM $tableName WHERE $queryParam LIKE '%$keyword%' ORDER BY id ASC");
    List<OptionClass> optionList =
        List<OptionClass>.from(list.map((x) => OptionClass.fromJson(x)));
    print(list);
    print(optionList);
    return optionList;
  }
}
