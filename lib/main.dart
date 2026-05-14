import 'package:flutter/material.dart';
import 'package:gymbro/gymbro_app.dart';
import 'package:provider/provider.dart';
import 'models/lista_rutinas.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ListaRutinas()..cargar(),
      child: GymbroAppApp(),
    ),
  );
}