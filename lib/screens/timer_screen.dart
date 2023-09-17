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
        ),
        onPressed: () {},
      ),
      Padding(
        padding: EdgeInsets.all(20),
      ),
      // 포기하기 버튼
      ElevatedButton(
        child: Text('Give up'),
        onPressed: () {},
      ),
    ];

    // 2. 타이머 정지상태 일때
    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        child: Text('시작하기'),
        onPressed: () {},
      ),
    ];

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Pomodoro Timer',
        )),
        body: Column(
          children: [
            Container(
              child: Center(child: Text('00:00')),
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            // Row 버튼은 휴식중인지 아닌지 검사헤서 상황에 따라 다른 버튼들 보여줌
            // 휴식 중 ? 참이면 const[](버튼없음) : 거짓이면 버튼있음
            // 버튼 있음 ? 참이면 _stoppedButtons 스탑 : 거짓이면 _runningButtons 러닝
            Row(
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
