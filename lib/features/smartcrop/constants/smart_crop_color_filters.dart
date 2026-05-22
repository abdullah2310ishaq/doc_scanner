import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:colorfilter_generator/presets.dart';

/// Document-friendly filters via [colorfilter_generator] (presets + addons).
abstract final class SmartCropColorFilters {
  static final List<ColorFilterGenerator> filters = [
    PresetFilters.none,
    ColorFilterGenerator(
      name: 'Lighten',
      filters: [ColorFilterAddons.brightness(0.28)],
    ),
    PresetFilters.clarendon,
    ColorFilterGenerator(
      name: 'Grayscale',
      filters: [ColorFilterAddons.grayscale()],
    ),
    PresetFilters.inkwell,
    PresetFilters.reyes,
  ];
}
