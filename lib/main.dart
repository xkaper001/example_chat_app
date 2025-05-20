import 'package:example_chat_app/features/chat/presentation/screens/group_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/chat/presentation/bloc/group_chat_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.setupDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupChatBloc>(
      create: (_) => di.sl<GroupChatBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Group Chat App',
        theme: AppTheme.themeData(),
        home: const GroupChatScreen(groupId: 'group_1',),
      ),
    );
  }
}
