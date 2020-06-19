import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SharedAxisPR.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ForgotPass.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isEmpty = true;
  bool _isFilled = false;
  bool _isObscured = true;
  FocusNode _focusNodeEmail = FocusNode();
  FocusNode _focusNodePass = FocusNode();
  String _email;
  String _password;
  bool _isLoading = false;
  bool _autoValidate = false;
  String _error = '';

  Widget _sufIC(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      return _isEmpty
          ? null
          : IconButton(
              icon: Icon(
                Icons.clear,
                color: const Color(0xfff23b5f),
              ),
              onPressed: () {
                _emailController.clear();
                setState(() {
                  _isEmpty = true;
                });
              },
            );
    } else {
      return null;
    }
  }

  void _loginFunction() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser user = result.user;
        _error = 'Welcome back,' + user.displayName.toString() + '!';
        Navigator.of(context).pop();
        //Navigator.of(context).pushReplacementNamed('/home');
      } on PlatformException catch (e) {
        switch (e.code) {
          case 'ERROR_INVALID_EMAIL':
            _error = 'Enter a proper email';
            break;
          case 'ERROR_WRONG_PASSWORD':
            _error = 'Incorrect Password';
            break;
          case 'ERROR_USER_NOT_FOUND':
            _error = 'Account not found';
            break;
          case 'ERROR_USER_DISABLED':
            _error = 'Account disabled';
            break;
          case 'ERROR_TOO_MANY_REQUESTS':
            _error = 'Too many requests';
            break;
          default:
            _error = 'Unknown error occurred';
            break;
        }
      } finally {
        Fluttertoast.showToast(
          msg: _error,
          textColor: const Color(0xff253a4b),
          fontSize: 15,
        );
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            iconSize: 30,
            color: const Color(0xfff23b5f),
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(SharedAxisPageRoute()),
          ),
        ),
        body: Center(
          heightFactor: 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello Again!',
                style: GoogleFonts.openSans(
                  color: const Color(0xff253a4b),
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Form(
                autovalidate: _autoValidate,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),
                      child: TextFormField(
                        focusNode: _focusNodeEmail,
                        controller: _emailController,
                        validator: validateEmail,
                        obscureText: false,
                        maxLines: 1,
                        autovalidate: false,
                        enableSuggestions: true,
                        toolbarOptions:
                            ToolbarOptions(paste: true, selectAll: true),
                        textCapitalization: TextCapitalization.none,
                        cursorColor: const Color(0xff253a4b),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          fillColor: const Color(0x25253a4b),
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: const Color(0xfff23b5f),
                          ),
                          suffixIcon: _sufIC(_focusNodeEmail),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(_focusNodePass),
                        onChanged: (value) {
                          setState(() {
                            _emailController.text.isEmpty
                                ? _isEmpty = true
                                : _isEmpty = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _emailController.text.isEmpty
                                ? _isEmpty = true
                                : _isEmpty = false;
                          });
                        },
                        onEditingComplete: () {
                          setState(() {
                            _emailController.text.isEmpty
                                ? _isEmpty = true
                                : _isEmpty = false;
                          });
                        },
                        onSaved: (newValue) => _email = newValue,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: TextFormField(
                        focusNode: _focusNodePass,
                        controller: _passController,
                        obscureText: _isObscured,
                        validator: validatePassword,
                        maxLines: 1,
                        autovalidate: false,
                        enableSuggestions: false,
                        toolbarOptions: ToolbarOptions(
                          paste: false,
                          selectAll: true,
                          copy: false,
                          cut: false,
                        ),
                        textCapitalization: TextCapitalization.none,
                        cursorColor: const Color(0xff253a4b),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          fillColor: const Color(0x25253a4b),
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: const Color(0xfff23b5f),
                          ),
                          suffixIcon: _isFilled
                              ? IconButton(
                                  icon: Icon(
                                    _isObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xfff23b5f),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                )
                              : null,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          setState(() {
                            _passController.text.isEmpty
                                ? _isFilled = false
                                : _isFilled = true;
                          });
                        },
                        onSaved: (value) => _password = value,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () =>
                          Navigator.of(context).push(SharedAxisPageRoute(
                        page: ForgotPass(),
                        transitionType: SharedAxisTransitionType.horizontal,
                      )),
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.roboto(
                          color: const Color(0xfff23b5f),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 8.0,
                            ),
                            elevation: 5.0,
                            onPressed: () => _loginFunction(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: const Color(0xfff23b5f),
                            child: Text(
                              'Login',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
            bottom: 15.0,
            left: 20,
          ),
          child: Row(
            children: <Widget>[
              Text(
                'Not a member?',
                style: GoogleFonts.roboto(
                  color: const Color(0xff253a4b),
                  fontSize: 20,
                ),
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () =>
                    Navigator.of(context).pushReplacement(SharedAxisPageRoute(
                  page: RegisterPage(),
                  transitionType: SharedAxisTransitionType.horizontal,
                )),
                child: Text(
                  'Register',
                  style: GoogleFonts.roboto(
                    color: const Color(0xfff23b5f),
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
