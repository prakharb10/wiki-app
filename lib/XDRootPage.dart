import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import './XDLoginPage.dart';

class XDRootPage extends StatelessWidget {
  XDRootPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Container(
            width: 360.0,
            height: 477.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(36.0),
              ),
              color: const Color(0xff253a4b),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 207.22),
            child: SvgPicture.string(
              _svg_ummgt8,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(43.0, 55.0),
            child: Text(
              'Welcome!',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 50,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(50.0, 127.0),
            child: Text(
              'Nice to see you!',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0x80ffffff),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(43.0, 179.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  ease: Curves.easeInOut,
                  duration: 0.3,
                  pageBuilder: () => XDLoginPage(),
                ),
              ],
              child: Container(
                width: 193.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.0),
                  color: const Color(0xfff23b5f),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(64.0, 185.0),
            child: Text(
              'Get Started',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(200.0, 193.25),
            child: SvgPicture.string(
              _svg_901h34,
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ummgt8 =
    '<svg viewBox="0.0 207.2 360.5 350.8" ><path transform="translate(-155.0, -25.0)" d="M 154.9998016357422 549.272705078125 L 154.9998016357422 345.2210998535156 C 206.2855529785156 439.4583129882812 304.9256591796875 498.0006103515625 412.4277038574219 498.0006103515625 C 447.9189147949219 498.0006103515625 482.577880859375 491.7474060058594 515.4739379882812 479.4126586914062 C 461.7958068847656 542.7594604492188 381.4911499023438 583.000244140625 291.7584838867188 583.000244140625 C 242.3596649169922 583.000244140625 195.8131256103516 570.8031616210938 154.9998016357422 549.272705078125 Z" fill="#f23b5f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 360.47, 486.0)" d="M 0 33.7275390625 L 0 237.7791442871094 C 51.28575134277344 143.5419311523438 149.9258575439453 84.9996337890625 257.4279174804688 84.9996337890625 C 292.9191284179688 84.9996337890625 327.5780639648438 91.25283813476562 360.47412109375 103.5875854492188 C 306.7960205078125 40.24078369140625 226.4913482666016 0 136.7586822509766 0 C 87.35986328125 0 40.81332397460938 12.19708251953125 0 33.7275390625 Z" fill="#f23b5f" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 360.47, 445.0)" d="M 0 33.7275390625 L 0 237.7791442871094 C 51.28575134277344 143.5419311523438 149.9258575439453 84.9996337890625 257.4279174804688 84.9996337890625 C 292.9191284179688 84.9996337890625 327.5780639648438 91.25283813476562 360.47412109375 103.5875854492188 C 306.7960205078125 40.24078369140625 226.4913482666016 0 136.7586822509766 0 C 87.35986328125 0 40.81332397460938 12.19708251953125 0 33.7275390625 Z" fill="#f23b5f" fill-opacity="0.15" stroke="none" stroke-width="1" stroke-opacity="0.15" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_901h34 =
    '<svg viewBox="200.0 193.3 22.1 19.4" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 222.0, 212.76)" d="M 7.970400333404541 18.7578010559082 L 0.9685983061790466 11.83312225341797 C 0.3396835029125214 11.36948108673096 -0.06840000301599503 10.62331485748291 -0.06840000301599503 9.782100677490234 C -0.06840000301599503 9.026431083679199 0.2607710063457489 8.347810745239258 0.783626914024353 7.881685733795166 L 7.943400382995605 0.8019000291824341 C 8.954100608825684 -0.1988999992609024 10.59390068054199 -0.1988999992609024 11.60550022125244 0.8019000291824341 C 12.61710071563721 1.801800012588501 12.61710071563721 3.423600196838379 11.60550022125244 4.423500061035156 L 8.760313987731934 7.236900329589844 L 19.45440101623535 7.236900329589844 C 20.86020088195801 7.236900329589844 21.99960136413574 8.376299858093262 21.99960136413574 9.782100677490234 C 21.99960136413574 11.18790054321289 20.86020088195801 12.328200340271 19.45440101623535 12.328200340271 L 8.728615760803223 12.328200340271 L 11.60010051727295 15.16770076751709 C 12.60179996490479 16.15950012207031 12.60179996490479 17.76600074768066 11.60010051727295 18.7578010559082 C 11.09880065917969 19.25325012207031 10.44202518463135 19.50097465515137 9.785250663757324 19.50097465515137 C 9.128475189208984 19.50097465515137 8.471700668334961 19.25325012207031 7.970400333404541 18.7578010559082 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
