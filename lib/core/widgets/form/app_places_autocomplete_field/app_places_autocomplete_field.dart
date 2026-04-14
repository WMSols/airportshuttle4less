import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:airportshuttle4less/core/config/env_config.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:airportshuttle4less/core/widgets/form/app_input_decoration/app_input_decoration.dart';

class _PlaceSuggestion {
  const _PlaceSuggestion({required this.placeId, required this.description});
  final String placeId;
  final String description;
}

/// Google Places autocomplete field with optional "open map" action.
class AppPlacesAutocompleteField extends StatefulWidget {
  const AppPlacesAutocompleteField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  State<AppPlacesAutocompleteField> createState() =>
      _AppPlacesAutocompleteFieldState();
}

class _AppPlacesAutocompleteFieldState
    extends State<AppPlacesAutocompleteField> {
  final Dio _dio = Dio();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  bool _loading = false;
  List<_PlaceSuggestion> _suggestions = const [];
  String? _selectedAddress;
  String? _apiError;

  static const String _autocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String _detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  String get _apiKey => EnvConfig.googleMapsApiKey;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _suggestions = const []);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchSuggestions(String input) async {
    if (_apiKey.isEmpty || input.trim().length < 3) {
      if (mounted) {
        setState(() {
          _suggestions = const [];
          _apiError = _apiKey.isEmpty
              ? 'Google Maps API key is missing.'
              : null;
        });
      }
      return;
    }
    setState(() {
      _loading = true;
      _apiError = null;
    });
    try {
      final response = await _dio.get(
        _autocompleteUrl,
        queryParameters: <String, dynamic>{
          'input': input.trim(),
          'key': _apiKey,
          'types': 'geocode',
        },
      );
      final status = (response.data['status'] ?? '').toString();
      final errorMessage = (response.data['error_message'] ?? '').toString();
      if (status == 'REQUEST_DENIED' || status == 'INVALID_REQUEST') {
        if (mounted) {
          setState(() {
            _suggestions = const [];
            _apiError = errorMessage.isNotEmpty
                ? errorMessage
                : 'Google Places request was denied.';
          });
        }
        return;
      }
      final predictions =
          (response.data['predictions'] as List<dynamic>? ?? const []);
      final parsed = predictions
          .map(
            (e) => _PlaceSuggestion(
              placeId: (e['place_id'] ?? '').toString(),
              description: (e['description'] ?? '').toString(),
            ),
          )
          .where((e) => e.placeId.isNotEmpty && e.description.isNotEmpty)
          .take(5)
          .toList();
      if (mounted) {
        setState(() {
          _suggestions = parsed;
          _apiError = null;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _suggestions = const [];
          _apiError = 'Unable to fetch place suggestions right now.';
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _selectSuggestion(_PlaceSuggestion suggestion) async {
    String value = suggestion.description;
    if (_apiKey.isNotEmpty) {
      try {
        final response = await _dio.get(
          _detailsUrl,
          queryParameters: <String, dynamic>{
            'place_id': suggestion.placeId,
            'key': _apiKey,
            'fields': 'formatted_address',
          },
        );
        final fromDetails =
            (response.data['result']?['formatted_address'] ?? '').toString();
        if (fromDetails.isNotEmpty) value = fromDetails;
      } catch (_) {}
    }
    widget.controller.text = value;
    widget.onChanged?.call(value);
    if (mounted) {
      setState(() {
        _selectedAddress = value;
        _suggestions = const [];
        _apiError = null;
      });
    }
    _focusNode.unfocus();
  }

  Future<void> _openInMap() async {
    final query = (_selectedAddress ?? widget.controller.text).trim();
    if (query.isEmpty) return;
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}',
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  String _primaryAddress(String full) {
    final index = full.indexOf(',');
    if (index <= 0) return full;
    return full.substring(0, index).trim();
  }

  String _secondaryAddress(String full) {
    final index = full.indexOf(',');
    if (index <= 0) return '';
    return full.substring(index + 1).trim();
  }

  bool get _shouldShowDropdown {
    final typed = widget.controller.text.trim().length >= 3;
    return _focusNode.hasFocus && typed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFieldLabel(label: widget.label),
        AppSpacing.vertical(context, 0.004),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: (value) {
            widget.onChanged?.call(value);
            _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 350), () {
              _fetchSuggestions(value);
            });
          },
          decoration: AppInputDecoration.decoration(
            context,
            hintText: widget.hint,
            prefixIcon: Iconsax.location,
            suffixIcon: _loading
                ? SizedBox(
                    width: AppResponsive.scaleSize(context, 18),
                    height: AppResponsive.scaleSize(context, 18),
                    child: Padding(
                      padding: EdgeInsets.all(
                        AppResponsive.scaleSize(context, 10),
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: AppResponsive.scaleSize(context, 2),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: _openInMap,
                    icon: const Icon(Iconsax.map),
                    color: AppColors.grey,
                    tooltip: 'Open in map',
                  ),
          ),
          style: AppTextStyles.bodyText(context),
        ),
        if (_shouldShowDropdown)
          Container(
            margin: EdgeInsets.only(
              top: AppSpacing.verticalValue(context, 0.006),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              border: Border.all(color: AppColors.lightGrey),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: AppResponsive.scaleSize(context, 8),
                  offset: Offset(0, AppResponsive.scaleSize(context, 2)),
                ),
              ],
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: AppResponsive.screenHeight(context) * 0.32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_loading)
                    Padding(
                      padding: AppSpacing.symmetric(context, h: 0.03, v: 0.012),
                      child: Row(
                        children: [
                          SizedBox(
                            width: AppResponsive.scaleSize(context, 16),
                            height: AppResponsive.scaleSize(context, 16),
                            child: CircularProgressIndicator(
                              strokeWidth: AppResponsive.scaleSize(context, 2),
                            ),
                          ),
                          AppSpacing.horizontal(context, 0.02),
                          Expanded(
                            child: Text(
                              'Loading suggestions...',
                              style: AppTextStyles.hintText(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_apiError != null && _apiError!.isNotEmpty)
                    Padding(
                      padding: AppSpacing.symmetric(context, h: 0.03, v: 0.012),
                      child: Text(
                        _apiError!,
                        style: AppTextStyles.hintText(
                          context,
                        ).copyWith(color: AppColors.error),
                      ),
                    )
                  else if (_suggestions.isEmpty)
                    Padding(
                      padding: AppSpacing.symmetric(context, h: 0.03, v: 0.012),
                      child: Text(
                        'No places found.',
                        style: AppTextStyles.hintText(context),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _suggestions.length,
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: AppColors.lightGrey),
                        itemBuilder: (context, index) {
                          final s = _suggestions[index];
                          final primary = _primaryAddress(s.description);
                          final secondary = _secondaryAddress(s.description);
                          return InkWell(
                            onTap: () => _selectSuggestion(s),
                            child: Padding(
                              padding: AppSpacing.symmetric(
                                context,
                                h: 0.03,
                                v: 0.012,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: AppResponsive.scaleSize(context, 2),
                                    ),
                                    child: Icon(
                                      Iconsax.location,
                                      color: AppColors.grey,
                                      size: AppResponsive.iconSize(
                                        context,
                                        factor: 0.8,
                                      ),
                                    ),
                                  ),
                                  AppSpacing.horizontal(context, 0.02),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          primary,
                                          style: AppTextStyles.bodyText(
                                            context,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (secondary.isNotEmpty) ...[
                                          AppSpacing.vertical(context, 0.003),
                                          Text(
                                            secondary,
                                            style: AppTextStyles.hintText(
                                              context,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    padding: AppSpacing.symmetric(context, h: 0.03, v: 0.008),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'powered by Google',
                      style: AppTextStyles.hintText(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
