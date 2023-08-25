import 'package:fashionshop/presentation/resource/value_manager.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              const Text('Naka'),
            ],
          ),
        ),
        
      ],
    );
  }
}
