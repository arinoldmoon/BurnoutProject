import 'package:burnout_mobile/constants/custom_color.dart';
import 'package:burnout_mobile/constants/home_page_sizes.dart';
import 'package:burnout_mobile/data_models/home_page_mock_machine_card.dart';
import 'package:flutter/material.dart';

class HomePageMachineCard extends StatefulWidget {
  const HomePageMachineCard({
    Key? key,
    required this.homePageMockMachineCard,
    required this.onTap,
  }) : super(key: key);

  final HomePageMockMachineCard homePageMockMachineCard;
  final VoidCallback onTap;

  @override
  State<HomePageMachineCard> createState() => _HomePageMachineCardState();
}

class _HomePageMachineCardState extends State<HomePageMachineCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: HomePageSizes.homePageMachineCardPadding,
        height: HomePageSizes.homePageMachineCardHieght,
        width: HomePageSizes.homePageMachineCardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              HomePageSizes.homePageMachineCardBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     _buildMachineImage(widget.homePageMockMachineCard.machinePic)
            //   ],
            // ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              _buildMachineDetail(
                  widget.homePageMockMachineCard.machineStatus,
                  widget.homePageMockMachineCard.machineName,
                  widget.homePageMockMachineCard.machineModel)
            ])
          ],
        ),
      ),
    );
  }

  Widget _buildMachineImage(String img) {
    return SizedBox(
      height: HomePageSizes.homePageMachineImgHeight,
      width: HomePageSizes.homePageMachineImgWidth,
      child: Image.asset(
        img,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildMachineDetail(
      bool machineStatus, String machineName, String machineModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          key: const Key('machineStatus'),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: machineStatus == true
                ? Border.all(color: CustomColor.machineStatusOnBorderColor)
                : Border.all(color: CustomColor.machineStatusOffBorderColor),
          ),
          child: Icon(
            Icons.circle,
            size: HomePageSizes.homePageMachineStatusIconsize,
            color: machineStatus == true
                ? CustomColor.machineStatusOnBorderColor.withOpacity(0.8)
                : CustomColor.machineStatusOffBorderColor.withOpacity(0.8),
          ),
        ),
        const SizedBox(
          height: HomePageSizes.homePageMachineStatusNameSpacing,
        ),
        Container(
          key: const Key('machineName'),
          child: Text(
            machineName,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: HomePageSizes.homePageMachineStatusNameSpacing,
        ),
        Container(
            key: const Key('machineModel'),
            child: Text(machineModel,
                style: Theme.of(context).textTheme.subtitle1)),
      ],
    );
  }
}
