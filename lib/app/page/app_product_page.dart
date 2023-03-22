// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jarnama02/components/custom.dart';
import 'package:jarnama02/models/models.dart';
import 'package:jarnama02/services/loading_service.dart';
import 'package:jarnama02/services/storage_service.dart';
import 'package:jarnama02/services/store_service.dart';

import '../../services/date_time_service.dart';

class AppProductPage extends StatelessWidget {
  const AppProductPage({Key? key}) : super(key: key);

  get images => null;

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final desc = TextEditingController();
    final adress = TextEditingController();
    final userName = TextEditingController();
    final phoneNumber = TextEditingController();
    final price = TextEditingController();
    final dateTime = TextEditingController();
    List<XFile> images = [];

    return Scaffold(
        appBar: AppBar(
          title: const Text('AppProductPage'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CustomTextFild(
              controller: title,
              hintText: 'Title',
            ),
            const SizedBox(
              height: 12,
            ),
            ImageContainer(
              images: images,
              onPicked: (value) => value,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFild(
              controller: desc,
              hintText: 'Descriptoin',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFild(
              controller: userName,
              hintText: 'User Name',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFild(
              controller: adress,
              hintText: 'Adress',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFild(
              controller: phoneNumber,
              hintText: 'Phone Number',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFild(
              controller: price,
              hintText: 'Prices',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFild(
                controller: dateTime,
                hintText: 'DateTime',
                focusNode: FocusNode(),
                onTap: () async {
                  await DateTimeService.showDateTimePicker(
                    context,
                    (value) =>
                        dateTime.text = DateFormat("d MMM,y").format(value),
                    // (value) => dateTime.text = value.toString(),
                  );
                }),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                LoadingService().showloading(context);
                final urls = await StorageService().uploadImage(images);

                final product = Product(
                    images: urls,
                    title: title.text,
                    description: desc.text,
                    phoneNumber: phoneNumber.text,
                    dateTime: dateTime.text,
                    adress: adress.text,
                    userName: userName.text,
                    price: price.text);
                await StoreService().saveProduct(product);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.publish),
              label: const Text('Add to FireStore'),
            ),
          ],
        ));
  }
}

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    Key? key,
    required this.onPicked,
    required images,
  }) : super(key: key);

  final void Function(List<XFile>)? onPicked;

  get images => null;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  final service = ImagePickerService();
  List<XFile> images = [];

  void _updateImagesList(List<XFile> newImages) {
    setState(() {
      images = newImages;
    });
    widget.onPicked?.call(images);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: images.isNotEmpty
          ? SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ImageCard(
                    file: images[index],
                    delete: (xfile) {
                      widget.images.remove(xfile);
                      setState(() {});
                    },
                  );
                },
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: IconButton(
                  onPressed: () async {
                    final value = await service.pickImages();
                    if (value != null) {
                      _updateImagesList(value);
                    }
                  },
                  icon: const Icon(
                    Icons.camera_enhance,
                    size: 30,
                  ),
                ),
              ),
            ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.file,
    required this.delete,
  }) : super(key: key);

  final XFile file;
  final void Function(XFile) delete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
      children: [
        Image.file(
          File(file.path),
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: () => delete(file),
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ],
    ));
  }
}

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> pickImages() async {
    final images = await _picker.pickMultiImage();
    return images;
  }
}
