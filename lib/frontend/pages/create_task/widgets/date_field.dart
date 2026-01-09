import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';

class DateField extends StatefulWidget {
  final DateTime? dateTime;
  final void Function(DateTime) date;

  const DateField({super.key, required this.date, this.dateTime});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late DateTime selectedDate = widget.dateTime ?? DateTime.now();

  Future<void> dateSelect(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
    widget.date(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return GestureDetector(
      onTap: () async => await dateSelect(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month),
            AppSpacing.w08,
            Text(DateFormat(S.of(context).dateFormat).format(selectedDate)),
          ],
        ),
      ),
    );
  }
}
