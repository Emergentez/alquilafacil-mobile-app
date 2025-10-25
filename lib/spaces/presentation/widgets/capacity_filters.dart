import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../public/ui/theme/main_theme.dart';
import '../providers/space_provider.dart';

class CapacityFilters extends StatefulWidget {
  final String range;
  const CapacityFilters({super.key, required this.range});

  @override
  State<CapacityFilters> createState() => _CapacityFiltersState();
}

class _CapacityFiltersState extends State<CapacityFilters> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final spaceProvider = context.watch<SpaceProvider>();
    return Row(
        children:[
          Checkbox(
            side:  BorderSide(color: MainTheme.contrast(context)),
            shape: const CircleBorder(),
            value: isChecked,
            checkColor: Colors.white,
            activeColor: MainTheme.primary(context),
            onChanged: (bool? newValue) {
              setState(() {
                isChecked = newValue ?? false;
                spaceProvider.capacityRangesSelected.add(widget.range);
              });
            },
          ),
          Text(
            widget.range,
            style: TextStyle(
                color: MainTheme.contrast(context)
            ),
          )
        ]
    );
  }
}
