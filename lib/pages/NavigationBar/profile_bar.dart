import 'dart:async';
import 'dart:convert';
import 'package:Ponto_App/values/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Ponto_App/global/variables.dart' as variables_global;
import 'package:Ponto_App/model/employ.dart' as employ_global;
import 'package:Ponto_App/model/profile.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  static Profile fromJson(Map mapProfile) {}
}

class _ProfileState extends State<Profile> {
  Profile profile = new Profile();

  StreamController _postsController;
  String employId;
  bool erro = true;
  String people;
  String user;
  String people_employ;


  Future fetchPost() async {
    var url = Uri.http(PreferencesKeys.apiURL, '/api/login');
    var response = await http.post(url, body: {
      'employ_id': employ_global.employ_id,
    });
    Map<String, dynamic> mapProfile = json.decode(response.body);
    return mapProfile;
  }
  // var response = await http.get(url, headers:{'employ_id': people});
  // try {
  // employId = jsonDecode(response.body)['user']['people']
  //   ['people_employ']['employ_id']
  //       .toString();
  // if(employId != null){
  //   erro = false ;
  //   log( employId.toString());
  // }else{
  //   return erro;
  // }
  // }catch (e) {
  //   return e.toString();
  // }

  void getinfo() async {
    Map mapProfile = await fetchPost();
    Profile profileConvert = Profile.fromJson(mapProfile);
    setState(() {
      this.profile = profileConvert;
    });
  }

  load() async {
    fetchPost().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  Future<Null> _handleRefresh() async {
    fetchPost().then((res) async {
      _postsController.add(res);
      return Null;
    });
  }

  void initState() {
    _postsController = new StreamController();
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, condition) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Image.asset("assets/branca.png"),
            ),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Image.network(PreferencesKeys.apiURL),
          Container(
            child: Text('Variavel :  ' + (1+1).toString()),
          )
        ],
      ),


      // body: StreamBuilder(
      //   stream: _postsController.stream,
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     print('Has error: ${snapshot.hasError}');
      //     if (snapshot.hasError) {
      //       return Text('teste');
      //     }else{
      //
      //     }
      //
      //   },
      // ),
    );
  }
}
