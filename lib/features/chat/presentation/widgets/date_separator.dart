import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';

class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateText;
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      dateText = "Today";
    } else if (difference == 1) {
      dateText = "Yesterday";
    } else if (difference < 7) {
      dateText = DateFormat('EEEE').format(date); // Day name
    } else {
      dateText = DateFormat('MMM d').format(date); // Month and day
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppTheme.lightGrey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dateText,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppTheme.lightGrey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
