import 'dart:async';

class TimerService {
  late Timer _timer;
  late int _hours;
  int _minutes = 0;
  int _seconds = 0;

  TimerService(int initialHours) {
    _hours = initialHours;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_hours == 0 && _minutes == 0 && _seconds == 0) {
        _timer.cancel();
        // Timer has reached 0
        print('Timer has reached 0');
      } else {
        if (_seconds == 0) {
          if (_minutes == 0) {
            _hours--;
            _minutes = 59;
          } else {
            _minutes--;
          }
          _seconds = 59;
        } else {
          _seconds--;
        }
        // Add a stream controller to emit the current time
        _timeController.add('$_hours:$_minutes:$_seconds');
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  final StreamController<String> _timeController = StreamController<String>.broadcast();
  Stream<String> get currentTimeStream => _timeController.stream;

  String getCurrentTime() {
    String hoursStr = _hours.toString().padLeft(2, '0');
    String minutesStr = _minutes.toString().padLeft(2, '0');
    String secondsStr = _seconds.toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr:$secondsStr';
  }

  void dispose() {
    _timeController.close();
  }
}
