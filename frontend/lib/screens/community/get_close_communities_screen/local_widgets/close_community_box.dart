import 'package:flutter/material.dart';
import 'package:frontend/widgets/primary_button.dart';

class CommunityCard extends StatelessWidget {
  final String name;
  final String description;
  final int membersCount;
  final VoidCallback onJoinPressed;
  final VoidCallback onTap;

  const CommunityCard({
    super.key,
    required this.name,
    required this.description,
    required this.membersCount,
    required this.onJoinPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Color.fromARGB(20, 0, 0, 0)),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: const Color(0xFF5988FF),
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                maxLines: 2, 
                overflow: TextOverflow.ellipsis, 
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$membersCount Miembros',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                  ),
                  PrimaryButton(
                    label: 'Solicitar Unirse',
                    onPressed: onJoinPressed,
                    height: 36,
                    width: 140,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
