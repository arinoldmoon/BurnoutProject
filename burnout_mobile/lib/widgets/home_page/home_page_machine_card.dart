import 'package:burnout_mobile/constants/homepage/home_page_sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/data_models/home_page_mock_machine_card.dart';
import 'package:flutter/material.dart';

class HomePageMachineCard extends StatefulWidget {
  const HomePageMachineCard({
    Key? key,
    required this.homePageMockMachineCard,
  }) : super(key: key);

  final HomePageMockMachineCard homePageMockMachineCard;

  @override
  State<HomePageMachineCard> createState() => _HomePageMachineCardState();
}

class _HomePageMachineCardState extends State<HomePageMachineCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.homePageMockMachineCard.onTap,
      child: Container(
        key: const Key('machineCard'),
        padding: HomePageSizes.homePageMachineCardPadding,
        height: HomePageSizes.homePageMachineCardHieght,
        width: HomePageSizes.homePageMachineCardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              HomePageSizes.homePageMachineCardBorderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildMachineImage(widget.homePageMockMachineCard.machinePic)
              ],
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildMachineDetail(
                      widget.homePageMockMachineCard.machineStatus,
                      widget.homePageMockMachineCard.machineName,
                      widget.homePageMockMachineCard.machineModel),
                ],
              ),
            ),
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
                ? Border.all(color: AppTheme.greenPrimary)
                : Border.all(color: AppTheme.redPrimary),
          ),
          child: Icon(
            Icons.circle,
            size: HomePageSizes.homePageMachineStatusIconsize,
            color: machineStatus == true
                ? AppTheme.greenPrimary.withOpacity(0.8)
                : AppTheme.redPrimary.withOpacity(0.8),
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
                .caption
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: HomePageSizes.homePageMachineStatusNameSpacing,
        ),
        Container(
          key: const Key('machineModel'),
          child: Text(machineModel, style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }
}
