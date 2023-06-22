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
      home: BemVindoScreen(),
    );
  }
}

class BemVindoScreen extends StatefulWidget {
  @override
  _BemVindoScreenState createState() => _BemVindoScreenState();
}

class _BemVindoScreenState extends State<BemVindoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _redirectToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'TASK-CHECKLIST')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _textAnimation,
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'TASK-CHECKLIST',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: ScaleTransition(
                      scale: _textAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            '/Users/anthonysilveira/StudioProjects/a2_mobile/assets/animated_welcome.gif',
                            fit: BoxFit.cover,
                            width: 250,
                            height: 200,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Seu app de Tarefas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ScaleTransition(
                  scale: _textAnimation,
                  child: ElevatedButton(
                    onPressed: _redirectToHomePage,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    child: Text('Vamos lá'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
