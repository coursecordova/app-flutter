import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/utils/course_data.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_cordova/utils/video_data.dart';
import 'package:quickalert/quickalert.dart';

class LearningPage extends StatelessWidget {
  // const LearningPage({super.key});
  final String courseId;

  LearningPage({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VideoProvider()),
          ChangeNotifierProvider(create: (_) => PageProvider())
        ],
        child: Consumer<PageProvider>(
          builder: (context, value, child) => Scaffold(
            body: FirstPage(
              courseId: courseId,
            ), // Provider.of<PageProvider>(context).currentPage,
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                  elevation: 10,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  height: 57,
                  surfaceTintColor: Color(0xFFEF2D74),
                  indicatorColor: Color.fromARGB(255, 252, 222, 236),
                  backgroundColor: Colors.white,
                  labelTextStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey))),
              child: NavigationBar(
                selectedIndex: Provider.of<PageProvider>(context).currentIndex,
                onDestinationSelected: (index) {
                  Provider.of<PageProvider>(context, listen: false)
                      .changePage(index);
                  Provider.of<VideoProvider>(context, listen: false)
                      .updateIsSelected(index == 0
                          ? courseVideoData['1']['video']
                          : courseVideoData['1']['taskvideo']);
                },
                destinations: [
                  NavigationDestination(
                    icon: Icon(
                      Icons.source,
                      color:
                          (Provider.of<PageProvider>(context).currentIndex == 0)
                              ? Color(0xFFEF2D74)
                              : Colors.grey,
                    ),
                    label: 'Materi',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.shop,
                      color:
                          (Provider.of<PageProvider>(context).currentIndex == 1)
                              ? Color(0xFFEF2D74)
                              : Colors.grey,
                    ),
                    label: 'Tugas',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// Provider
class PageProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

// Provider
class VideoProvider extends ChangeNotifier {
  // Get data to initilized first video
  late Map<String, dynamic> _firstData;

  // course Id
  late String _courseId;

  // title video
  late String _titleText;

  // link video
  late String _videoLink;

  // selected video card
  late List<bool> _isSelected;

  // video index
  // for first rendering the page. auto play first video
  late String _videoId;

  late final PodPlayerController _controller;

  VideoProvider()
      : _controller = PodPlayerController(
            playVideoFrom: PlayVideoFrom.youtube(
                "https://www.youtube.com/watch?v=aSG9sKc-VLE")) {
    // Setelah objek VideoProvider diinisialisasi, atur videoLink pada _controller.
    _firstData = courseVideoData['1']['video']['1'];
    _titleText = _firstData["videoname"];
    _videoLink = _firstData["videolink"];
    _videoId = _firstData['id'];
    debugPrint("============================= $_videoId");
    _isSelected = List.generate(
        courseVideoData['1']['video'].length, (index) => index == 0);
    _controller.changeVideo(playVideoFrom: PlayVideoFrom.youtube(_videoLink));
    _controller.initialise();
  }

  String get courseId => _courseId;

  PodPlayerController get controller => _controller;

  String get titleText => _titleText;

  void updateText(String newText) {
    _titleText = newText;
    notifyListeners();
  }

  void updateCourseId(String id) {
    _courseId = id;
    notifyListeners();
  }

  void updateIsSelected(Map<String, dynamic> value) {
    _isSelected = List.generate(value.length,
        (index) => value[(index + 1).toString()]['id'] == _videoId);
    debugPrint(_isSelected.toString());
    notifyListeners();
  }

  List<bool> get isSelected => _isSelected;

  void toggleSelection(String videoId, String tag) {
    // change video Id
    _videoId = videoId;

    // update true false
    for (int i = 0; i < _isSelected.length; i++) {
      _isSelected[i] =
          (courseVideoData['1'][tag][(i + 1).toString()]['id'] == videoId);
    }
    notifyListeners();
  }
}

class FirstPage extends StatelessWidget {
  // const LearningPage({super.key});
  final String courseId;

  FirstPage({required this.courseId});

  @override
  Widget build(BuildContext context) {
    //course title
    Map<String, dynamic>? targetCourse = courseData.values.firstWhere(
      (course) => course['course_id'] == courseId,
      orElse: () => {},
    );

    String? courseName = targetCourse['name'];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 32,
      ),
      PodVideoPlayer(
        controller:
            Provider.of<VideoProvider>(context, listen: false).controller,
        podProgressBarConfig: const PodProgressBarConfig(
            playingBarColor: Colors.pink, circleHandlerColor: Colors.pink),
        videoTitle: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            Provider.of<VideoProvider>(context).titleText,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16, top: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            courseName ?? "course",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "By Cordova course",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ]),
      ),
      const SizedBox(
        height: 32,
      ),
      const Divider(
        thickness: 4,
        height: 0,
        indent: 12,
        endIndent: 12,
        color: Color.fromARGB(106, 239, 45, 116),
      ),
      Expanded(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: CourseList(
          courseId: courseId,
          controller:
              Provider.of<VideoProvider>(context, listen: false).controller,
        ),
      )),
    ]);
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page dummy content'),
    );
  }
}

class CourseList extends StatefulWidget {
  // course Id
  final String courseId;

  // controller variabel for constructor
  final PodPlayerController controller;

  CourseList({Key? key, required this.controller, required this.courseId})
      : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    bool isFirstPage = Provider.of<PageProvider>(context).currentIndex == 0;

    // course video data
    Map<String, dynamic>? targetCourse = courseVideoData.values.firstWhere(
      (course) => course['video_id'] == widget.courseId,
      orElse: () => {},
    );

    // to show number of list video
    final Map<String, dynamic> videoData = targetCourse?['video'];

    // to show number of list task video
    final Map<String, dynamic> taskVideo = targetCourse?['taskvideo'];

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: isFirstPage ? videoData.length : taskVideo.length,
        itemBuilder: (context, index) {
          // for video number
          String videoNumber = (index + 1).toString();

          // for video name
          String videoName = isFirstPage
              ? videoData[(index + 1).toString()]['videoname']
              : taskVideo[(index + 1).toString()]['videoname'];

          // for video duration
          String videoDuration = isFirstPage
              ? videoData[(index + 1).toString()]['videoduration']
              : taskVideo[(index + 1).toString()]['videoduration'];

          // access point
          String accessCode = isFirstPage
              ? videoData[(index + 1).toString()]['access']
              : taskVideo[(index + 1).toString()]['access'];

          // locked color
          Color lockedColor() {
            if (accessCode == "0") {
              return Colors.grey;
            } else {
              return Colors.black;
            }
          }

          // for video link
          String videoLink = isFirstPage
              ? videoData[(index + 1).toString()]['videolink']
              : taskVideo[(index + 1).toString()]['videolink'];

          // changing video
          String codeInput = "";
          void changeVideo() async {
            if (accessCode == "0") {
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.custom,
                barrierDismissible: true,
                confirmBtnText: "Konfirmasi",
                widget: TextFormField(
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "Enter code",
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => codeInput = value,
                ),
                onConfirmBtnTap: () async {
                  if (codeInput ==
                      videoData[(index + 1).toString()]['code_video']) {
                    setState(() {
                      videoData[(index + 1).toString()]['access'] = "1";
                    });
                    await QuickAlert.show(
                        context: context, type: QuickAlertType.success);
                    Navigator.pop(context);
                  }
                },
              );
            } else {
              Provider.of<VideoProvider>(context, listen: false)
                  .toggleSelection(
                      isFirstPage
                          ? videoData[(index + 1).toString()]['id']
                          : taskVideo[(index + 1).toString()]['id'],
                      isFirstPage ? "video" : "taskvideo");
              await widget.controller
                  .changeVideo(playVideoFrom: PlayVideoFrom.youtube(videoLink))
                  .then((value) =>
                      Provider.of<VideoProvider>(context, listen: false)
                          .updateText(videoName));
            }
          }

          return Container(
            color: Provider.of<VideoProvider>(context).isSelected[index]
                ? const Color(0xFFEF2D74).withOpacity(0.10)
                : Colors.transparent,
            child: TextButton(
                // toggle when bottom navbar clicked change video list
                onPressed: changeVideo,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xFFEF2D74).withOpacity(0.46);
                      }
                      return Colors.transparent;
                    }),
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 8, bottom: 8))),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        videoNumber,
                        style: TextStyle(fontSize: 18, color: lockedColor()),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            videoName,
                            style: TextStyle(
                                fontSize: 18,
                                color: lockedColor(),
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Video - $videoDuration",
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Spacer(),
                      accessCode == "0"
                          ? Icon(
                              Icons.lock,
                              color: Colors.black,
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        width: 16,
                      )
                    ])),
          );
        });
  }
}

// class CourseList extends StatelessWidget {
//   // course Id
//   final String courseId;

//   // controller variabel for constructor
//   final PodPlayerController controller;

//   CourseList({super.key, required this.controller, required this.courseId});

//   @override
//   Widget build(BuildContext context) {
//     bool isFirstPage = Provider.of<PageProvider>(context).currentIndex == 0;

//     // course video data
//     Map<String, dynamic>? targetCourse = courseVideoData.values.firstWhere(
//       (course) => course['video_id'] == courseId,
//       orElse: () => {},
//     );

//     // to show number of list video
//     final Map<String, dynamic> videoData = targetCourse?['video'];

//     // to show number of list task video
//     final Map<String, dynamic> taskVideo = targetCourse?['taskvideo'];

//     return ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: isFirstPage ? videoData.length : taskVideo.length,
//         itemBuilder: (context, index) {
//           // for video number
//           String videoNumber = (index + 1).toString();

//           // for video name
//           String videoName = isFirstPage
//               ? videoData[(index + 1).toString()]['videoname']
//               : taskVideo[(index + 1).toString()]['videoname'];

//           // for video duration
//           String videoDuration = isFirstPage
//               ? videoData[(index + 1).toString()]['videoduration']
//               : taskVideo[(index + 1).toString()]['videoduration'];

//           // access point
//           String accessCode = isFirstPage
//               ? videoData[(index + 1).toString()]['access']
//               : taskVideo[(index + 1).toString()]['access'];

//           // locked color
//           Color lockedColor() {
//             if (accessCode == "0") {
//               return Colors.grey;
//             } else {
//               return Colors.black;
//             }
//           }

//           // for video link
//           String videoLink = isFirstPage
//               ? videoData[(index + 1).toString()]['videolink']
//               : taskVideo[(index + 1).toString()]['videolink'];

//           // changing video
//           String codeInput = "";
//           void changeVideo() async {
//             if (accessCode == "0") {
//               return QuickAlert.show(
//                 context: context,
//                 type: QuickAlertType.custom,
//                 barrierDismissible: true,
//                 confirmBtnText: "Konfirmasi",
//                 widget: TextFormField(
//                   decoration: InputDecoration(
//                     alignLabelWithHint: true,
//                     hintText: "Enter code",
//                   ),
//                   textInputAction: TextInputAction.next,
//                   onChanged: (value) => codeInput = value,
//                 ),
//                 onConfirmBtnTap: () async {
//                   if (codeInput ==
//                       videoData[(index + 1).toString()]['code_video']) {
//                     videoData[(index + 1).toString()]['access'] = "1";
//                     await QuickAlert.show(
//                         context: context, type: QuickAlertType.success);
//                     Navigator.pop(context);
//                   }
//                 },
//               );
//             } else {
//               Provider.of<VideoProvider>(context, listen: false)
//                   .toggleSelection(
//                       isFirstPage
//                           ? videoData[(index + 1).toString()]['id']
//                           : taskVideo[(index + 1).toString()]['id'],
//                       isFirstPage ? "video" : "taskvideo");
//               await controller
//                   .changeVideo(playVideoFrom: PlayVideoFrom.youtube(videoLink))
//                   .then((value) =>
//                       Provider.of<VideoProvider>(context, listen: false)
//                           .updateText(videoName));
//             }
//           }

//           return Container(
//             color: Provider.of<VideoProvider>(context).isSelected[index]
//                 ? const Color(0xFFEF2D74).withOpacity(0.10)
//                 : Colors.transparent,
//             child: TextButton(
//                 // toggle when bottom navbar clicked change video list
//                 onPressed: changeVideo,
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                       if (states.contains(MaterialState.pressed)) {
//                         return const Color(0xFFEF2D74).withOpacity(0.46);
//                       }
//                       return Colors.transparent;
//                     }),
//                     elevation: MaterialStateProperty.all(0),
//                     padding: MaterialStateProperty.all(
//                         const EdgeInsets.only(top: 8, bottom: 8))),
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         width: 16,
//                       ),
//                       Text(
//                         videoNumber,
//                         style: TextStyle(fontSize: 18, color: lockedColor()),
//                       ),
//                       const SizedBox(
//                         width: 16,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             videoName,
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: lockedColor(),
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "Video - $videoDuration",
//                             style: const TextStyle(color: Colors.grey),
//                           )
//                         ],
//                       ),
//                       Spacer(),
//                       accessCode == "0"
//                           ? Icon(
//                               Icons.lock,
//                               color: Colors.black,
//                             )
//                           : SizedBox.shrink(),
//                       SizedBox(
//                         width: 16,
//                       )
//                     ])),
//           );
//         });
//   }
// }
