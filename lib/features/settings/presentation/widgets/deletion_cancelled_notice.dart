import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/presentation/controllers/account_controller.dart';

/// Says "Deletion cancelled" when signing in has stopped a requested
/// account deletion.
class DeletionCancelledNotice extends ConsumerWidget {
  const DeletionCancelledNotice({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(deletionCancelledProvider, (_, next) {
      if (next.value ?? false) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.deleteCancelled)));
      }
    });
    return child;
  }
}
