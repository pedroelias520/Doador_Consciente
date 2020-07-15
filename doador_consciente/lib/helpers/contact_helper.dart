import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";
final String tipoSangueColumn="tipoSangueColumn";
final String localizacaoColumn="localizacaoColumn";
final String tipoColumn="tipoColumn";
final String necessidadeColumn="necessidadeColumn";
final String unidadeColumn="unidadeColumn";

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT,"
              "$phoneColumn TEXT, $imgColumn TEXT,$tipoSangueColumn TEXT,$localizacaoColumn TEXT,$tipoColumn BOOLEAN,$necessidadeColumn INTEGER,$unidadeColumn TEXT)"
      );
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn,tipoSangueColumn,localizacaoColumn,tipoColumn,necessidadeColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable,
        contact.toMap(),
        where: "$idColumn = ?",
        whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable WHERE necessidadeColumn=0");
    /*List listMap = await dbContact.query("SELECT * FROM $contactTable",where: "$tipoColumn=?",whereArgs: [true]);*/
    List<Contact> listContact = List();
    for(Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }
  Future<List> getAllPacients() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable WHERE necessidadeColumn>0");
    /*List listMap = await dbContact.query("SELECT * FROM $contactTable",where: "$tipoColumn=?",whereArgs: [false]);*/
    List<Contact> listContact2 = List();
    for(Map m in listMap){
      listContact2.add(Contact.fromMap(m));
    }
    return listContact2;
  }
  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}

class Contact {

  int id;
  String name;
  String email;
  String phone;
  String img;
  String tipoSangue;
  String localizacao;
  String tipo;
  int necessidade;
  String unidade;

  Contact();

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
    tipoSangue = map[tipoSangueColumn];
    localizacao=map[localizacaoColumn];
    tipo=map[tipoColumn];
    necessidade=map[necessidadeColumn];
    unidade=map[unidadeColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
      tipoSangueColumn: tipoSangue,
      localizacaoColumn :localizacao,
      tipoColumn:tipo,
      necessidadeColumn:necessidade,
      unidadeColumn:unidade
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }
  Map toMap2() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
      tipoSangueColumn: tipoSangue,
      localizacaoColumn :localizacao,
      tipoColumn:tipo
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img ,Tipo_Sanguineo:$tipoSangue),Localização:$localizacao,Tipo:$tipo,Necessidade:$necessidade,Uniadade Hospitalar:$unidade ";
  }

}