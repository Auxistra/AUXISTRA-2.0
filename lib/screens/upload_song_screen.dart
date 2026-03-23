// Import Flutter material UI package
import 'package:flutter/material.dart';

// Import Provider for state management
import 'package:provider/provider.dart';

// Import custom music provider (handles song data/state)
import '../providers/music_provider.dart';

// Import API service (for backend interaction - currently simulated)
import '../services/api_service.dart';

// Stateful widget for Upload Song screen
class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  // Controller for song title input
  final _titleController = TextEditingController();

  // Controller for artist name input
  final _artistController = TextEditingController();

  // Controller for price input
  final _priceController = TextEditingController();

  // Boolean to track upload state (loading indicator)
  bool _isUploading = false;

  // Stores selected file name/path (mocked here)
  String? _selectedFile;

  // Function to handle song upload
  Future<void> _uploadSong() async {
    // Validation: ensure all required fields are filled
    if (_titleController.text.isEmpty ||
        _artistController.text.isEmpty ||
        _selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Set loading state to true
    setState(() => _isUploading = true);

    try {
      // Simulate generating a unique file key (e.g., for AWS S3 storage)
      final s3Key =
          'songs/${DateTime.now().millisecondsSinceEpoch}_${_selectedFile}';

      // Call provider method to add song (handles backend logic)
      await Provider.of<MusicProvider>(context, listen: false).addSong(
        _titleController.text.trim(),   // Song title
        _artistController.text.trim(),  // Artist name
        s3Key,                          // File reference
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Song uploaded successfully')),
      );

      // Navigate back after successful upload
      Navigator.of(context).pop();
    } catch (e) {
      // Handle errors and show failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      // Reset loading state
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set dark theme background
      backgroundColor: Colors.black,

      // App bar with title
      appBar: AppBar(
        title: const Text('Upload Song'),
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        // Scrollable container (prevents overflow when keyboard appears)
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen heading
              const Text(
                'Add New Song',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              // Song title input field
              _buildInputField(
                _titleController,
                'Song Title',
                Icons.music_note,
              ),

              const SizedBox(height: 20),

              // Artist name input field
              _buildInputField(
                _artistController,
                'Artist Name',
                Icons.person,
              ),

              const SizedBox(height: 20),

              // Price input field (numeric)
              _buildInputField(
                _priceController,
                'Price (cents)',
                Icons.attach_money,
                isNumber: true,
              ),

              const SizedBox(height: 32),

              // Button to select audio file (currently mocked)
              ElevatedButton.icon(
                onPressed: _isUploading
                    ? null
                    : () => setState(() =>
                        _selectedFile = 'demo_track.wav'), // Simulated file
                icon: const Icon(Icons.file_upload),
                label: Text(_selectedFile ?? 'Select Audio File (.wav)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1826F8),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Upload button
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadSong,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1826F8),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                // Show loading indicator while uploading
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Upload Song',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable input field widget
  Widget _buildInputField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,

      // Set keyboard type based on input type
      keyboardType:
          isNumber ? TextInputType.number : TextInputType.text,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),

        // Icon displayed inside input field
        prefixIcon: Icon(icon, color: const Color(0xFF1826F8)),

        filled: true,
        fillColor: const Color(0xFF1C1C1E),

        // Rounded border with no visible outline
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
