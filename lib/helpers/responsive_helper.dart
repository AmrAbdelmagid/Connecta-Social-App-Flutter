

import 'package:flutter/material.dart';

double getHeight(BuildContext context,AppBar appBar){
  return MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
}

double getHeightWithoutAppBar(BuildContext context){
  return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
}

double getDeviceHeight(BuildContext context,AppBar appBar){
  return MediaQuery.of(context).size.height;
}


double getDeviceWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}