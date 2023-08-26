import 'package:fashionshop/presentation/resource/color_manager.dart';
import 'package:fashionshop/presentation/resource/value_manager.dart';
import 'package:flutter/material.dart';

import '../../presentation/resource/style_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s28),
        ),
        color: ColorManager.grey,
      ),
      child: Row(
        children: [
          Icon(iconData, size: AppSize.s28,color: ColorManager.primary,),
          Text(userData,style: getMediumStyle(color: ColorManager.darkGrey),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(AppMargin.m20),
                height: 150,
                child: ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset('assets/Profile.jpg'),
                ),
              ),
              Text(
                'Naka',
                style: getBoldStyle(
                    color: ColorManager.darkGrey, fontSize: AppSize.s16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
