import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:orbitly/features/chat/domain/repositories/chat_repository.dart';
import 'package:orbitly/features/friends/data/repositories/mock_friends_repository.dart';
import 'package:orbitly/features/friends/domain/repositories/friends_repository.dart';
import 'package:orbitly/features/planet/data/repositories/mock_planet_repository.dart';
import 'package:orbitly/features/planet/domain/repositories/planet_repository.dart';
import 'package:orbitly/features/report/data/repositories/mock_report_repository.dart';
import 'package:orbitly/features/report/domain/repositories/report_repository.dart';
import 'package:orbitly/features/system/data/repositories/mock_system_repository.dart';
import 'package:orbitly/features/system/domain/repositories/system_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

// Единственное место, где UI связывается с реализациями репозиториев.
// Чтобы подключить бэкенд, замените Mock*Repository на настоящие
// реализации в провайдерах ниже — экраны и контроллеры не меняются.

@Riverpod(keepAlive: true)
MockStore mockStore(Ref ref) => MockStore();

@Riverpod(keepAlive: true)
SystemRepository systemRepository(Ref ref) =>
    MockSystemRepository(ref.watch(mockStoreProvider));

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) =>
    MockChatRepository(ref.watch(mockStoreProvider));

@Riverpod(keepAlive: true)
PlanetRepository planetRepository(Ref ref) =>
    MockPlanetRepository(ref.watch(mockStoreProvider));

@Riverpod(keepAlive: true)
ReportRepository reportRepository(Ref ref) =>
    MockReportRepository(ref.watch(mockStoreProvider));

@Riverpod(keepAlive: true)
FriendsRepository friendsRepository(Ref ref) =>
    MockFriendsRepository(ref.watch(mockStoreProvider));
