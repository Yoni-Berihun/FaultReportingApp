import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fault_reporting_app/data/drift/app_database.dart';
import 'package:fault_reporting_app/services/fixer_mode_service.dart';
import 'package:fault_reporting_app/services/fixer_sync_service.dart';
import 'package:intl/intl.dart';

class FixerReportsListScreen extends StatefulWidget {
  const FixerReportsListScreen({super.key});

  @override
  State<FixerReportsListScreen> createState() => _FixerReportsListScreenState();
}

class _FixerReportsListScreenState extends State<FixerReportsListScreen> {
  bool _allowed = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final ok = await FixerModeService.isEnabled();
    if (!mounted) {
      return;
    }
    setState(() {
      _allowed = ok;
    });
    if (ok) {
      await FixerSyncService.instance.fullSync();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_allowed) {
      return const Scaffold(
        body: Center(
          child: Text('Fixer mode is not enabled for this device.'),
        ),
      );
    }

    final db = AppDatabase.instance;
    final q = db.select(db.localReports)
      ..orderBy([
        (t) => OrderingTerm(
              expression: t.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0085D5),
        foregroundColor: Colors.white,
        title: const Text('Fault reports (fixer)'),
        actions: [
          IconButton(
            onPressed: () => FixerSyncService.instance.fullSync(),
            icon: const Icon(Icons.sync),
            tooltip: 'Sync now',
          ),
        ],
      ),
      body: StreamBuilder<List<LocalReport>>(
        stream: q.watch(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final list = snap.data ?? [];
          if (list.isEmpty) {
            return const Center(child: Text('No cached reports yet. Pull to sync.'));
          }
          return RefreshIndicator(
            onRefresh: () => FixerSyncService.instance.fullSync(),
            child: ListView.separated(
              itemCount: list.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final r = list[i];
                return ListTile(
                  title: Text(
                    r.description.isNotEmpty
                        ? r.description
                        : 'Report #${r.serverId}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${DateFormat.yMd().add_jm().format(r.createdAt.toLocal())} · ${r.status} · ${r.localActionState}',
                  ),
                  isThreeLine: true,
                  onTap: () => context.push('/fixer/reports/${r.serverId}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
