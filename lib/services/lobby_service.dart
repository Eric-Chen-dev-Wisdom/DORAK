import '../models/room_model.dart';
import '../models/user_model.dart';

class LobbyService {
  // In-memory storage for prototype (we'll replace with Firebase later)
  static final Map<String, GameRoom> _rooms = {};
  
  // Generate random room code
  String _generateRoomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = String.fromCharCodes(
      List.generate(6, (index) => 
        chars.codeUnitAt((DateTime.now().microsecondsSinceEpoch + index) % chars.length)
      )
    );
    return random;
  }
  
  // Create new room
  GameRoom createRoom(String hostId, String hostName) {
    final roomCode = _generateRoomCode();
    
    // Create host user
    final hostUser = UserModel(
      id: hostId,
      displayName: hostName,
      email: '',
      photoUrl: '',
      type: UserType.guest,
      createdAt: DateTime.now(),
    );
    
    // Create room with PROPERLY INITIALIZED voting properties
    final room = GameRoom(
      code: roomCode,
      hostId: hostId,
      teamA: [hostUser],
      teamB: [],
      selectedCategories: [],
      state: GameState.waiting,
      createdAt: DateTime.now(),
      maxPlayers: 10,
      // FIX: Explicitly initialize voting properties
      teamVotes: {'A': {}, 'B': {}},
      voteHistory: {'A': [], 'B': []},
    );
    
    _rooms[roomCode] = room;
    return room;
  }
  
  // Join existing room
  bool joinRoom(String roomCode, UserModel user, String team) {
    if (!_rooms.containsKey(roomCode)) return false;
    
    final room = _rooms[roomCode]!;
    
    // Check if user already in room
    final existingUser = room.teamA.any((u) => u.id == user.id) || 
                        room.teamB.any((u) => u.id == user.id);
    if (existingUser) return true;
    
    // Add to selected team
    if (team == 'A') {
      room.teamA.add(user);
    } else {
      room.teamB.add(user);
    }
    
    return true;
  }
  
  // Get room by code
  GameRoom? getRoom(String roomCode) {
    return _rooms[roomCode];
  }
  
  // Check if room exists
  bool roomExists(String roomCode) {
    return _rooms.containsKey(roomCode);
  }
}