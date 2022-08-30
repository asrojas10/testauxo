import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:prueba_auxo/model/airline.dart';
import 'package:prueba_auxo/model/itinerary.dart';
import 'package:prueba_auxo/model/leg.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FlightsDB {
  static Database? _database;

  FlightsDB._privateConstructor();
  static final FlightsDB instance = FlightsDB._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'fligths.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE legs (
          id TEXT PRIMARY KEY,
          departure_airport TEXT,
          arrival_airport TEXT,
          departure_time TEXT,
          arrival_time TEXT,
          stops INTEGER,
          airline_name TEXT,
          airline_id TEXT,
          duration_mins INTEGER
        );
      ''');

    await db.execute('''
        CREATE TABLE itineraries (
          id TEXT PRIMARY KEY,
          leg1 TEXT,
          leg2 TEXT,
          price TEXT,
          agent TEXT,
          agent_rating DOUBLE
        );
      ''');
  }

  Future<int> addLeg(Leg legs) async {
    try {
      final Database db = await database;
      bool? value = await getLegById(legs.id);
      if (value) {
        return db.insert('legs', legs.toMap());
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception('ADD Leg error ${e.toString()}');
    }
  }

  Future<int> addItinerary(Itinerary itinerary) async {
    try {
      final Database db = await database;
      bool value = await getItinerarieById(itinerary.id);
      if (value) {
        return db.insert('itineraries', itinerary.toMap());
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception('ADD Leg error ${e.toString()}');
    }
  }

  Future<List<Leg>> getLegs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('legs');
    List<Leg> legs = maps.isNotEmpty
        ? maps.map<Leg>((leg) {
            return Leg.fromJson(leg);
          }).toList()
        : [];
    return legs;
  }

  Future<List<Itinerary>> getItineraries() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('itineraries');
    List<Itinerary> itineraries = maps.isNotEmpty
        ? maps.map<Itinerary>((itinerary) {
            return Itinerary.fromSql(itinerary);
          }).toList()
        : [];

    return itineraries;
  }

  Future<bool> getLegById(String id) async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query('legs', where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        // return Leg.fromJson(maps.first);
        return false;
      }
      return true;
    } catch (e) {
      throw Exception('Find leg by Id: ${e.toString()}');
    }
  }

  Future<bool> getItinerarieById(String id) async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> maps =
          await db.query('itineraries', where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        // return Itinerary.fromJson(maps.first);
        return false;
      }
      return true;
    } catch (e) {
      throw Exception('Find it by Id: ${e.toString()}');
    }
  }

  Future<List<Airline>> getAirlines() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT *, COUNT(*) FROM legs GROUP BY airline_name');
    List<Airline> list =
        maps.isNotEmpty ? maps.map((leg) => Airline.fromSql(leg)).toList() : [];
    return list;
  }
}
