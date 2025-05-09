import 'package:flutter/material.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/profile.dart';

class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  final List<Friend> friends = [
    Friend(
      name: "Vandan",
      lastMessage: "Hey, how's it going?",
      time: "3h ago",
      profilePic: "https://randomuser.me/api/portraits/men/1.jpg",
      isOnline: true,
    ),
    Friend(
      name: "Ishita",
      lastMessage: "See you tomorrow!",
      time: "5h ago",
      profilePic: "https://randomuser.me/api/portraits/women/2.jpg",
      isOnline: false,
    ),
    Friend(
      name: "Dhyana",
      lastMessage: "Can we meet at 3?",
      time: "1d ago",
      profilePic: "https://randomuser.me/api/portraits/women/2.jpg",
      isOnline: true,
    ),
    Friend(
      name: "Yashvi",
      lastMessage: "Hello",
      time: "1d ago",
      profilePic: "https://randomuser.me/api/portraits/women/2.jpg",
      isOnline: false,
    ),
  ];

  int myindex = 1;
  final TextEditingController _searchController = TextEditingController();
  List<Friend> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    // Initially show all friends
    filteredFriends = List.from(friends); // Copy the original list
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        // If search field is empty, show all friends
        filteredFriends = List.from(friends);
      } else {
        // Filter friends based on name (case-insensitive)
        filteredFriends = friends.where((friend) {
          return friend.name.toLowerCase().contains(_searchController.text.toLowerCase());
        }).toList();

        // If no matches, filteredFriends will be empty
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VibeTribe", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
        centerTitle: true,
        toolbarHeight: 38,
        backgroundColor: Colors.lightBlue[300],
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person))
        ],
      ),
      
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController, // Attach the controller
              decoration: InputDecoration(
                hintText: "Search friends...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                )
              ),
            ),
          ),
          Expanded(
            child: filteredFriends.isEmpty && _searchController.text.isNotEmpty
                ? Center(child: Text("Friend not found", style: TextStyle(fontSize: 18, color: Colors.grey)))
                : ListView.builder(
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      return FriendTile(friend: filteredFriends[index]);
                    },
                  ),
          ),
        ],
      ),
      
    );
  }
}

class Friend {
  final String name;
  final String lastMessage;
  final String time;
  final String profilePic;
  final bool isOnline;

  Friend({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profilePic,
    required this.isOnline,
  });
}

class FriendTile extends StatelessWidget {
  final Friend friend;

  const FriendTile({required this.friend});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(friend.profilePic),
            radius: 25,
          ),
          if (friend.isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            friend.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            friend.time,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
      subtitle: Text(
        friend.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(friend: friend),
          ),
        );
      },
    );
  }
}

class ChatScreen extends StatelessWidget {
  final Friend friend;

  const ChatScreen({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(friend.profilePic),
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(friend.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(child: Text("Chat with ${friend.name}")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}