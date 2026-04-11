import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../models/fault_report.dart';
import '../services/fault_service.dart';

class MapPreviewScreen extends StatefulWidget {
  final FaultReport report;
  const MapPreviewScreen({super.key, required this.report});
  @override
  State<MapPreviewScreen> createState() => _MapPreviewScreenState();
}

class _MapPreviewScreenState extends State<MapPreviewScreen> {
  static const _primaryColor = Color(0xFF0085D5);
  bool _isSubmitting = false;

  Future<void> _handleConfirm() async {
    setState(() => _isSubmitting = true);
    try {
      final trackingId = await FaultService.submitReport(widget.report);
      if (mounted) context.go('/confirmation', extra: trackingId);
    } catch (e, stackTrace) {
      debugPrint('Submit error: $e');
      debugPrint('Submit stackTrace: $stackTrace');
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Submission failed: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(widget.report.latitude, widget.report.longitude);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [_buildMap(latLng), _buildDetailsCard(), const SizedBox(height: 100)],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _isSubmitting ? null : () => context.pop(),
            icon: const Icon(Icons.chevron_left, size: 28),
            style: IconButton.styleFrom(shape: const CircleBorder()),
          ),
          const Text('Confirm Location',
              style: TextStyle(color: _primaryColor, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMap(LatLng latLng) {
    return SizedBox(
      height: 380,
      child: FlutterMap(
        options: MapOptions(initialCenter: latLng, initialZoom: 16.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.hawassa.fault_reporting',
          ),
          MarkerLayer(
            markers: [Marker(point: latLng, width: 56, height: 56, child: const _AnimatedPin())],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 4))],
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: const Icon(Icons.location_pin, color: _primaryColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.report.commonName.isNotEmpty ? widget.report.commonName : 'Selected Location',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lat: ${widget.report.latitude.toStringAsFixed(6)}, Long: ${widget.report.longitude.toStringAsFixed(6)}',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              _buildDetailRow('Description', widget.report.description),
              const SizedBox(height: 16),
              _buildDetailRow('Contact Number', widget.report.phoneNumber),
              if (widget.report.photoPath != null) ...[
                const SizedBox(height: 16),
                const Text('Attached Photo',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF6B7280))),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(File(widget.report.photoPath!), width: double.infinity, height: 130, fit: BoxFit.cover),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF6B7280))),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF111827))),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton.icon(
          onPressed: _isSubmitting ? null : _handleConfirm,
          icon: _isSubmitting
              ? const SizedBox(
                  width: 18, height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)),
                )
              : const Icon(Icons.check),
          label: Text(_isSubmitting ? 'Submitting...' : 'Confirm & Submit'),
        ),
      ),
    );
  }
}

class _AnimatedPin extends StatefulWidget {
  const _AnimatedPin();
  @override
  State<_AnimatedPin> createState() => _AnimatedPinState();
}

class _AnimatedPinState extends State<_AnimatedPin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this)..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: -6).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: const Icon(Icons.location_pin, color: Color(0xFF0085D5), size: 48,
            shadows: [Shadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 4))]),
      ),
    );
  }
}
