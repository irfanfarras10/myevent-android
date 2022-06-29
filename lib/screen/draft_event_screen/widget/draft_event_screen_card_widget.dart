import 'package:flutter/material.dart';
import 'package:myevent_android/colors/myevent_color.dart';

class DraftEventScreenCardWidget extends StatelessWidget {
  const DraftEventScreenCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 7.5),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 200,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 170.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Onsite',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MyEventColor.secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Text(
                            'Webinar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Webinar Crypto asd ad asd asd asd ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyEventColor.secondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Event Organizer asdasdas das ada s d',
                          style: TextStyle(
                            color: MyEventColor.secondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Kamis, 2 Juli 2022',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: MyEventColor.secondaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '•',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '12.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'The Breeze',
                          style: TextStyle(
                            color: MyEventColor.secondaryColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.black26,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0.0,
                      15.0,
                      0.0,
                      15.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.dashboard,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Dasbor',
                              style: TextStyle(
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(8.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0.0,
                      15.0,
                      0.0,
                      15.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.local_activity,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Tiket',
                              style: TextStyle(
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(8.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0.0,
                      15.0,
                      0.0,
                      15.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.people,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Peserta',
                              style: TextStyle(
                                color: MyEventColor.secondaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(8.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      0.0,
                      15.0,
                      0.0,
                      15.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.share,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Bagikan',
                              style: TextStyle(
                                color: MyEventColor.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(8.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
