import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import './XDRootPage.dart';
import './XDRegisterPage.dart';

class XDLoginPage extends StatelessWidget {
  XDLoginPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(43.0, 110.0),
            child: Text(
              'Hello Again!',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 37,
                color: const Color(0xff253a4b),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(43.0, 596.0),
            child: Text(
              'Not a member?',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff253a4b),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(214.0, 351.0),
            child: Container(
              width: 108.0,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.0),
                color: const Color(0xfff23b5f),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(238.0, 357.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(43.0, 209.0),
            child: SvgPicture.string(
              _svg_wha76q,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(43.0, 280.0),
            child: Container(
              width: 279.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0x1a253a4b),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(75.0, 222.0),
            child: Text(
              'Email',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                color: const Color(0xff253a4b),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(75.0, 298.0),
            child: SvgPicture.string(
              _svg_dw62t9,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(24.0, 30.26),
            child: PageLink(
              links: [
                PageLinkInfo(
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => XDRootPage(),
                ),
              ],
              child: SvgPicture.string(
                _svg_eq67z0,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(24.0, 30.26),
            child: SvgPicture.string(
              _svg_eq67z0,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(188.0, 596.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => XDRegisterPage(),
                ),
              ],
              child: Text(
                'Register',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                  color: const Color(0xfff23b5f),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_wha76q =
    '<svg viewBox="43.0 209.0 279.0 50.0" ><path transform="translate(43.0, 209.0)" d="M 25 0 L 254 0 C 267.80712890625 0 279 11.19288063049316 279 25 C 279 38.80712127685547 267.80712890625 50 254 50 L 25 50 C 11.19288063049316 50 0 38.80712127685547 0 25 C 0 11.19288063049316 11.19288063049316 0 25 0 Z" fill="#253a4b" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dw62t9 =
    '<svg viewBox="75.0 298.0 162.0 15.0" ><path transform="translate(75.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(96.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(117.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(138.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(159.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(180.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(201.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(222.0, 298.0)" d="M 7.5 0 C 11.64213562011719 0 15 3.357864856719971 15 7.5 C 15 11.64213562011719 11.64213562011719 15 7.5 15 C 3.357864856719971 15 0 11.64213562011719 0 7.5 C 0 3.357864856719971 3.357864856719971 0 7.5 0 Z" fill="#253a4b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eq67z0 =
    '<svg viewBox="24.0 30.3 19.4 29.4" ><path transform="translate(24.0, 30.25)" d="M 12.52219009399414 28.31371307373047 L 1.188668131828308 17.45805740356445 C -0.392622709274292 15.94268131256104 -0.392622709274292 13.48837089538574 1.188668131828308 11.97299480438232 C 1.318673014640808 11.84852027893066 1.455293655395508 11.73437976837158 1.59748113155365 11.63037395477295 L 12.56439590454102 1.12551486492157 C 14.13161754608154 -0.3748715817928314 16.67096900939941 -0.3748715817928314 18.23819160461426 1.12551486492157 C 19.80400657653809 2.625900983810425 19.80400657653809 5.059770107269287 18.23819160461426 6.560156345367432 L 9.750591278076172 14.69117641448975 L 18.24663352966309 22.83001327514648 C 19.82792282104492 24.34402656555176 19.82792282104492 26.79969787597656 18.24663352966309 28.31371307373047 C 17.45598793029785 29.07072067260742 16.41984748840332 29.4492244720459 15.38388442993164 29.4492244720459 C 14.34792041778564 29.4492244720459 13.31213188171387 29.07072067260742 12.52219009399414 28.31371307373047 Z" fill="#f23b5f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
