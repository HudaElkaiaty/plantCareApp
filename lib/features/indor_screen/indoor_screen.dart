import 'package:flutter/material.dart';

class IndoorScreen extends StatelessWidget {
  const IndoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 50),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    Image.asset("assets/indoorLogo.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
