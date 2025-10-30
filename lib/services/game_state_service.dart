import '../models/room_model.dart';

class GameStateService {
  static void startGame(GameRoom room) {
    room.state = GameState.inGame;
    room.currentRound = 1;
    room.startVoting();
  }
  
  static void nextRound(GameRoom room) {
    room.currentRound++;
    room.startVoting();
  }
  
  static void endGame(GameRoom room) {
    room.state = GameState.gameComplete;
  }
}