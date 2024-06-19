import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/components/text_input_feilds.dart';
import 'package:video_player/video_player.dart';
import '../controllers/upload_video_controller.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final UploadVideoController _uploadVideoController =
      Get.put(UploadVideoController());

  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {
          controller.play();
          controller.setVolume(1);
          controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    _songController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _uploadVideo() async {
    setState(() {
      isUploading = true;
    });
    await _uploadVideoController.uploadVideo(
        _songController.text, _captionController.text, widget.videoPath);
    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.yellow),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: controller.value.isInitialized
                  ? VideoPlayer(controller)
                  : Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _songController,
                      labelText: "Title",
                      icon: Icons.title,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _captionController,
                      labelText: "Description",
                      icon: Icons.closed_caption,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isUploading ? null : _uploadVideo,
                    child: isUploading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Share',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
