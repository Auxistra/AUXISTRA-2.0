
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../services/api_service.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  final _titleController = TextEditingController();
  final _artistController = TextEditingController(); // NEW: Artist Controller
  final _priceController = TextEditingController();
  bool _isUploading = false;
  String? _selectedFile;

  Future<void> _uploadSong() async {
    if (_titleController.text.isEmpty ||
        _artistController.text.isEmpty ||
        _selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Simulate file upload or direct backend register
      final s3Key = 'songs/${DateTime.now().millisecondsSinceEpoch}_${_selectedFile}';

      await Provider.of<MusicProvider>(context, listen: false).addSong(
        _titleController.text.trim(),
        _artistController.text.trim(), // PASSING ARTIST NAME
        s3Key,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Song uploaded successfully')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Upload Song'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Song',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 32),

              // SONG TITLE FIELD
              _buildInputField(_titleController, 'Song Title', Icons.music_note),
              const SizedBox(height: 20),

              // ARTIST NAME FIELD
              _buildInputField(_artistController, 'Artist Name', Icons.person),
              const SizedBox(height: 20),

              // PRICE FIELD
              _buildInputField(_priceController, 'Price (cents)', Icons.attach_money, isNumber: true),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _isUploading ? null : () => setState(() => _selectedFile = 'demo_track.wav'),
                icon: const Icon(Icons.file_upload),
                label: Text(_selectedFile ?? 'Select Audio File (.wav)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1826F8),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadSong,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1826F8),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Song', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: const Color(0xFF1826F8)),
        filled: true,
        fillColor: const Color(0xFF1C1C1E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
