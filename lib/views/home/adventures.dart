import '../widgets/rev_text.dart';

class AdventuresScreen extends StatefulWidget {
  const AdventuresScreen({super.key});

  @override
  State<AdventuresScreen> createState() => _AdventuresScreenState();
}

class _AdventuresScreenState extends State<AdventuresScreen> {
  dynamic chosen;
  @override
  Widget build(BuildContext context) {
    double width1 = (MediaQuery.of(context).size.width - 50.h) / 2;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleSpacing: 4.h,
        title: RevText(
          'Themed Adventures',
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.grey,
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0, 1),
          child: Divider(height: 0, thickness: 1.h, color: Colors.black12),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RevButton(
          'Confirm',
          buttonColor: AppColors.black,
          height: 50,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          onPressed: chosen == null
              ? null
              : () {
                  Navigator.pop(context, chosen);
                },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Wrap(
          runSpacing: 16.h,
          spacing: 16.h,
          children: themes.map((value) {
            bool isPresent = chosen?['term'] == value['term'];
            return InkWell(
              onTap: () {
                chosen = value;
                setState(() {});
              },
              borderRadius: BorderRadius.circular(6.h),
              child: Container(
                height: 40.h,
                width: width1,
                padding: EdgeInsets.symmetric(horizontal: 4.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: isPresent ? AppColors.priBG : null,
                    borderRadius: BorderRadius.circular(6.h),
                    border: Border.all(
                        color: isPresent
                            ? AppColors.priBG
                            : const Color(0xffE0E0E0))),
                child: RevText(
                  value['term'],
                  fontSize: 12.sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: isPresent ? AppColors.primary : AppColors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List get themes => [
        {
          'term': 'Starbucks',
          'limit': 10,
          'open_now': true,
        },
        {
          'term': 'Wizarding Feasts',
          'limit': 10,
          'open_now': true,
        },
        {
          'term': 'Superhero Snacks',
          'limit': 10,
          'open_now': true,
        },
        {
          'term': 'Bar',
          'limit': 10,
          'open_now': true,
        },
        {
          'term': 'Cold Drink',
          'limit': 10,
          'open_now': true,
        },
        {
          'term': 'Fruit Kingdom',
          'limit': 10,
          'open_now': true,
        },
        {
          'term': 'First Date',
          'limit': 10,
          'open_now': true,
        },
      ];
}
