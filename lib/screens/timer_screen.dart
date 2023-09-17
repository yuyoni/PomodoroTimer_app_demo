// lib/screens/timer_screen.dart

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter_pomodoro_timer/tools/utils.dart';

enum TimerStatus { running, paused, stopped, resting }

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // 상태변수 1. 타이머 시간
  static const WORK_SECONDS = 25;
  static const REST_SECONDS = 5;

  // 상태변수 2. 타이머 Status
  late TimerStatus _timerStatus;
  late int _timer;

  //상태변수 3. 뽀모도로 횟수
  late int _pomodoroCount;

  //상태의 초기값 설정하기 위해 initState()메서드를 오버라이드
  @override
  void initState() {
    super.initState();
    //_timerStatus의 초기상태는 정지
    _timerStatus = TimerStatus.stopped;
    showToast(_timerStatus.toString());
    //_timer의 초기상태는 WORK_SECONDS
    _timer = WORK_SECONDS;
    //_pomodoroCount의 초기상태는 0
    _pomodoroCount = 0;
  }

  // 이벤트 5가지 : run, rest, pause, resume, stop
  void run() {
    setState(() {
      _timerStatus = TimerStatus.running;
      showToast("[=>] " + _timerStatus.toString());
      runTimer(); // 타이머 실행 함수
    });
  }

  void rest() {
    setState(() {
      _timer = REST_SECONDS;
      _timerStatus = TimerStatus.resting;
      showToast("[=>] " + _timerStatus.toString());
    });
  }

  void pause() {
    setState(() {
      _timerStatus = TimerStatus.paused;
      showToast("[=>] " + _timerStatus.toString());
    });
  }

  void resume() {
    run();
  }

  void stop() {
    setState(() {
      _timer = WORK_SECONDS;
      _timerStatus = TimerStatus.stopped;
      showToast("[=>] " + _timerStatus.toString());
    });
  }

  void runTimer() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      //switch case문으로 5가지 이벤트 처리해주기
      switch (_timerStatus) {
        // paused 일때 : 취소
        case TimerStatus.paused:
          t.cancel();
          break;
        // stopped 일때 : 취소
        case TimerStatus.stopped:
          t.cancel();
          break;
        // running 일때 : _timer를 1씩 감소하고 _timer가 0이면 rest()메서드 실행
        case TimerStatus.running:
          if (_timer <= 0) {
            showToast("작업 완료");
            rest();
          } else {
            setState(() {
              _timer -= 1;
            });
          }
          break;
        // resting 일때 : _timer를 1씩 감소하고 _timer가 0이면 뽀모도로 갯수 +1하고 stop()메서드 실행
        case TimerStatus.resting:
          if (_timer <= 0) {
            setState(() {
              _pomodoroCount += 1;
            });
            showToast("오늘 $_pomodoroCount 개의 뽀모도로를 달성했습니다.");
            t.cancel();
            stop();
          } else {
            setState(() {
              _timer -= 1;
            });
          }
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. 타이머 돌아가고 있을 때
    final List<Widget> _runningButtons = [
      // 계속하기/일시정지 버튼
      ElevatedButton(
        child: Text(
          _timerStatus == TimerStatus.paused ? 'Continue' : 'Pause',
          style: TextStyle(
              color: Colors.white, fontFamily: 'DungGeunMo', fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: _timerStatus == TimerStatus.paused ? resume : pause,
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
        onPressed: stop,
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
            backgroundColor: _timerStatus == TimerStatus.resting
                ? Colors.green
                : Colors.blue),
        onPressed: run,
      ),
    ];

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Pomodoro Timer App',
          style: TextStyle(fontFamily: 'DungGeunMo'),
        )),
        backgroundColor:
            _timerStatus == TimerStatus.resting ? Colors.green : Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                  child: Text(
                secondsToString(_timer),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'DungGeunMo',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              )),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _timerStatus == TimerStatus.resting
                    ? Colors.green
                    : Colors.blue,
              ),
            ),
            // Row 버튼은 휴식중인지 아닌지 검사헤서 상황에 따라 다른 버튼들 보여줌
            // 휴식 중 ? 참이면 const[](버튼없음) : 거짓이면 버튼있음
            // 버튼 있음 ? 참이면 _stoppedButtons 스탑 : 거짓이면 _runningButtons 러닝
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _timerStatus == TimerStatus.resting
                  ? const []
                  : _timerStatus == TimerStatus.stopped
                      ? _stoppedButtons
                      : _runningButtons,
            ),
          ],
        ));
  }
}
