import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:part_8/Photos.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photos> photo=[];
  Future<List<Photos>> getPhotos()async
  {
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
    {
      for(Map i in data)
      {
        Photos photos=Photos(title: i['title'], url: i['url'],id: i['id']);
        photo.add(photos);


      }
      return photo;



    }
    else
    {

      return photo;
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Course Part 8"),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context,snapshot)
                {
                  if(!snapshot.hasData)
                  {
                    return Text("Loading");

                  }
                  else
                  {


                    return ListView.builder(

                        itemCount: photo.length,
                        itemBuilder: (context,index)
                        {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                            ),
                            subtitle:Text(snapshot.data![index].url.toString()) ,
                            title: Text(snapshot.data![index].id.toString()),
                          );

                        });

                  }

                }
            ),
          ),

        ],
      ),
    );
  }
}
