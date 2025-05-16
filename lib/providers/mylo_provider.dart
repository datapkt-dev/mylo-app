import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedItemProvider = StateProvider<int>((ref) => -1);
final rentProvider = StateProvider<int>((ref) => 0);