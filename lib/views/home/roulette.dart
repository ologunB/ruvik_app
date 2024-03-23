import 'package:lendo/views/widgets/rev_text.dart';
import 'package:roulette/roulette.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with SingleTickerProviderStateMixin {
  late RouletteController rouController;
  @override
  void initState() {
    const units = [
      RouletteUnit.noText(color: Colors.red),
      RouletteUnit.noText(color: Colors.green),
      RouletteUnit.noText(color: Colors.black),
      RouletteUnit.noText(color: Colors.blue),
      RouletteUnit.noText(color: Colors.red),
      RouletteUnit.noText(color: Colors.green),
      RouletteUnit.noText(color: Colors.black),
      RouletteUnit.noText(color: Colors.blue),
      // ...other units
    ];
    rouController =
        RouletteController(group: RouletteGroup(units), vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Colors.white,
          titleSpacing: 4.h,
          title: RevText(
            'Roulette',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
          bottom: PreferredSize(
            preferredSize: const Size(0, 1),
            child: Divider(height: 0, thickness: 1.h, color: Colors.black12),
          ),
        ),
        bottomNavigationBar: RevButton(
          rolledTo == null ? 'Roll' : 'Confirm',
          buttonColor: AppColors.black,
          height: 50,
          icon: rolledTo != null
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.h),
                      child: Image.asset(
                        'roulette'.png,
                        height: 24.h,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          onPressed: () async {
            if (rolledTo != null) {
              Navigator.pop(context, rolledTo);
              return;
            }
            // Generate random offset
            final random = Random();
            final offset = random.nextDouble();
            rolledTo = random.nextInt(20);

            await rouController.rollTo(2, offset: offset);
            setState(() {});
          },
        ),
        body: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Roulette(
              controller: rouController,
              style: const RouletteStyle(),
            ),
            if (rolledTo != null)
              RevText(
                'You rolled $rolledTo',
                fontSize: 24.sp,
                top: 50.h,
                align: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
          ],
        ));
  }

  int? rolledTo;
}
