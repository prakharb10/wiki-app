import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SharedAxisPR.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ForgotPassState extends State<ForgotPass> {
  final _forgotemailController = TextEditingController();
  bool _isEmpty2 = true;
  FocusNode _focusNodeEmail2 = FocusNode();
  String _email;
  final _formKey2 = GlobalKey<FormState>();
  String errorMsg = '';
  bool _isLoading = false;

  Widget _sufIC() {
    if (_focusNodeEmail2.hasFocus) {
      return _isEmpty2
          ? null
          : IconButton(
              icon: Icon(
                Icons.clear,
                color: const Color(0xfff23b5f),
              ),
              onPressed: () {
                _forgotemailController.clear();
                setState(() {
                  _isEmpty2 = true;
                });
              },
            );
    } else {
      return null;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Can\'t remember your password? ',
                  style: GoogleFonts.openSans(
                    color: const Color(0xff253a4b),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: Form(
                    autovalidate: true,
                    key: _formKey2,
                    child: TextFormField(
                      validator: validateEmail,
                      focusNode: _focusNodeEmail2,
                      controller: _forgotemailController,
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
                        suffixIcon: _sufIC(),
                      ),
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        setState(() {
                          _forgotemailController.text.isEmpty
                              ? _isEmpty2 = true
                              : _isEmpty2 = false;
                        });
                      },
                      onTap: () {
                        setState(() {
                          _forgotemailController.text.isEmpty
                              ? _isEmpty2 = true
                              : _isEmpty2 = false;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          _forgotemailController.text.isEmpty
                              ? _isEmpty2 = true
                              : _isEmpty2 = false;
                        });
                      },
                      onSaved: (newValue) => _email = newValue,
                    ),
                  ),
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 10.0,
                        ),
                        elevation: 5.0,
                        onPressed: () async {
                          if (_formKey2.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            _formKey2.currentState.save();
                            try {
                              await _auth.sendPasswordResetEmail(email: _email);
                            } on PlatformException catch (error) {
                              switch (error.code) {
                                case 'ERROR_INVALID_EMAIL':
                                  errorMsg = 'Enter a proper email';
                                  break;
                                case 'ERROR_USER_NOT_FOUND':
                                  errorMsg = 'User does not exist!';
                                  break;
                                default:
                                  errorMsg = 'Unknown error occurred';
                                  break;
                              }
                            }
                            setState(() {
                              _isLoading = false;
                            });
                            if (errorMsg == '') {
                              errorMsg = 'Email sent successfully';
                              Fluttertoast.showToast(
                                fontSize: 15,
                                msg: errorMsg,
                                textColor: const Color(0xff253a4b),
                              );
                            } else {
                              Fluttertoast.showToast(
                                fontSize: 15.0,
                                msg: errorMsg,
                                textColor: const Color(0xff253a4b),
                              );
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: const Color(0xfff23b5f),
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}
