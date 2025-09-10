import 'package:civic_pulse_frontend/controllers/complaint_controller.dart';
import 'package:civic_pulse_frontend/controllers/dept_head_controller.dart';
import 'package:civic_pulse_frontend/controllers/worker_controller.dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:civic_pulse_frontend/provider/deptheadprovider.dart';
import 'package:civic_pulse_frontend/provider/workerprovider.dart';
import 'package:civic_pulse_frontend/views/depthead/views/complaint_report_widget.dart';
import 'package:civic_pulse_frontend/views/nav_screen/reports_screen.dart';
import 'package:civic_pulse_frontend/views/worker/views/widget/worker_complaint_report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerHomeScreen extends ConsumerStatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  ConsumerState<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends ConsumerState<WorkerHomeScreen> {


  late Future<List<ComplaintReport>> futureAssignedReports;

  Future<void> fetchComplaintReports()async{
    final worker = ref.read(workerProvider);
    futureAssignedReports = WorkerController().getAssignedReports(worker!.id);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchComplaintReports();
  }

  @override
  Widget build(BuildContext context) {
    final depthead = ref.read(workerProvider);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Welcome! ${depthead!.fullname.split(' ')[0]}",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,),
                              IconButton(onPressed: (){}, icon: Icon(Icons.circle_notifications,color: Colors.black,size: 35,))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  "Patan Road, Karmeta, Jabalpur, 482002, India",
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                  });
                                },
                                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,))
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              TabBar(
                  tabs: [
                    Tab(
                      text: "Your Pending Tasks",
                    ),Tab(
                      text: "Completed Tasks",
                    ),
                  ]
              ),

              Expanded(
                child: TabBarView(
                    children: [
                      FutureBuilder<List<ComplaintReport>>(
                        future: futureAssignedReports ,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text(snapshot.error.toString()));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No Data'));
                          } else {
                            final reports = snapshot.data!;
                            return ListView.builder(
                              itemCount: reports.length,
                              itemBuilder: (context, index) {
                                final report = reports[index];
                                return WorkerComplaintReportWidget(report: report);
                              },
                            );
                          }
                        },
                      ),
                      Center(child: Text("Completed Tasks")),
                    ]
                ),
              )

            ],
          ),
        )
    );
  }
}
