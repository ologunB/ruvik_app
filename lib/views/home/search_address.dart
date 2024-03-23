import 'package:flutter_google_maps_webservices/places.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/rev_text.dart';

class SelectAddressScreen extends StatelessWidget {
  const SelectAddressScreen({super.key, required this.pre});

  final String pre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: RevText(
          'Search Address',
          color: AppColors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          align: TextAlign.center,
        ),
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
      ),
      body: PlacesAutocompleteWidget(
        language: 'EN',
        startText: pre,
        components: [Component(Component.country, 'US')],
        onError: (response) => errorSnackBar(context, response.errorMessage!),
      ),
    );
  }
}

class PlacesAutocompleteWidget extends StatefulWidget {
  const PlacesAutocompleteWidget({
    super.key,
    this.offset,
    this.location,
    this.radius,
    this.language,
    this.sessionToken,
    this.types,
    this.components,
    this.strictBounds,
    this.region,
    this.onError,
    this.proxyBaseUrl,
    this.startText,
    this.debounce = 300,
  });

  final String? startText;
  final Location? location;
  final num? offset;
  final num? radius;
  final String? language;
  final String? sessionToken;
  final List<String>? types;
  final List<Component>? components;
  final bool? strictBounds;
  final String? region;
  final ValueChanged<PlacesAutocompleteResponse>? onError;
  final int debounce;

  final String? proxyBaseUrl;

  @override
  State<PlacesAutocompleteWidget> createState() =>
      _PlacesAutocompleteOverlayState();
}

class _PlacesAutocompleteOverlayState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Column header = Column(children: <Widget>[
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.h),
        child: RevField(
          hintText: 'Enter Address',
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.search,
          controller: _queryTextController,
          autoFocus: true,
          suffix: _queryTextController.text.isEmpty
              ? const SizedBox()
              : IconButton(
                  icon: const CloseButtonIcon(),
                  color: Colors.black,
                  onPressed: () {
                    _queryTextController.clear();
                  },
                ),
        ),
      ),
      SizedBox(height: 16.h),
    ]);

    Widget body;

    if (_searching) {
      body = Stack(
          alignment: FractionalOffset.bottomCenter,
          children: <Widget>[_Loader()]);
    } else if (_queryTextController.text.isEmpty ||
        _response?.predictions == null ||
        _response!.predictions.isEmpty) {
      body = Material(color: theme.dialogBackgroundColor);
    } else {
      body = SingleChildScrollView(
        child: Material(
          color: theme.dialogBackgroundColor,
          child: ListBody(
            children: _response!.predictions
                .map(
                  (p) => LocationItem(
                    prediction: p,
                    onTap: (a) {
                      Navigator.pop(context, a);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    return Stack(children: [
      header,
      Padding(padding: EdgeInsets.only(top: 70.h), child: body),
    ]);
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      constraints: const BoxConstraints(maxHeight: 2.0),
      child: const LinearProgressIndicator(),
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem({
    super.key,
    required this.prediction,
    required this.onTap,
    this.isHistory = false,
  });

  final Prediction prediction;
  final ValueChanged<Prediction> onTap;
  final bool isHistory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(prediction);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(3.h),
              margin: EdgeInsets.all(6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.h),
                border: Border.all(width: 1.h, color: AppColors.grey),
                color: AppColors.white,
              ),
              child: Icon(
                isHistory ? Icons.history : Icons.location_on,
                color: AppColors.grey,
                size: 20,
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  RevText(
                    string1Divider(prediction.description),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  RevText(
                    string2Divider(prediction.description),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 15.h),
                  const Divider(height: 0, color: AppColors.grey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String string1Divider(String? text) {
  if (text == null) return '';
  return text.split(',').first.trim();
}

String string2Divider(String? text) {
  if (text == null) return '';
  List<String> all = text.split(',');
  all.removeAt(0);

  if (all.isEmpty) return 'USA';

  return all.join(', ').trim();
}

abstract class PlacesAutocompleteState extends State<PlacesAutocompleteWidget> {
  late TextEditingController _queryTextController;
  PlacesAutocompleteResponse? _response;
  late GoogleMapsPlaces _places;
  bool _searching = false;
  Timer? _debounce;

  final BehaviorSubject<String> _queryBehavior =
      BehaviorSubject<String>.seeded('');

  String? oldText;
  @override
  void initState() {
    oldText = widget.startText;
    super.initState();
    _queryTextController = TextEditingController(text: widget.startText);

    _places = GoogleMapsPlaces(
      apiKey: Utils.googleKey,
      baseUrl: widget.proxyBaseUrl,
    );
    _searching = false;
    _onQueryChange();
    _queryTextController.addListener(() {
      if (oldText != _queryTextController.text) _onQueryChange();
      oldText = _queryTextController.text;
    });

    _queryBehavior.stream.listen(doSearch);
  }

  Future<void> doSearch(String? value) async {
    if (value != null) {
      if (mounted && value.isNotEmpty) {
        setState(() {
          _searching = true;
        });

        final PlacesAutocompleteResponse res = await _places.autocomplete(
          value,
          offset: widget.offset,
          location: widget.location,
          radius: widget.radius,
          language: widget.language,
          sessionToken: widget.sessionToken,
          types: widget.types ?? [],
          components: widget.components ?? [],
          strictbounds: widget.strictBounds ?? false,
          region: widget.region ?? "",
        );

        if (res.errorMessage?.isNotEmpty == true ||
            res.status == 'REQUEST_DENIED') {
          onResponseError(res);
        } else {
          onResponse(res);
        }
      }
    }
  }

  void _onQueryChange() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(Duration(milliseconds: widget.debounce), () {
      if (!_queryBehavior.isClosed) {
        _queryBehavior.add(_queryTextController.text);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _places.dispose();
    _debounce?.cancel();
    _queryBehavior.close();
    _queryTextController.removeListener(_onQueryChange);
  }

  @mustCallSuper
  void onResponseError(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    if (widget.onError != null) {
      widget.onError!(res);
    }
    setState(() {
      _response = null;
      _searching = false;
    });
  }

  @mustCallSuper
  void onResponse(PlacesAutocompleteResponse res) {
    if (!mounted) {
      return;
    }

    setState(() {
      _response = res;
      _searching = false;
    });
  }
}
