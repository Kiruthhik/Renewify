import 'package:flutter/material.dart';
import 'post_model.dart'; // Ensure this path is correct
import 'post_write_page.dart'; // Ensure this path is correct
import 'dart:io'; // Import to handle File

class PostViewPage extends StatefulWidget {
  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  List<Post> staticPosts = [
    Post(
      'Solar Energy is a renewable resource. It can be harnessed using solar panels.',
      imageUrl:
          'https://www.renewableenergyworld.com/wp-content/uploads/2022/12/perovskite.jpg',
    ),
    Post(
      'சோலார் பேனல்களை கூரைகள் அல்லது சோலார் பண்ணைகளில் நிறுவி மின்சாரம் தயாரிக்கலாம்.',
      imageUrl:
          'https://cdn.pixabay.com/photo/2024/02/24/10/48/solar-panels-8593759_1280.png',
    ),
    Post(
      'बायोगैस का उत्पादन कार्बनिक पदार्थों के अपघटन से होता है। इसका उपयोग खाना पकाने और बिजली उत्पादन के लिए किया जा सकता है।',
      imageUrl:
          'https://img.freepik.com/free-vector/industry-biogas-illustration_23-2149397907.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1721520000&semt=ais_user',
    ),
  ];

  List<Post> dynamicPosts = [];

  void _toggleLike(int index) {
    setState(() {
      if (index < dynamicPosts.length) {
        // Toggle like for dynamic posts
        dynamicPosts[index].isLiked = !dynamicPosts[index].isLiked;
      } else {
        // Toggle like for static posts
        int staticIndex = index - dynamicPosts.length;
        staticPosts[staticIndex].isLiked = !staticPosts[staticIndex].isLiked;
      }
    });
  }

  void _addPost(String text, String? imageUrl) {
    setState(() {
      dynamicPosts.insert(0, Post(text, imageUrl: imageUrl));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Post> allPosts = [...dynamicPosts, ...staticPosts];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts'),
        backgroundColor: Color.fromARGB(255, 153, 219, 155),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostWritePage(
                    onPostCreated: _addPost,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 125, 253, 245), // Light green
              Color.fromARGB(255, 59, 200, 186), // Dark green
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: allPosts.isEmpty
            ? const Center(
                child:
                    Text('No posts yet', style: TextStyle(color: Colors.white)))
            : ListView.builder(
                itemCount: allPosts.length,
                itemBuilder: (context, index) {
                  final post = allPosts[index];
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post.imageUrl != null)
                          post.imageUrl!.startsWith('http')
                              ? Image.network(
                                  post.imageUrl!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(post.imageUrl!),
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        const SizedBox(height: 10),
                        Text(
                          post.text,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          post.createdAt.toString(),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.thumb_up,
                                color: post.isLiked ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => _toggleLike(index),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.comment, color: Colors.grey),
                              onPressed: () {
                                // Add your comment functionality here
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
