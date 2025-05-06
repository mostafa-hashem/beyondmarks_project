import 'package:beyondmarks/utils/cubit/settings/settings_cubit.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {

  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          title: settingsCubit.language == 'en'
              ? Text("About us", style: Theme.of(context).textTheme.bodyMedium)
              : Text("من نحن",
                  style: Theme.of(context).textTheme.bodyMedium,),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(
                child: Text.rich(TextSpan(children: [
                  if (settingsCubit.language == "en") TextSpan(
                          text: "powered by ",
                          style: Theme.of(context).textTheme.bodySmall,) else TextSpan(
                          text: "مشغل بواسطة ",
                          style: Theme.of(context).textTheme.bodySmall,),
                  if (settingsCubit.language == "en") TextSpan(
                          text: "SOLDIER",
                          style: Theme.of(context).textTheme.bodyMedium,) else TextSpan(
                          text: "SOLDIER",
                          style: Theme.of(context).textTheme.bodyMedium,),
                ],),),
              ),

            ],
          ),
        ),
    );
  }
}
