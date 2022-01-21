import 'package:flutter/material.dart';

class FoodGrupe extends StatefulWidget {
  final CateguryBanner categuryBanner;

  const FoodGrupe({Key key, this.categuryBanner}) : super(key: key);
  @override
  _FoodGrupeState createState() => _FoodGrupeState();
}

class _FoodGrupeState extends State<FoodGrupe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bannerTheme.backgroundColor,
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCateguryBanner.length,
          itemBuilder: (context, index) {
            var categury = listCateguryBanner[index];

            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 15, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, -1),
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                .withOpacity(0.5),
                            spreadRadius: 0.2,
                            blurRadius: 5),
                        BoxShadow(
                            offset: Offset(-1, 1),
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                .withOpacity(0.5),
                            spreadRadius: 0.2,
                            blurRadius: 5)
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        categury.selected = !categury.selected;
                        setState(() {});
                      },
                      color: Theme.of(context).primaryColor,
                      child: ColorFiltered(
                        child: Image.asset(
                          categury.photo,
                          fit: BoxFit.cover,
                        ),
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).bottomAppBarTheme.color ==
                                    Color(0xFF2A2929)
                                ? (categury.selected == false
                                    ? Color(0xFFFFFFFF)
                                    : categury.colorCategury)
                                : (categury.selected == false
                                    ? Colors.black
                                    : categury.colorCategury),
                            BlendMode.srcIn),
                      ),
                      shape: StadiumBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      categury.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline6
                          .apply(fontSizeDelta: -3),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CateguryBanner {
  String name;
  String photo;
  bool selected;
  Color colorCategury;
  CateguryBanner(this.name, this.photo, this.selected, this.colorCategury);
}

final pizza =
    CateguryBanner('Pizza', "assets/pizza-slice.png", false, Color(0xFFFC186A));
final burger =
    CateguryBanner('Burger', "assets/ber1.png", false, Color(0xFF18B3FC));
final salat =
    CateguryBanner('Salat', "assets/sa1.png", false, Color(0xFF97B500));
final pasta =
    CateguryBanner('Pasta', "assets/sp1.png", false, Color(0xFFF08800));
final kebap =
    CateguryBanner('Kebap', "assets/ke1.png", false, Color(0xFF06716A));
final mehr =
    CateguryBanner('Mehr', "assets/Mehr.png", false, Color(0xFFA7021C));

final List<CateguryBanner> listCateguryBanner = [
  pizza,
  burger,
  salat,
  pasta,
  kebap,
  mehr,
];
