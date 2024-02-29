import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../utils/constants/constants.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

DateTime? selectedStartDate;
DateTime? selectedEndDate;

class _CalenderWidgetState extends State<CalenderWidget> {
  bool isShow = false;
  DateTime today = DateTime.now();
  DateTime? selectedDate;
  DateTime? _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = today;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Trip Dates',
                style:
                    googleFontStyle(fontsize: 18, fontweight: FontWeight.w500),
              ),
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  icon: Icon(
                    isShow ? Icons.arrow_drop_down_sharp : Icons.arrow_drop_up,
                    color: Colors.black,
                  ),
                  label: FittedBox(
                    child: Text(
                      isShow ? 'show calender' : 'hide calender',
                      style: googleFontStyle(
                          fontsize: 15, fontweight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 5,
            child: Visibility(
              visible: !isShow,
              child: TableCalendar(
                rowHeight: 50,
                focusedDay: _focusedDay!,
                firstDay: DateTime.utc(2023, 01, 01),
                lastDay: DateTime.utc(2025, 12, 01),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 217, 230, 37),
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    if (selectedStartDate != null &&
                        selectedEndDate != null &&
                        date.isAfter(selectedStartDate!) &&
                        date.isBefore(selectedEndDate!)) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(251, 226, 228, 153)
                              .withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (date == selectedStartDate ||
                        date == selectedEndDate) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(249, 183, 189, 21),
                          shape: BoxShape.circle,
                        ),
                        child: Text(date.day.toString(),
                            style: const TextStyle(color: Colors.white)),
                      );
                    }
                    return null;
                  },
                ),
                selectedDayPredicate: (date) {
                  return isSameDay(selectedStartDate, date) ||
                      isSameDay(selectedEndDate, date) ||
                      (selectedStartDate != null &&
                          selectedEndDate != null &&
                          date.isAfter(selectedStartDate!) &&
                          date.isBefore(selectedEndDate!));
                },
                onDaySelected: (date, _) {
                  setState(() {
                    if (date.isBefore(today)) {
                      selectedDate = null;
                      selectedStartDate = null;
                      selectedEndDate = null;
                    } else if (selectedDate == null ||
                        selectedEndDate != null) {
                      selectedDate = date;
                      selectedStartDate = date;
                      selectedEndDate = null;
                    } else if (selectedDate != null &&
                        selectedEndDate == null) {
                      if (date.isAfter(selectedDate!)) {
                        selectedEndDate = date;
                      } else {
                        selectedEndDate = selectedStartDate;
                        selectedStartDate = date;
                      }
                    }
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedStartDate != null
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                      const SizedBox(width: 8),
                      Text(
                        selectedStartDate != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(selectedStartDate!)
                            : 'Start Date',
                        style: googleFontStyle(
                            fontsize: 17, fontweight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedEndDate != null
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                      const SizedBox(width: 8),
                      Text(
                        selectedEndDate != null
                            ? DateFormat('dd/MM/yyyy').format(selectedEndDate!)
                            : 'End Date',
                        style: googleFontStyle(
                            fontweight: FontWeight.w500, fontsize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
