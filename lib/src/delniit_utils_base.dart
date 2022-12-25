import 'dart:collection';
import 'dart:math';

final RegExp DELNIIT_SPLIT_STRING = RegExp(r".[\u0300\u0301]?");

final LinkedHashMap<String, String> DELNIIT_UPPER_TO_LOWER = LinkedHashMap<String, String>.fromEntries([
  MapEntry<String, String>('Λ', 'a'),
  MapEntry<String, String>('Λ́', 'á'),
  MapEntry<String, String>('̀Λ', 'à'),
  MapEntry<String, String>('B', 'ƃ'),
  MapEntry<String, String>('C', 'c'),
  MapEntry<String, String>('Ç', 'ç'),
  MapEntry<String, String>('Δ', 'ᴧ'),
  MapEntry<String, String>('Σ', 'e'),
  MapEntry<String, String>('Σ́', 'é'),
  MapEntry<String, String>('F', 'ſ'),
  MapEntry<String, String>('Ԍ', 'ʒ'),
  MapEntry<String, String>('H', 'н'),
  MapEntry<String, String>('I', 'ı'),
  MapEntry<String, String>('Í', 'í'),
  MapEntry<String, String>('Ì', 'ì'),
  MapEntry<String, String>('Î', 'î'),
  MapEntry<String, String>('Э', 'э'),
  MapEntry<String, String>('L', 'ʟ'),
  MapEntry<String, String>('M', 'м'),
  MapEntry<String, String>('N', 'ɴ'),
  MapEntry<String, String>('O', 'o'),
  MapEntry<String, String>('Ψ', 'ч'),
  MapEntry<String, String>('Ж', 'ж'),
  MapEntry<String, String>('Ӂ', 'ӂ'),
  MapEntry<String, String>('R', 'г'),
  MapEntry<String, String>('S', 's'),
  MapEntry<String, String>('X', 'x'),
  MapEntry<String, String>('T', 'т'),
  MapEntry<String, String>('Ѳ', 'ѳ'),
  MapEntry<String, String>('П', 'п'),
  MapEntry<String, String>('Ф', 'ɸ'),
  MapEntry<String, String>('V', 'v'),
  MapEntry<String, String>('W', 'w'),
  MapEntry<String, String>('☐', 'ㇿ'),
  MapEntry<String, String>('Y', 'y'),
  MapEntry<String, String>('Z', 'z')
]);
final Map<String, String> DELNIIT_LOWER_TO_UPPER = DELNIIT_UPPER_TO_LOWER.map((k, v) => MapEntry(v, k));

List<String> _convert_to_list(LinkedHashMap<String, String> map) {
  List<String> list = [];
  for (var key in map.keys) {
    list.add(map[key]!);
    list.add(key);
  }
  return list;
}

final List<String> DELNIIT_SORT_ORDER = _convert_to_list(DELNIIT_UPPER_TO_LOWER);

const Map<String, String> DELNIIT_ACCENT_REMOVAL = {
  'Λ́': 'Λ',
  '̀Λ': 'Λ',
  'á': 'a',
  'à': 'a',
  'Ç': 'C',
  'ç': 'c',
  'Σ́': 'Σ',
  'é': 'e',
  'Í': 'I',
  'Ì': 'I',
  'Î': 'I',
  'í': 'ı',
  'ì': 'ı',
  'î': 'ı',
  'Ӂ': 'ж',
  'ӂ': 'ж',
};

String delniit_lower(String string) {
  return delniit_split(string).map((char) => DELNIIT_UPPER_TO_LOWER[char] ?? char).join('');
}

String delniit_upper(String string) {
  return delniit_split(string).map((char) => DELNIIT_LOWER_TO_UPPER[char] ?? char).join('');
}

String delniit_remove_accents(String string) {
  return delniit_split(string).map((char) => DELNIIT_ACCENT_REMOVAL[char] ?? char).join('');
}

List<String> delniit_split(String string) {
  return DELNIIT_SPLIT_STRING.allMatches(string).map((e) => e[0]!).toList();
}

int delniit_compare(String a, String b) {
  List<String> a1 = delniit_split(a);
  List<String> b1 = delniit_split(b);
  for (int i = 0; i < max(a1.length, b1.length); i++) {
    if (i >= a1.length)
      return ''.compareTo(b1.sublist(i).join(''));
    else if (i >= b1.length) return a1.sublist(i).join('').compareTo('');
    int letter_compare = DELNIIT_SORT_ORDER.indexOf(a1[i]).compareTo(DELNIIT_SORT_ORDER.indexOf(b1[i]));
    if (letter_compare != 0) return letter_compare;
  }
  return 0;
}
