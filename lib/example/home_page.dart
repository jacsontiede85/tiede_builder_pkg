import 'package:flutter/material.dart';
import 'package:tiede_builder_pkg/tiede_builder_pkg.dart';
import 'cidades_controller.dart';


// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  Cidades cidades = Cidades();

  @override
  Widget build(BuildContext context) {
    print('build home page');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidades'),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'UF',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if(value.toUpperCase().length == 2) {
                  cidades.getCidades(uf: value.toUpperCase());
                }
              }
            ),
          ),

          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TiedeBuilder(
                notify: cidades,
                builder: (context)=>
                  cidades.isLoading 
                  ? const CircularProgressIndicator()
                  : ListView(
                    children: cidades.cidades.map((e) => Text('${e['nome']} - ${cidades.uf}')).toList(),
                  )
              )
            ),
          ),

          TiedeBuilder(
            notify: cidades,
            builder: (context)=>
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Total de cidades: ${cidades.cidades.length}'),
              ),
          ),


        ],
      ),
    );
  }
}