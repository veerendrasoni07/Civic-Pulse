import 'package:civic_pulse_frontend/controllers/complaint_controller.dart';
import 'package:civic_pulse_frontend/provider/commentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentSection extends ConsumerStatefulWidget {
  final String reportId;
  final String userId;
  final String profilePic;
  final String fullname;

  const CommentSection({super.key, required this.reportId, required this.userId, required this.profilePic, required this.fullname});

  @override
  ConsumerState<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends ConsumerState<CommentSection> {
  final TextEditingController _commentController = TextEditingController();

  bool isLoading = false;

  final ComplaintController complaintController = ComplaintController();
  Future<void> addComment()async{
    final comment = _commentController.text.trim();
    if(comment.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      await complaintController.addComment(reportId: widget.reportId, userId: widget.userId, text: comment, profilePic: widget.profilePic, fullname: widget.fullname, ref: ref, context: context);
      setState(() {
        isLoading = false;
        _commentController.clear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(commentProvider.notifier).getComments(widget.reportId);
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          comments.isEmpty ? const Center(child: Text("No Comments Yet, Be The First One")) :
          ListView.builder(
              itemCount: comments.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: comment.profilePic.isEmpty
                        ? const AssetImage("Assets/images/user_image.png")
                        : NetworkImage(comment.profilePic) as ImageProvider,
                    radius: 20,
                  ),

                  title: Text(comment.fullname),
                  subtitle: Text(comment.text),
                  trailing: Text(comment.createdAt.toString().split(' ')[0]),
                );
              }
          ),
          if(isLoading)
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircularProgressIndicator()
                  ],
                )
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7
                      ),
                      cursorColor: Theme.of(context).colorScheme.onSurface,
                      decoration: InputDecoration(
                        hintText: "Add Comment...",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600
                        ),
                        fillColor:Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                        filled: true,
                        enabled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: isLoading ? null : addComment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).colorScheme.surface,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
