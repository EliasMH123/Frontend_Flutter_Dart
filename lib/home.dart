import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'agregar.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List posts = [];

  readAll() async {
    final url = Uri.parse('http://10.0.2.2:3000/post/');
    final response = await http.get(url);
    posts = json.decode(response.body);
    setState(() {
      print(posts);
    });
  }

  Future<http.Response> deleteData(int id) async {
    final url = Uri.parse('http://10.0.2.2:3000/post/delete/${id}');

    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    readAll();
    return response;
  }

  @override
  void initState() {
    super.initState();
    readAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                final object = posts[index];
                Navigator.pushNamed(context, '/update', arguments: object);
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                            title: const Text("Eliminando post"),
                            content: Text("¿Desea eliminarlo? "),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      deleteData(posts[index]['idpost']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Post Eliminado !')));
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Eliminar",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ]));
              },
              child: Card(
                elevation: 15,
                child: ListTile(
                    leading:
                        const Icon(Icons.airline_seat_legroom_reduced_sharp),
                    title: Text("Titulo:" + '${posts[index]['titulo']}'),
                    subtitle: Text(
                        "Descripcion:" + '${posts[index]['descripcion']}')),
              ),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AgregarPage()));
        },
        tooltip: 'INSERTAR NUEVO POST',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
