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

  static String get yelpToken =>
      'lPhPjeoB8YU2_ByQ8WOdLNHBsXKtfGn7e61fvhDGwW470p-gJmY6XPNN61DwHi-ZDk0Um14Jf1Ph0Di21b1hOtL_qXjJ3-S2bxTN-aUDQGSQidoMWCQbtZanL5L9ZXYx';

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

  static String reviewData =
      "{\n  \"possible_languages\": [\n    \"en\"\n  ],\n  \"reviews\": [\n    {\n      \"id\": \"xAG4O7l-t1ubbwVAlPnDKg\",\n      \"url\": \"https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w\",\n      \"text\": \"Went back again to this place since the last time i visited the bay area 5 months ago, and nothing has changed. Still the sketchy Mission, Still the cashier...\",\n      \"rating\": 5,\n      \"time_created\": \"2016-08-29 00:41:13\",\n      \"user\": {\n        \"id\": \"W8UK02IDdRS2GL_66fuq6w\",\n        \"profile_url\": \"https://www.yelp.com/user_details?userid=W8UK02IDdRS2GL_66fuq6w\",\n        \"image_url\": \"https://s3-media3.fl.yelpcdn.com/photo/iwoAD12zkONZxJ94ChAaMg/o.jpg\",\n        \"name\": \"Ella A.\"\n      }\n    },\n    {\n      \"id\": \"1JNmYjJXr9ZbsfZUAgkeXQ\",\n      \"url\": \"https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=fj87uymFDJbq0Cy5hXTHIA&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w\",\n      \"text\": \"The restaurant is inside a small deli so there is no sit down area. Just grab and go. Inside, they sell individually packaged ingredients so that you can...\",\n      \"rating\": 4,\n      \"time_created\": \"2016-09-28 08:55:29\",\n      \"user\": {\n        \"id\": \"rk-MwIUejOj6LWFkBwZ98Q\",\n        \"profile_url\": \"https://www.yelp.com/user_details?userid=rk-MwIUejOj6LWFkBwZ98Q\",\n        \"image_url\": \"\",\n        \"name\": \"Yanni L.\"\n      }\n    },\n    {\n      \"id\": \"SIoiwwVRH6R2s2ipFfs4Ww\",\n      \"url\": \"https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=m_tnQox9jqWeIrU87sN-IQ&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w\",\n      \"text\": \"Dear Mission District, I miss you and your many delicious late night food establishments and vibrant atmosphere.  I miss the way you sound and smell on a...\",\n      \"rating\": 4,\n      \"time_created\": \"2016-08-10 07:56:44\",\n      \"user\": {\n        \"id\": \"rpOyqD_893cqmDAtJLbdog\",\n        \"profile_url\": \"https://www.yelp.com/user_details?userid=rpOyqD_893cqmDAtJLbdog\",\n        \"image_url\": \"\",\n        \"name\": \"Suavecito M.\"\n      }\n    }\n  ],\n  \"total\": 3\n}";

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
