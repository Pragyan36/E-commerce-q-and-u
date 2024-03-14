import 'package:flutter/material.dart';
import 'package:q_and_u_furniture/app/constants/constants.dart';

class CustomSectionHeader extends StatelessWidget {
  final String headerName;
  final void Function()? onViewAllTapped;
  final bool shouldViewAll;

  const CustomSectionHeader({
    super.key,
    required this.headerName,
    required this.onViewAllTapped,
    required this.shouldViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor:
                        AppColor.kalaAppSecondaryColor.withOpacity(0.5),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor:
                        AppColor.kalaAppSecondaryColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            headerName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          const Expanded(
            child: Divider(),
          ),
          const SizedBox(
            width: 6,
          ),
          shouldViewAll
              ? ElevatedButton(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        side: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                  onPressed: onViewAllTapped,
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: AppColor.kalaAppMainColor,
                    ),
                  ),
                )
              : ElevatedButton(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        side: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "",
                  ),
                ),
        ],
      ),
    );
  }
}
