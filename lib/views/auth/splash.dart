import 'package:lendo/views/widgets/rev_text.dart';

import '../home/filter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //  AppCache.clear();
    Future.delayed(const Duration(seconds: 2), () {
      pushReplacement(context, const FilterScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: Image.asset('loc'.png, width: 140.h)),
    );
  }
}
