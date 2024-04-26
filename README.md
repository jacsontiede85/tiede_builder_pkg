Tiede Builder Package 

## Features

TODO: Package para builder de UI's sem renderização de toda interface, será reconstruído somente widgets que precisam de renderização

## Getting started

- Entre no arquivo pubspec.yaml
- Adicione isto ao arquivo pubspec.yaml do seu pacote:
``` Dart
dependencies:
     tiede_builder_pkg: ^1.0.0
```
- Get dependencies

``` shell
flutter pub get
```

## Usage

TODO: Caso de uso.

- Consumir uma API para teste na classe Cidades que receberá alteração para exemplo de notificação de alterações de dados
```dart
import "dart:convert";
import "package:http/http.dart" as http;

class ApiConsumer {

  Future<List> get(String uf) async {
    var response = await http.get(Uri.parse('https://brasilapi.com.br/api/ibge/municipios/v1/$uf?providers=dados-abertos-br,gov,wikipedia'));
    try{
      return jsonDecode(response.body);
    } catch(e) {
      return [];
    }
  }

}
```


- Uso da classe TiedeNotify para notificar alterações em variavéis da classe Cidades quando um novo dado for alterado
```dart
import 'package:tiede_builder_pkg/tiede_builder_pkg.dart';
import 'api_consumer.dart';

class Cidades extends TiedeNotify{

  List cidades = [];
  String uf = 'MG';

  getCidades({String uf = 'MG'}) async {
    this.uf = uf;
    cidades.clear();
    notify(isLoading: true);

    ApiConsumer().get(uf).then((value) {
      cidades = value;
      print('get ok');
      notify();
    });
  }

}

```


- Uso da classe TiedeBuilder para reconstruir widgets que precisam sofrer alteração
```dart
import 'package:flutter/material.dart';
import 'package:tiede_builder_pkg/tiede_builder_pkg.dart';
import 'cidades_controller.dart';

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

                        // RECONSTRUIR
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

                    // RECONSTRUIR
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

```
