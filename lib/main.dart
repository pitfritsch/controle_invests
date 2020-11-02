import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaginaInicial(title: 'Flutter Demo Home Page'),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  PaginaInicial({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final database = FirebaseDatabase.instance.reference();
  String valor;

  @override
  Widget build(BuildContext context) {
    return myApp();
  }

  void salvaValor() {
    print(valor);
    database.child("1").set({'valor': valor});
  }

  void getDados() {
    database.once().then((DataSnapshot dados) {
      print(dados.value);
    });
  }

  Scaffold myApp() {
    getDados();
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de investimentos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Valor'),
                        onChanged: (v) async {
                          setState(() {
                            valor = v;
                          });
                        },
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: FlatButton(
                    onPressed: () {
                      salvaValor();
                    },
                    child: Text('Adicionar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
