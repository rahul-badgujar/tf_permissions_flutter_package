import 'package:flutter/material.dart';

Future<bool?> showConfirmationBottomSheet(BuildContext context,
    {required String title,
      required String desc,
      required String positive,
      required String negative,
      bool isDismissible = true}) async {
  return await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.black,
      isDismissible: isDismissible,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, false);
            return true;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 17,
                          width: 60,
                          child: TextButton(
                            onPressed: () async {
                              Navigator.pop(context, true);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                positive,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                          width: 20,
                          child: TextButton(
                            onPressed: () async {
                              Navigator.pop(context, false);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                negative,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}