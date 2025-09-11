import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintReportDetailsScreen extends StatelessWidget {
  final ComplaintReport report;

  const ComplaintReportDetailsScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Details", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Reporter Info
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: report.profilePic.isEmpty
                      ? const AssetImage("Assets/images/user_image.png")
                      : NetworkImage(report.profilePic) as ImageProvider,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.fullname, style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Reported on: ${report.createdAt.toString().split(' ')[0]}", style: GoogleFonts.openSans(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Complaint Image
            if (report.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(report.image, height: 200, width: double.infinity, fit: BoxFit.cover),
              ),

            const SizedBox(height: 20),

            /// Status + Department
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoChip("Status: ${report.status}", Colors.orange),
                _infoChip(report.department, Colors.blueGrey),
              ],
            ),

            const SizedBox(height: 20),

            /// Location
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(report.location,
                      style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Description
            Text("Description", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(report.desc ?? "No description provided",
                style: GoogleFonts.lato(fontSize: 14)),


            const SizedBox(height: 20),

            Text("Assigned Workers", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.cyan),
                  title: Text(report.assignedHead['headName']),
                ),
              ]
            ),


            const SizedBox(height: 20),

            /// Assigned Workers
            Text("Assigned Workers", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            report.assignedTo != null && report.assignedTo.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: report.assignedTo.map((worker) {
                return ListTile(
                  leading: const Icon(Icons.person, color: Colors.cyan),
                  title: Text(worker["workerName"]),
                  subtitle: Text("Worker ID: ${worker["workerId"]}"),
                );
              }).toList(),
            )
                : Text("No workers assigned", style: GoogleFonts.lato(fontSize: 14, color: Colors.grey)),

            const SizedBox(height: 20),

            /// Comments Section Placeholder
            Text("Comments", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            report.comments.isNotEmpty ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: report.comments.map((comment) {
                return ListTile(
                  leading: comment.profilePic.isEmpty ? Icon(Icons.person, color: Colors.cyan) : Image.network(comment.profilePic) ,
                  title: Text(comment.text),
                  subtitle: Text(comment.createdAt.toString()),
                );
              }).toList()
            ) : Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    ),
              child: Text("No Comments In This Post"),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Helper Widget for Status / Department Chips
  Widget _infoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: GoogleFonts.openSans(fontWeight: FontWeight.bold, color: color)),
    );
  }
}
