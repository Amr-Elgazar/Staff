import 'package:flutter/material.dart';
import 'package:suezcanal/widget/custom_button.dart';
import 'package:suezcanal/widget/text_form_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('اضافه'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children:[
                      CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/Logo.png'),
                    ),
                      CircleAvatar(
                        child: IconButton(onPressed: (){},icon: Icon(Icons.edit),),
                      )
                  ]),
                ),
              ),
              CustomTextForm(
                  text: 'الاسم',
                  icon: Icon(Icons.account_box_outlined,),
                  textType: TextInputType.name),
              CustomTextForm(
                  text: 'رقم الهاتف',
                  icon: Icon(Icons.phone,),
                  textType: TextInputType.phone),
              CustomTextForm(
                  text: 'التخصص العام',
                  icon: Icon(Icons.work,),
                  textType: TextInputType.text),
              CustomTextForm(
                  text: 'التخصص الدقيق',
                  icon: Icon(Icons.work,),
                  textType: TextInputType.text),
              CustomTextForm(
                  text: 'تاريخ درجه الماجستير',
                  icon: Icon(Icons.work,),
                  textType: TextInputType.text),
              CustomTextForm(
                  text: 'اسم الجامعه',
                  icon: Icon(Icons.school,),
                  textType: TextInputType.text),
              CustomTextForm(
                  text: 'تاريخ درجه الدكتوراه',
                  icon: Icon(Icons.work,),
                  textType: TextInputType.text),
              CustomTextForm(
                  text: 'اسم الجامعه',
                  icon: Icon(Icons.school,),
                  textType: TextInputType.text),
              CustomButton(
                  width: 150,
                  onPress: (){
                  },
                  icon: Icon(Icons.save),
                  text: Text('حفظ'))
            ],
          ),
        ),
      ),
    );
  }
}
