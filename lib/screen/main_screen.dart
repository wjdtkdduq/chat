import 'package:chat/config/palette.dart';
import 'package:chat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _authentication = FirebaseAuth.instance;
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String id = '';
  String password = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image/red.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 90, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Welcome',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                        children: [
                          TextSpan(
                            text: isSignupScreen ? ' to Yummy chat!' : ' back!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isSignupScreen
                          ? 'Signup to continue'
                          : 'Login to continue',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 윗 상단 컨테이너
          Positioned(
            top: 180,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: isSignupScreen ? 280 : 250,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    top: 9,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignupScreen = false;
                                  });
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.textColor1
                                        : Palette.activeColor,
                                  ),
                                ),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                  margin: EdgeInsets.only(top: 3),
                                ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSignupScreen = true;
                                  });
                                },
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.textColor1
                                        : Palette.activeColor,
                                  ),
                                ),
                              ),
                              if (isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                  margin: EdgeInsets.only(top: 3),
                                ),
                            ],
                          ),
                        ],
                      ),
                      // 로그인 사인업 텍스트(상태값 여기서 바뀜)
                      if (isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return '4글자 이상 부탁합니다';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  onChanged: (value) {
                                    userName = value;
                                  },
                                  key: ValueKey(1),
                                  decoration: InputDecoration(
                                    hintText: 'User name',
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8),

                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return '@를 넣어야 합니다';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    id = value!;
                                  },
                                  onChanged: (value) {
                                    id = value;
                                  },
                                  key: ValueKey(2),
                                  decoration: InputDecoration(
                                    hintText: 'id',
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8),

                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return '6글자 이상 부탁합니다';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  key: ValueKey(3),
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      if (!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return '@를 넣어야 합니다';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    id = value!;
                                  },
                                  onChanged: (value) {
                                    id = value;
                                  },
                                  key: ValueKey(4),
                                  decoration: InputDecoration(
                                    hintText: 'id',
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return '6글자 이상 부탁합니다';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  key: ValueKey(5),
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                      color: Palette.textColor1,
                                      fontSize: 14,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 텍스트 폼 필드 컨테이너
          Positioned(
            top: isSignupScreen ? 430 : 390,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (isSignupScreen) {
                      _tryValidation();
                      try {
                        final newUser = await _authentication
                            .createUserWithEmailAndPassword(
                              email: id,
                              password: password,
                            );
                        if (newUser.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('다시 입력하세요')));
                      }
                    }
                    if (!isSignupScreen) {
                      _tryValidation();
                      try {
                        final newUser = await _authentication
                            .signInWithEmailAndPassword(
                              email: id,
                              password: password,
                            );
                        if (newUser.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange],
                      ),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          // 전송버튼
          Positioned(
            top: isSignupScreen
                ? MediaQuery.of(context).size.height - 125
                : MediaQuery.of(context).size.height - 165,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(isSignupScreen ? 'or Signup with' : 'go chat page'),
                  SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      'Google',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.add, color: Colors.white),
                    style: TextButton.styleFrom(
                      backgroundColor: Palette.googleColor,
                      minimumSize: Size(150, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 텍스트 버튼
        ],
      ),
    );
  }
}
