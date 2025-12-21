import 'package:flutter/material.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/constant/imageasset.dart';

class Customcardusers extends StatefulWidget {
  final void Function()? onTap;
  final String name;
  final String email;
  final String id;
  final String number;

  const Customcardusers({
    super.key,
    required this.name,
    required this.email,
    required this.id,
    required this.number,
    this.onTap,
  });

  @override
  State<Customcardusers> createState() => _CustomcardusersState();
}

class _CustomcardusersState extends State<Customcardusers> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isHover
                ? AppColor.primaryColor.withOpacity(0.5)
                : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: isHover ? 18 : 8,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppImageAsset.personprofile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID
                      Text(
                        "ID • ${widget.id}",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Name
                      Text(
                        widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Email & Number
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.number,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action
                Icon(Icons.more_vert, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
