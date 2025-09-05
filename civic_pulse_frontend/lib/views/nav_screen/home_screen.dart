import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? clickedImage;

  Future<void> pickImageFromCamera()async{
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      setState(() {
        clickedImage = File(image.path);
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintForm(image: clickedImage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Civic Pulse",
          style: GoogleFonts.marcellus(
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Click The Picture Of Issue That You Want To Report!",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width *.95,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [
                      Colors.cyan.shade300,
                      Colors.cyan.shade700
                    ]
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("Assets/animations/camera_shutter.json"),
                  Expanded(child: SizedBox()),
                  ElevatedButton(
                      onPressed: ()async{
                        await pickImageFromCamera();
                      },
                      child: Text("Click Photo",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
  Widget reportForm(File? image){
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Form"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: MediaQuery.of(context).size.width *.5,
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.file(image!)),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){}, child: Text("Submit"))
        ],
      ),
    );
  }
}


class ComplaintForm extends StatefulWidget {
  final File? image;
  const ComplaintForm({super.key,required this.image});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();

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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Complaint submitted successfully!"),
                          ),
                        );
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

