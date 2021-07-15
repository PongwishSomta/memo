
import 'package:flutter/material.dart';
import 'package:memo/models/chipmodel.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'ออกกำลังกาย',
      isSelected: false,
      selectedColor: Colors.red[300],
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'กิจวัตร',
      isSelected: false,
      selectedColor: Colors.yellow[300],
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'งานอดิเรก',
      isSelected: false,
      selectedColor: Colors.green[300],
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'อื่นๆ',
      isSelected: false,
      selectedColor: Colors.orange[300],
      textColor: Colors.white,
    ),
  ];

  static List<ChoiceChipData> selecedColor;
}