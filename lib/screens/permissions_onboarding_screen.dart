import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/permission_service.dart';

class PermissionsOnboardingScreen extends StatefulWidget {
  const PermissionsOnboardingScreen({super.key});

  @override
  State<PermissionsOnboardingScreen> createState() =>
      _PermissionsOnboardingScreenState();
}

class _PermissionsOnboardingScreenState
    extends State<PermissionsOnboardingScreen> {
  bool _isRequesting = false;

  Future<void> _requestPermissions() async {
    setState(() => _isRequesting = true);

    try {
      final statuses = await PermissionService.requestCorePermissions();
      final deniedForever =
          statuses.values.any((status) => status.isPermanentlyDenied);

      await PermissionService.markOnboardingCompleted();

      if (!mounted) return;

      if (deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Some permissions are permanently denied. Open Settings to enable them.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      context.go('/');
    } finally {
      if (mounted) {
        setState(() => _isRequesting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_user,
                  size: 44, color: Color(0xFF0085D5)),
              const SizedBox(height: 16),
              const Text(
                'Permissions Needed',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'To submit accurate fault reports, we need access to location, camera, and photos/storage.',
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
              const SizedBox(height: 28),
              _buildReasonTile(
                icon: Icons.location_on_outlined,
                title: 'Location',
                subtitle: 'Pin the exact fault position on the map.',
              ),
              const SizedBox(height: 12),
              _buildReasonTile(
                icon: Icons.camera_alt_outlined,
                title: 'Camera',
                subtitle: 'Take a photo of the fault for faster maintenance.',
              ),
              const SizedBox(height: 12),
              _buildReasonTile(
                icon: Icons.photo_library_outlined,
                title: 'Photos / Storage',
                subtitle: 'Choose an existing image to attach to a report.',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isRequesting ? null : _requestPermissions,
                  child: _isRequesting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Allow Permissions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0085D5)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
