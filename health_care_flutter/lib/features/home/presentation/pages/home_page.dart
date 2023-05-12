import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/core/presentation/widgets/form_builder.dart';
import 'package:health_care_flutter/core/resources/assets_manager.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/routes_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:health_care_flutter/features/home/presentation/cubit/home_cubit.dart';
import 'package:health_care_flutter/features/home/presentation/widgets/patient_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(HomeCubit.cubit(context).getAllpatient);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.home,
          style: FontStyles.bold22Primary,
        ),
        elevation: AppSize.s0p5,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(Routes.addPatientRoute)
                  .then((value) => HomeCubit.cubit(context).getAllpatient());
            },
            icon: const Icon(
              Icons.add,
              color: ColorManager.primary,
              size: AppSize.s28,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchField(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p10,
                vertical: AppPadding.p6,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: AppPadding.p12,
                horizontal: AppPadding.p32,
              ),
              onChanged: HomeCubit.cubit(context).onSearchChanged,
              suffixIcon: IconButton(
                onPressed: () {
                  HomeCubit.cubit(context).scanQrCode(
                    context,
                    isAuthed: true,
                  );
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: ColorManager.primary,
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HomeGetDataSate) {
                    if (HomeCubit.cubit(context).list != null &&
                        (HomeCubit.cubit(context).list?.isNotEmpty ?? false)) {
                      return ListView.builder(
                        itemCount: HomeCubit.cubit(context).list?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PatientItem(
                            patient: HomeCubit.cubit(context).list![index],
                          );
                        },
                      );
                    } else {
                      return const EmptyWidget();
                    }
                  }
                  return const ErrorWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        IconAssets.empty,
        width: AppSize.s200,
        height: AppSize.s200,
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        IconAssets.error,
        width: AppSize.s200,
        height: AppSize.s200,
      ),
    );
  }
}
