// screens/lobby_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../services/lobby_service.dart';
import '../models/user_model.dart';
import '../models/room_model.dart';
import 'category_selection_screen.dart'; // ADD THIS IMPORT

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
    setState(() {
      _isLoading = true;
    });

    // Subscribe to real-time room updates
    _roomSubscription = _lobbyService.getRoomStream(roomCode).listen((room) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          if (room != null) {
            _currentRoom = room;
            print(
                '🔄 Room updated: ${room.teamA.length}A, ${room.teamB.length}B players');
          }
        });
      }
      // Drive navigation based on room state
      if (room != null && !_navigatedToCategory) {
        if (room.state == GameState.categorySelection) {
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
    }, onError: (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('❌ Error listening to room: $error');
      _showError('Failed to connect to room: $error');
    });
  }

  void _createNewRoom() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final newRoom = await _lobbyService.createRoom(
        widget.user.id,
        _nicknameController.text.isEmpty ? 'Guest' : _nicknameController.text,
      );

      // Subscribe to the new room
      _roomSubscription =
          _lobbyService.getRoomStream(newRoom.code).listen((room) {
        if (mounted && room != null) {
          setState(() {
            _currentRoom = room;
            _isLoading = false;
          });
        }
      });

      print('✅ Room created and listening: ${newRoom.code}');
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      _showError('Failed to create room: $e');
    }
  }

  void _joinRoomWithCode() {
    final roomCode = _roomCodeController.text.toUpperCase().trim();
    if (roomCode.isEmpty) {
      _showError('Please enter a room code');
      return;
    }

    if (roomCode.length != 6) {
      _showError('Room code must be 6 characters');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Start listening to the room BEFORE sending the join request
    // so that when Firestore updates, the UI reflects it immediately.
    _roomSubscription?.cancel();
    _joinExistingRoom(roomCode);

    // Create user with entered nickname
    final joiningUser = UserModel(
      id: widget.user.id,
      displayName:
          _nicknameController.text.isEmpty ? 'Guest' : _nicknameController.text,
      email: widget.user.email,
      photoUrl: widget.user.photoUrl,
      type: widget.user.type,
      createdAt: DateTime.now(),
    );

    _lobbyService
        .joinRoom(roomCode, joiningUser, _selectedTeam)
        .then((success) {
      if (!success && mounted) {
        setState(() {
          _isLoading = false;
        });
        _showError('Failed to join room. Please check the code.');
      } else {
        print('✅ Join request sent for room: $roomCode');
        // The stream listener will update the UI when we successfully join
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      _showError('Error joining room: $error');
    });
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _startGame() {
    if (_currentRoom == null) return;
    // Host triggers shared state change; all clients navigate on stream
    _lobbyService.startGame(_currentRoom!);
  }

  void _shareRoomCode() {
    if (_currentRoom != null) {
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
                'Share this code with your friends to join the game!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Or use this link:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                'dorak.app/join?code=${_currentRoom!.code}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Game Lobby'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? _buildLoading()
              : _currentRoom == null
                  ? _buildRoomSelection()
                  : _buildLobby(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Connecting to room...'),
        ],
      ),
    );
  }

  Widget _buildRoomSelection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Nickname Input
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Enter Your Nickname',
                    style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(
                      labelText: 'Nickname',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your nickname',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Create Room Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.add_circle_outline,
                      size: 40, color: Color(0xFFCE1126)),
                  const SizedBox(height: 12),
                  const Text(
                    'Create New Room',
                    style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Start a new game and invite friends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppConstants.bodySize,
                      color: AppConstants.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _createNewRoom,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Create Room'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Text('OR', style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 16),

          // Join Room Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.group_add,
                      size: 40, color: Color(0xFF007A3D)),
                  const SizedBox(height: 12),
                  const Text(
                    'Join Existing Room',
                    style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Enter a room code to join a game',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppConstants.bodySize,
                      color: AppConstants.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _roomCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Room Code',
                      border: OutlineInputBorder(),
                      hintText: 'Enter 6-digit code',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, letterSpacing: 2),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Select Team:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
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
                            side: const BorderSide(color: Color(0xFFCE1126)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text('Team A'),
                        ),
                      ),
                      const SizedBox(width: 12),
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
                            side: const BorderSide(color: Color(0xFF007A3D)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text('Team B'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _joinRoomWithCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007A3D),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Join Room'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLobby() {
    final isHost = _currentRoom!.hostId == widget.user.id;

    return Column(
      children: [
        // Room Info
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Room Created!',
                  style: TextStyle(
                    fontSize: AppConstants.titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Code: ${_currentRoom!.code}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCE1126),
                    letterSpacing: 3,
                  ),
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
                        backgroundColor: const Color(0xFF007A3D),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _shareRoomCode,
                    icon: const Icon(Icons.share),
                    label: const Text('Share Room Code'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Teams
        Expanded(
          child: Row(
            children: [
              // Team A
              _buildTeamCard('A', _currentRoom!.teamA, const Color(0xFFFFE5E5),
                  const Color(0xFFCE1126)),
              const SizedBox(width: 12),
              // Team B
              _buildTeamCard('B', _currentRoom!.teamB, const Color(0xFFE5F4E5),
                  const Color(0xFF007A3D)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamCard(
      String team, List<UserModel> users, Color cardColor, Color textColor) {
    return Expanded(
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                'Team $team',
                style: TextStyle(
                  fontSize: AppConstants.titleSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: users.isEmpty
                    ? const Center(
                        child: Text(
                          'No players yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: textColor,
                            child: Text(
                              users[index]
                                  .displayName
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            users[index].displayName,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            users[index].type == UserType.guest
                                ? 'Guest'
                                : 'Member',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: users[index].id == _currentRoom!.hostId
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
}
