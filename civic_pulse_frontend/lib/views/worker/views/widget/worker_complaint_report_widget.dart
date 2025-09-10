import 'package:civic_pulse_frontend/controllers/dept_head_controller.dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:civic_pulse_frontend/provider/commentProvider.dart';
import 'package:civic_pulse_frontend/provider/deptheadprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerComplaintReportWidget extends ConsumerStatefulWidget{
  final ComplaintReport report;
  const WorkerComplaintReportWidget({super.key,required this.report});

  @override
  ConsumerState<WorkerComplaintReportWidget> createState() => _WorkerComplaintReportWidgetState();
}

class _WorkerComplaintReportWidgetState extends ConsumerState<WorkerComplaintReportWidget> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> assignWorkers({required List<Map<String,dynamic>> workers})async{
    final DepartmentHeadController controller = DepartmentHeadController();
    await controller.assignReportToWorker(workers: workers, reportId: widget.report.id, context: context);
  }


  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: widget.report.profilePic.isEmpty ? const AssetImage("Assets/images/user_image.png") : NetworkImage(widget.report.profilePic),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.report.fullname,style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),),
                      Text(widget.report.createdAt.toString().split(' ')[0],style: GoogleFonts.openSans(fontSize: 12,fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(padding: EdgeInsets.all(8),decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black,width: 1),),child: Text(widget.report.status,style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.bold),)),
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
                  widget.report.image,
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
                    Text(widget.report.location,style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),
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
                        child: Text(widget.report.department,style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    TextButton(
                        onPressed: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ReportDetails(report: report,)));
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
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


