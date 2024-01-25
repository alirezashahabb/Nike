import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/home_bloc.dart';
import 'package:flutter_application_1/data/repo/banner_repositroy.dart';
import 'package:flutter_application_1/data/repo/product_repositroy.dart';
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
                if(state is HomeResponseState)
{
 return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Image.asset(
                      'assets/img/nike_logo.png',
                      
                      height: 32,
                    );

                  default:  
                    return Container();
                }
              },
            );
}
           else if(state is  HomeInitial ){
               return const Center(child: CircularProgressIndicator(),
               );
              
            } else if(state is HomeErrorState){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(state.exception.message) , 
                          ElevatedButton(onPressed: () {
                            BlocProvider.of<HomeBloc>(context).add(HomeRefreshEvent());
                          }, child: const Text('تلاش مجدد'))
                      ],
                    ),
                  );
            }
            
            else{
             throw Exception('');
            }
            
          
           
          },
        ),
      )),
    );
  }
}
