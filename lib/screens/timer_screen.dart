// lib/screens/timer_screen.dart

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    // 1. 타이머 돌아가고 있을 때
    final List<Widget> _runningButtons = [
      // 계속하기/일시정지 버튼
      ElevatedButton(
        child: Text(
          1 == 2 ? 'Continue' : 'Pause',
          style: TextStyle(
              color: Colors.white, fontFamily: 'DungGeunMo', fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () {},
      ),
      Padding(
        padding: EdgeInsets.all(20),
      ),
      // 포기하기 버튼
      ElevatedButton(
        child: Text(
          'Give up',
          style: TextStyle(
              color: Colors.white, fontFamily: 'DungGeunMo', fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        onPressed: () {},
      ),
    ];

    // 2. 타이머 정지상태 일때
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        child: Text(
          'Start',
          style: TextStyle(
              color: Colors.white, fontFamily: 'DungGeunMo', fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            // 휴식 중인건지 정지인건지 구분하기 위해 색 다르게
            backgroundColor: 1 == 2 ? Colors.green : Colors.blue),
        onPressed: () {},
      ),
    ];

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Pomodoro Timer',
          style: TextStyle(fontFamily: 'DungGeunMo'),
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                  child: Text(
                '00:00',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'DungGeunMo',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              )),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: 1 == 2 ? Colors.green : Colors.blue,
              ),
            ),
            // Row 버튼은 휴식중인지 아닌지 검사헤서 상황에 따라 다른 버튼들 보여줌
            // 휴식 중 ? 참이면 const[](버튼없음) : 거짓이면 버튼있음
            // 버튼 있음 ? 참이면 _stoppedButtons 스탑 : 거짓이면 _runningButtons 러닝
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: 1 == 2
                  ? const []
                  : 1 == 2
                      ? _stoppedButtons
                      : _runningButtons,
            ),
          ],
        ));
  }
}
