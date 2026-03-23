import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../services/api_service.dart';
import '../providers/music_provider.dart';
import 'upload_song_screen.dart';

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
  final String _mockUid = 'user_123';

  @override
  void initState() {
    super.initState();
    _fetchArtistStatus();
  }

  Future<void> _fetchArtistStatus() async {
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
      _showFeedback(context, 'Verification successful!');
    } catch (e) {
      if (!mounted) return;
      _showFeedback(context, 'Upgrade failed: Check your connection');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white.withOpacity(0.1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final activeColor = provider.activeColor;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _isArtist ? _buildArtistDashboard(activeColor) : _buildUpgradeView(activeColor),
    );
  }

  Widget _buildUpgradeView(Color activeColor) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar('Artist Profile', activeColor),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: activeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: activeColor.withOpacity(0.2)),
                  ),
                  child: Icon(Icons.verified_user_rounded, size: 80, color: activeColor),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Become an Artist',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Upload music, manage stems, and collaborate. Unlock professional remixing tools and royalties.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleUpgrade,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activeColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 10,
                      shadowColor: activeColor.withOpacity(0.4),
                    ),
                    child: const Text('Start Verification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArtistDashboard(Color activeColor) {
    return DefaultTabController(
      length: 4,
      child: CustomScrollView(
        slivers: [
          _buildSliverAppBar('Dashboard', activeColor, showTabs: true),
          SliverFillRemaining(
            child: TabBarView(
              children: [
                _buildAnalyticsTab(activeColor),
                _buildContentTab(activeColor),
                _buildCollaborationTab(activeColor),
                _buildSettingsTab(activeColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(String title, Color activeColor, {bool showTabs = false}) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: showTabs ? 160 : 120,
      floating: true,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 20, bottom: showTabs ? 60 : 16),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 26,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
      ),
      bottom: showTabs
          ? TabBar(
              isScrollable: true,
              indicatorColor: activeColor,
              indicatorWeight: 3,
              labelColor: activeColor,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [Tab(text: 'Analytics'), Tab(text: 'Content'), Tab(text: 'Collab'), Tab(text: 'Settings')],
            )
          : null,
    );
  }

  Widget _buildAnalyticsTab(Color activeColor) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatCard('Total Streams', _analytics?['totalStreams']?.toString() ?? '0', '+12%', Icons.bar_chart_rounded, activeColor),
        _buildStatCard('Royalties', '\$${_analytics?['totalRevenue'] ?? '0'}', '+8%', Icons.account_balance_wallet_rounded, activeColor),
        const SizedBox(height: 24),
        _buildSectionHeader('TOP SONGS', activeColor),
        const SizedBox(height: 16),
        _buildSongStatItem('Midnight Echo', '450K streams', activeColor),
        _buildSongStatItem('Neon Nights', '210K streams', activeColor),
      ],
    );
  }

  Widget _buildSectionHeader(String title, Color activeColor) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: activeColor.withOpacity(0.8),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: activeColor.withOpacity(0.2), thickness: 0.5)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String growth, IconData icon, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: activeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: activeColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: Text(growth, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSongStatItem(String title, String subtitle, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 48,
            height: 48,
            color: activeColor.withOpacity(0.1),
            child: Icon(Icons.music_note_rounded, color: activeColor.withOpacity(0.5)),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
        trailing: Icon(Icons.chevron_right_rounded, color: Colors.white.withOpacity(0.2)),
        onTap: () {},
      ),
    );
  }

  Widget _buildContentTab(Color activeColor) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UploadSongScreen()),
            ),
            icon: const Icon(Icons.cloud_upload_rounded),
            label: const Text('Upload New Stems', style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: activeColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildSectionHeader('YOUR CATALOG', activeColor),
        const SizedBox(height: 16),
        _buildCatalogItem('Midnight Echo', '5 Stems Uploaded', activeColor),
      ],
    );
  }

  Widget _buildCatalogItem(String title, String status, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(status, style: TextStyle(color: activeColor.withOpacity(0.7), fontSize: 13)),
        trailing: Icon(Icons.more_vert_rounded, color: Colors.white.withOpacity(0.3)),
        onTap: () {},
      ),
    );
  }

  Widget _buildCollaborationTab(Color activeColor) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionHeader('ACTIVE REQUESTS', activeColor),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: activeColor.withOpacity(0.2),
              child: Text('DJ', style: TextStyle(color: activeColor, fontWeight: FontWeight.bold)),
            ),
            title: const Text('DJ Spark', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            subtitle: Text('Requested stems for "Midnight Echo"', style: TextStyle(color: Colors.white.withOpacity(0.5))),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab(Color activeColor) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildSectionHeader('ARTIST SETTINGS', activeColor),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: SwitchListTile.adaptive(
            title: const Text('Allow Global Remixing', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            subtitle: Text('Users can purchase remix rights automatically', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
            value: _allowGlobalRemix,
            activeColor: activeColor,
            onChanged: (v) => setState(() => _allowGlobalRemix = v),
          ),
        ),
      ],
    );
  }
}
