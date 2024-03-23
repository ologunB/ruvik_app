import 'package:lendo/views/auth/splash.dart';

import 'core/apis/local_storage.dart';
import 'core/models/navigator.dart';
import 'locator.dart';
import 'views/widgets/rev_text.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  await AppCache.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lendo',
          theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
            primaryColor: AppColors.primary,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: AppNavigator.navKey,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
