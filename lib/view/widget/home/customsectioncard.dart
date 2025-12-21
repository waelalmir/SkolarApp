import 'package:flutter/material.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/functions/responsive.dart';

class CustomSectionCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final void Function()? onTap;

  const CustomSectionCard({
    super.key,
    this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          hoverColor: AppColor.primaryColor.withValues(alpha: 0.05),
          splashColor: AppColor.primaryColor.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryColor.withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    icon,
                    size: r.icon(28),
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: r.font(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
