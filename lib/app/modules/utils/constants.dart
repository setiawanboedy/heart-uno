class Constants {
  Constants._();

  /// time to calculate BPM every 6 seconds
  static const timer = 6;

  /// threshold for get every peak ecg data
  static const threshold = 210;

  /// lenght of serial data in list
  static const lenghtData = 100;

  /// serial port to listen data from arduino
  static const port = 115200;
}
