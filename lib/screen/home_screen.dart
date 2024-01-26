import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/home_bloc.dart';
import 'package:flutter_application_1/common/exception.dart';
import 'package:flutter_application_1/common/utils.dart';

import 'package:flutter_application_1/data/repo/banner_repositroy.dart';
import 'package:flutter_application_1/data/repo/product_repositroy.dart';
import 'package:flutter_application_1/widgets/banner_section.dart';
import 'package:flutter_application_1/widgets/horizantal_product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        final bloc = HomeBloc(banner, products);
        bloc.add(HomeStartedEvent());
        return bloc;
      },
      child: Scaffold(body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeResponseState) {
              return ListView.builder(
                physics: defaultScrollPhysics,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Container(
                        alignment: Alignment.center,
                        height: 70,
                        child: Image.asset(
                          'assets/img/nike_logo.png',
                          height: 32,
                        ),
                      );
                    case 2:
                      return BannerSection(
                        banners: state.banners,
                      );
                    case 3:
                      return HorizontalLIstView(
                        products: state.latest,
                        onTap: () {},
                        title: 'جدید ترین',
                      );
                    case 4:
                      return HorizontalLIstView(
                          products: state.popular,
                          onTap: () {},
                          title: 'پربازدیدترین');
                    default:
                      return Container();
                  }
                },
              );
            } else if (state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeErrorState) {
              return AppErrorWidget(
                exception: state.exception,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeRefreshEvent());
                },
              );
            } else {
              throw Exception('');
            }
          },
        ),
      )),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onTap;
  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(onPressed: onTap, child: const Text('تلاش مجدد'))
        ],
      ),
    );
  }
}
