// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatefulWidget {
  final bool nameOnly;
  final String productName;
  final String productDesc;
  final String posterName;
  final String posterProfileURL;
  final String productImgURL1;
  final String productImgURL2;
  const ProductCard({
    Key? key, 
    required this.nameOnly,
    required this.productName,
    required this.productDesc,
    required this.posterProfileURL,
    required this.posterName,
    required this.productImgURL1,
    required this.productImgURL2,
    }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  //TODO: add passable parameters for the data needed
  Color $whitesh = const Color(0xffF5F4F7);
  Color $mustard = const Color(0xffF4C900);
  @override
  Widget build(BuildContext context) {
    var $screenWidth = MediaQuery.of(context).size.width;
    var $screenHeight = MediaQuery.of(context).size.height;

    String productPoster = widget.posterName;
    if (widget.nameOnly == true) {
      return NeumorphicButton(
        onPressed: (){
          //TODO: add functionality
        },
        style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            depth: 5,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))
        ),
        child: SizedBox(
          width: $screenWidth - 70,
          height: 40,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.productName,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );


    } else {
      return NeumorphicButton(
        onPressed: () {
          //TODO: add functionality
        },
        style: NeumorphicStyle(
            color: Colors.white,
            shape: NeumorphicShape.flat,
            depth: 5,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))),
        child: SizedBox(
          width: $screenWidth - 70,
          height: 272 - 60,
          child: Column(
            children: [
              SizedBox(
                // color: Colors.blue,
                width: double.infinity,
                height: 44 + 5,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24.5,
                      //TODO: Create logic here for profile image
                      backgroundImage: NetworkImage(
                          'https://images.generated.photos/NVJOK3XVAitYE-EIT9ffzsZjoyryw9KPx9z87M9kkQc/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/NjE5MjI0LmpwZw.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            //TODO: Placeholder for PRODUCT NAME
                            widget.productName,
                            style: GoogleFonts.inter(
                              // textStyle: Theme.of(context).textTheme.headlineSmall,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                            //TODO: Placeholder for who POSTED
                            'Posted by $productPoster',
                            style: GoogleFonts.inter(
                              // textStyle: Theme.of(context).textTheme.headlineSmall,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 34 + 5,
                child: Text(
                  //TODO: Create a string for product description
                  widget.productDesc,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              SizedBox(
                width: double.infinity,
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.amber,
                      width: 110,
                      height: double.infinity,
                      //TODO: Replacement for image
                      child: Image.network(
                          widget.productImgURL1,
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: Colors.amber,
                      width: 110,
                      height: double.infinity,
                      //TODO: Replacement for image
                      child: Image.network(
                          widget.productImgURL2,
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
