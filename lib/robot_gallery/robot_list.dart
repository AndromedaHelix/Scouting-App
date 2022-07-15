import 'package:flutter/material.dart';
import 'package:scouting_app/robot_gallery/robot_details.dart';
import 'package:scouting_app/system/fetch/controller_gallery.dart';
import 'package:scouting_app/system/fetch/feedback_gallery.dart';

class RobotList extends StatefulWidget {
  RobotList({Key? key}) : super(key: key);

  @override
  State<RobotList> createState() => _RobotListState();
}

class _RobotListState extends State<RobotList> {
  List<FeedbackGallery> feedbackItems = <FeedbackGallery>[];

  @override
  void initState() {
    super.initState();

    GalleryController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AssetImage image3 = AssetImage("assets/images/background/back1.jpeg");
    precacheImage(image3, context);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 125.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                  image: image3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10,
                    top: 100,
                  ),
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: feedbackItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RobotDetails(
                                    "${feedbackItems[index].number}",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 320,
                              width: 320,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "${feedbackItems[index].image}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14),
                                      ),
                                      color: Colors.amber.withOpacity(0.8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${feedbackItems[index].number}\n${feedbackItems[index].name}",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}