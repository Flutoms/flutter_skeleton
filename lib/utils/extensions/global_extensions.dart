import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:midlr/utils/global_strings.dart';

extension CustomContext on BuildContext {
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}

extension CapitalizeStringExtensions on String {
  String get capitalize => isNotEmpty && this[0].isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1)}'
      : '';
}

extension FormatDate on DateTime {
  String get formatDate {
    final dateFormat = DateFormat('MMM d, ' 'yyyy');
    return dateFormat.format(this);
  }
}

extension StringExtensions on String {
  String get svg => 'assets/images/svg/$this.svg';

  String get png => 'assets/images/png/$this.png';

  String get lottie => 'assets/lottie/$this.json';

  String get cleanFigure => replaceAll('₦', '').replaceAll(',', '');

  String get cleanDate => replaceAll(RegExp('[A-Za-z]'), '').trim();

  String get formattedPhone {
    if (length > 4) {
      if (substring(4).contains('2340')) {
        var item = split('')..remove('3');

        return item.join('');
      } else {
        return this;
      }
    } else {
      throw Exception('Invalid phone number');
    }
  }
}

extension FigureFormater on num {
  String formatFigures() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return '${myFormat.simpleCurrencySymbol(ngn)} '
        '${myFormat.format(this)}';
  }

  String get figuresSeparator {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return myFormat.format(this);
  }
}

extension TimeAgo on DateTime {
  String timeAgo() {
    Duration diff = DateTime.now().difference(this);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "yr" : "yrs"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hr" : "hrs"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "mins"} ago";
    }
    return 'just now';
  }
}

extension FormValidator on GlobalKey<FormState> {
  bool get validate => currentState!.validate();
}

