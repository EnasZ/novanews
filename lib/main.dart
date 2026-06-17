import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_router.dart';
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/models/user_model.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  
  final userBox = await Hive.openBox<UserModel>('users');
  final settingsBox = await Hive.openBox('settings');
  
  final authLocalDataSource = AuthLocalDataSourceImpl(userBox, settingsBox);

  runApp(MyApp(
    authLocalDataSource: authLocalDataSource,
    settingsBox: settingsBox,
  ));
}

class MyApp extends StatelessWidget {
  final AuthLocalDataSource authLocalDataSource;
  final Box settingsBox;

  const MyApp({
    super.key,
    required this.authLocalDataSource,
    required this.settingsBox,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(authLocalDataSource)..checkAuth()),
        BlocProvider(create: (context) => SettingsCubit(settingsBox)),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'NovaNews',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
