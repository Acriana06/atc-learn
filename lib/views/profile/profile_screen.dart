import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  XFile? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final currentUser = Supabase.instance.client.auth.currentUser;
    _nameController = TextEditingController(text: 'Cadet Captain Tadesse');
    _emailController = TextEditingController(text: currentUser?.email ?? 'tadesse.atc@eaa.edu.et');
    _phoneController = TextEditingController(text: '+251 91 234 5678');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- DEVICE IMAGE PICKER LOGIC ---
  Future<void> _pickProfileImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImageFile = pickedFile;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select image: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  // --- SIGN OUT HANDLER ---
  Future<void> _handleSignOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Sign Out'),
        content: const Text('Are you sure you want to log out of the ATC Cadet Terminal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Supabase.instance.client.auth.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false, 
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDarkMode ? const Color(0xFF141936) : Colors.white;
    final primaryTxt = isDarkMode ? Colors.white : Colors.black87;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // --- PROFILE PICTURE AVATAR & PICKER ---
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: const Color(0xFF3D52D5),
                backgroundImage: _selectedImageFile != null
                    ? (kIsWeb
                    ? NetworkImage(_selectedImageFile!.path)
                    : FileImage(File(_selectedImageFile!.path)) as ImageProvider)
                    : null,
                child: _selectedImageFile == null
                    ? const Icon(Icons.person, size: 52, color: Colors.white)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.cyanAccent,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 14, color: Colors.black87),
                    onPressed: _pickProfileImage,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(_nameController.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryTxt)),
        ),
        const Center(
          child: Text('Ethiopian Aviation Academy • ATC Trainee', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ),
        const SizedBox(height: 24),

        // --- CREDENTIALS CARD ---
        Card(
          color: cardBg,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cadet Credentials', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF3D52D5))),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                        if (!_isEditing) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile details saved successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: Text(_isEditing ? 'Save' : 'Edit Profile', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const Divider(height: 20),
                _buildProfileField('Full Name', _nameController, _isEditing, primaryTxt),
                const SizedBox(height: 12),
                _buildProfileField('Email Address', _emailController, _isEditing, primaryTxt),
                const SizedBox(height: 12),
                _buildProfileField('Phone Number', _phoneController, _isEditing, primaryTxt),
                const SizedBox(height: 12),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Cadet ID', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text('EAA-ATC-0248', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // --- SIGN OUT BUTTON ---
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.logout),
          label: const Text('Sign Out of Terminal', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: _handleSignOut,
        ),
      ],
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller, bool isEditable, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        isEditable
            ? TextField(
          controller: controller,
          style: TextStyle(color: textColor, fontSize: 14),
          decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
        )
            : Text(controller.text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
      ],
    );
  }
}
