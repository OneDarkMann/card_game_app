import 'package:flutter/material.dart';
import 'package:flutter_rpg/model/vocation.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class VocationCard extends StatelessWidget {
  const VocationCard({
    required this.onTap,
    required this.vocation,
    required this.selected,
    super.key,
  });

  final bool selected;
  final void Function(Vocation) onTap;
  final Vocation vocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(vocation);
      },
      child: Card(
        color: selected ? AppColors.secondaryColor : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              //vocation image
              Image.asset(
                'assets/img/vocations/${vocation.image}',
                width: 80,
                colorBlendMode: BlendMode.color,
                color: !selected ? Colors.black.withOpacity(0.8) : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledHeadline(vocation.title),
                  StyledText(vocation.description)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
