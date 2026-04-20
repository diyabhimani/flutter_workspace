import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_screen.dart';

class SearchUsersScreen extends StatefulWidget {
  const SearchUsersScreen({super.key});

  @override
  State<SearchUsersScreen> createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  String _getChatRoomId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  Future<void> _startChat(String otherUid, String otherName) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final chatRoomId = _getChatRoomId(currentUser.uid, otherUid);

    // Create or get chatroom
    final chatRoomRef =
        FirebaseFirestore.instance.collection('chatrooms').doc(chatRoomId);
    final doc = await chatRoomRef.get();
    if (!doc.exists) {
      await chatRoomRef.set({
        'users': [currentUser.uid, otherUid],
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          chatRoomId: chatRoomId,
          otherUserName: otherName,
          otherUserId: otherUid,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon:
                    const Icon(Icons.search_rounded, color: Color(0xFF6C63FF)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF8E8EA0)),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
            ),
          ),

          // User list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(color: Color(0xFF6C63FF)),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No users found',
                      style: GoogleFonts.poppins(color: const Color(0xFF8E8EA0)),
                    ),
                  );
                }

                final users = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  if (data['uid'] == currentUser.uid) return false;
                  if (_searchQuery.isEmpty) return true;
                  final name = (data['name'] ?? '').toString().toLowerCase();
                  return name.contains(_searchQuery.toLowerCase());
                }).toList();

                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      'No users match your search',
                      style:
                          GoogleFonts.poppins(color: const Color(0xFF8E8EA0)),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final data = users[index].data() as Map<String, dynamic>;
                    final name = data['name'] ?? 'Unknown';
                    final email = data['email'] ?? '';
                    final initials =
                        name.isNotEmpty ? name[0].toUpperCase() : '?';

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        email,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF8E8EA0),
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Color(0xFF6C63FF),
                          size: 20,
                        ),
                      ),
                      onTap: () => _startChat(data['uid'], name),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
