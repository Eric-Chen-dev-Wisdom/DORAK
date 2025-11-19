import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../services/navigation_service.dart';
import '../services/lobby_service.dart';
import '../models/user_model.dart';
import '../models/room_model.dart';
import 'category_selection_screen.dart';
import 'package:DORAK/l10n/app_localizations.dart';
import '../widgets/chat_widget.dart'; // Import the new ChatWidget

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
  bool _isChatVisible = false; // Add this line

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
        ).then((_) {
          // Reset flag when returning from category screen
          setState(() {
            _navigatedToCategory = false;
          });
        });
      }
    }, onError: (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(
          AppLocalizations.of(context)!.errorConnectingRoom(error.toString()));
    });
  }

  void _createNewRoom() async {
    setState(() => _isLoading = true);
    try {
      final newRoom = await _lobbyService.createRoom(
        widget.user.id,
        _nicknameController.text.isEmpty
            ? AppLocalizations.of(context)!.guestLabel
            : _nicknameController.text,
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
            ).then((_) {
              // Reset flag when returning from category screen
              if (mounted) {
                setState(() {
                  _navigatedToCategory = false;
                });
              }
            });
          }
        }
      });
      print('✅ Room created and listening: ${newRoom.code}');
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(AppLocalizations.of(context)!.createRoomFailed(e.toString()));
    }
  }

  void _joinRoomWithCode() {
    final code = _roomCodeController.text.toUpperCase().trim();
    if (code.isEmpty || code.length != 6) {
      _showError(AppLocalizations.of(context)!.invalidRoomCode);
      return;
    }

    setState(() => _isLoading = true);
    _roomSubscription?.cancel();
    _joinExistingRoom(code);

    final userToJoin = UserModel(
      id: widget.user.id,
      displayName: _nicknameController.text.isEmpty
          ? AppLocalizations.of(context)!.guestLabel
          : _nicknameController.text,
      email: widget.user.email,
      photoUrl: widget.user.photoUrl,
      type: widget.user.type,
      createdAt: DateTime.now(),
    );

    _lobbyService.joinRoom(code, userToJoin, _selectedTeam).then((success) {
      if (!mounted) return;
      if (!success) {
        setState(() => _isLoading = false);
        _showError(AppLocalizations.of(context)!.roomJoinFailed);
      }
    }).catchError((e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError(AppLocalizations.of(context)!.errorJoiningRoom(e.toString()));
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _startGame() {
    if (_currentRoom == null) return;

    final totalPlayers =
        _currentRoom!.teamA.length + _currentRoom!.teamB.length;
    if (totalPlayers < 2) {
      _showError(AppLocalizations.of(context)!.needMorePlayers);
      return;
    }

    if (widget.user.id != _currentRoom!.hostId) {
      _showError(AppLocalizations.of(context)!.onlyHostCanStart);
      return;
    }

    _showStartGameConfirmation();
  }

  void _showStartGameConfirmation() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.startGameDialogTitle),
        content: Text(l10n.startGameDialogContent(
            (_currentRoom!.teamA.length + _currentRoom!.teamB.length)
                .toString())),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _lobbyService.startGame(_currentRoom!);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(l10n.startGameNow),
          ),
        ],
      ),
    );
  }

  void _shareRoomCode() async {
    if (_currentRoom == null) return;
    final l10n = AppLocalizations.of(context)!;

    try {
      print('🔄 Starting share process for room: ${_currentRoom!.code}');

      await _lobbyService.signalShare(
          _currentRoom!.code, widget.user.displayName);

      final roomCode = _currentRoom!.code;
      await _copyToClipboard(roomCode);

      _showSuccess(
        l10n.copyCodeSuccess(roomCode),
      );

      print('✅ Room code copied to clipboard: $roomCode');
    } catch (e) {
      print('❌ Error sharing room: $e');
      _showError(l10n.copyCodeFailed);
    }
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.gameLobbyTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: NavigationService.goBack,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _isLoading
                  ? _buildLoading(l10n)
                  : _currentRoom == null
                      ? _buildRoomSelection(l10n)
                      : _buildLobby(l10n),
            ),
          ),
          if (_currentRoom != null && _isChatVisible)
            Positioned(
              right: 16,
              bottom: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ChatWidget(
                  room: _currentRoom!,
                  user: widget.user,
                  lobbyService: _lobbyService,
                  l10n: l10n,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: _currentRoom != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isChatVisible = !_isChatVisible;
                });
              },
              backgroundColor: const Color(0xFFCE1126),
              child: Icon(_isChatVisible ? Icons.close : Icons.chat),
            )
          : null,
    );
  }

  Widget _buildLoading(AppLocalizations l10n) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(l10n.connectingRoom),
          ],
        ),
      );

  Widget _buildRoomSelection(AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _nicknameInput(l10n),
          const SizedBox(height: 20),
          _createRoomCard(l10n),
          const SizedBox(height: 20),
          Text(l10n.or, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          _joinRoomCard(l10n),
        ],
      ),
    );
  }

  Widget _nicknameInput(AppLocalizations l10n) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(l10n.enterNickname,
                  style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _nicknameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: l10n.nicknameLabel,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _createRoomCard(AppLocalizations l10n) => Card(
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
                Text(
                  l10n.createNewRoom,
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
                    child: Text(l10n.createRoom),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _joinRoomCard(AppLocalizations l10n) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.group_add, size: 40, color: Color(0xFF007A3D)),
              const SizedBox(height: 12),
              Text(l10n.joinExistingRoom,
                  style: TextStyle(
                      fontSize: AppConstants.titleSize,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _roomCodeController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: l10n.roomCodeLabel,
                  border: OutlineInputBorder(),
                  hintText: l10n.roomCodeHint,
                ),
              ),
              const SizedBox(height: 12),
              _teamSelector(l10n),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _joinRoomWithCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007A3D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text(l10n.joinRoom),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _teamSelector(AppLocalizations l10n) => Row(
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
              child: Text(l10n.teamA),
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
              child: Text(l10n.teamB),
            ),
          ),
        ],
      );

  Widget _buildLobby(AppLocalizations l10n) {
    final isHost = _currentRoom!.hostId == widget.user.id;
    return Column(
      children: [
        _roomInfoCard(isHost, l10n),
        const SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.green, size: 16),
              SizedBox(width: 8),
              Text(
                l10n.liveStatus(
                    (_currentRoom!.teamA.length + _currentRoom!.teamB.length)
                        .toString()),
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    _buildTeamCard('A', _currentRoom!.teamA,
                        const Color(0xFFFFE5E5), const Color(0xFFCE1126), l10n),
                    const SizedBox(width: 12),
                    _buildTeamCard('B', _currentRoom!.teamB,
                        const Color(0xFFE5F4E5), const Color(0xFF007A3D), l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _roomInfoCard(bool isHost, AppLocalizations l10n) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.roomCreated,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AppConstants.titleSize,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  l10n.code(_currentRoom!.code),
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
                      label: Text(l10n.startGameNow),
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
                    label: Text(l10n.shareRoomCode),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildTeamCard(String team, List<UserModel> users, Color bg,
          Color accent, AppLocalizations l10n) =>
      Expanded(
        child: Card(
          color: bg,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                    team == 'A'
                        ? l10n.teamA
                        : team == 'B'
                            ? l10n.teamB
                            : '',
                    style: TextStyle(
                        fontSize: AppConstants.titleSize,
                        fontWeight: FontWeight.bold,
                        color: accent)),
                const SizedBox(height: 8),
                Expanded(
                  child: users.isEmpty
                      ? Center(
                          child: Text(l10n.noPlayersYet,
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
                                  ? l10n.guestLabel
                                  : l10n.memberLabel,
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
