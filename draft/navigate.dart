///navigate and remove all in the stack
// Navigator.of(context).pushNamedAndRemoveUntil(
// AppRoutes.appHome,
// (route) => false,
// // arguments: true,
// );

///push to custom screen in the stack
// Navigator.of(context).pushNamed(AppRoutes.forgetPassword);


///back to custom screen in the stack
// Navigator.of(context).popUntil(
// (route) => route.settings.name == AppRoutes.login,
// );


///pushed from any place to notifiaction
// Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
// AppRoutes.notifications,
// );

///to push and send data argument
// Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamed(
// AppRoutes.orderDetails,
// arguments: {'id': notification.payload!['model_id']},
// );

///to recieve data argument
// final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;


///push with replacement
// Navigator.pushReplacementNamed(context, AppRoutes.login);


///back
// Navigator.pop(context);

///navigate with of context
// Navigator.of(context).pushNamed(
// AppRoutes.adDetails,
// arguments:{"ad":widget.ad,"isEdit":widget.isEdit},
// );

///navigate with back with data
// final result = await Navigator.of(context).pushNamed(AppRoutes.filter);
// var result = await Navigator.of(context).pushNamed(AppRoutes.filter) as Map<String,dynamic>;

//Map<String,dynamic> ?filterData = {};
// filterData.addAll(
//   {
//     "address":address.text,
//     "category_id":DropDownCubit.get(context).categoryModel!.id,
//     "subcategory_id":DropDownCubit.get(context).subCategoryModel!.id,
//     "bedrooms_num":bedroomNumber,
//     "bathrooms_num":bathroomNumber,
//     "area_from":areaFrom.text,
//     "area_to":areaTo.text,
//     "price_from":priceFrom.text,
//     "price_to":priceTo.text,
//     "building_year":buildingYear.text,
//   }
// );

// Navigator.pop(context,filterData);