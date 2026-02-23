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
  bool _allowGlobalRemix = true;

  Map<String, dynamic>? _analytics;
  final String _mockUid = 'user_123'; // Replace with FirebaseAuth later

  @override
  void initState() {
    super.initState();
    _fetchArtistStatus();
  }

  Future<void> _fetchArtistStatus() async {
    // Future backend check can go here
    setState(() {});
  }

  Future<void> _handleUpgrade() async {
    setState(() => _isLoading = true);

    try {
      await ApiService.upgradeToArtist(_mockUid);
      final data = await ApiService.getAnalytics(_mockUid);

      if (!mounted) return;

      setState(() {
        _isArtist = true;
        _analytics = data;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Artist verification successful!')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upgrade failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _isArtist ? _buildArtistDashboard() : _buildUpgradeView();
  }

  // ---------------- UPGRADE VIEW ----------------

  Widget _buildUpgradeView() {
    return Scaffold(
      appBar: AppBar(title: const Text('Artist Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_user,
                      size: 80, color: Color(0xFF1826F8)),
                  const SizedBox(height: 24),
                  const Text(
                    'Become an Artist',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upload your music, manage stems, and collaborate with others. '
                    'Unlock professional remixing tools and royalty analytics.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _handleUpgrade,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1826F8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Start Verification'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- DASHBOARD ----------------

  Widget _buildArtistDashboard() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Artist Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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

  // ---------------- ANALYTICS ----------------

  Widget _buildAnalyticsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        final data = await ApiService.getAnalytics(_mockUid);
        if (!mounted) return;
        setState(() => _analytics = data);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatCard(
            'Total Streams',
            _analytics?['totalStreams']?.toString() ?? '0',
            '+12%',
          ),
          _buildStatCard(
            'Remix Royalties',
            '\$${_analytics?['totalRevenue'] ?? '0'}',
            '+8%',
          ),
          _buildStatCard('Active Listeners', '---', '+5%'),
          const SizedBox(height: 24),
          const Text('Top Songs',
              style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildSongStatItem('Midnight Echo', '450K streams'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String growth) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                Text(growth,
                    style:
                        const TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongStatItem(String title, String subtitle) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }

  // ---------------- CONTENT ----------------

  Widget _buildContentTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.cloud_upload),
          label: const Text('Upload Stems (WAV/AIFF)'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1826F8),
            padding:
                const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Your Catalog',
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildCatalogItem('Midnight Echo', '5 Stems Uploaded'),
      ],
    );
  }

  Widget _buildCatalogItem(String title, String status) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(status),
        trailing: PopupMenuButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          itemBuilder: (context) => const [
            PopupMenuItem(child: Text('Edit Rights')),
            PopupMenuItem(child: Text('View Stems')),
          ],
        ),
      ),
    );
  }

  // ---------------- COLLABORATION ----------------

  Widget _buildCollaborationTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Pending Requests',
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('DJ')),
            title: Text('DJ Spark'),
            subtitle:
                Text('Requested stems for "Midnight Echo"'),
          ),
        ),
      ],
    );
  }

  // ---------------- SETTINGS ----------------

  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Allow Global Remixing'),
          subtitle: const Text(
              'Users can purchase remix rights automatically'),
          value: _allowGlobalRemix,
          onChanged: (v) {
            setState(() => _allowGlobalRemix = v);
          },
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
