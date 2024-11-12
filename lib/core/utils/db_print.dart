import 'dart:developer';

import 'package:flutter/foundation.dart';

void dbPrint(Object? message) {
  if (!kDebugMode) return;
  log(message.toString());
}
