//The initial page for plans of the user
import 'dart:ui';
import 'package:flutter/material.dart';

class ZoomableImage extends StatefulWidget {
  const ZoomableImage({Key? key}) : super(key: key);

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  late List<AssetImage> _images;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _images = [
      const AssetImage('images/plan1.jpeg'),
      const AssetImage('images/plan2.jpeg'),
      const AssetImage('images/plan1.jpeg'),
      const AssetImage('images/plan2.jpeg'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            // Background image
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("images/e1.jpg"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            // Blurred background when dialog is open
            AnimatedOpacity(
              opacity: _isDialogOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),

            // Content
            SingleChildScrollView(
              child: Column(
                children: _buildImageWidgets(),
              ),
            ),

            // App bar
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: AppBar(
            //     backgroundColor: Colors.transparent,
            //     elevation: 0,
            //     title: const Center(child: Text("Plans For You")),
            //   ),
            // ),
          ],
        );

  }

  List<Widget> _buildImageWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < _images.length; i++) {
      widgets.add(
        Padding(
          padding:
              const EdgeInsets.only(top: 25, bottom: 25, left: 40, right: 40),
          child: GestureDetector(
            onTap: () => _showImageDialog(i),
            child: Hero(
              tag: "image$i",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image(
                  image: _images[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );

      if (i < _images.length - 1) {
        widgets.add(const SizedBox(height: 16.0));
        // Delay half second between images
        widgets.add(const DelayedWidget(
          delay: Duration(milliseconds: 500),
          child: Divider(
            color: Colors.black,
          ),
        ));
        widgets.add(const SizedBox(height: 16.0));
      }
    }

    return widgets;
  }

  void _showImageDialog(int index) {
    _setDialogOpen(true);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Hero(
            tag: "image$index",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: _images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ).then((_) => _setDialogOpen(false));
  }

  void _setDialogOpen(bool value) {
    setState(() {
      _isDialogOpen = value;
    });
  }
}

class DelayedWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const DelayedWidget({Key? key, 
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _DelayedWidgetState createState() => _DelayedWidgetState();
}

class _DelayedWidgetState extends State<DelayedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.delay, vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}




/////////////////////////////Old Design///////////////////////////////////////////////////
// ListView.builder(
//       itemCount: 4,
//       itemBuilder: (context, index) {
//         return  FadeIn(
//       child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 17,vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.onTertiary,
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: const [
//                         BoxShadow(
//                         color: Colors.grey,//Theme.of(context).colorScheme.primary,
//                         blurRadius:8, 
//                       ),            
//                       ]
//                     ),
//                     child:ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Image.asset('images/plan1.jpeg'))

// ),
//       // Optional paramaters
//       duration: const Duration(milliseconds: 250),
//       curve: Curves.easeIn,
//       );
//       },
//     );

