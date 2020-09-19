import 'dart:ui';

class Note {
  Color color;
  int tone;
  bool isSuccess;

  Note(Color color, int tone) {
    this.color = color;
    this.tone = tone;
    isSuccess = false;
  }

  Color getColor() {
    return this.color;
  }

  int getTone() {
    return this.tone;
  }

  bool getSuccess() {
    return this.isSuccess;
  }

  void setSuccess() {
    this.isSuccess = true;
  }

  void setColor(Color color) {
    this.color = color;
  }

  void setTone(int tone) {
    this.tone = tone;
  }
}
