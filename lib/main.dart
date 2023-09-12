// Importamos el paquete Flutter Material, que proporciona widgets para construir UI de Material Design.
import 'package:flutter/material.dart';

// Definimos un enumerador (enum) llamado SingingCharacter con dos valores: zelda y link.
enum SingingCharacter { zelda, link }

// La función principal main() es el punto de entrada de la aplicación Flutter.
void main() {
  // Ejecutamos la aplicación Flutter creando una instancia de MyApp y la pasamos a runApp().
  runApp(const MyApp());
}

// Definimos la clase MyApp como un widget StatelessWidget (sin estado).
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // La función build() crea la interfaz de usuario de la aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Título de la aplicación
      home:
          const MyHomePage(title: 'Flutter Demo Home Page'), // Página de inicio
    );
  }
}

// Definimos la clase MyHomePage como un StatefulWidget (con estado).
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title; // Título de la página

  // Esta función crea el estado mutable para la página.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Definimos la clase _MyHomePageState para el estado de MyHomePage.
class _MyHomePageState extends State<MyHomePage> {
  // Variables de estado
  bool _isChecked = false;
  DateTime _selectedDate = DateTime.now();
  String _selectedOption = 'Inicio';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showList = false;
  bool _showScrollContent = false;

  // Función para mostrar un cuadro de diálogo de alerta
  void _showAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text('Acabas de Presionar el Botón'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Aceptar'),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  // Función para obtener el widget seleccionado en función de _selectedOption
  Widget _getSelectedOptionWidget() {
    switch (_selectedOption) {
      case 'AlertDialog':
        return _buildAlertDialog();
      case 'Card':
        return _buildCard();
      case 'Checkbox':
        return _buildCheckbox();
      case 'ShowDatePicker':
        return _buildDatePicker();
      case 'ListView':
        return _buildListView();
      case 'Form':
        return _buildForm();
      case 'SingleChildScrollView':
        return _buildSingleChildScrollView();
      case 'Radio':
        return RadioExample(); // Agregado el ejemplo de Radio aquí
      case 'BottomNavigationBar':
        return Text(
            'La barra de navegación se encuentra abajo, es donde se encuentra Inicio, Negocios y Escuela');
      default:
        return Text(
          _selectedOption.isEmpty
              ? 'Selecciona una opción'
              : 'Opción seleccionada: $_selectedOption',
          style: TextStyle(fontSize: 18),
        );
    }
  }

  // Función para construir un botón de alerta
  Widget _buildAlertDialog() {
    return ElevatedButton(
      onPressed: _showAlertDialog,
      child: const Text('Mostrar Diálogo'),
    );
  }

  // Función para construir una tarjeta (Card)
  Widget _buildCard() {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text('Esto es una Card'),
      ),
    );
  }

  // Función para construir una casilla de verificación (Checkbox)
  Widget _buildCheckbox() {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? newValue) {
        setState(() {
          _isChecked = newValue ?? false;
        });
      },
    );
  }

  // Función para mostrar un selector de fecha
  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2023, 12, 31),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Función para construir un botón de selector de fecha
  Widget _buildDatePicker() {
    return ElevatedButton(
      onPressed: _showDatePicker,
      child: const Text('Mostrar Selector de Fecha'),
    );
  }

  // Función para construir una lista desplegable
  Widget _buildListView() {
    return _showList
        ? Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Elemento $index'),
                );
              },
            ),
          )
        : ElevatedButton(
            onPressed: () {
              setState(() {
                _showList = true;
              });
            },
            child: const Text('Mostrar Lista'),
          );
  }

  // Función para construir un formulario de inicio de sesión
  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Iniciar Sesión',
            style: TextStyle(fontSize: 18),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Correo Electrónico',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Contraseña',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _passwordController.text;
              print('Email: $email, Contraseña: $password');
            },
            child: const Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }

  // Función para construir un widget con desplazamiento único (SingleChildScrollView)
  Widget _buildSingleChildScrollView() {
    return _showScrollContent
        ? SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.yellow,
                  height: 120.0,
                  alignment: Alignment.center,
                  child: const Text('Fixed Height Content'),
                ),
                Container(
                  color: Colors.red,
                  height: 120.0,
                  alignment: Alignment.center,
                  child: const Text('Flexible Content'),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              setState(() {
                _showScrollContent = true;
              });
            },
            child: const Text('Mostrar SingleChildScrollView'),
          );
  }

  // Función build() para construir la interfaz de usuario de la página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seleccionaste: $_selectedOption',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getSelectedOptionWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Barra de navegación inferior (BottomNavigationBar)
          BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            onTap: (index) {
              String option = 'Inicio';

              switch (index) {
                case 0:
                  option = 'Inicio';
                  break;
                case 1:
                  option = 'Negocios';
                  break;
                case 2:
                  option = 'Escuela';
                  break;
              }
              setState(() {
                _selectedOption = option;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Negocios',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Escuela',
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Encabezado del cajón de navegación (Drawer)
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drawer Opciones',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Manuel Alberto Rivera Borrego',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Número de control: 19540502',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Elementos de la lista en el cajón de navegación
            ListTile(
              title: Text('AlertDialog'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'AlertDialog';
                });
              },
            ),
            ListTile(
              title: Text('Card'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'Card';
                });
              },
            ),
            ListTile(
              title: Text('Checkbox'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'Checkbox';
                });
              },
            ),
            ListTile(
              title: Text('ShowDatePicker'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'ShowDatePicker';
                });
              },
            ),
            ListTile(
              title: Text('ListView'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'ListView';
                });
              },
            ),
            ListTile(
              title: Text('Form'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'Form';
                });
              },
            ),
            ListTile(
              title: Text('SingleChildScrollView'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'SingleChildScrollView';
                });
              },
            ),
            ListTile(
              title: Text('Radio'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'Radio';
                });
              },
            ),
            ListTile(
              title: Text('BottomNavigationBar'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = 'BottomNavigationBar';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Definimos la clase RadioExample como un StatefulWidget para un grupo de botones de opción (Radio).
class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

// Definimos la clase _RadioExampleState para el estado de RadioExample.
class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.zelda;

  // Función build() para construir los botones de opción (Radio).
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Zelda'), // Cambiado de 'Lafayette' a 'Zelda'
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.zelda,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Link'), // Cambiado de 'Thomas Jefferson' a 'Link'
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.link,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
