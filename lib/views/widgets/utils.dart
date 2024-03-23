import '../../core/models/restaurant_model.dart';
import 'rev_text.dart';

Future<dynamic> push(
  BuildContext context,
  Widget page, [
  bool dialog = false,
  bool root = true,
]) async {
  FocusScope.of(context).unfocus();
  return await Navigator.of(context, rootNavigator: root).push(
    CupertinoPageRoute(
      builder: (context) => page,
      fullscreenDialog: dialog,
      settings: RouteSettings(arguments: dialog),
    ),
  );
}

void pushReplacement(BuildContext context, Widget page) {
  FocusScope.of(context).unfocus();
  Navigator.pushReplacement(
    context,
    CupertinoPageRoute(builder: (context) => page),
  );
}

void pushAndRemoveUntil(BuildContext context, Widget page) {
  FocusScope.of(context).unfocus();
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(builder: (context) => page),
    (Route<dynamic> route) => false,
  );
}

class Utils {
  static void offKeyboard() async {
    await SystemChannels.textInput.invokeMethod<dynamic>('TextInput.hide');
  }

  static String get googleKey => 'AIzaSyDa-Rb_DceGzTMkKuSPdPpMevXbzu1IKUY';

  static List<String> categoryData = [
    "{\"alias\":\"chinese\",\"title\":\"Chinese\"}",
    "{\"alias\":\"noodles\",\"title\":\"Noodles\"}",
    "{\"alias\":\"newamerican\",\"title\":\"New American\"}",
    "{\"alias\":\"wine_bars\",\"title\":\"Wine Bars\"}",
    "{\"alias\":\"beerbar\",\"title\":\"Beer Bar\"}",
    "{\"alias\":\"italian\",\"title\":\"Italian\"}",
    "{\"alias\":\"breakfast_brunch\",\"title\":\"Breakfast & Brunch\"}",
    "{\"alias\":\"mediterranean\",\"title\":\"Mediterranean\"}",
    "{\"alias\":\"newmexican\",\"title\":\"New Mexican Cuisine\"}",
    "{\"alias\":\"cocktailbars\",\"title\":\"Cocktail Bars\"}",
    "{\"alias\":\"mexican\",\"title\":\"Mexican\"}",
    "{\"alias\":\"korean\",\"title\":\"Korean\"}",
    "{\"alias\":\"bbq\",\"title\":\"Barbeque\"}",
    "{\"alias\":\"desserts\",\"title\":\"Desserts\"}",
    "{\"alias\":\"caribbean\",\"title\":\"Caribbean\"}",
    "{\"alias\":\"spanish\",\"title\":\"Spanish\"}",
    "{\"alias\":\"seafood\",\"title\":\"Seafood\"}",
    "{\"alias\":\"bars\",\"title\":\"Bars\"}",
    "{\"alias\":\"vietnamese\",\"title\":\"Vietnamese\"}",
    "{\"alias\":\"japanese\",\"title\":\"Japanese\"}",
    "{\"alias\":\"sushi\",\"title\":\"Sushi Bars\"}",
    "{\"alias\":\"steak\",\"title\":\"Steakhouses\"}",
    "{\"alias\":\"burgers\",\"title\":\"Burgers\"}",
    "{\"alias\":\"sandwiches\",\"title\":\"Sandwiches\"}",
    "{\"alias\":\"lebanese\",\"title\":\"Lebanese\"}"
  ];

  static List<Categories> get categories =>
      categoryData.map((e) => Categories.fromJson(jsonDecode(e))).toList();
}

extension CustomIntExtension on double {
  toAmount() {
    return toString().toAmount();
  }
}

extension CustomStringExtension on String {
  toTitleCase() {
    final words = toString().toLowerCase().split(' ');
    var newWord = '';
    for (var word in words) {
      if (word.isNotEmpty) {
        newWord += '${word[0].toUpperCase()}${word.substring(1)} ';
      }
    }

    return newWord.trim();
  }

  String colon() {
    if (length != 4) {
      return "Invalid time"; // Or handle the error in another appropriate way
    }

    // Extract hours and minutes from the string
    int hours = int.parse(substring(0, 2));
    int minutes = int.parse(substring(2, 4));

    // Determine AM or PM
    String amPm = hours >= 12 && hours < 24 ? "PM" : "AM";

    // Convert hours to 12-hour format
    if (hours > 12) {
      hours -= 12;
    } else if (hours == 0) {
      hours = 12; // Midnight to 12 AM
    }

    // Format minutes to always be two digits
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    // Return the formatted time string
    return "$hours:$formattedMinutes $amPm";
  }

  toAmount() {
    return NumberFormat("#,##0.00", "en_US")
        .format(double.tryParse(this) ?? 0.00);
  }

  get png => 'assets/images/$this.png';

  getSingleInitial() => split('')[0].toUpperCase();

  firstCapitalize() => "${this[0].toUpperCase()}${substring(1)}";
}
