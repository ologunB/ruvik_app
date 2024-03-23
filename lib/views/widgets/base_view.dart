import '../../core/vms/base_vm.dart';
import 'rev_text.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  const BaseView(
      {super.key, required this.builder, this.onModelReady, this.dispose});

  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;
  final Function(T)? dispose;

  @override
  State<BaseView> createState() {
    return _BaseViewState<T>();
  }
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) widget.onModelReady!(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.dispose != null) widget.dispose!(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
