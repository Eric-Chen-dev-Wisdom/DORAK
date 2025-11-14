import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';
import '../services/lobby_service.dart';
import 'package:DORAK/l10n/app_localizations.dart';

class ChatWidget extends StatefulWidget {
  final GameRoom room;
  final UserModel user;
  final LobbyService lobbyService;
  final AppLocalizations l10n;

  const ChatWidget({
    super.key,
    required this.room,
    required this.user,
    required this.lobbyService,
    required this.l10n,
  });

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _sendChatMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;

    widget.lobbyService.sendChat(
      widget.room.code,
      widget.user.id,
      widget.user.displayName,
      text,
    );

    _chatController.clear();
  }

  Widget _buildChatToggle() {
    bool chatEnabled = widget.room.chatEnabled;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          chatEnabled ? widget.l10n.chatOn : widget.l10n.chatOff,
          style: TextStyle(
            color: chatEnabled ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
        SizedBox(width: 4),
        Switch(
          value: chatEnabled,
          onChanged: (value) async {
            await widget.lobbyService.setChatEnabled(widget.room.code, value);
          },
          activeColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    final isMe = message['senderId'] == widget.user.id;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey[300],
              child: Text(
                (message['senderName'] != null &&
                        message['senderName'].isNotEmpty)
                    ? message['senderName'][0]
                    : '?',
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isMe ? Color(0xFFE3F2FD) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Text(
                      message['senderName'] ?? widget.l10n.unknownUser,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  Text(
                    message['text'] ?? '',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          if (isMe)
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFFCE1126),
              child: Text(
                widget.l10n.you,
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _chatController,
            decoration: InputDecoration(
              hintText: widget.l10n.typeMessageHint,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onSubmitted: (text) => _sendChatMessage(),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.send, color: Color(0xFFCE1126)),
          onPressed: _sendChatMessage,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHost = widget.room.hostId == widget.user.id;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.chat, size: 20, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  widget.l10n.liveChat,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                if (isHost) _buildChatToggle(),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: widget.lobbyService.getChatStream(widget.room.code),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            widget.l10n.chatError(snapshot.error.toString())));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data?.docs ?? [];

                  if (messages.isEmpty) {
                    return Center(
                      child: Text(
                        widget.l10n.noMessagesYet,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index].data();
                      return _buildChatMessage(message);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            _buildChatInput(),
          ],
        ),
      ),
    );
  }
}
