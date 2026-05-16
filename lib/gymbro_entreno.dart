import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

import 'models/rutina.dart';
import 'models/entreno.dart';

Future<File> _getFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/entrenos.json');
}

class PantallaEntreno extends StatefulWidget {
  final Rutina rutina;

  const PantallaEntreno({super.key, required this.rutina});

  @override
  State<PantallaEntreno> createState() => _PantallaEntrenoState();
}

class _PantallaEntrenoState extends State<PantallaEntreno> {
  late List<bool> _ejerciciosCompletados;

  @override
  void initState() {
    super.initState();
    _ejerciciosCompletados = List.filled(
      widget.rutina.getEjercicios.length,
      false,
    );
  }

  int get _completados => _ejerciciosCompletados.where((e) => e).length;
  int get _total => widget.rutina.getEjercicios.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      appBar: AppBar(
        title: Text(widget.rutina.nombre),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  '$_completados / $_total',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _total > 0 ? _completados / _total : 0,
                      backgroundColor: const Color(0xFF1E2126),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2D4E4A),
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.rutina.getEjercicios.isEmpty
                ? const Center(
                    child: Text(
                      "No hay ejercicios en esta rutina",
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: widget.rutina.getEjercicios.length,
                    itemBuilder: (context, index) {
                      final ejercicio = widget.rutina.getEjercicios[index];
                      final completado = _ejerciciosCompletados[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _ejerciciosCompletados[index] = !completado;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E2126),
                              borderRadius: BorderRadius.circular(16),
                              border: completado
                                  ? Border.all(
                                      color: const Color(0xFF2D4E4A),
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: completado
                                        ? const Color(0xFF2D4E4A)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: completado
                                          ? const Color(0xFF2D4E4A)
                                          : Colors.white54,
                                      width: 2,
                                    ),
                                  ),
                                  child: completado
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ejercicio.nombre,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          decoration: completado
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            ejercicio.grupoMuscular.icono,
                                            size: 14,
                                            color: Colors.white54,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            ejercicio.grupoMuscular.nombre,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${ejercicio.series} series',
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final file = await _getFile();
                  List<Entreno> entrenos = [];

                  if (await file.exists()) {
                    final content = await file.readAsString();
                    entrenos = (jsonDecode(content) as List)
                        .map((e) => Entreno.fromJson(e))
                        .toList();
                  }

                  final nombresCompletados = <String>[];
                  for (int i = 0; i < widget.rutina.getEjercicios.length; i++) {
                    if (_ejerciciosCompletados[i]) {
                      nombresCompletados.add(
                        widget.rutina.getEjercicios[i].nombre,
                      );
                    }
                  }

                  final nuevoEntreno = Entreno(
                    nombreRutina: widget.rutina.nombre,
                    fecha: DateTime.now(),
                    ejerciciosCompletados: nombresCompletados,
                    totalEjercicios: widget.rutina.getEjercicios.length,
                  );

                  entrenos.add(nuevoEntreno);
                  await file.writeAsString(
                    jsonEncode(entrenos.map((e) => e.toJson()).toList()),
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Terminar entrenamiento',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
