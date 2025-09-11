import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/models/user.dart';
import 'package:civic_pulse_frontend/provider/commentProvider.dart';
import 'package:civic_pulse_frontend/views/Widgets/comment_section.dart';
import 'package:civic_pulse_frontend/views/Widgets/more_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MyReport extends ConsumerWidget {
  final ComplaintReport report;
  final User user;
  const MyReport({super.key,required this.report,required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(commentProvider);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: report.profilePic.isEmpty ? const AssetImage("Assets/images/user_image.png") : NetworkImage(report.profilePic),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(report.fullname,style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),),
                      Text(report.createdAt.toString().split(' ')[0],style: GoogleFonts.openSans(fontSize: 12,fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(padding: EdgeInsets.all(8),decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black,width: 1),),child: Text(report.status,style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  report.image,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_rounded,size: 26,),
                    const SizedBox(width: 10,),
                    Text(report.location,style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )
                        ),
                        child: Text(report.department,style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintReportDetailsScreen(report: report,)));
                        },
                        child: Row(
                          children: [
                            Text("More Details",style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios_rounded,size: 20,)
                          ],
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.thumb_up_alt_outlined)
                  ),
                  Text("Upvote"),
                  SizedBox(width: 5,),
                  Text("2"),
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          builder: (context) {
                            return CommentSection(reportId: report.id,fullname: user.fullname,profilePic: user.picture,userId: user.id,);
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.mode_comment_rounded),
                          SizedBox(width: 5,),
                          Text("Comment"),
                          SizedBox(width: 5,),
                          Text(comments.length.toString())
                        ],
                      )
                  ),
                ],
              )
            ],
          ),

        ],
      ),
    );
  }
}


