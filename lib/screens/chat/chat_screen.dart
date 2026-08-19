import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      _Conversation('Chidera Okafor', 'Sure, I can pick that up by 5pm today', '2m', unread: 2),
      _Conversation('Kenji Watanabe', 'Sent you the inspection photos', '1h', unread: 0),
      _Conversation('Giulia Romano', 'Negotiation: \$45 for the walking tour', '3h', unread: 1),
      _Conversation('Vasatyl Support', 'Your dispute has been resolved', '1d', unread: 0),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Conversations'),
              Tab(text: 'Task Discussions'),
              Tab(text: 'Negotiations'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ConversationList(conversations: conversations),
            _ConversationList(conversations: conversations.where((c) => c.unread > 0).toList()),
            _ConversationList(conversations: conversations.where((c) => c.name.contains('Giulia')).toList()),
          ],
        ),
      ),
    );
  }
}

class _Conversation {
  final String name;
  final String preview;
  final String time;
  final int unread;
  _Conversation(this.name, this.preview, this.time, {this.unread = 0});
}

class _ConversationList extends StatelessWidget {
  final List<_Conversation> conversations;
  const _ConversationList({required this.conversations});

  @override
  Widget build(BuildContext context) {
    if (conversations.isEmpty) {
      return const Center(child: Text('Nothing here yet', style: TextStyle(color: AppColors.textMuted)));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: conversations.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 76),
      itemBuilder: (context, i) {
        final c = conversations[i];
        return ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.secondaryGreen.withOpacity(0.15),
            child: Text(c.name.substring(0, 1), style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w700)),
          ),
          title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(c.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(c.time, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              if (c.unread > 0) ...[
                const SizedBox(height: 4),
                CircleAvatar(radius: 9, backgroundColor: AppColors.primaryGreen, child: Text('${c.unread}', style: const TextStyle(fontSize: 10, color: Colors.white))),
              ],
            ],
          ),
        );
      },
    );
  }
}
