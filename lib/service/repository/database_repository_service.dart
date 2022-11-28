import 'package:sqflite/sqflite.dart';

class DatabaseRepositoryService {
  const DatabaseRepositoryService();

  /// databaseFilePath Eg. app/sample.db
  Future<Database> open({
    required final String filePath,
    required final int version,
    required Future<void> Function(Database, int) onCreate,
    required Future<void> Function(Database, int, int) onUpgrade,
  }) async {
    return openDatabase(
      filePath,
      version: version,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  /// Drop table remove the table from database
  Future<void> dropTable (Database database, {
    required final String tableName,
  }) {
    return database.execute('DROP TABLE IF EXISTS $tableName');
  }

  Future<void> dropTableList (Database database, {
    required final List<String> tableNameList,
  }) {
    final dbBatch = database.batch();

    for (final tableName in tableNameList) {
      dbBatch.execute('DROP TABLE IF EXISTS $tableName');
    }

    return dbBatch.commit();
  }

  /// Execute sql query with no result
  Future<void> executeSql (Database database, {
    required final String instruction,
  }) {
    return database.execute(instruction);
  }

  Future<void> executeSqlList (Database database, {
    required final List<String> instructionList,
  }) {
    final dbBatch = database.batch();

    for (final instruction in instructionList) {
      dbBatch.execute(instruction);
    }

    return dbBatch.commit();
  }

  /// Execute raw query with result
  Future<void> querySql (Database database, {
    required final String query,
  }) {
    return database.rawQuery(query);
  }

  Future<void> querySqlList (Database database, {
    required final List<String> queryList,
  }) {
    final dbBatch = database.batch();

    for (final query in queryList) {
      dbBatch.rawQuery(query);
    }

    return dbBatch.commit();
  }

  /// Insert data query
  Future<void> insert (Database database, {
    required final String tableName,
    required final Map<String, Object?> values,
    final String? nullColumnHack,
    final ConflictAlgorithm? conflictAlgorithm,
  }) {
    return database.insert(
      tableName,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  Future<void> insertList (Database database, {
    required final String tableName,
    required final List<Map<String, Object?>> valueList,
    final String? nullColumnHack,
    final ConflictAlgorithm? conflictAlgorithm,
  }) {
    final dbBatch = database.batch();

    for (final value in valueList) {
      dbBatch.insert(
        tableName,
        value,
        nullColumnHack: nullColumnHack,
        conflictAlgorithm: conflictAlgorithm,
      );
    }

    return dbBatch.commit();
  }

  /// Update data query
  Future<void> update (Database database, {
    required final String tableName,
    required final Map<String, Object?> values,
    final String? where,
    final List<Object?>? whereArgs,
    final ConflictAlgorithm? conflictAlgorithm,
  }) {
    return database.update(
      tableName,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  Future<void> updateList (Database database, {
    required final String tableName,
    required final List<Map<String, Object?>> valueList,
    final String? where,
    final List<Object?>? whereArgs,
    final ConflictAlgorithm? conflictAlgorithm,
  }) {
    final dbBatch = database.batch();

    for (final value in valueList) {
      dbBatch.update(
        tableName,
        value,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm,
      );
    }

    return dbBatch.commit();
  }

  /// Delete table remove all the data from that table without removing the table
  Future<void> delete (Database database, {
    required final String tableName,
    required final String? where,
    required final List<Object?>? whereArgs,
  }) {
    return database.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> deleteList (Database database, {
    required final List<String> tableNameList,
    required final String? where,
    required final List<Object?>? whereArgs,
  }) {
    final dbBatch = database.batch();

    for (final tableName in tableNameList) {
      dbBatch.delete(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
    }

    return dbBatch.commit();
  }
}