import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../services/lobby_service.dart';
import '../models/user_model.dart';
import '../models/room_model.dart';

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

  @override
  void initState() {
    super.initState();
    // Set hint text instead of pre-filling with actual value
    _nicknameController.text = '';
    if (widget.roomCode != null) {
      _joinExistingRoom(widget.roomCode!);
    }
  }

  void _createNewRoom() {
    final newRoom = _lobbyService.createRoom(
      widget.user.id, 
      _nicknameController.text.isEmpty ? 'Koala' : _nicknameController.text
    );
    
    setState(() {
      _currentRoom = newRoom;
    });
  }

  void _joinExistingRoom(String roomCode) {
    final room = _lobbyService.getRoom(roomCode);
    if (room != null) {
      // Create user with entered nickname
      final joiningUser = UserModel(
        id: widget.user.id,
        displayName: _nicknameController.text.isEmpty ? 'Koala' : _nicknameController.text,
        email: widget.user.email,
        photoUrl: widget.user.photoUrl,
        type: widget.user.type,
        createdAt: DateTime.now(),
      );
      
      final joined = _lobbyService.joinRoom(
        roomCode, 
        joiningUser, 
        _selectedTeam
      );
      
      if (joined) {
        setState(() {
          _currentRoom = room;
        });
      } else {
        _showError('Failed to join room. Please check the room code.');
      }
    } else {
      _showError('Room not found. Please check the room code.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
          padding: const EdgeInsets.all(16.0), // Reduced padding
          child: _currentRoom == null 
              ? _buildRoomSelection()
              : _buildLobby(),
        ),
      ),
    );
  }

  Widget _buildRoomSelection() {
    return SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
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
                      hintText: 'Koala', // Changed to "Koala" as example
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20), // Reduced spacing
          
          // Create Room Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Reduced padding
              child: Column(
                children: [
                  const Icon(Icons.add_circle_outline, size: 40, color: Color(0xFFCE1126)), // Smaller icon
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
                        padding: const EdgeInsets.symmetric(vertical: 12), // Reduced padding
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
              padding: const EdgeInsets.all(16.0), // Reduced padding
              child: Column(
                children: [
                  const Icon(Icons.group_add, size: 40, color: Color(0xFF007A3D)), // Smaller icon
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, letterSpacing: 2), // Smaller font
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Select Team:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Smaller font
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
                            padding: const EdgeInsets.symmetric(vertical: 10), // Reduced padding
                          ),
                          child: const Text('Team A'),
                        ),
                      ),
                      const SizedBox(width: 12), // Reduced spacing
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
                            padding: const EdgeInsets.symmetric(vertical: 10), // Reduced padding
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
                      onPressed: () {
                        if (_roomCodeController.text.isNotEmpty) {
                          _joinExistingRoom(_roomCodeController.text.toUpperCase());
                        } else {
                          _showError('Please enter a room code');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007A3D),
                        padding: const EdgeInsets.symmetric(vertical: 12), // Reduced padding
                      ),
                      child: const Text('Join Room'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20), // Added bottom padding for scroll
        ],
      ),
    );
  }

  Widget _buildLobby() {
    return Column(
      children: [
        // Room Info
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Reduced padding
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
                    fontSize: 28, // Slightly smaller font
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCE1126),
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible( // Added Flexible to prevent overflow
                      child: ElevatedButton.icon(
                        onPressed: _shareRoomCode,
                        icon: const Icon(Icons.share),
                        label: const Text('Share Code'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible( // Added Flexible to prevent overflow
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showError('Game starting feature coming tomorrow!');
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Game'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007A3D),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16), // Reduced spacing
        
        // Teams
        Expanded(
          child: Row(
            children: [
              // Team A
              Expanded(
                child: Card(
                  color: const Color(0xFFFFE5E5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // Reduced padding
                    child: Column(
                      children: [
                        const Text(
                          'Team A',
                          style: TextStyle(
                            fontSize: AppConstants.titleSize,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCE1126),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: _currentRoom!.teamA.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No players yet',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView(
                                  children: _currentRoom!.teamA.map((user) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: const Color(0xFFCE1126),
                                      child: Text(
                                        user.displayName.substring(0, 1).toUpperCase(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      user.displayName,
                                      style: const TextStyle(fontSize: 14), // Smaller font
                                    ),
                                    subtitle: Text(
                                      user.type == UserType.guest ? 'Guest' : 'Member',
                                      style: const TextStyle(fontSize: 12), // Smaller font
                                    ),
                                  )).toList(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12), // Reduced spacing
              
              // Team B
              Expanded(
                child: Card(
                  color: const Color(0xFFE5F4E5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // Reduced padding
                    child: Column(
                      children: [
                        const Text(
                          'Team B',
                          style: TextStyle(
                            fontSize: AppConstants.titleSize,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF007A3D),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: _currentRoom!.teamB.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No players yet',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView(
                                  children: _currentRoom!.teamB.map((user) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: const Color(0xFF007A3D),
                                      child: Text(
                                        user.displayName.substring(0, 1).toUpperCase(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(
                                      user.displayName,
                                      style: const TextStyle(fontSize: 14), // Smaller font
                                    ),
                                    subtitle: Text(
                                      user.type == UserType.guest ? 'Guest' : 'Member',
                                      style: const TextStyle(fontSize: 12), // Smaller font
                                    ),
                                  )).toList(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}