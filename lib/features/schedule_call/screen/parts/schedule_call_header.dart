import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/widgets/professional_header/professional_header.dart';

class ScheduleCallHeader extends StatelessWidget {
  const ScheduleCallHeader({super.key, required this.professional});

  final Professional professional;

  @override
  Widget build(BuildContext context) {
    return ProfessionalHeader(professional: professional);
  }
}
