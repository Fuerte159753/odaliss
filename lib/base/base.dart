import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_app/models/usuario.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'odaliss_crud.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Crear tabla de usuarios
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellidos TEXT,
        correo TEXT UNIQUE,
        contrasena TEXT
      )
    ''');

    // Crear tabla de productos
    await db.execute('''
      CREATE TABLE productos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descripcion TEXT,
        categoria TEXT,
        cantidad INTEGER,
        url_imagen TEXT
      )
    ''');

    // Insertar datos iniciales en la tabla de productos
    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 10,
      'url_imagen': 'assets/img/blusa1.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 12,
      'url_imagen': 'assets/img/blusa2.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 8,
      'url_imagen': 'assets/img/blusa3.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 5,
      'url_imagen': 'assets/img/blusa4.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 7,
      'url_imagen': 'assets/img/blusa5.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 6,
      'url_imagen': 'assets/img/blusa6.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Blusa de seda',
      'categoria': 'Ropa',
      'cantidad': 4,
      'url_imagen': 'assets/img/blusa7.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Falda corta',
      'categoria': 'Ropa',
      'cantidad': 15,
      'url_imagen': 'assets/img/falda1.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Falda corta',
      'categoria': 'Ropa',
      'cantidad': 10,
      'url_imagen': 'assets/img/falda2.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Falda corta',
      'categoria': 'Ropa',
      'cantidad': 12,
      'url_imagen': 'assets/img/falda3.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Falda corta',
      'categoria': 'Ropa',
      'cantidad': 8,
      'url_imagen': 'assets/img/falda4.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Pantalón vaquero',
      'categoria': 'Ropa',
      'cantidad': 20,
      'url_imagen': 'assets/img/pantalon1.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Pantalón vaquero',
      'categoria': 'Ropa',
      'cantidad': 18,
      'url_imagen': 'assets/img/pantalon2.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Pantalón vaquero',
      'categoria': 'Ropa',
      'cantidad': 15,
      'url_imagen': 'assets/img/pantalon3.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Pantalón vaquero',
      'categoria': 'Ropa',
      'cantidad': 10,
      'url_imagen': 'assets/img/pantalon4.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Saco de lana',
      'categoria': 'Ropa',
      'cantidad': 5,
      'url_imagen': 'assets/img/saco1.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Saco de lana',
      'categoria': 'Ropa',
      'cantidad': 7,
      'url_imagen': 'assets/img/saco2.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Vestido elegante',
      'categoria': 'Ropa',
      'cantidad': 8,
      'url_imagen': 'assets/img/vestido1.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Vestido elegante',
      'categoria': 'Ropa',
      'cantidad': 6,
      'url_imagen': 'assets/img/vestido2.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Vestido elegante',
      'categoria': 'Ropa',
      'cantidad': 5,
      'url_imagen': 'assets/img/vestido3.jpeg'
    });

    await db.insert('productos', {
      'descripcion': 'Vestido elegante',
      'categoria': 'Ropa',
      'cantidad': 4,
      'url_imagen': 'assets/img/vestido4.jpeg'
    });
  }

  // Verifica si el correo ya existe en la base de datos
  Future<bool> correoExiste(String correo) async {
    final db = await database;
    var res = await db.query("usuarios", where: "correo = ?", whereArgs: [correo]);
    return res.isNotEmpty;
  }

  // Registra un nuevo usuario
  Future<void> newUser(Usuario usuario) async {
    final db = await database;
    if (await correoExiste(usuario.correo)) {
      throw Exception("El correo ya está registrado. Intenta con un correo diferente.");
    } else {
      await db.insert('usuarios', usuario.toMap());
    }
  }

  // Función para login (como ejemplo)
  Future<Usuario?> login(String correo, String contrasena) async {
    final db = await database;
    var res = await db.query("usuarios",
        where: "correo = ? AND contrasena = ?", whereArgs: [correo, contrasena]);
    return res.isNotEmpty ? Usuario.fromMap(res.first) : null;
  }

}