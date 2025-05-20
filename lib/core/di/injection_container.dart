import 'package:get_it/get_it.dart';

import '../../features/chat/data/datasources/mock_chat_datasource.dart';
import '../../features/chat/data/repositories/group_chat_repository_impl.dart';
import '../../features/chat/domain/repositories/group_chat_repository.dart';
import '../../features/chat/domain/usecases/get_group_chat_by_id.dart';
import '../../features/chat/domain/usecases/get_group_chats.dart';
import '../../features/chat/presentation/bloc/group_chat_bloc.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  // Data sources
  sl.registerLazySingleton<MockChatDataSource>(() => MockChatDataSource());

  // Repositories
  sl.registerLazySingleton<GroupChatRepository>(
    () => GroupChatRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetGroupChats(sl()));
  sl.registerLazySingleton(() => GetGroupChatById(sl()));

  // BLoC
  sl.registerFactory(
    () => GroupChatBloc(
      getGroupChats: sl(),
      getGroupChatById: sl(),
    ),
  );
}
