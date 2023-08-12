import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoController {
  Uint8List? bytes;
}

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({
    required this.controller,
    this.readonly = false,
    super.key,
  });

  final ProfilePhotoController controller;
  final bool readonly;

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: widget.controller.bytes != null
              ? Image.memory(widget.controller.bytes!).image
              : null,
          child: widget.readonly
              ? null
              : IconButton(
                  icon: const Icon(FontAwesomeIcons.camera),
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      maxHeight: 150,
                      maxWidth: 150,
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      widget.controller.bytes = await image.readAsBytes();
                      setState(() {});
                    }
                  },
                ),
        ),
        if (!widget.readonly)
          Positioned(
            bottom: 0,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.x),
                  color: Colors.white,
                  iconSize: 15,
                  onPressed: () async {
                    widget.controller.bytes = null;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
