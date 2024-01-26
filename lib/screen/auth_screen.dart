import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    const onBackground = Colors.white;
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
              minimumSize: const MaterialStatePropertyAll(
                Size.fromHeight(56),
              ),
              backgroundColor: MaterialStateProperty.all(onBackground),
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              )),
        ),
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(onSurface: onBackground, secondary: onBackground),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
            color: onBackground,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: onBackground, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: onBackground, width: 1),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nike_logo.png',
                color: Colors.white,
                width: 129,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: const TextStyle(color: onBackground, fontSize: 22),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                isLogin
                    ? 'لطفا وارد حساب کاربری خود شوید'
                    : 'ایمیل و رمز عبور خود را تعین کنید',
                style: const TextStyle(color: onBackground, fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: onBackground),
                decoration: InputDecoration(label: Text('ادرس ایمیل')),
              ),
              const SizedBox(
                height: 16,
              ),
              const TextFelidPassword(onBackground: onBackground),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  isLogin ? 'ورود' : 'ثبت نام',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? 'حساب کاربری ندارید' : 'حساب کاربری دارید',
                      style: TextStyle(
                        color: onBackground.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      isLogin ? ' ثبت نام' : 'ورود',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFelidPassword extends StatefulWidget {
  const TextFelidPassword({
    super.key,
    required this.onBackground,
  });

  final Color onBackground;

  @override
  State<TextFelidPassword> createState() => _TextFelidPasswordState();
}

class _TextFelidPasswordState extends State<TextFelidPassword> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: widget.onBackground),
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: widget.onBackground)),
        label: const Text('رمز عبور'),
      ),
    );
  }
}