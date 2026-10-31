import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/core/utils/l10n.dart';

/// Нижняя навигация: Система, Чаты, Моя планета.
class HomeShell extends StatelessWidget {
  const HomeShell({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          // Повторный тап по вкладке возвращает в её начало.
          initialLocation: index == shell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.blur_circular_rounded),
            label: l10n.navSystem,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: const Icon(Icons.chat_bubble_rounded),
            label: l10n.navChats,
          ),
          NavigationDestination(
            icon: const Icon(Icons.public_rounded),
            label: l10n.navPlanet,
          ),
        ],
      ),
    );
  }
}
