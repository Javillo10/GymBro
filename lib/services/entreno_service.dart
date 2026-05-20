import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/entreno.dart';

class EntrenoService {
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/entrenos.json');
  }

  Future<List<Entreno>> cargar() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      final List data = jsonDecode(content);
      return data.map((e) => Entreno.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> guardar(List<Entreno> entrenos) async {
    final file = await _getFile();
    final data = entrenos.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(data));
  }

  Future<void> anadir(Entreno entreno) async {
    final entrenos = await cargar();
    entrenos.add(entreno);
    await guardar(entrenos);
  }
}
