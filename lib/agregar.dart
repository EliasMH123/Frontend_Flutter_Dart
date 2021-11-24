import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class AgregarPage extends StatefulWidget {
  const AgregarPage({Key? key}) : super(key: key);

  @override
  _AgregarPageState createState() => _AgregarPageState();
}

class _AgregarPageState extends State<AgregarPage> {
  String titulo = '';
  String descripcion = '';
  List<Model> model = [];
  late TextEditingController _nombre;
  late TextEditingController controllerPost;

  @override
  void initState() {
    _nombre = new TextEditingController();
    controllerPost = new TextEditingController();
  }

  Future<http.Response> createPost(Model m) async {
    final url = Uri.parse('http://10.0.2.2:3000/post/create');

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(m.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }

    this.model.add(m);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Post"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.0,
          ),
          titleInput(),
          SizedBox(
            height: 20.0,
          ),
          descripcionInput(),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              final postObjeto =
                  Model(titulo: this.titulo, descripcion: this.descripcion);
              final dataEnviar = await createPost(postObjeto);
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('AGREGAR'),
          ),
        ],
      ),
    );
  }

  Widget titleInput() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapchot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              icon: Icon(Icons.title),
              hintText: "Titulo",
              labelText: "Titulo: "),
          onChanged: (value) {
            setState(() {
              this.titulo = value;
            });
          },
        ),
      );
    });
  }

  Widget descripcionInput() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapchot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              icon: Icon(Icons.description),
              hintText: "Descripcion",
              labelText: "Descripcion:"),
          onChanged: (value) {
            setState(() {
              this.descripcion = value;
            });
          },
        ),
      );
    });
  }
}

/*final postObjeto =
    new Model(titulo: this.titulo, descripcion: this.descripcion);
    final dataEnviar = await createPost(postObjeto);
  Navigator.pushNamed(context, '/home');},*/