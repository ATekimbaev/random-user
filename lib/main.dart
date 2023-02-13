import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_08_00/bloc/random_user_bloc.dart';
import 'package:random_user_08_00/dio_setting.dart';
import 'package:random_user_08_00/get_user_data_repo.dart';
import 'package:random_user_08_00/home_page.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => GetUserDataRepo(
              dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) => RandomUserBloc(
          repo: RepositoryProvider.of<GetUserDataRepo>(context),
        ),
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );
  }
}
