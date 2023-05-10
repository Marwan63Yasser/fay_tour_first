
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<dynamic> urlImages;
  final int index;
  GalleryWidget({Key? key, required this.urlImages,this.index = 0}) : pageController = PageController(initialPage: index), super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PhotoViewGallery.builder(
            pageController: widget.pageController,
            itemCount: widget.urlImages.length, 
            builder:(context, index) {
              final urlImage =  widget.urlImages[index];
              
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(urlImage),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
              onPageChanged: (index) => setState(() {this.index = index;}),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width,
              child: Container(
                
                margin:  EdgeInsets.fromLTRB(7,MediaQuery.of(context).size.height*0.05,7,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                            onPressed: () {Navigator.pop(context);},
                            child: const Icon(Icons.arrow_back_rounded,),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            foregroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow:  const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 6, 
                                            //offset: Offset(4,4),
                                          ),]
                                        ),
                           
                            child: Center(
                              child: Text(
                                                "Photo: ${index + 1}/${widget.urlImages.length}",
                                                style:  GoogleFonts.aclonica(color:Theme.of(context).colorScheme.primary,fontSize: 20),
                                                ),
                            )),
                  ],
                ),
              ),
            ),
            
        ],
      ),
    );
  }
}