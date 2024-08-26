import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/Components/round_button.dart';
import 'package:sistem_pakar/Components/today_sleep_schedule_row.dart';
import 'package:sistem_pakar/page/pola_hidup.dart';
import 'package:sistem_pakar/page/tambah_jadwal_tidur.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  CalendarAgendaController _calendarAgendaControllerAppBar =
      CalendarAgendaController();
  late DateTime _selectedDateAppBBar;

  List todaySleepArr = [
    {
      "name": "Bedtime",
      "image": "assets/bed.png",
      "time": "01/06/2023 09:00 PM",
      "duration": "in 6hours 22minutes"
    },
    {
      "name": "Alarm",
      "image": "assets/alaarm.png",
      "time": "02/06/2023 05:10 AM",
      "duration": "in 14hours 30minutes"
    },
  ];

  List<int> showingTooltipOnSpots = [4];

  @override
  void initState() {
    super.initState();
    _selectedDateAppBBar = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "JADWAL TIDUR",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(20),
                    height: media.width * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          TColor.primaryColor2.withOpacity(0.4),
                          TColor.primaryColor1.withOpacity(0.4)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Jam Ideal untuk Tidur",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "8 jam 30 menit",
                              style: TextStyle(
                                color: TColor.primaryColor3,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 110,
                              height: 35,
                              child: RoundButton(
                                title: "Learn More",
                                fontSize: 12,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Pola(),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Image.asset(
                          "assets/tidur.png",
                          width: media.width * 0.35,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.01,
                ),
                CalendarAgenda(
                  controller: _calendarAgendaControllerAppBar,
                  appbar: false,
                  selectedDayPosition: SelectedDayPosition.center,
                  leading: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/ArrowLeft.png",
                      width: 15,
                      height: 15,
                    ),
                  ),
                  training: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/ArrowRight.png",
                      width: 15,
                      height: 15,
                    ),
                  ),
                  weekDay: WeekDay.short,
                  dayNameFontSize: 12,
                  dayNumberFontSize: 16,
                  dayBGColor: Colors.grey.withOpacity(0.15),
                  titleSpaceBetween: 15,
                  backgroundColor: Colors.transparent,
                  // fullCalendar: false,
                  fullCalendarScroll: FullCalendarScroll.horizontal,
                  fullCalendarDay: WeekDay.short,
                  selectedDateColor: Colors.white,
                  dateColor: Colors.black,
                  locale: 'en',

                  initialDate: DateTime.now(),
                  calendarEventColor: TColor.primaryColor2,
                  firstDate: DateTime.now().subtract(const Duration(days: 140)),
                  lastDate: DateTime.now().add(const Duration(days: 60)),

                  onDateSelected: (date) {
                    _selectedDateAppBBar = date;
                  },
                  selectedDayLogo: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: TColor.primaryG,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),

                // data jadwal tidur
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todaySleepArr.length,
                  itemBuilder: (context, index) {
                    var sObj = todaySleepArr[index] as Map? ?? {};
                    return TodaySleepScheduleRow(
                      sObj: sObj,
                    );
                  },
                ),
                // end
              ],
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
          ],
        ),
      ),

      // tambah jadwal tidur
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JadwalTidur(
                date: _selectedDateAppBBar,
              ),
            ),
          );
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: TColor.secondaryG),
            borderRadius: BorderRadius.circular(27.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),
    );
  }
}
