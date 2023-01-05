import 'package:sqflite/sqflite.dart';

class DatabaseStorageUtility {
  static final _databaseInstance = <String, Database>{};

  /// databaseFilePath Eg. app/sample.db
  static Future<void> open({
    required final String name,
    required final int version,
    required Future<void> Function() onCreate,
    required Future<void> Function(int, int) onUpgrade,
  }) async {
    _databaseInstance[name] ??= await openDatabase(
      name,
      version: version,
      onCreate: (database, version) {
        _databaseInstance[name] ??= database;
        onCreate();
      },
      onUpgrade: (database, oldVersion, newVersion) {
        onUpgrade(oldVersion, newVersion);
      },
    );
  }

  /// Drop table remove the table from database
  static Future<void> dropTable({
    required final String databaseName,
    required final String tableName,
  }) async {
    _databaseInstance[databaseName]?.execute('DROP TABLE IF EXISTS $tableName');
  }

  static Future<void> dropTableList({
    required final String databaseName,
    required final List<String> tableNameList,
  }) async {
    final dbBatch = _databaseInstance[databaseName]?.batch();

    for (final tableName in tableNameList) {
      dbBatch?.execute('DROP TABLE IF EXISTS $tableName');
    }

    await dbBatch?.commit();
  }

  /// Execute sql query with no result
  static Future<void> executeSql({
    required final String databaseName,
    required final String instruction,
  }) async {
    _databaseInstance[databaseName]?.execute(instruction);
  }

  static Future<void> executeSqlList({
    required final String databaseName,
    required final List<String> instructionList,
  }) async {
    final dbBatch = _databaseInstance[databaseName]?.batch();

    for (final instruction in instructionList) {
      dbBatch?.execute(instruction);
    }

    await dbBatch?.commit();
  }

  /// Execute raw query with result
  static Future<List<Map<String, Object?>>> querySql({
    required final String databaseName,
    required final String tableName,
    final bool? distinct,
    final List<String>? columns,
    final String? where,
    final List<Object?>? whereArgs,
    final String? groupBy,
    final String? having,
    final String? orderBy,
    final int? limit,
    final int? offset,
  }) async {
    return await _databaseInstance[databaseName]?.query(
      tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    ) ?? [];
  }

  static Future<List<Map<String, Object?>>> queryRawSql({
    required final String databaseName,
    required final String query,
  }) async {
    return await _databaseInstance[databaseName]?.rawQuery(query) ?? [];
  }

  static Future<void> queryRawSqlList({
    required final String databaseName,
    required final String tableName,
    required final List<String> queryList,
  }) async {
    final dbBatch = _databaseInstance[databaseName]?.batch();

    for (final query in queryList) {
      dbBatch?.rawQuery(query);
    }

    await dbBatch?.commit();
  }

  /// Insert data query
  static Future<void> insert({
    required final String databaseName,
    required final String tableName,
    required final Map<String, Object?> values,
    final String? nullColumnHack,
    final ConflictAlgorithm? conflictAlgorithm,
  }) async {
    await _databaseInstance[databaseName]?.insert(
      tableName,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  static Future<void> insertList({
    required final String databaseName,
    required final String tableName,
    required final List<Map<String, Object?>> valueList,
    final String? nullColumnHack,
    final ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final dbBatch = _databaseInstance[databaseName]?.batch();

    for (final value in valueList) {
      dbBatch?.insert(
        tableName,
        value,
        nullColumnHack: nullColumnHack,
        conflictAlgorithm: conflictAlgorithm,
      );
    }

    await dbBatch?.commit();
  }

  /// Update data query
  static Future<void> update({
    required final String databaseName,
    required final String tableName,
    required final Map<String, Object?> values,
    final String? where,
    final List<Object?>? whereArgs,
    final ConflictAlgorithm? conflictAlgorithm,
  }) async {
    await _databaseInstance[databaseName]?.update(
      tableName,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  static Future<void> updateList({
    required final String databaseName,
    required final String tableName,
    required final List<Map<String, Object?>> valueList,
    final String? where,
    final List<Object?>? whereArgs,
    final ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final dbBatch = _databaseInstance[databaseName]?.batch();

    for (final value in valueList) {
      dbBatch?.update(
        tableName,
        value,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm,
      );
    }

    await dbBatch?.commit();
  }

  /// Delete table remove all the data from that table without removing the table
  static Future<void> delete({
    required final String databaseName,
    required final String tableName,
    final String? where,
    final List<Object?>? whereArgs,
  }) async {
    await _databaseInstance[databaseName]?.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  static Future<void> deleteList({
    required final String databaseName,
    required final List<String> tableNameList,
    final String? where,
    final List<Object?>? whereArgs,
  }) async {
    final dbBatch = _databaseInstance[databaseName]?.batch();

    for (final tableName in tableNameList) {
      dbBatch?.delete(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
    }

    await dbBatch?.commit();
  }

  const DatabaseStorageUtility._();
}
