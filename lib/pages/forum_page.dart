import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final List<_Post> _posts = [
    _Post(
      id: '1',
      title: 'GDG RCPIT Launch Event',
      content:
          'Join us for the grand launch of Google Developer Group at RCPIT! Workshops, networking & fun activities planned.',
      link:
          'https://gdg.community.dev/events/details/google-developer-group-rcpit-launch/',
      postedBy: 'Binod Dey',
      comments: [
        _Comment(user: 'Rahul', comment: 'Looking forward to it!'),
        _Comment(user: 'Ananya', comment: 'Excited to join!'),
      ],
      likes: 5,
    ),
    _Post(
      id: '2',
      title: 'Internship Tips from Alumni',
      content:
          'Check out these tips for securing internships in tech companies. Networking and open source contributions matter a lot!',
      link: null,
      postedBy: 'Rohan',
      comments: [
        _Comment(user: 'Kavita', comment: 'Very helpful, thanks!'),
      ],
      likes: 8,
    ),
  ];

  final Map<String, TextEditingController> _commentControllers = {};
  final Map<String, bool> _showComments = {};
  final String currentUserRole = 'Student';

  @override
  void initState() {
    super.initState();
    for (var post in _posts) {
      _commentControllers[post.id] = TextEditingController();
      _showComments[post.id] = false;
    }
  }

  @override
  void dispose() {
    for (var controller in _commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final post = _posts[index];
        final showComments = _showComments[post.id] ?? false;

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header with initials avatar
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF001A66),
                      child: Text(
                        _getInitials(post.postedBy),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.postedBy,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const Text("Alumni",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),

                const SizedBox(height: 12),

                // Post content with left thick black line
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(post.content),
                      if (post.link != null)
                        TextButton(
                          onPressed: () => _openUrl(post.link!),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'More Info',
                                style: TextStyle(
                                  color: Color(0xFF001A66),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset('assets/icons/open-arrow.svg',
                                  width: 16,
                                  height: 16,
                                  color: Color(0xFF001A66)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Likes & Replies
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleLike(post),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/like.svg',
                            width: 20,
                            colorFilter: ColorFilter.mode(
                              post.isLikedByCurrentUser
                                  ? Colors.blue
                                  : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text('${post.likes} likes'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SvgPicture.asset(
                      'assets/icons/comment.svg',
                      width: 20,
                      colorFilter:
                          const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 4),
                    Text('${post.comments.length} replies'),
                  ],
                ),

                // Show comments toggle
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showComments[post.id] =
                          !(_showComments[post.id] ?? false);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      showComments ? 'Hide comments' : 'Show comments',
                      style: const TextStyle(
                        color: Color(0xFF001A66),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Comments section
                if (showComments)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      ...post.comments.map((c) => ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 14,
                              backgroundColor: Color(0xFF001A66),
                              child: Text(
                                _getInitials(c.user),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(c.user,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            subtitle: Text(c.comment),
                          )),
                      if (currentUserRole == 'Student' ||
                          currentUserRole == 'Alumni')
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _commentControllers[post.id],
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: -6),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () => _addComment(post),
                                padding: const EdgeInsets.all(16.0),
                                icon: SvgPicture.asset('assets/icons/send.svg',
                                    width: 20,
                                    height: 20,
                                    color: Color(0xFF001A66)),
                                color: Color(0xFF001A66),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Utility to get initials from full name string
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
  }

  void _toggleLike(_Post post) {
    setState(() {
      post.isLikedByCurrentUser = !post.isLikedByCurrentUser;
      post.likes += post.isLikedByCurrentUser ? 1 : -1;
    });
  }

  void _addComment(_Post post) {
    final text = _commentControllers[post.id]?.text.trim();
    if (text == null || text.isEmpty) return;

    setState(() {
      post.comments.add(_Comment(
          user: currentUserRole == 'Student' ? 'You' : 'You', comment: text));
      _commentControllers[post.id]?.clear();
    });
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
    }
  }
}

class _Post {
  final String id;
  final String title;
  final String content;
  final String? link;
  final String postedBy;
  final List<_Comment> comments;
  int likes;
  bool isLikedByCurrentUser;

  _Post({
    required this.id,
    required this.title,
    required this.content,
    this.link,
    required this.postedBy,
    required this.comments,
    required this.likes,
    this.isLikedByCurrentUser = false,
  });
}

class _Comment {
  final String user;
  final String comment;

  _Comment({required this.user, required this.comment});
}
