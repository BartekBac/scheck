import 'dart:math';

extension RandomListItem<T> on List<T> {
  T randomElement() => this[Random().nextInt(length)];
}