import 'package:flutter/material.dart';
import '../../services/analytics_service.dart';
import '../../utils/constants.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AnalyticsService _analyticsService = AnalyticsService();
  
  int _totalGames = 0;
  double _avgDuration = 0.0;
  Map<String, int> _popularCategories = {};
  Map<String, int> _powerCardStats = {};
  Map<String, dynamic> _bonusStats = {};
  bool _loading = true;
  int _selectedDays = 7;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    setState(() => _loading = true);

    final results = await Future.wait([
      _analyticsService.getTotalGames(),
      _analyticsService.getAverageGameDuration(days: _selectedDays),
      _analyticsService.getPopularCategories(days: _selectedDays),
      _analyticsService.getPowerCardStats(days: _selectedDays),
      _analyticsService.getBonusStats(days: _selectedDays),
    ]);

    setState(() {
      _totalGames = results[0] as int;
      _avgDuration = results[1] as double;
      _popularCategories = results[2] as Map<String, int>;
      _powerCardStats = results[3] as Map<String, int>;
      _bonusStats = results[4] as Map<String, dynamic>;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        backgroundColor: AppConstants.primaryRed,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.calendar_today),
            onSelected: (days) {
              setState(() => _selectedDays = days);
              _loadAnalytics();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text('Last 24 Hours')),
              const PopupMenuItem(value: 7, child: Text('Last 7 Days')),
              const PopupMenuItem(value: 30, child: Text('Last 30 Days')),
              const PopupMenuItem(value: 90, child: Text('Last 90 Days')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnalytics,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadAnalytics,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period indicator
                    Center(
                      child: Chip(
                        avatar: const Icon(Icons.calendar_today, size: 16),
                        label: Text('Last $_selectedDays Days'),
                        backgroundColor: AppConstants.primaryGreen.withOpacity(0.1),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Overview cards
                    _buildOverviewSection(),

                    const SizedBox(height: 24),

                    // Category popularity
                    _buildCategorySection(),

                    const SizedBox(height: 24),

                    // Power card usage
                    _buildPowerCardSection(),

                    const SizedBox(height: 24),

                    // Bonus statistics
                    _buildBonusSection(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Games',
                _totalGames.toString(),
                Icons.sports_esports,
                AppConstants.primaryRed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Avg Duration',
                '${(_avgDuration / 60).toStringAsFixed(1)} min',
                Icons.timer,
                AppConstants.primaryGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    if (_popularCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    // Sort by usage
    final sorted = _popularCategories.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: sorted.take(5).map((entry) {
                final total = sorted.fold<int>(0, (sum, e) => sum + e.value);
                final percentage = (entry.value / total * 100).toStringAsFixed(1);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${entry.value} ($percentage%)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: entry.value / sorted.first.value,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(AppConstants.primaryGreen),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPowerCardSection() {
    if (_powerCardStats.isEmpty) {
      return const SizedBox.shrink();
    }

    final sorted = _powerCardStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Power Card Usage',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: sorted.map((entry) {
                final cardName = _formatCardName(entry.key);
                final icon = _getCardIcon(entry.key);

                return ListTile(
                  leading: Icon(icon, color: _getCardColor(entry.key)),
                  title: Text(cardName),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getCardColor(entry.key).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${entry.value}×',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getCardColor(entry.key),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBonusSection() {
    final totalStreaks = _bonusStats['totalStreaks'] ?? 0;
    final totalSpeed = _bonusStats['totalSpeedBonuses'] ?? 0;
    final totalJackpots = _bonusStats['totalJackpots'] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bonus Statistics',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildBonusCard('🔥 Streaks', totalStreaks, Colors.orange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBonusCard('⚡ Speed', totalSpeed, Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildBonusCard('🎁 Jackpots', totalJackpots, Colors.amber),
      ],
    );
  }

  Widget _buildBonusCard(String label, int count, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCardName(String cardId) {
    switch (cardId) {
      case 'double_points':
        return 'Double Points';
      case 'steal_points':
        return 'Steal Points';
      case 'reverse_turn':
        return 'Reverse Turn';
      case 'skip_round':
        return 'Skip Round';
      default:
        return cardId;
    }
  }

  IconData _getCardIcon(String cardId) {
    switch (cardId) {
      case 'double_points':
        return Icons.attach_money;
      case 'steal_points':
        return Icons.currency_exchange;
      case 'reverse_turn':
        return Icons.swap_horiz;
      case 'skip_round':
        return Icons.fast_forward;
      default:
        return Icons.card_giftcard;
    }
  }

  Color _getCardColor(String cardId) {
    switch (cardId) {
      case 'double_points':
        return Colors.amber;
      case 'steal_points':
        return Colors.purple;
      case 'reverse_turn':
        return Colors.blue;
      case 'skip_round':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

