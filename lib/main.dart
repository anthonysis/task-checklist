import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/perfil_screen.dart';
import 'screens/cronometro_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programa de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'TASK-CHECKLIST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Text(
      'INICIO',
    ),
    Home(),
    CronometroScreen(),

    PerfilScreen(),
    Text(
      'PERFIL',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.purple,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'INICIO',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'TAREFAS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time), // Ícone de um relógio
              label: 'CRONOMETRO',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'PERFIL',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.purple, // Defina como transparente para que a cor de fundo do Container seja visível
          selectedItemColor: Colors.purple, // Define a cor dos ícones e rótulos dos itens selecionados
          unselectedItemColor: Colors.purple, // Define a cor dos ícones e rótulos dos itens não selecionados
        ),
      ),
    );
  }
}
