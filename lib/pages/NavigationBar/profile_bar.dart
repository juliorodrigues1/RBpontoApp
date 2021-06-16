import 'dart:async';
import 'dart:convert';
import 'package:Ponto_App/model/profile.dart';
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
    var url =
    Uri.http(PreferencesKeys.apiURL, '/api/employ/infomation');
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

  void initState() {
    getinfo();
    super.initState();
  }

  Widget _listProfile(BuildContext context, int index) {
    return Container(
      child: Text('exemplo'),
    );
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
        // children: <Widget>[
        //   Container(child: _listProfile(context, 1) )
        // // ],
        children: <Widget>[
          Image.network('http://'+ this.profileModel.image  ),
          Container(
            child: _listProfile(context, 1),
          )
        ],
      ),
    );

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
  }
}
