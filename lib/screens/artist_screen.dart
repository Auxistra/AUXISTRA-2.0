import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  bool _isArtist = false;
  bool _isLoading = false;
  Map<String, dynamic>? _analytics;
  final String _mockUid = 'user_123'; // In real app, get from FirebaseAuth

  @override
  void initState() {
    super.initState();
    _fetchArtistStatus();
  }

  Future<void> _fetchArtistStatus() async {
    // In a real app, you'd check if the user record in DB has is_artist = true
    // For now, we simulate with a state check if needed.
  }

  Future<void> _handleUpgrade() async {
    setState(() => _isLoading = true);
    try {
      await ApiService.upgradeToArtist(_mockUid);
      final data = await ApiService.getAnalytics(_mockUid);
      setState(() {
        _isArtist = true;
        _analytics = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (!_isArtist) return _buildUpgradeView();
    return _buildArtistDashboard();
  }

  Widget _buildUpgradeView() {
    return Scaffold(
      appBar: AppBar(title: const Text('Artist Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 80, color: Color(0xFF1826F8)),
            const SizedBox(height: 24),
            const Text('Become an Artist', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              'Upload your music, manage stems, and collaborate with others. Unlock professional remixing tools and royalty analytics.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _handleUpgrade,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1826F8),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text('Start Verification'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistDashboard() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Artist Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF1826F8),
            tabs: [
              Tab(text: 'Analytics'),
              Tab(text: 'Content'),
              Tab(text: 'Collaboration'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAnalyticsTab(),
            _buildContentTab(),
            _buildCollaborationTab(),
            _buildSettingsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        final data = await ApiService.getAnalytics(_mockUid);
        setState(() => _analytics = data);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatCard('Total Streams', _analytics?['totalStreams']?.toString() ?? '0', '+12%'),
          _buildStatCard('Remix Royalties', '\$${_analytics?['totalRevenue'] ?? '0'}', '+8%'),
          _buildStatCard('Active Listeners', '---', '+5%'),
          const SizedBox(height: 24),
          const Text('Top Songs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildSongStatItem('Midnight Echo', '450K streams'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String growth) {
    return Card(
      color: const Color(0xFF2C2C2C),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Text(growth, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongStatItem(String title, String subtitle) {
    return ListTile(
      leading: Container(width: 50, height: 50, color: Colors.grey[800]),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }

  Widget _buildContentTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.cloud_upload),
          label: const Text('Upload Stems (WAV/AIFF)'),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1826F8)),
        ),
        const SizedBox(height: 24),
        const Text('Your Catalog', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _buildCatalogItem('Midnight Echo', '5 Stems Uploaded'),
      ],
    );
  }

  Widget _buildCatalogItem(String title, String status) {
    return ListTile(
      title: Text(title),
      subtitle: Text(status),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(child: Text('Edit Rights')),
          const PopupMenuItem(child: Text('View Stems')),
        ],
      ),
    );
  }

  Widget _buildCollaborationTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Pending Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ListTile(
          leading: CircleAvatar(child: Text('DJ')),
          title: Text('DJ Spark'),
          subtitle: Text('Requested stems for "Midnight Echo"'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: Icon(Icons.check, color: Colors.green), onPressed: null),
              IconButton(icon: Icon(Icons.close, color: Colors.red), onPressed: null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Allow Global Remixing'),
          subtitle: const Text('Users can purchase remix rights automatically'),
          value: true,
          onChanged: (v) {},
          activeColor: const Color(0xFF1826F8),
        ),
        const ListTile(
          title: Text('Platform Fee'),
          subtitle: Text('Current rate: 15%'),
        ),
      ],
    );
  }
}
