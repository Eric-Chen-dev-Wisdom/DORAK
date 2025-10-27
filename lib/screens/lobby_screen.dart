import 'package:flutter/material.dart';
import 'gameplay_screen.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});
  Widget _buildPlayer(String name, bool isPresent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isPresent ? const Color(0xFFDCFCE7) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPresent ? const Color(0xFF22C55E) : const Color(0xFFD1D5DB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isPresent
                  ? const Color(0xFF22C55E)
                  : const Color(0xFF9CA3AF),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isPresent
                    ? const Color(0xFF166534)
                    : const Color(0xFF6B7280),
                fontWeight: isPresent ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        print('Toggled: $category');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4F46E5)
                : const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4F46E5)
                      : const Color(0xFFCBD5E0),
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Color(0xFF4F46E5))
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF2D3748),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
        backgroundColor: const Color(0xFF4F46E5),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Room info dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ROOM CODE SECTION (your existing code)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0F2FE)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.group, color: Color(0xFF0EA5E9)),
                  const SizedBox(width: 8),
                  const Text(
                    'Room Code: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'D0R4K7',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      print('Copy room code');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // TEAMS SECTION (your existing code)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'TEAM A (2/4)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildPlayer('Player 1', true),
                        const SizedBox(height: 8),
                        _buildPlayer('Player 2', true),
                        const SizedBox(height: 8),
                        _buildPlayer('Empty Slot', false),
                        const SizedBox(height: 8),
                        _buildPlayer('Empty Slot', false),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'TEAM B (1/4)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildPlayer('Player 3', true),
                        const SizedBox(height: 8),
                        _buildPlayer('Empty Slot', false),
                        const SizedBox(height: 8),
                        _buildPlayer('Empty Slot', false),
                        const SizedBox(height: 8),
                        _buildPlayer('Empty Slot', false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // CATEGORY SELECTION SECTION (your existing code)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SELECT CATEGORIES (3-8)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Choose 3 to 8 categories for your game:',
                    style: TextStyle(color: Color(0xFF718096)),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildCategoryItem('Trivia', true),
                      _buildCategoryItem('Movies', false),
                      _buildCategoryItem('Sports', false),
                      _buildCategoryItem('Music', false),
                      _buildCategoryItem('Geography', false),
                      _buildCategoryItem('Food', false),
                      _buildCategoryItem('Science', false),
                      _buildCategoryItem('Pop Culture', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
                         // TEST BUTTONS (Remove these later)
            const SizedBox(height: 16),
            const Text(
              'Test Screens:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameplayScreen(
                            challengeType: 'trivia',
                            category: 'Science',
                          ),
                        ),
                      );
                    },
                    child: const Text('Test Trivia'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameplayScreen(
                            challengeType: 'physical',
                            category: 'Sports',
                          ),
                        ),
                      );
                    },
                    child: const Text('Test Physical'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // START GAME BUTTON
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameplayScreen(
                        challengeType: 'trivia', // We'll randomize this later
                        category: 'Trivia',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'START GAME',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
