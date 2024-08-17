import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.state.dart';
import 'package:projeto_leituramiga/interface/widget/scroll_horizontal.dart';

void main() {
  Rota.registrarTodas();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Tema tema = TemaState.instancia.temaSelecionado!;
    return MaterialApp.router(
      title: 'LeiturAmiga',
      scrollBehavior: ScrollHorizontal(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Color(tema.accent)), // Cor da barra de rolagem
          thickness: WidgetStateProperty.all(8.0), // Espessura da barra de rolagem
          radius: Radius.circular(10), // Raio das bordas da barra de rolagem
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: RotaState.instancia!.appRouter.config(),
    );
  }
}
