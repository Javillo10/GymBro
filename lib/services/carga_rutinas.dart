import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/rutina.dart';

class RutinaService {
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/rutinas.json');
  }

  Future<List<Rutina>> cargarRutinas() async {
    try {
      final file = await _getFile();

      if (!await file.exists()) return [];

      final content = await file.readAsString();
      final List data = jsonDecode(content);

      return data.map((e) => Rutina.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> guardarRutinas(List<Rutina> rutinas) async {
    final file = await _getFile();

    final data = rutinas.map((e) => e.toJson()).toList();

    await file.writeAsString(jsonEncode(data));
  }
}