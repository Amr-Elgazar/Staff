import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suezcanal/Api/staff.dart';
import 'package:suezcanal/Model/model_staff.dart';
import 'package:suezcanal/widget/custom_button.dart';
import 'package:suezcanal/widget/text_form_field.dart';

class UpdateScreen extends StatefulWidget {
  Staff staff ;
  UpdateScreen({Key? key , required this.staff}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String? base64;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerGeneralSpecialty = TextEditingController();
  TextEditingController controllerSpecialization = TextEditingController();
  TextEditingController controllerMasterDHistory = TextEditingController();
  TextEditingController controllerPhDHistory = TextEditingController();
  TextEditingController controllerUniversityName = TextEditingController();

  @override
  void initState() {
    base64 = widget.staff.image;
    controllerName.text = widget.staff.name;
    controllerPhone.text = widget.staff.phone;
    controllerSpecialization.text = widget.staff.specialization;
    controllerGeneralSpecialty.text = widget.staff.generalSpecialty;
    controllerMasterDHistory.text = widget.staff.masterDHistory;
    controllerPhDHistory.text = widget.staff.phDHistory;
    controllerUniversityName.text = widget.staff.universityName;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اضافه'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: base64 == null || base64!.isEmpty
                          ? Image.asset('assets/Logo.png')
                          : Image.memory(base64Decode(base64!)),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () => chooseImage(),
                        icon: const Icon(Icons.edit),
                      ),
                    )
                  ]),
                ),
              ),
              CustomTextForm(
                text: 'الاسم',
                icon: const Icon(
                  Icons.account_box_outlined,
                ),
                textType: TextInputType.name,
                controller: controllerName,
              ),
              CustomTextForm(
                text: 'رقم الهاتف',
                icon: const Icon(
                  Icons.phone,
                ),
                textType: TextInputType.phone,
                controller: controllerPhone,
              ),
              CustomTextForm(
                text: 'التخصص العام',
                icon: const Icon(
                  Icons.work,
                ),
                textType: TextInputType.text,
                controller: controllerGeneralSpecialty,
              ),
              CustomTextForm(
                text: 'التخصص الدقيق',
                icon: const Icon(
                  Icons.work,
                ),
                textType: TextInputType.text,
                controller: controllerSpecialization,
              ),
              CustomTextForm(
                text: 'تاريخ درجه الماجستير',
                icon: const Icon(
                  Icons.work,
                ),
                textType: TextInputType.text,
                controller: controllerMasterDHistory,
              ),
              CustomTextForm(
                text: 'اسم الجامعه',
                icon: const Icon(
                  Icons.school,
                ),
                textType: TextInputType.text,
                controller: controllerUniversityName,
              ),
              CustomTextForm(
                text: 'تاريخ درجه الدكتوراه',
                icon: const Icon(
                  Icons.work,
                ),
                textType: TextInputType.text,
                controller: controllerPhDHistory,
              ),
              CustomButton(
                  width: 150,
                  onPress: () => validate(context),
                  icon: const Icon(Icons.save),
                  text: const Text('حفظ'))
            ],
          ),
        ),
      ),
    );
  }

  void chooseImage() async {
    PickedFile? pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      try {
        setState(() {
          File file = File(pickedFile!.path);
          base64 = base64Encode(file.readAsBytesSync()).toString();
        });
      } catch (e) {
        print(e);
      }
    });
  }

  bool validate(BuildContext context2) {
    if (controllerName.text.isEmpty &&
        controllerPhone.text.isEmpty &&
        base64 == null &&
        controllerGeneralSpecialty.text.isEmpty &&
        controllerSpecialization.text.isEmpty &&
        controllerMasterDHistory.text.isEmpty &&
        controllerPhDHistory.text.isEmpty &&
        controllerUniversityName.text.isEmpty) {
      _showErrorDialog('جميع الحقول و الصورة فارغة من فلك قم بملئ البيانات',
          "خطأ في عملية الإضافة");
      return false;
    } else if (controllerName.text.isEmpty ||
        controllerPhone.text.isEmpty ||
        base64 == null ||
        controllerGeneralSpecialty.text.isEmpty ||
        controllerSpecialization.text.isEmpty ||
        controllerMasterDHistory.text.isEmpty ||
        controllerPhDHistory.text.isEmpty ||
        controllerUniversityName.text.isEmpty) {
      _showErrorDialog('عذرا تأكد من إدخالك جميع البيانات',
          "خطأ في عملية الإضافة");
      return false;
    } else {
      if(controllerPhone.text == widget.staff.phone){
        Staff2 _staff = Staff2(
            name: controllerName.text,
            phone: controllerPhone.text,
            image: base64 ?? '',
            generalSpecialty: controllerGeneralSpecialty.text,
            specialization: controllerSpecialization.text,
            masterDHistory: controllerMasterDHistory.text,
            phDHistory: controllerPhDHistory.text,
            universityName: controllerUniversityName.text);
        StaffData().updateStaff(staff: _staff).then((value) {
          print(value);
          if (value == 'phone exist') {
            print(value);
            _showErrorDialog(
                'هذا الهاتف موجود من قبل', 'فشلت عملية التعديل');
          } else if (value == 'user update successfully') {
            _showSuccessDialog();

          } else {}
        });
      }else{
        Staff2 _staff = Staff2(
            name: controllerName.text,
            phone: controllerPhone.text,
            image: base64 ?? '',
            generalSpecialty: controllerGeneralSpecialty.text,
            specialization: controllerSpecialization.text,
            masterDHistory: controllerMasterDHistory.text,
            phDHistory: controllerPhDHistory.text,
            universityName: controllerUniversityName.text);
        StaffData().updateStaffNewPhone(staff: _staff).then((value) {
          print(value);
          if (value == 'phone exist') {
            print(value);
            _showErrorDialog(
                'هذا الهاتف موجود من قبل', 'فشلت عملية التعديل');
          } else if (value == 'user update successfully') {
            _showSuccessDialog();

          } else {}
        });
      }

      return true;
    }
  }

  void _showSuccessDialog() {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: false,
        title: 'عملية تعديل ناجحة',
        desc: 'تم التعديل بنجاح',
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {

        })
        .show();
  }

  void _showErrorDialog(String message, String title) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: title,
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
        .show();
  }
}
