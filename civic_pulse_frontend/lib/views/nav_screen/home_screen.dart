import 'dart:convert';
import 'dart:io';

import 'package:civic_pulse_frontend/controllers/complaint_controller.dart';
import 'package:civic_pulse_frontend/models/complaint_report.dart';
import 'package:civic_pulse_frontend/provider/userprovider.dart';
import 'package:civic_pulse_frontend/views/nav_screen/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  File? clickedImage;
  bool isExpand =false ;

  late Future<List<ComplaintReport>> futureMyReports;
  late Future<List<ComplaintReport>> futureNearByReports;

  Future<void> fetchNearByReports() async {
    final user = ref.read(userProvider);
    futureNearByReports = ComplaintController().issuesInMyArea(userId: user!.id,address: 'Patan Road, Karmeta, Jabalpur, 482002, India');
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    futureMyReports = ComplaintController().myReports(userId: user!.id);
    fetchNearByReports();
  }

  Future<void> pickImageFromCamera() async {
    final user = ref.read(userProvider);
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        clickedImage = File(image.path);
      });
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ComplaintForm(image: clickedImage,phone: user!.phone,fullname: user.fullname,userId: user.id,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    print(user!.address);
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
                            Text("Welcome! ${user!.fullname.split(' ')[0]}",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,),
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
                                overflow: isExpand ? TextOverflow.visible : TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  isExpand = !isExpand;
                                });
                              },
                              icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,))
                        ],
                      ),
                      if (isExpand) const SizedBox(height: 20),
                    ],
                  ),
                ),

              ],
            ),
            TabBar(
                tabs: [
                  Tab(text: "Issues In My Area",),
                  Tab(text: 'My Reports',)
                ]
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<ComplaintReport>>(
                    future: futureNearByReports,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Data'));
                      } else {
                        final nearByReports = snapshot.data!;
                        return ListView.builder(
                          itemCount: nearByReports.length,
                          itemBuilder: (context, index) {
                            final nearByReport = nearByReports[index];
                            return MyReport(report: nearByReport,user: user,);
                          },
                        );
                      }
                    },
                  ),
                  FutureBuilder<List<ComplaintReport>>(
                    future: futureMyReports,
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
                            return MyReport(report: report,user: user,);
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.teal,
          icon: Icon(Icons.camera_alt_outlined,color: Colors.black,),
          label: Text("Post An Issue",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
          onPressed: () async {
            await pickImageFromCamera();
          },

        )
      ),
    );
  }
}


class ComplaintForm extends StatefulWidget {
  final File? image;
  final String fullname;
  final String phone;
  final String userId;

  const ComplaintForm({super.key,required this.image,required this.fullname,required this.phone,required this.userId});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final ComplaintController complaintController = ComplaintController();
  // Controllers
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Dropdown value
  String? _selectedComplaintType;
  final List<String> complaintTypes = [
    "Sewage",
    "Garbage",
    "Road Damage",
    "Street Light",
    "Water Supply",
    "Other"
  ];

  Future<Position> getCurrentPosition()async{
    bool isServiceEnabled;
    LocationPermission permission;
    // checking if location services are enabled or not
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnabled){
      throw Exception('Location services are disabled');
    }

    // check for permissions
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception('Location permissions are denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      throw Exception('Location permissions are permanently denied');
    }

    // get current position
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best
      )
    );

  }

  Future<String> getAddressFromLatLng(double lat,double lng)async{
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      print(placemarks);
      if(placemarks.isNotEmpty){
        Placemark place = placemarks[0];
        String address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        return address;
      }
      else{
        throw Exception('No address found');
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Complaint"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width *.5,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.file(widget.image!,width:MediaQuery.of(context).size.width *.5 ,fit: BoxFit.fill,)),
                  ),
                ),
                // Complaint Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Complaint Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: _selectedComplaintType,
                  items: complaintTypes
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedComplaintType = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? "Please select complaint type" : null,
                ),
                const SizedBox(height: 16),

                // Location TextField
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: "Location",
                    hintText: "Enter complaint location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter location" : null,
                ),
                TextButton(
                    onPressed: ()async{
                      Position pos = await getCurrentPosition();
                      String address = await getAddressFromLatLng(pos.latitude, pos.longitude);
                      _locationController.text = address;
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on_rounded,color: Colors.blueAccent,),
                        Text("Use Your Current Location",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blueAccent),)
                      ],
                    )
                ),
                const SizedBox(height: 16),

                // Description TextField
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Describe the issue in detail",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter description"
                      : null,
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: ()async {
                      if (_formKey.currentState!.validate()) {
                        // Handle submission
                        await complaintController.sendComplaintReport(image: widget.image!, fullname: widget.fullname, location: _locationController.text, desc: _descriptionController.text, phone: widget.phone,userId:widget.userId ,department: _selectedComplaintType!, context: context);
                      }
                    },
                    child: const Text(
                      "Submit Complaint",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

