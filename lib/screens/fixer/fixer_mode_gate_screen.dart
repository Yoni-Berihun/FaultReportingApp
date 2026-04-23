import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_config.dart';
import '../../services/background_work_manager.dart';
import '../../services/fixer_bootstrap.dart';
import '../../services/fixer_mode_service.dart';

class FixerModeGateScreen extends StatefulWidget {
  const FixerModeGateScreen({super.key});

  @override
  State<FixerModeGateScreen> createState() => _FixerModeGateScreenState();
}

class _FixerModeGateScreenState extends State<FixerModeGateScreen> {
  final _p1 = TextEditingController();
  bool _loading = true;
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final e = await FixerModeService.isEnabled();
    if (mounted) {
      setState(() {
        _enabled = e;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _p1.dispose();
    super.dispose();
  }

  Future<void> _apply() async {
    if (_p1.text.trim() != kFixerEnablePasscode) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid passcode')),
      );
      return;
    }
    setState(() => _loading = true);
    if (_enabled) {
      await FixerModeService.setEnabled(false);
      await BackgroundWorkManager.cancel();
      FixerBootstrap.connectivity.stop();
      FixerBootstrap.realtime.stop();
    } else {
      await FixerModeService.setEnabled(true);
      await BackgroundWorkManager.registerIfFixer();
      await FixerBootstrap.syncIfEnabled();
    }
    _p1.clear();
    if (!mounted) {
      return;
    }
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixer mode (maintenance device)'),
        backgroundColor: const Color(0xFF0085D5),
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _enabled
                        ? 'Fixer mode is ON. This device will cache reports, sync in the background, and notify after reconnecting from offline.'
                        : 'Fixer mode is OFF. Enter the passcode to enable (device-local only).',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _p1,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Passcode',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _apply,
                    child: Text(_enabled ? 'Disable (with passcode)' : 'Enable (with passcode)'),
                  ),
                  const Spacer(),
                  if (_enabled) ...[
                    OutlinedButton(
                      onPressed: () {
                        context.push('/fixer/reports');
                      },
                      child: const Text('Open fixer report list'),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
