import 'dart:convert';
import 'dart:io';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:RBPONTOAMAC/model/employ.dart' as employ_global;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'home.dart';

class Abono extends StatefulWidget {
  const Abono({Key key}) : super(key: key);

  @override
  _AbonoState createState() => _AbonoState();
}

class _AbonoState extends State<Abono> {
  List data = null;
  String day;
  String justification = '';
  File _imagemSelecionada = null;
  bool load = false;

  Future<dynamic> getData() async {
    // var url = Uri.https(PreferencesKeys.apiURL,
    //     '/api/listar/abonos/' + employ_global.employ_id);
    var url = Uri.http(PreferencesKeys.apihomologa,
        '/api/listar/abonos/' + employ_global.employ_id);
    var response = await http.get(url);
    setState(() {
      data = jsonDecode(response.body);
    });
    print('pendencias ' + data.toString());
  }

  Future abono(formControlSelectLack, justification) async {
    setState(() {
      load = true;
    });
    // var url = Uri.https(PreferencesKeys.apiURL, '/api/solicitar/abono');
    var url = Uri.http(PreferencesKeys.apihomologa, '/api/solicitar/abono');

    List<int> imageBytes;
    var image64Bytes;
    print('imagem: ' + (_imagemSelecionada != null).toString());
    if (_imagemSelecionada != null) {
      imageBytes = _imagemSelecionada.readAsBytesSync();
      image64Bytes = base64Encode(imageBytes);
    }
    print('''
      employ_id: ${employ_global.employ_id},
      formControlSelectLack: ${formControlSelectLack},
      inputJustification: ${justification},
      file : ${image64Bytes != null ? image64Bytes : ''}
    ''');
    var response = await http.post(url, body: {
      'employ_id': employ_global.employ_id,
      'formControlSelectLack': formControlSelectLack.toString(),
      'inputJustification': justification,
      'inputFile': image64Bytes != null ? image64Bytes : ''
    });
    print('response' + response.body);
    if (response.statusCode == 200) {
      setState(() {
        load = false;
      });
      if (jsonDecode(response.body)['success'] == true) {
        showmensage('Solicitação de abono realizado com sucesso.');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      employID: employ_global.employ_id,
                    )));
      } else {
        showmensage('Não foi possível realizar a solicitação');
      }
    }

    /*print('''erea;
      employ_id: ${employ_global.employ_id},
      formControlSelectLack: ${formControlSelectLack},
      inputJustification: ${justification},
      file : ${_imagemSelecionada}
    ''');*/
  }

  Future recuperarImagem(String origem) async {
    final ImagePicker _picker = ImagePicker();
    var pickedFile = null;
    switch (origem) {
      case "camera":
        pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
        );
        break;
      case "galeria":
        pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        break;
    }

    setState(() {
      _imagemSelecionada = File(pickedFile.path);
    });
  }

  showmensage(String mensagem) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aviso'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          )),
          backgroundColor: Color(0xff38c172),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo-amac.png'), scale: 2)),
          ),
        ),
      ),
      body: load == true
          ? Center(child: CircularProgressIndicator())
          : (data.length == 0 || data == null)
              ? Center(
                  child: Text('Nenhuma Falta/Pendências'),
                )
              : Container(
                  child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (data.length == 0) {
                          return Center(
                            child: Text('Nenhuma Falta/Pendências'),
                          );
                        } else {
                          var inputFormat = DateFormat('dd/MM/yyyy');

                          return ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('solicitação de abono'),
                                      actions: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: TextField(
                                            onChanged: (valor) {
                                              justification = valor;
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'motivo',
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text('Anexo de arquivo'),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                recuperarImagem("camera");
                                              },
                                              child: Text('Câmara'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                recuperarImagem("galeria");
                                              },
                                              child: Text('Galeria'),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _imagemSelecionada = null;
                                                  });
                                                },
                                                child: Text('Cancelar'),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    print(justification != '');
                                                    if (justification != '') {
                                                      abono(data[index]['id'],
                                                          justification);
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                              'Aviso'),
                                                          content: const Text(
                                                              'o Campo motivo é obrigatório'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'OK'),
                                                              child: const Text(
                                                                  'OK'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Text('Enviar'))
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            title: Text(inputFormat.format(
                                DateTime.parse(data[index]['created_at']))),
                            subtitle: Text('Clique para solicitar abono'),
                          );
                        }
                      }),
                ),
    );
  }
}
