import 'package:flutter/material.dart';
import '../widgets/custom_tile_widget.dart';
import '../routes/app_routes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      height: double.infinity,
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          const SizedBox(height: 35),
          const Text("Menu"),
          CustomTileWidget(lead: Icons.home_outlined, label: "Home", route: AppRoutes.home,),
          CustomTileWidget(lead: Icons.document_scanner_outlined, label: "List", route: AppRoutes.tournamentsScreen,),
          // CustomTileWidget(lead: Icons.find_in_page_outlined, label: "Detail", route: AppRoutes.productDetail,),
          CustomTileWidget(lead: Icons.add_outlined, label: "Create", route: AppRoutes.createUpdateTournament,),
          
        ],
      ),
    );
  }
}