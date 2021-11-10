import 'dart:async';
import 'dart:convert';
import 'package:RBPONTOAMAC/model/profile.dart';
import 'package:RBPONTOAMAC/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:RBPONTOAMAC/model/employ.dart' as employ_global;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileModel profileModel;

  Future fetchPost() async {
    try {
      var url = Uri.http(PreferencesKeys.apiURL, '/api/employ/infomation');
      // var url = Uri.http(PreferencesKeys.apihomologa, '/api/employ/infomation');
      var response = await http.post(url, body: {
        'employ_id': employ_global.employ_id,
      });
      Map<String, dynamic> mapProfile = json.decode(response.body);
      print(mapProfile.toString());
      return mapProfile;
    } catch (ex) {
      return ex;
    }
  }

  void getinfo() async {
    Map mapProfile = await fetchPost();
    setState(() {
      this.profileModel = ProfileModel.fromJson(mapProfile);
    });
  }


  void initState() {
    getinfo();
    super.initState();
  }

  Widget _cabProfile(BuildContext context, int index) {
    return PreferredSize(
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
          child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: 'http://' + this.profileModel.image != null
                    ? Image.network(
                        'http://' + this.profileModel.image,
                        width: 100,
                      )
                    : Text('erro')),
          ),

        ),
      ),
    );

  }

  Widget _listProfile(BuildContext context, int index) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10),
        Card(
          child: Center(
            child: Text(
              this.profileModel.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    return Scaffold(
      appBar: _cabProfile(context, 1),
      body: _listProfile(context, 1),
    );
  }
}
