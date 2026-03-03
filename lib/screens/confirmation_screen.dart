import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationScreen extends StatefulWidget {
  final String trackingId;

  const ConfirmationScreen({super.key, required this.trackingId});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const _primaryColor = Color(0xFF0085D5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slight delay before animating in
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEFF6FF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSuccessIcon(),
                      const SizedBox(height: 32),
                      _buildSuccessText(),
                      const SizedBox(height: 40),
                      _buildInfoCard(),
                      const SizedBox(height: 32),
                      _buildBackButton(context),
                      const SizedBox(height: 24),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse ring
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.2),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                width: 128, height: 128,
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
          onEnd: () => setState(() {}),
        ),
        // Main circle
        Container(
          width: 120, height: 120,
          decoration: const BoxDecoration(
            color: _primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x400085D5),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 72,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessText() {
    return const Column(
      children: [
        Text(
          'Report Submitted!',
          style: TextStyle(
            color: _primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Your fault report has been successfully submitted.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF374151),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'SMS sent to maintenance team.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF6FF),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text('📱', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What happens next?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Our maintenance team will review your report and contact you shortly on the provided phone number.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Tracking ID: #${widget.trackingId}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.go('/'),
      icon: const Icon(Icons.home_outlined),
      label: const Text('Back to Home'),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text(
          'Hawassa University IoT Campus',
          style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
        ),
        SizedBox(height: 4),
        Text(
          'Anonymous Fault Reporting System',
          style: TextStyle(fontSize: 12, color: Color(0xFFD1D5DB)),
        ),
      ],
    );
  }
}
