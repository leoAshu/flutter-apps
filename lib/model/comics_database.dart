import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './comic.dart';
import '../utility/constants.dart';

class ComicsDatabase {
  static Database _db;
  static final ComicsDatabase _mInstance = ComicsDatabase._();

  ComicsDatabase._();

  static ComicsDatabase getInstance() {
    return _mInstance;
  }

  Future<Database> init() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, Constants.dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return _db;
  }

  void _onCreate(Database db, int version) {
    const String query = '''CREATE TABLE comics (
              id INTEGER PRIMARY KEY, 
              title TEXT, alt TEXT, 
              imgUrl TEXT, 
              isFavourite INTEGER)''';
    db.execute(query);
    print('DB created');
  }

  Future<int> insertComic(Comic comic) async {
    if (_db == null) {
      _db = await init();
    }
    if (await fetchComic(comic.id) == null) {
      return _db.insert(Constants.tableName, comic.comicToMap());
    }
    print('Already present');
    return -1;
  }

  Future<Comic> fetchComic(int id) async {
    if (_db == null) {
      _db = await init();
    }
    final results = await _db.query(Constants.tableName, where: 'id = $id');
    if (results.length != 0) {
      return Comic.fromMap(results.first);
    }
    return null;
  }

  Future<List<Comic>> fetchFavouriteComics() async {
    if (_db == null) {
      _db = await init();
    }
    final results =
        await _db.query(Constants.tableName, where: 'isFavourite = 1');
    if (results.length != 0) {
      return List.generate(
          results.length, (index) => Comic.fromMap(results[index]));
    }
    return null;
  }

  Future<int> updateComic(Comic newComic) async {
    if (_db == null) {
      _db = await init();
    }
    return _db.update(Constants.tableName, newComic.comicToMap(),
        where: 'id = ?',
        whereArgs: [newComic.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void closeConnectionToDB() {
    if (_db != null) {
      _db.close();
      print('DB closed');
    }
  }
}
