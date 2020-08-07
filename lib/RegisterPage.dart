import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SharedAxisPR.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ForgotPass.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isEmpty = true;
  bool _isFilled = false;
  bool _isObscured = true;
  FocusNode _focusNodeName = FocusNode();
  FocusNode _focusNodeEmail = FocusNode();
  FocusNode _focusNodePass = FocusNode();
  String _email;
  String _password;
  String _name;
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

  void _signupFunction() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser firebaseUser = result.user;
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = _name;
        firebaseUser.updateProfile(updateInfo);
        _error = 'Hi, $_name!';
        FirebaseAnalytics().logSignUp(signUpMethod: 'EmailAndPassword');
        FirebaseAnalytics().setUserId(firebaseUser.uid);
        Navigator.of(context).pop();
        //Navigator.of(context).pushNamed('/home');
      } on PlatformException catch (err) {
        switch (err.code) {
          case 'ERROR_WEAK_PASSWORD':
            _error = 'Create a stronger password';
            break;
          case 'ERROR_INVALID_EMAIL':
            _error = 'Enter a proper email';
            break;
          case 'ERROR_EMAIL_ALREADY_IN_USE':
            _error = 'Account already exists';
            break;
          default:
            _error = 'Unknown error occurred';
            break;
        }
      } on TimeoutException catch (f) {
        _error = f.message;
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
          //heightFactor: 1,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                'Hello There!',
                style: GoogleFonts.openSans(
                  color: const Color(0xff253a4b),
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              AutofillGroup(
                child: Form(
                  autovalidate: _autoValidate,
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),
                        child: TextFormField(
                          autofillHints: [AutofillHints.name],
                          focusNode: _focusNodeName,
                          controller: _nameController,
                          validator: (value) {
                            if (value.length < 3) {
                              return "Name too short";
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          maxLines: 1,
                          autovalidate: false,
                          enableSuggestions: true,
                          toolbarOptions:
                              ToolbarOptions(paste: true, selectAll: true),
                          textCapitalization: TextCapitalization.words,
                          cursorColor: const Color(0xff253a4b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            fillColor: const Color(0x25253a4b),
                            hintText: 'Name',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: const Color(0xfff23b5f),
                            ),
                            suffixIcon: _sufIC(_focusNodeName),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(_focusNodeEmail),
                          onChanged: (value) {
                            setState(() {
                              _nameController.text.isEmpty
                                  ? _isEmpty = true
                                  : _isEmpty = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _nameController.text.isEmpty
                                  ? _isEmpty = true
                                  : _isEmpty = false;
                            });
                          },
                          onEditingComplete: () {
                            setState(() {
                              _nameController.text.isEmpty
                                  ? _isEmpty = true
                                  : _isEmpty = false;
                            });
                          },
                          onSaved: (newValue) => _name = newValue,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: TextFormField(
                          autofillHints: [AutofillHints.email],
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
                          onFieldSubmitted: (value) => FocusScope.of(context)
                              .requestFocus(_focusNodePass),
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
                          autofillHints: [AutofillHints.newPassword],
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 10.0,
                        ),
                        elevation: 5.0,
                        onPressed: () => _signupFunction(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: const Color(0xfff23b5f),
                        child: Text(
                          'Register',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String validatePassword(String value) {
  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = new RegExp(pattern);
  print(value);
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value))
      return 'Your password must have an uppercase, a lowercase, a numeric and a special character';
    else
      return null;
  }
}
