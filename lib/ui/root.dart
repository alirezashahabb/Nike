import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repo/auth_repository.dart';
import 'package:flutter_application_1/ui/cart/cart.dart';
import 'package:flutter_application_1/ui/home/home.dart';
import 'package:flutter_application_1/ui/widgets/badge.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, const HomeScreen()),
              _navigator(_cartKey, cartIndex, const CartScreen()),
              _navigator(
                  _profileKey,
                  profileIndex,
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Profile'),
                        ElevatedButton(
                          onPressed: () {
                            authRepository.signOut();
                          },
                          child: const Text('logOut'),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'خانه'),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(CupertinoIcons.cart),
                      Positioned(right: -13, child: BadgeeItem(value: 1)),
                    ],
                  ),
                  label: 'سبد خرید'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
            ],
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            },
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}


///////////////////////////////////////////////////
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/data/auth_info.dart';
// import 'package:flutter_application_1/data/repo/auth_repository.dart';
// import 'package:flutter_application_1/data/repo/cart_repositroy.dart';
// import 'package:flutter_application_1/ui/auth/auth.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     cartRepository.geAll().then((value) {
//       debugPrint(value.toString());
//     }).catchError((e) {
//       debugPrint(e.toString());
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("سبد خرید"),
//       ),
//       body: ValueListenableBuilder<AuthInfo?>(
//         valueListenable: AuthRepository.authChangeNotifier,
//         builder: (context, authState, child) {
//           bool isAuthenticated =
//               authState != null && authState.accessToken.isNotEmpty;
//           return SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(isAuthenticated
//                     ? 'خوش آمدید'
//                     : 'لطفا وارد حساب کاربری خود شوید'),
//                 isAuthenticated
//                     ? ElevatedButton(
//                         onPressed: () {
//                           authRepository.signOut();
//                         },
//                         child: const Text('خروج از حساب'))
//                     : ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context, rootNavigator: true).push(
//                               MaterialPageRoute(
//                                   builder: (context) => const AuthScreen()));
//                         },
//                         child: const Text('ورود')),
//                 ElevatedButton(
//                     onPressed: () async {
//                       await authRepository.refreshToken();
//                     },
//                     child: const Text('Refresh Token')),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
