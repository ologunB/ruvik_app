import 'package:lendo/views/widgets/rev_text.dart';

class RevCachedImage extends StatelessWidget {
  const RevCachedImage({required this.url, super.key, this.height, this.width});

  final String url;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      fit: BoxFit.cover,
      width: width ?? size.width,
      /*   placeholder: (_, __) => Image.asset(
        'placeholder'.png,
        height: height,
        fit: BoxFit.cover,
        width: width ?? size.width,
      ),*/
      progressIndicatorBuilder: (_, __, a) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
              width: 30.h,
              child: CircularProgressIndicator(value: a.progress),
            )
          ],
        );
      },
      errorWidget: (_, __, ___) => Image.asset(
        'placeholder'.png,
        height: height,
        fit: BoxFit.cover,
        width: width ?? size.width,
      ),
    );
  }
}
