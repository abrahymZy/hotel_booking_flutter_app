import 'package:sqflite/sqflite.dart';

class Dbhelber {
  static Database? _db;
  static Future<Database> create_data_baase() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      'TurkdbHotel.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE clints (
            id_clint       INTEGER PRIMARY KEY AUTOINCREMENT,
            name_clint     TEXT,
            phone_clint    TEXT,
            count_clint    TEXT,
            type_pay       TEXT,
            identity_clint TEXT
          );
          ''');
        await db.execute('''
          CREATE TABLE rooms (
              id_room    INTEGER PRIMARY KEY AUTOINCREMENT,
              poto_room  TEXT,
              type_room    TEXT,
              count_bed  TEXT,
              price_room TEXT,
              isEmpty    INTEGER DEFAULT (0) 
          );''');

        await db.insert("rooms", {
          "id_room": 1,
          "type_room": 'عادي',
          "count_bed": '3',
          "price_room": '7000',
          "isEmpty": 1,
        });
        await db.insert("rooms", {
          "id_room": 2,
          "type_room": 'عادي',
          "count_bed": '2',
          "price_room": '5000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 3,
          "type_room": 'عادي',
          "count_bed": '2',
          "price_room": '5000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 4,
          "type_room": 'عادي',
          "count_bed": '2',
          "price_room": '5000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 5,
          "type_room": 'عادي',
          "count_bed": '3',
          "price_room": '7000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 6,
          "type_room": 'جناح',
          "count_bed": '5',
          "price_room": '10000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 7,
          "type_room": 'جناح',
          "count_bed": '5',
          "price_room": '10000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 8,
          "type_room": 'جناح',
          "count_bed": '5',
          "price_room": '10000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 9,
          "type_room": 'جناح',
          "count_bed": '7',
          "price_room": '15000',
          "isEmpty": 0,
        });
        await db.insert("rooms", {
          "id_room": 10,
          "type_room": 'جناح',
          "count_bed": '7',
          "price_room": '15000',
          "isEmpty": 0,
        });
        await db.execute('''
            CREATE TABLE rents (
                id_rent   INTEGER PRIMARY KEY AUTOINCREMENT,
                id_clint  INTEGER REFERENCES rooms (id_clint) ,
                id_room   INTEGER REFERENCES rooms (id_room),
                date_rent TEXT
            );''');

        // await db.insert("rents", {
        //   "id_rent": 1,
        //   "id_clint": 2,
        //   "id_room": 7,
        //   "date_rent": '2025/5/5',
        // });
        //  await db.insert("rents", {
        //   "id_rent": 2,
        //   "id_clint": 3,
        //   "id_room": 5,
        //   "date_rent": '2025/5/6',
        // });
        //  await db.insert("rents", {
        //   "id_rent": 3,
        //   "id_clint": 4,
        //   "id_room": 2,
        //   "date_rent": '2025/5/7',
        // });
        //  await db.insert("rents", {
        //   "id_rent": 4,
        //   "id_clint": 7,
        //   "id_room": 1,
        //   "date_rent": '2025/5/10',
        // });
        //  await db.insert("rents", {
        //   "id_rent": 5,
        //   "id_clint": 10,
        //   "id_room": 6,
        //   "date_rent": '2025/5/15',
        // });
      },
      onOpen: (db) {
        print('open');
      },
    );
    return _db!;
  }

  static Future<List<Map>> getClint() async {
    //find
    _db ??= await create_data_baase();
    return await _db!.query("clints", orderBy: 'id_clint');
  }

  static Future<List<Map>> getRooms() async {
    //find
    _db ??= await create_data_baase();
    return await _db!.query("rooms", orderBy: 'id_room');
  }

  static Future<List<Map>> getRents() async {
    //find
    _db ??= await create_data_baase();
    // return await _db!.query("rents", orderBy: 'id_rent');
    return await _db!.rawQuery(
      '''SELECT id_rent, rents.id_clint,name_clint, rooms.id_room,price_room,date_rent
        from clints, Rents, rooms
        where Rents.id_clint = clints.id_clint
        and rooms.id_room = Rents.id_room''',
    );
  }

  static Future<int> insertClints(
    String name_Clint,
    String phone_Clint,
    String count_Clint,
    String type_Pay,
  ) async {
    //create
    _db ??= await create_data_baase();
    return await _db!.insert("clints", {
      'name_clint': name_Clint,
      'phone_clint': phone_Clint,
      'count_clint': count_Clint,
      'type_pay': type_Pay,
    });
  }

  static Future<int> insertRooms(
    String type_Room,
    String count_Bed,
    String price_Room,
  ) async {
    //create
    _db ??= await create_data_baase();
    return await _db!.insert("rooms", {
      'type_room': type_Room,
      'count_Bed': count_Bed,
      'price_room': price_Room,
    });
  }

  static Future<int> insertRents(
    int id_Clint,
    int id_Room,
    String date_Rent,
  ) async {
    _db ??= await create_data_baase();
    await _db!.insert('rents', {
      'id_clint': id_Clint,
      'id_room': id_Room,
      'date_rent': date_Rent,
    });
    return _db!.update(
      "rooms",
      {"isEmpty": 1},
      where: "id_room=?",
      whereArgs: [id_Room],
    );
  }

  static Future<int> maxClint() async {
    dynamic data = await _db!.rawQuery(
      "SELECT max(id_clint) as maxId from clints",
    );
    return data[0]["maxId"];
  }

  static Future<int> cancelRent(int id, int idRent) async {
    _db!.delete('rents', where: 'id_rent = ?', whereArgs: [idRent]);
    return _db!.update(
      "rooms",
      {"isEmpty": 0},
      where: "id_room=?",
      whereArgs: [id],
    );
  }

static Future<Map<String, dynamic>> getRentDetails(int idRent) async {
  _db ??= await create_data_baase();

  // 1) جلب بيانات الحجز
  final rent = await _db!.query(
    'rents',
    where: 'id_rent = ?',
    whereArgs: [idRent],
  );

  if (rent.isEmpty) return {};

  final rentData = rent.first;

  // 2) جلب بيانات العميل
  final client = await _db!.query(
    'clints',
    where: 'id_clint = ?',
    whereArgs: [rentData['id_clint']],
  );

  // 3) جلب بيانات الغرفة
  final room = await _db!.query(
    'rooms',
    where: 'id_room = ?',
    whereArgs: [rentData['id_room']],
  );

  return {
    "rent": rentData,
    "client": client.isNotEmpty ? client.first : {},
    "room": room.isNotEmpty ? room.first : {},
  };
}

}
