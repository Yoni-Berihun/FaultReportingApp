import 'package:flutter/material.dart';
import 'package:fault_reporting_app/data/drift/app_database.dart';
import 'package:fault_reporting_app/services/fixer_mode_service.dart';
import 'package:fault_reporting_app/services/fixer_sync_service.dart';
import 'package:intl/intl.dart';

class FixerReportDetailScreen extends StatefulWidget {
  const FixerReportDetailScreen({super.key, required this.serverId});

  final int serverId;

  @override
  State<FixerReportDetailScreen> createState() => _FixerReportDetailScreenState();
}

class _FixerReportDetailScreenState extends State<FixerReportDetailScreen> {
  String? _signed;
  bool _loading = true;
  String? _error;
  bool _marking = false;
  LocalReport? _row;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final allowed = await FixerModeService.isEnabled();
    if (!allowed) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'Fixer mode not enabled';
        });
      }
      return;
    }
    final db = AppDatabase.instance;
    final r = await (db.select(db.localReports)
          ..where((t) => t.serverId.equals(widget.serverId)))
        .getSingleOrNull();
    if (r == null) {
      await FixerSyncService.instance.fullSync();
      final r2 = await (db.select(db.localReports)
            ..where((t) => t.serverId.equals(widget.serverId)))
          .getSingleOrNull();
      if (!mounted) {
        return;
      }
      if (r2 == null) {
        setState(() {
          _loading = false;
          _error = 'Report not found';
        });
        return;
      }
      _row = r2;
    } else {
      _row = r;
    }
    final url = await FixerSyncService.instance.signedUrlForLocalPhoto(_row!);
    if (!mounted) {
      return;
    }
    setState(() {
      _signed = url;
      _loading = false;
    });
  }

  Future<void> _onSeen() async {
    if (_row == null) {
      return;
    }
    setState(() => _marking = true);
    try {
      await FixerSyncService.instance.markSeenFromFixer(_row!.serverId);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to mark seen: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _marking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0085D5),
          foregroundColor: Colors.white,
        ),
        body: Center(child: Text(_error!)),
      );
    }
    final r = _row!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0085D5),
        foregroundColor: Colors.white,
        title: Text('Report #${r.serverId}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _kv('Status', r.status),
          _kv('Local sync', r.localActionState),
          _kv('Tracking', r.trackingId),
          _kv('Created (UTC)', DateFormat.yMd().add_jm().format(r.createdAt.toUtc())),
          _kv('Phone (contact)', r.contactNumber),
          _kv('Description', r.description),
          if (r.commonName.isNotEmpty) _kv('Common name', r.commonName),
          _kv('Location', '${r.latitude}, ${r.longitude}'),
          const SizedBox(height: 12),
          if (r.status == 'pending' || (r.seenAt == null && r.status != 'resolved'))
            ElevatedButton(
              onPressed: _marking ? null : _onSeen,
              child: Text(_marking ? 'Marking...' : 'Mark as seen'),
            ),
          if (r.resolvedAt != null)
            _kv('Resolved (UTC)', DateFormat.yMd().add_jm().format(r.resolvedAt!.toUtc())),
          if (_signed != null && _signed!.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text('Photo', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Image.network(
              _signed!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Text('Could not load image'),
            ),
          ] else
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('No photo, or not available offline.'),
            ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(k, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
          Text(v, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
