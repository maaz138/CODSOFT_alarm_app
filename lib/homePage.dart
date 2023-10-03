import 'dart:async';
import 'dart:math';

import 'package:alarm_tutorial/clockPainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: Text("Alarm clock Codsoft",
              style: TextStyle(color: Colors.black))),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Clock(),
            Spacer(),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: alarm.length + 1,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == 0)
                      return AddAlarm();
                    else
                      return OldAlarm(
                          alarm[i - 1]["active"],
                          alarm[i - 1]["time"],
                          alarm[i - 1]["id"],
                          alarm[i - 1]["monday"],
                          alarm[i - 1]["tuesday"],
                          alarm[i - 1]["wednesday"],
                          alarm[i - 1]["thursday"],
                          alarm[i - 1]["friday"],
                          alarm[i - 1]["saturday"],
                          alarm[i - 1]["sunday"]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();
  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (inputWidth / 414.0) * screenWidth;
  }

  String getSVG(int hour) {
    if (4 < hour && hour < 20)
      return "assets/Sun.svg";
    else
      return "assets/Moon.svg";
  }

  String textTime(String hour, String min) {
    if (hour.length == 1) hour = "0" + hour;
    if (min.length == 1) min = "0" + min;
    return hour + ":" + min;
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 191, 191),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 64,
                            color: Color(0xFF364564).withOpacity(0.14))
                      ]),
                  child: Transform.rotate(
                    angle: -pi / 2,
                    child: CustomPaint(
                      painter: ClockPainter(_dateTime),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.17)),
                child: SvgPicture.asset(getSVG(_dateTime.hour),
                    height: 24,
                    color: const Color.fromARGB(255, 218, 126, 119)),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.17),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                    textTime(
                        _dateTime.hour.toString(), _dateTime.minute.toString()),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          ],
        )
      ],
    );
  }
}
//clock completed

List<Map<String, dynamic>> alarm = [
  {
    "id": 0,
    "time": "21:00",
    "active": true,
    "monday": true,
    "tuesday": true,
    "wednesday": false,
    "thursday": true,
    "friday": false,
    "saturday": true,
    "sunday": false
  },
  {
    "id": 1,
    "time": "01:00",
    "active": false,
    "monday": true,
    "tuesday": true,
    "wednesday": false,
    "thursday": true,
    "friday": false,
    "saturday": true,
    "sunday": true
  }
];

class AddAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: SizedBox(
        height: 180,
        child: AspectRatio(
          aspectRatio: 0.7,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.orange),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.white,
                ),
                Spacer(),
                Text("ADD NEW",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OldAlarm extends StatefulWidget {
  final String time;
  final int id;
  bool active, monday, tuesday, wednesday, thursday, friday, saturday, sunday;

  OldAlarm(this.active, this.time, this.id, this.monday, this.tuesday,
      this.wednesday, this.thursday, this.friday, this.saturday, this.sunday);

  @override
  _OldAlarmState createState() => _OldAlarmState();
}

class _OldAlarmState extends State<OldAlarm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: SizedBox(
        height: 180,
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 0.1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Switch(
                    value: widget.active,
                    activeColor: Colors.blueGrey,
                    onChanged: (value) {
                      setState(() {
                        widget.active = value;
                      });
                    }),
                Spacer(),
                Text(
                  widget.time,
                  style: TextStyle(
                      fontSize: 25,
                      color: widget.active ? Colors.black : Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("M",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.monday
                                    ? Colors.orange
                                    : Colors.grey
                                : Colors.grey)),
                    Text("T",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.tuesday
                                    ? Colors.orange
                                    : Colors.grey
                                : Colors.grey)),
                    Text("W",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.wednesday
                                    ? Colors.orange
                                    : Colors.grey
                                : Colors.grey)),
                    Text("T",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.thursday
                                    ? Colors.orange
                                    : Colors.grey
                                : Colors.grey)),
                    Text("F",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.friday
                                    ? Colors.red
                                    : Colors.grey
                                : Colors.grey)),
                    Text("S",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.saturday
                                    ? Colors.pinkAccent
                                    : Colors.grey
                                : Colors.grey)),
                    Text("S",
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.active
                                ? widget.sunday
                                    ? Colors.pinkAccent
                                    : Colors.grey
                                : Colors.grey))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
