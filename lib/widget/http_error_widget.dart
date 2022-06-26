import 'package:flutter/material.dart';
import 'package:myevent_android/colors/myevent_color.dart';

class HttpErrorWidget extends StatelessWidget {
  final errorMessage;
  final VoidCallback refreshAction;
  const HttpErrorWidget({
    Key? key,
    required this.errorMessage,
    required this.refreshAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_tethering_error_rounded_rounded,
                color: Colors.red,
                size: 50.0,
              ),
              Text(
                errorMessage,
                style: TextStyle(
                  color: MyEventColor.secondaryColor,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: refreshAction,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        return MyEventColor.primaryColor;
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Coba Lagi',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: MyEventColor.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
