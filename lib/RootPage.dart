import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'LoginPage.dart';
import 'SharedAxisPR.dart';

class RootPage extends StatelessWidget {
  RootPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color(0xff253a4b),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(36.0))),
        ),
        Transform.translate(
          offset: Offset(0, MediaQuery.of(context).size.height * 0.365),
          child: SvgPicture.string(
            _svg_ummgt8,
            allowDrawingOutsideViewBox: true,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Transform.translate(
          offset: Offset(MediaQuery.of(context).size.width * 0.1,
              MediaQuery.of(context).size.height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome!',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 50,
                ),
              ),
              Text(
                'Nice to see you!',
                style: GoogleFonts.openSans(
                  color: const Color(0x80ffffff),
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                  onPressed: () => Navigator.of(context).push(
                      SharedAxisPageRoute(
                          page: LoginPage(),
                          transitionType: SharedAxisTransitionType.horizontal)),
                  color: const Color(0xfff23b5f),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Get Started',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25,
                      )
                    ],
                  ))
            ],
          ),
        )
      ]),
    );
  }
}

const String _svg_ummgt8 =
    '<svg viewBox="0.0 207.2 360.5 350.8" ><path transform="translate(-155.0, -25.0)" d="M 154.9998016357422 549.272705078125 L 154.9998016357422 345.2210998535156 C 206.2855529785156 439.4583129882812 304.9256591796875 498.0006103515625 412.4277038574219 498.0006103515625 C 447.9189147949219 498.0006103515625 482.577880859375 491.7474060058594 515.4739379882812 479.4126586914062 C 461.7958068847656 542.7594604492188 381.4911499023438 583.000244140625 291.7584838867188 583.000244140625 C 242.3596649169922 583.000244140625 195.8131256103516 570.8031616210938 154.9998016357422 549.272705078125 Z" fill="#f23b5f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 360.47, 486.0)" d="M 0 33.7275390625 L 0 237.7791442871094 C 51.28575134277344 143.5419311523438 149.9258575439453 84.9996337890625 257.4279174804688 84.9996337890625 C 292.9191284179688 84.9996337890625 327.5780639648438 91.25283813476562 360.47412109375 103.5875854492188 C 306.7960205078125 40.24078369140625 226.4913482666016 0 136.7586822509766 0 C 87.35986328125 0 40.81332397460938 12.19708251953125 0 33.7275390625 Z" fill="#f23b5f" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 360.47, 445.0)" d="M 0 33.7275390625 L 0 237.7791442871094 C 51.28575134277344 143.5419311523438 149.9258575439453 84.9996337890625 257.4279174804688 84.9996337890625 C 292.9191284179688 84.9996337890625 327.5780639648438 91.25283813476562 360.47412109375 103.5875854492188 C 306.7960205078125 40.24078369140625 226.4913482666016 0 136.7586822509766 0 C 87.35986328125 0 40.81332397460938 12.19708251953125 0 33.7275390625 Z" fill="#f23b5f" fill-opacity="0.15" stroke="none" stroke-width="1" stroke-opacity="0.15" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';