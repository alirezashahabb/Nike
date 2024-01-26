import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/image_loading_service.dart';
import 'package:flutter_application_1/common/style.dart';
import 'package:flutter_application_1/data/module/banner_module.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// this class for banner section 
class BannerSection extends StatelessWidget {
  final List<BannerEntity> banners ; 
  const BannerSection({
    super.key, required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return AspectRatio(
      aspectRatio: 2,
    
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: banners.length,
            itemBuilder: (context, index) {
            return  Padding(
              padding: const EdgeInsets.only(left: 12 , right: 12),
              child: ImageLoadingService(imageUrl: banners[index].image,radius: 12,),
            );
          },),
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: Center(
              child: SmoothPageIndicator(  
                 controller: controller,  // PageController  
                 count:  banners.length,  
                 effect:  const WormEffect(
                  dotHeight: 4,
                  activeDotColor: LightThemeColors.primaryTextColor,
                 ),  // your preferred effect  
                 onDotClicked: (index){  
                       
                 }  
              ),
            ),
          )  
        ],
      ),
    );
  }
}