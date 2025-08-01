import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/responsive/responsive_ui.dart';
import 'package:dashborad/widgets/content_button_invoice.dart';
import 'package:dashborad/widgets/header.dart';
import 'package:flutter/material.dart';

class MonthInvoice extends StatelessWidget {
  const MonthInvoice({super.key});

  @override
  Widget build(BuildContext context) {
 
    late ResponsiveUtil responsiveUtil = ResponsiveUtil(context);
    double responsiveTop = responsiveUtil.getResponsiveHeight(0.10);
    double responsiveWith = responsiveUtil.getResponsiveWidth(0.89); // Adjust the value to fit your design
    double responsiveHeigth = responsiveUtil.getResponsiveHeight(0.42);

    return Container(
        color: Colors.black.withValues(alpha: 0.02 * 255),
        width: responsiveWith,
        height: responsiveHeigth,
        
        child:  Column(
        
                  
        children: [
          
          const SizedBox(height: 50), 
          
           Container(
            
            width: responsiveWith,
            height:responsiveTop,
            decoration: decorationMonthInvoice(),
            child: const Header(),
          ),
          
          Container(
            width: responsiveWith,
            height: responsiveTop,
            decoration: decorationSpacerContainer(),
            child: Row(
              children: [
                  
                  
                const SizedBox(
                  width: 25,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    )),
                             ),
                  
                Expanded(
                  child: LayoutBuilder(
                   
                    builder: (BuildContext context, BoxConstraints constraints) { 
                      return Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate((constraints.constrainWidth()/15).floor(), (index) => const SizedBox(
                      width:  5, height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white
                        )),
                    ))
                    
                    ); 
                    },
                    
                  )),
                  
                const SizedBox(
                  width: 25,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                      )
                    )),
                             ),
                  
                  
              
              ],
            ),
          ),
          
          
            Container(
           
            decoration: decorationbuttonContainer(),
            width: responsiveWith ,
            height: responsiveHeigth,
            child: const ContentButtonInvoice(),
          ) 
        ],
                  )
    );
  }

  BoxDecoration decorationbuttonContainer() => BoxDecoration(
    color: titleColor,
     borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)), 
  );

  BoxDecoration decorationSpacerContainer() => BoxDecoration(
    color: firstColor,


  );

  BoxDecoration decorationMonthInvoice() => BoxDecoration(
    color: firstColor,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)), 
  );
}