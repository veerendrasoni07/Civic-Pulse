import 'package:civic_pulse_frontend/controllers/complaint_controller.dart';
import 'package:civic_pulse_frontend/controllers/dept_head_controller.dart';
import 'package:civic_pulse_frontend/controllers/worker_controller.dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/models/worker.dart';
import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/depthead/views/complaint_report_widget.dart';
import 'package:civic_pulse_frontend/views/nav_screen/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DeptHeadHomeScreen extends ConsumerStatefulWidget {
  const DeptHeadHomeScreen({super.key});

  @override
  ConsumerState<DeptHeadHomeScreen> createState() => _DeptHeadHomeScreenState();
}

class _DeptHeadHomeScreenState extends ConsumerState<DeptHeadHomeScreen> {

  late Future<List<ComplaintReport>> futureAssignedReports;

  Future<void> fetchAssignedReports() async {
    final depthead = ref.read(userProvider);
    futureAssignedReports = DepartmentHeadController().getAssignedReports(depthead!.id);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAssignedReports();
  }

  @override
  Widget build(BuildContext context) {
    final depthead = ref.read(userProvider);
    return DefaultTabController(
        length: 4,
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
                      text: "All Issues",
                    ),
                    Tab(
                      text: "Assigned",
                    ),Tab(
                      text: "Escalated",
                    ),
                    Tab(
                      text: "Bad Feedback",
                    )
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
                                return ComplaintReportWidget(report: report);
                              },
                            );
                          }
                        },
                      ),


                      Center(child: Text("Bad Feedback"),),
                      Center(child: Text("Bad Feedback"),),
                    ]
                ),
              )

            ],
          ),
        )
    );
  }
}
