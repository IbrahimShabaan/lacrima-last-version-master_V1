import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:min_id/min_id.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:lacrima/shared/components/widgets.dart';
import 'package:lacrima/shared/constants/constants.dart';
import 'package:lacrima/admin/business_logic/admin_cubit.dart';
import 'package:lacrima/admin/business_logic/admin_states.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';

class NEWS_AND_EVENTS_Screen extends StatelessWidget {
  NEWS_AND_EVENTS_Screen({Key? key}) : super(key: key);

  var dataList = [
    {
      "id": "2",
      "title": "file Video 1",
      "url": "https://download.samplelib.com/mp4/sa..."
    },
    {
      "id": "3",
      "title": "file Video 2",
      "url": "https://download.samplelib.com/mp4/sa..."
    },
    {
      "id": "4",
      "title": "file Video 3",
      "url": "https://download.samplelib.com/mp4/sa..."
    },
    {
      "id": "5",
      "title": "file Video 4",
      "url": "https://download.samplelib.com/mp4/sa..."
    },
    {
      "id": "6",
      "title": "file PDF 6",
      "url":
      "https://www.iso.org/files/live/sites/..."
    },
    {
      "id": "10",
      "title": "file PDF 7",
      "url": "https://www.tutorialspoint.com/javasc..."
    },
    {
      "id": "10",
      "title": "C++ Tutorial",
      "url": "https://www.tutorialspoint.com/cplusp..."
    },
    {
      "id": "11",
      "title": "file PDF 9",
      "url":
      "https://www.iso.org/files/live/sites/..."
    },
    {
      "id": "12",
      "title": "file PDF 10",
      "url": "https://www.tutorialspoint.com/java/j..."
    },
    {
      "id": "13",
      "title": "file PDF 12",
      "url": "https://www.irs.gov/pub/irs-pdf/p463.pdf"
    },
    {
      "id": "14",
      "title": "file PDF 11",
      "url": "https://www.tutorialspoint.com/css/cs..."
    },
  ];

  final formKey = GlobalKey<FormState>();
  final descController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is InsertAnnouncementSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppItems.customText(
                'Successfully',
                fontSize: 12.sp,
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('New Events / News'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
              onPressed: () {
                Navigator.pop(context);
                cubit.changeCloseImage();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.sp),
                    AppItems.customAppLogo(),
                    SizedBox(height: 30.sp),
                    AppItems.customTextField(
                      hintText: 'Title',
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.sp),
                    AppItems.customTextField(
                      hintText: 'Description',
                      controller: descController,
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),

                    if (cubit.announcementImage != null)
                      SizedBox(height: 15.sp),
                    if (cubit.announcementImage != null)
                      Stack(
                        children: [
                          Image.file(cubit.announcementImage!),
                          Positioned(
                            right: 1,
                            child: IconButton(
                              icon:
                              const Icon(Icons.close, color: Colors.black),
                              onPressed: () => cubit.changeCloseImage(),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 10.sp),
                    if (cubit.announcementImage == null)
                      SizedBox(height: 15.sp),
                    if (cubit.announcementImage == null)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: AppItems.customText('Select Image'),
                        style: TextButton.styleFrom(
                          backgroundColor: ConstColors.kPrimaryColor,
                        ),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            contentPadding: EdgeInsets.all(2.sp),
                            content: SizedBox(
                              height: 80.sp,
                              width: 60.sp,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton.icon(
                                      label: Text('Gallery',
                                          style: TextStyle(fontSize: 16.sp)),
                                      icon: const Icon(Icons.camera),
                                      style: TextButton.styleFrom(
                                        foregroundColor: ConstColors.kPrimaryColor,
                                      ),
                                      onPressed: () {
                                        cubit.pickedImageAnnouncement(
                                            ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton.icon(
                                      label: Text('Camera',
                                          style: TextStyle(fontSize: 16.sp)),
                                      icon: const Icon(Icons.camera_alt),
                                      style: TextButton.styleFrom(
                                          foregroundColor: ConstColors.kPrimaryColor),
                                      onPressed: () {
                                        cubit.pickedImageAnnouncement(
                                            ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    SizedBox(height: 40.sp),
                    BuildCondition(
                      condition: state is! InsertAnnouncementLoadingState,
                      fallback: (context) => AppItems.customIndicator(),
                      builder: (context) => AppButtons.customElevatedButton(
                        text: 'Submit',
                        fontSize: 14.sp,
                        color: ConstColors.kPrimaryColor,
                        onPressed: () async {
                          final id = MinId.getId();
                          if (formKey.currentState!.validate()) {
                            if (cubit.announcementImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AppItems.customText(
                                    'must be upload image',
                                    fontSize: 12.sp,
                                  ),
                                ),
                              );
                            } else {
                              await cubit.insertAnnouncement(
                                id: id,
                                title: titleController.text,
                                description: descController.text,
                                dateTime: DateFormat.yMMMd().format(
                                  DateTime.now(),
                                ),
                              );
                              cubit.changeCloseImage();
                              await NotificationServices
                                  .sendNotificationToTopic(
                                topic: ConstText.announcements,
                                title: titleController.text,
                                body: descController.text,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}