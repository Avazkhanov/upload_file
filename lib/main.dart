import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_file/data/repositories/file_repository.dart';
import 'package:upload_file/screens/on_board/on_board_screen.dart';
import 'package:upload_file/services/file_manager_sevice.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FileManagerService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => FileRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: const OnBoardScreen(),
      ),
    );
  }
}
