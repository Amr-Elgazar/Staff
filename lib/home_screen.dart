import 'package:flutter/material.dart';
import 'package:suezcanal/add_screen.dart';
import 'package:suezcanal/widget/custom_button.dart';
import 'package:suezcanal/widget/text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:Icon(Icons.add),
            onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            );},),
          title: Text('قاعده البينات'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: CustomButton(
                  text: Text('تحميل'),
                  onPress: (){},
                  width: 150,
                  icon: Icon(Icons.download),

                ),
              ),
              CustomTextForm(
                  text: 'البحث',
                  icon: Icon(Icons.search),
                  textType: TextInputType.text
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(child: Image.asset('assets/Logo.png'),radius: 40,backgroundColor: Colors.white,),
                          Column(
                            children: [
                              Text('عمرو احمد محمد طاهر',style: TextStyle(fontSize: 20),),
                              Text('التخصص العام',style: TextStyle(color: Colors.grey),)
                            ],
                          ),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit),color: Colors.green,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.remove_circle,color: Colors.red,))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
