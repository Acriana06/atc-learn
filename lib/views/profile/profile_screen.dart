import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController(text: 'Cadet Captain Tadesse');
  final TextEditingController _emailController = TextEditingController(text: 'tadesse.atc@eaa.edu.et');
  final TextEditingController _phoneController = TextEditingController(text: '+251 91 234 5678');

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDarkMode ? const Color(0xFF141936) : Colors.white;
    final primaryTxt = isDarkMode ? Colors.white : Colors.black87;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Center(
          child: Stack(
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: Color(0xFF3D52D5),
                child: Icon(Icons.person, size: 52, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.cyanAccent,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 14, color: Colors.black87),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile picture updated successfully!')),
                      );
                    },
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
                            const SnackBar(content: Text('Profile details saved successfully!')),
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