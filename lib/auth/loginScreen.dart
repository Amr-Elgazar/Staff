import 'package:flutter/material.dart';
import 'package:suezcanal/home_screen.dart';
import 'package:suezcanal/widget/custom_button.dart';
import 'package:suezcanal/widget/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextForm(
                 textType: TextInputType.number,
                  text: 'كلمه السر ؟',
                  icon: Icon(Icons.lock,)),
              CustomButton(
                  width: 150,
                  onPress: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  },
                  icon: Icon(Icons.login),
                  text: Text('تسجيل الدخول'))

            ],
          ),
        ),
      ),
    );
  }
}
