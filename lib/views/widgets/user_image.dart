import 'rev_text.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    this.file,
    this.imageUrl,
    required this.size,
    required this.radius,
  });

  final File? file;
  final String? imageUrl;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: file == null
          ? imageUrl == null || imageUrl!.isEmpty
              ? Image.asset(
                  'person'.png,
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl ?? 'm',
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Image.asset(
                    'person'.png,
                    height: size,
                    width: size,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (_, __, ___) => Image.asset(
                    'person'.png,
                    height: size,
                    width: size,
                    fit: BoxFit.cover,
                  ),
                )
          : Image.file(
              file!,
              height: size,
              width: size,
              fit: BoxFit.cover,
            ),
    );
  }
}
