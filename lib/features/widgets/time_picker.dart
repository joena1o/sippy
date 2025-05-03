import 'package:flutter/material.dart';

class TimeRange extends StatelessWidget {
  final TimeOfDay start;
  final TimeOfDay end;
  final List<TimeOfDay> blackoutTimes;
  final Function(TimeOfDay, TimeOfDay) onRangeSelected;

  const TimeRange({
    Key? key,
    required this.start,
    required this.end,
    required this.onRangeSelected,
    this.blackoutTimes = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimeList(
            start: start,
            end: end,
            onTimeSelected: (selectedTime) {
              onRangeSelected(selectedTime, end);
            },
            blackoutTimes: blackoutTimes,
          ),
        ),
        Expanded(
          child: TimeList(
            start: start,
            end: end,
            onTimeSelected: (selectedTime) {
              onRangeSelected(start, selectedTime);
            },
            blackoutTimes: blackoutTimes,
          ),
        ),
      ],
    );
  }
}

class TimeList extends StatefulWidget {
  final TimeOfDay start;
  final TimeOfDay end;
  final Function(TimeOfDay) onTimeSelected;
  final List<TimeOfDay> blackoutTimes;

  const TimeList({
    super.key,
    required this.start,
    required this.end,
    required this.onTimeSelected,
    this.blackoutTimes = const [],
  });

  @override
  _TimeListState createState() => _TimeListState();
}

class _TimeListState extends State<TimeList> {
  late List<TimeOfDay> availableTimes;

  @override
  void initState() {
    super.initState();
    _loadHours();
  }

  void _loadHours() {
    availableTimes = [];
    TimeOfDay current = widget.start;
    while (_isBeforeOrEqual(current, widget.end)) {
      if (!widget.blackoutTimes.contains(current)) {
        availableTimes.add(current);
      }
      current = _addMinutes(current, 30);
    }
  }

  bool _isBeforeOrEqual(TimeOfDay first, TimeOfDay second) {
    return first.hour < second.hour ||
        (first.hour == second.hour && first.minute <= second.minute);
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    int newMinutes = time.minute + minutes;
    int newHours = time.hour + (newMinutes ~/ 60);
    newMinutes %= 60;
    return TimeOfDay(hour: newHours, minute: newMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: availableTimes.length,
      itemBuilder: (context, index) {
        TimeOfDay time = availableTimes[index];
        bool isBlackout = widget.blackoutTimes.contains(time);

        return GestureDetector(
          onTap: isBlackout ? null : () => widget.onTimeSelected(time),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: isBlackout ? Colors.grey : Colors.white,
            child: Text(
              '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: isBlackout ? Colors.grey[600] : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
