import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: const Icon(Icons.person_add_alt_1_outlined),
        actions: const [
          Icon(Icons.more_horiz),
        ],
        title: const Text(
          'username',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
        imageUrl: "http://via.placeholder.com/350x150",
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) =>const Icon(Icons.error),
     ),
                  ),
                ],
              ),
             const SizedBox(height: 15,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                          Column(
                            children: [
                              Text('10',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                              const SizedBox(height: 5,),
                              Text('Following', style: TextStyle(
                                fontSize: 14,
                              ),)
                            ],
                            
                          ),
                          Container(
                            color: Colors.black54,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          //2
Column(
                            children: [
                              Text('1',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                              const SizedBox(height: 5,),
                              Text('Followers', style: TextStyle(
                                fontSize: 14,
                              ),)
                            ],
                            
                          ),
                          //3
                          Column(
                            children: [
                              Text('2',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                              const SizedBox(height: 5,),
                              Text('Likes', style: TextStyle(
                                fontSize: 14,
                              ),)
                            ],
                            
                          )
              ],
             ),
             SizedBox(height: 15,),
             Container(
              width: 140,
              height: 47,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
             ),
            ],
          ),
        ],
      ),
    );
  }
}
