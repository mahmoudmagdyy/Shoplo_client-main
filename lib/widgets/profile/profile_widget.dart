import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/utils/media/dimensions.dart';
import '../../resources/colors/colors.dart';

class ProfileInfoWidget extends StatelessWidget {
  final IconData ?iconData;
  final String ?detailsInfo;
  const ProfileInfoWidget({Key? key, this.iconData, this.detailsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Container(
          height: getSize(context).height*.065,
          width: getSize(context).width,
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.grey.withOpacity(.3)
            ),
          ),
          child: ListTile(
            tileColor: AppColors.white,
            leading: Icon(iconData,color: AppColors.grey.withOpacity(.5),),
            title: Text(detailsInfo!,style: TextStyle(
                color: AppColors.grey.withOpacity(.8)
            ),),
          ),
        ),
      ),
    );
  }
}