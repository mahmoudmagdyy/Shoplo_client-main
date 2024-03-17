import 'package:logger/logger.dart';

class LoggerUtils {
  final Logger _logger;
  static LoggerUtils? _instance;

  LoggerUtils._(this._logger);

  static LoggerUtils getInstance() {
    if (_instance == null) {
      Logger logger = Logger();
      _instance = LoggerUtils._(logger);
    }
    return _instance!;
  }

  ///view
  makeLoggerView(String print){
    _logger.v(print);
  }
  ///debug
  makeLoggerDebug(String print){
    _logger.d(print);
  }
  ///info message
  makeLoggerInfo(String print){
    _logger.i(print);
  }
  ///warning
  makeLoggerWarning(String print){
    _logger.w(print);
  }
  ///errror
  makeLoggerError(String print){
    _logger.e(print);
  }

  // locator<LoggerUtils>().makeLoggerDebug("here your message");
  // locator<LoggerUtils>().makeLoggerError("here your message");
  // locator<LoggerUtils>().makeLoggerInfo("here your message");
  // locator<LoggerUtils>().makeLoggerWarning("here your message");
  // locator<LoggerUtils>().makeLoggerView("here your message");
}