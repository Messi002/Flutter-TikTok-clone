import 'dart:io';

import 'package:ap2/Controller/uploadvideo_controller.dart';
import 'package:ap2/View/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

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
  bool isLoading = false;
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
                width: mediaQuery.width,
                height: mediaQuery.height / 1.5,
                child: VideoPlayer(controller)),
            const SizedBox(height: 30),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: mediaQuery.width - 20,
                    child: TextInputField(
                        controller: _songController,
                        labelText: 'Song name',
                        icon: Icons.music_note_rounded),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: mediaQuery.width - 20,
                    child: TextInputField(
                        controller: _captionController,
                        labelText: 'Caption',
                        icon: Icons.closed_caption_off_rounded),
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'uploading video...',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });

                            uploadVideoController.uploadVideo(
                                _songController.text.trim(),
                                _captionController.text.trim(),
                                widget.videoPath);
                           
                          },
                          child: const Text(
                            'Share!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
