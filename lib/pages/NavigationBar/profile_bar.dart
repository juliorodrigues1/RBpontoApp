import 'dart:async';
import 'dart:convert';
import 'package:Ponto_App/model/profile.dart';
import 'package:Ponto_App/ui/shared/globals.dart';
import 'package:Ponto_App/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Ponto_App/model/employ.dart' as employ_global;
import 'package:Ponto_App/global/variables.dart' as variables_global;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StreamController _postsController;
  ProfileModel profileModel;

  Future fetchPost() async {
    var url = Uri.http(PreferencesKeys.apiURL, '/api/employ/infomation');
    var response = await http.post(url, body: {
      'employ_id': employ_global.employ_id,
    });
    Map<String, dynamic> mapProfile = json.decode(response.body);
    print(mapProfile.toString());
    return mapProfile;
  }

  void getinfo() async {
    Map mapProfile = await fetchPost();
    setState(() {
      this.profileModel = ProfileModel.fromJson(mapProfile);
    });
  }

  teste() async {

}
  void initState() {
    getinfo();
    super.initState();
  }
  Widget _cabProfile(BuildContext context, int index){
    return Container(
      height: 150,
      color: Colors.blue,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            'http://' + this.profileModel.image,width: 100,

          ),
        ),
      ),

    );
  }

  Widget _listProfile(BuildContext context, int index) {
    return ListBody(
      children: <Widget>[
        SizedBox(height: 10),
        Card(
          child: Center(
            child: Text(
              this.profileModel.name,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 10),

        SizedBox(height: 20),
        Card(
          child: Text(
            'SECRETARIA: \n \n  ' + this.profileModel.organ,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Card(
          child: Text(
            'N° MATRICULA: \n \n  ' + this.profileModel.registrationNumber,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Card(
          child: Text(
            'CARGO: \n \n  ' + this.profileModel.officeName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Card(
          child: Text(
            'VÍNCULO: \n \n  ' + this.profileModel.bondName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Container(
            child: _cabProfile(context,1),
          ),
          Card(
            child: _listProfile(context, 1),
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: teste,
            backgroundColor: Global.mediumBlue,
            label: Text('Editar Imagen de Perfil'),
          )
        ],
      );

  }
}
