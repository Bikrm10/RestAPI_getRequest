// ignore: file_names
import 'dart:convert';
import 'dart:ui';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() =>
  _HomeScreenState();
  
  
 
  
}
class _HomeScreenState extends State<HomeScreen>{
  List<dynamic> users = [];
  @override
  Widget build (BuildContext context){
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Rest API Call"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user['email'];
          final name = user['name']['first'];
          final imageUrl = user['picture']['thumbnail'];
          return ListTile(
            leading: CircleAvatar(
              child:Image.network(imageUrl,
              ),
              ),
            
            title: Text(name),
            subtitle: Text(email),
          );
        },
       ),
      floatingActionButton: FloatingActionButton(onPressed: () {fetchUsers();},
      ),

    );
  }

  void fetchUsers() async{
    print('fetch User called');
    const url = "https://randomuser.me/api/?results=100";
    var uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    
    print('fetch User completed');

    
  }

}