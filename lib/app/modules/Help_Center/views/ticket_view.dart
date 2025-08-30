// ticket_view.dart
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/modules/Help_Center/controllers/my_ticket_controller.dart';
import 'package:farmitra/app/utils/global_widgets/vendor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TicketView extends GetView<MyTicketController> {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyTicketController controller = Get.put(MyTicketController());

    return Scaffold(
      appBar: VendorAppBar(title: 'My Ticket'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return  Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryGradinatMixColor,
            ),
          );
        }

        if (controller.grievanceTicketList.isEmpty) {
          return const Center(child: Text('No tickets found.'));
        }

        return ListView.builder(
          itemCount: controller.grievanceTicketList.length,
          itemBuilder: (context, index) {
            final ticket = controller.grievanceTicketList[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.lightGrey,
              ),
              child: ExpansionTile(
                iconColor: AppColors.primaryGradinatMixColor,
                collapsedIconColor: AppColors.primaryGradinatMixColor,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide.none,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ticket Id   :  ',
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "#${ticket.id}",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat(
                        'd MMMM yyyy, h:mm a',
                      ).format(ticket.createdAt.toLocal()),
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 5),
                    Text(
                      ticket.status.capitalize ?? '',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            ticket.status.capitalize == 'Pending'
                                ? AppColors.error
                                : AppColors.green,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  Divider(),
                  _infoRow("Category :", ticket.category.name),
                  const SizedBox(height: 8),
                  _infoRow(
                    "Mentioned issue :",
                    ticket.description.isNotEmpty
                        ? ticket.description
                        : "No concern entered.",
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    "Remark :",
                    ticket.adminRemark ?? "No admin remark provided.",
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
