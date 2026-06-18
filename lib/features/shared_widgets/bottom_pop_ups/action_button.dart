// import 'package:flutter/material.dart';
// import 'package:go_sport/design_system/foundations/ds_spacing.dart';
// import 'package:go_sport/design_system/ds_extensions.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ActionButton extends StatelessWidget {
//   final String icon;
//   final String label;
//   final VoidCallback onTap;

//   const ActionButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(),
//       child: Row(
//         children: [
//           SvgPicture.asset(icon, width: 32, height: 32),
//           const SizedBox(width: DSSpacing.s10),
//           Text(
//             label,
//             style: context.subtitleMBold,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // No need for a lambda function here
      behavior: HitTestBehavior.opaque, // Makes the entire empty area tappable
      child: 
      // Container(
      //   width:
      //       double.infinity, // Forces the container to take all available width
        // padding: const EdgeInsets.symmetric(
        //   vertical: DSSpacing.s10,
        // ), // Optional: Adds vertical padding so the hit target isn't too thin
        // child: 
        Row(
          children: [
            SvgPicture.asset(icon, width: 32, height: 32),
            const SizedBox(width: DSSpacing.s10),
            Text(
              label,
              style: context.subtitleMBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      // ),
    );
  }
}
