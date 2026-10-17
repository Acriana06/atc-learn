import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: theme.colorScheme.onSurface)),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(Icons.person, size: 40, color: theme.colorScheme.onPrimaryContainer),
            ),
            const SizedBox(height: 12),
            Text(
              user?.email ?? 'Trainee Controller',
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 24),
            Card(
              color: theme.colorScheme.surfaceContainer,
              child: ListTile(
                leading: Icon(Icons.school, color: theme.colorScheme.primary),
                title: Text('Training Level', style: TextStyle(color: theme.colorScheme.onSurface)),
                subtitle: Text('Tower Control (Level 1)', style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.errorContainer,
                foregroundColor: theme.colorScheme.onErrorContainer,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}