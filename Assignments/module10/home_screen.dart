import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'chat_screen.dart';
import 'search_users_screen.dart';
import 'image_gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getChatRoomId(String uid1, String uid2) {
    final sorted = [uid1, uid2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.chat_rounded, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Text('Chats'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library_rounded),
            tooltip: 'Image Gallery',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ImageGalleryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign Out',
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .where('users', arrayContains: currentUser.uid)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A3D),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Icon(
                      Icons.forum_rounded,
                      size: 48,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No conversations yet',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to start a new chat',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF8E8EA0),
                    ),
                  ),
                ],
              ),
            );
          }

          final chatRooms = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final data = chatRooms[index].data() as Map<String, dynamic>;
              final users = List<String>.from(data['users'] ?? []);
              final otherUid = users.firstWhere(
                (uid) => uid != currentUser.uid,
                orElse: () => '',
              );

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUid)
                    .get(),
                builder: (context, userSnap) {
                  if (!userSnap.hasData) {
                    return const SizedBox(height: 72);
                  }
                  final userData =
                      userSnap.data!.data() as Map<String, dynamic>? ?? {};
                  final name = userData['name'] ?? 'Unknown';
                  final lastMsg = data['lastMessage'] ?? '';
                  final timestamp = data['lastMessageTime'] as Timestamp?;
                  final timeStr = timestamp != null
                      ? timeago.format(timestamp.toDate())
                      : '';

                  return _ChatTile(
                    name: name,
                    lastMessage: lastMsg,
                    time: timeStr,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            chatRoomId: _getChatRoomId(
                                currentUser.uid, otherUid),
                            otherUserName: name,
                            otherUserId: otherUid,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C63FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchUsersScreen()),
          );
        },
        child: const Icon(Icons.edit_rounded, color: Colors.white),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final VoidCallback onTap;

  const _ChatTile({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6C63FF).withOpacity(0.8),
                    Color(0xFF03DAC6).withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    lastMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF8E8EA0),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Time
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF8E8EA0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
