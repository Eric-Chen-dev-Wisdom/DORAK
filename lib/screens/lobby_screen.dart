import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../services/lobby_service.dart';
import '../models/user_model.dart';
import '../models/room_model.dart';
import 'category_selection_screen.dart';

class LobbyScreen extends StatefulWidget {
  final String? roomCode;
  final UserModel user;

  const LobbyScreen({
    super.key,
    this.roomCode,
    required this.user,
  });

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final LobbyService _lobbyService = LobbyService();
  final TextEditingController _roomCodeController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  GameRoom? _currentRoom;
  String _selectedTeam = 'A';
  StreamSubscription<GameRoom?>? _roomSubscription;
  bool _isLoading = false;
  bool _navigatedToCategory = false;
  String? _lastEventShown;

  @override
  void initState() {
    super.initState();
    _nicknameController.text = widget.user.displayName;

    if (widget.roomCode != null) {
      _joinExistingRoom(widget.roomCode!);
    }
  }

  @override
  void dispose() {
    _roomSubscription?.cancel();
    super.dispose();
  }

  void _joinExistingRoom(String roomCode) {
    setState(() => _isLoading = true);

    _roomSubscription = _lobbyService.getRoomStream(roomCode).listen((room) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _currentRoom = room;
      });

      if (room != null &&
          room.lastEvent != null &&
          room.lastEvent != _lastEventShown) {
        _lastEventShown = room.lastEvent;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(room.lastEvent!),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Navigation trigger
      if (room != null &&
          !_navigatedToCategory &&
          room.state == GameState.categorySelection) {
        _navigatedToCategory = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelectionScreen(
              room: room,
              user: widget.user,
            ),
          ),
        );
      }
    }, onError: (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError('Error connecting to room: $error');
    });
  }

  void _createNewRoom() async {
    setState(() => _isLoading = true);
    try {
      final newRoom = await _lobbyService.createRoom(
        widget.user.id,
        _nicknameController.text.isEmpty ? 'Guest' : _nicknameController.text,
      );

      _roomSubscription =
          _lobbyService.getRoomStream(newRoom.code).listen((room) {
        if (!mounted) return;
        if (room != null) {
          setState(() {
            _currentRoom = room;
            _isLoading = false;
          });
          if (!_navigatedToCategory &&
              room.state == GameState.categorySelection) {
            _navigatedToCategory = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategorySelectionScreen(
                  room: room,
                  user: widget.user,
                ),
              ),
            );
          }
        }
      });
      print('✅ Room created and listening: ${newRoom.code}');
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError('Failed to create room: $e');
    }
  }

  void _joinRoomWithCode() {
    final code = _roomCodeController.text.toUpperCase().trim();
    if (code.isEmpty || code.length != 6) {
      _showError('Please enter a valid 6-character room code.');
      return;
    }

    setState(() => _isLoading = true);
    _roomSubscription?.cancel();
    _joinExistingRoom(code);

    final userToJoin = UserModel(
      id: widget.user.id,
      displayName:
          _nicknameController.text.isEmpty ? 'Guest' : _nicknameController.text,
      email: widget.user.email,
      photoUrl: widget.user.photoUrl,
      type: widget.user.type,
      createdAt: DateTime.now(),
    );

    _lobbyService.joinRoom(code, userToJoin, _selectedTeam).then((success) {
      if (!mounted) return;
      if (!success) {
        setState(() => _isLoading = false);
        _showError('Room not found or join failed.');
      }
    }).catchError((e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError('Error joining room: $e');
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _startGame() {
    if (_currentRoom == null) return;
    if (widget.user.id != _currentRoom!.hostId) {
      _showError('Only the host can start the game.');
      return;
    }
    _lobbyService.startGame(_currentRoom!);
  }

  void _shareRoomCode() {
    if (_currentRoom == null) return;

    _lobbyService.signalShare(_currentRoom!.code, widget.user.displayName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Room Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _currentRoom!.code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCE1126),
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Share this code with your friends!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Game Lobby'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: NavigationService.goBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? _buildLoading()
              : _currentRoom == null
                  ? _buildRoomSelection()
                  : _buildLobby(),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Connecting to room...'),
          ],
        ),
      );

  Widget _buildRoomSelection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _nicknameInput(),
          const SizedBox(height: 20),
          _createRoomCard(),
          const SizedBox(height: 20),
          const Text('OR', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          _joinRoomCard(),
        ],
      ),
    );
  }

  Widget _nicknameInput() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Enter Your Nickname',
                  style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _nicknameController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _createRoomCard() => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 230,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_circle_outline,
                  size: 50,
                  color: Color(0xFF007A3D),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Create New Room',
                  style: TextStyle(
                    fontSize: AppConstants.titleSize + 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _createNewRoom,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Create Room'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _joinRoomCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.group_add, size: 40, color: Color(0xFF007A3D)),
              const SizedBox(height: 12),
              const Text('Join Existing Room',
                  style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _roomCodeController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Room Code',
                  border: OutlineInputBorder(),
                  hintText: 'Enter 6-digit code',
                ),
              ),
              const SizedBox(height: 12),
              _teamSelector(),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _joinRoomWithCode,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Join Room'),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _teamSelector() => Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _selectedTeam = 'A'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _selectedTeam == 'A'
                    ? Colors.white
                    : const Color(0xFFCE1126),
                backgroundColor: _selectedTeam == 'A'
                    ? const Color(0xFFCE1126)
                    : Colors.transparent,
              ),
              child: const Text('Team A'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => _selectedTeam = 'B'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _selectedTeam == 'B'
                    ? Colors.white
                    : const Color(0xFF007A3D),
                backgroundColor: _selectedTeam == 'B'
                    ? const Color(0xFF007A3D)
                    : Colors.transparent,
              ),
              child: const Text('Team B'),
            ),
          ),
        ],
      );

  Widget _buildLobby() {
    final isHost = _currentRoom!.hostId == widget.user.id;
    return Column(
      children: [
        _roomInfoCard(isHost),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              _buildTeamCard('A', _currentRoom!.teamA, const Color(0xFFFFE5E5),
                  const Color(0xFFCE1126)),
              const SizedBox(width: 12),
              _buildTeamCard('B', _currentRoom!.teamB, const Color(0xFFE5F4E5),
                  const Color(0xFF007A3D)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _roomInfoCard(bool isHost) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Room Created!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppConstants.titleSize,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'Code: ${_currentRoom!.code}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCE1126),
                      letterSpacing: 3),
                ),
                const SizedBox(height: 12),
                if (isHost)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _startGame,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Game'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007A3D)),
                    ),
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _shareRoomCode,
                    icon: const Icon(Icons.share),
                    label: const Text('Share Room Code'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildTeamCard(
          String team, List<UserModel> users, Color bg, Color accent) =>
      Expanded(
        child: Card(
          color: bg,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('Team $team',
                    style: TextStyle(
                        fontSize: AppConstants.titleSize,
                        fontWeight: FontWeight.bold,
                        color: accent)),
                const SizedBox(height: 8),
                Expanded(
                  child: users.isEmpty
                      ? const Center(
                          child: Text('No players yet',
                              style: TextStyle(color: Colors.grey)),
                        )
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: accent,
                              child: Text(
                                users[i].displayName[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(users[i].displayName),
                            subtitle: Text(
                              users[i].type == UserType.guest
                                  ? 'Guest'
                                  : 'Member',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: users[i].id == _currentRoom!.hostId
                                ? const Icon(Icons.star,
                                    color: Colors.amber, size: 16)
                                : null,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
}
