import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:flutter/widgets.dart' show FormFieldValidator;

class Validators {
  static FormFieldValidator<String> required(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> min(double min, String errorMessage) {
    return (value) {
      if (value!.trim().isEmpty) {
        return null;
      } else {
        final dValue = _toDouble(value);
        if (dValue < min) {
          return errorMessage;
        } else {
          return null;
        }
      }
    };
  }

  static FormFieldValidator<String> max(double max, String errorMessage) {
    return (value) {
      if (value!.trim().isEmpty) {
        return null;
      } else {
        final dValue = _toDouble(value);
        if (dValue > max) {
          return errorMessage;
        } else {
          return null;
        }
      }
    };
  }

  static FormFieldValidator<String> email(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        return null;
      } else {
        final emailRegex = RegExp(UiStrings.regExpSource);
        if (emailRegex.hasMatch(value)) {
          return null;
        } else {
          return errorMessage;
        }
      }
    };
  }

  static FormFieldValidator<String> minLength(
      int minLength, String errorMessage) {
    return (value) {
      if (value!.isEmpty) return null;

      if (value.length < minLength) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> maxLength(
      int maxLength, String errorMessage) {
    return (value) {
      if (value!.isEmpty) return null;

      if (value.length > maxLength) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> patternString(
      String pattern, String errorMessage) {
    return patternRegExp(RegExp(pattern), errorMessage);
  }

  static FormFieldValidator<String> patternRegExp(
      RegExp pattern, String errorMessage) {
    return (value) {
      if (value!.isEmpty) return null;

      if (pattern.hasMatch(value)) {
        return null;
      } else {
        return errorMessage;
      }
    };
  }

  static FormFieldValidator<String> compose(
      List<FormFieldValidator<String>> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  static FormFieldValidator<String> isDigit(String errorMessage) {
    return (value) {
      if (isNumeric(value!)) {
        return null;
      } else {
        return errorMessage;
      }
    };
  }

  static double _toDouble(String value) {
    value = value.replaceAll(' ', '').replaceAll(',', '');
    return double.parse(value);
  }

  static bool isNumeric(String value) {
    if (value.isEmpty) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
