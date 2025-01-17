import "package:flutter/material.dart";
import 'package:weathery/apiData.dart';
import 'package:weathery/semiWidgets.dart';
import 'themeData.dart';
import 'localValues.dart';

String userCountry = '',
    userCity = '',
    tempCurrent = '',
    descCurrent = '',
    feelsLike = '',
    icon = "",
    rainMeasure = '',
    rainDesc = "",
    pressureC = "",
    AQI = "",
    AQIDesc = "",
    bgimage = '',
    posLat = '',
    posLong = '';
List<Widget> alerts = [], forecastsWidgetList = [];

class MainScreen extends StatefulWidget {
  var userNameObjPassed;
  MainScreen({Key? key, userNameObj}) : super(key: key) {
    userNameObjPassed = userNameObj;
  }
  @override
  State<MainScreen> createState() =>
      _MainScreenState(username: userNameObjPassed);
}

void setWeatherData({temp, desc, feels, iconPathWithoutAPI, pressure}) {
  tempCurrent = temp;
  descCurrent = desc;
  feelsLike = feels;
  icon = iconPathWithoutAPI;
  pressureC = pressure;
}

void setAQI({usepa, desc}) {
  AQI = usepa;
  AQIDesc = desc;
}

void setRainInfo({measure, desc}) {
  rainMeasure = measure.toString();
  rainDesc = desc;
}

final greeting = Greetings().getMessage();
String name = "";

class _MainScreenState extends State<MainScreen> {
  var usernameObj;
  _MainScreenState({username}) {
    usernameObj = username;
  }
  @override
  Widget build(BuildContext context) {
    name = usernameObj.getName();
    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(
        elevation: 25,
        actions: [
          SizedBox(
            width: 40,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              focusColor: primaryBackgroundColor,
              onPressed: () {
                setState(() {
                  showSearchOverlay(context);
                });
              },
              child: const Icon(
                Icons.search_sharp,
                size: 27.5,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              focusColor: primaryBackgroundColor,
              onPressed: () {
                getCurrentLocation();
                alertUser(
                    title: const SizedBox(
                      height: 0,
                      width: 0,
                    ),
                    content: Container(
                      padding: const EdgeInsets.all(0),
                      height: 90,
                      width: 90,
                      child: RotationAnimation(
                        childToRotate: Image.asset(
                          "assets/weathery_loading_icon.png",
                        ),
                      ),
                    ),
                    actions: [
                      const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    ]);
              },
              child: const Icon(
                Icons.location_on_sharp,
                size: 27.5,
              ),
            ),
          ),
        ],
        centerTitle: false,
        title: Text(
          "$greeting, $name",
          textAlign: TextAlign.center,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bg/$bgimage.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, primaryBackgroundColor],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter)),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        //City name And Refresh
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  userCity,
                                  style: headingStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 30,
                                  child: Center(
                                    child: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      splashColor: secondaryForegroundColor,
                                      onPressed: () {
                                        getWeatherFromName(
                                            city: "$posLat,$posLong");
                                        alertUser(
                                            title: const SizedBox(
                                              height: 0,
                                              width: 0,
                                            ),
                                            content: Container(
                                              padding: const EdgeInsets.all(0),
                                              height: 90,
                                              width: 90,
                                              child: RotationAnimation(
                                                childToRotate: Image.asset(
                                                  "assets/weathery_loading_icon.png",
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              const SizedBox(
                                                height: 0,
                                                width: 0,
                                              )
                                            ]);
                                      },
                                      child: const Icon(
                                        Icons.refresh,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            userCountry,
                            style: captionStyle,
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      Container(
                        //Main Temp
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: primaryForegroundColor,
                        ),
                        margin: const EdgeInsets.only(top: 15, bottom: 12.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        tempCurrent,
                                        style: headingStyle.copyWith(
                                          fontSize: 45,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "°C",
                                        style:
                                            headingStyle.copyWith(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    descCurrent,
                                    textAlign: TextAlign.center,
                                    style: captionStyle,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "assets/$icon",
                                scale: 0.65,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        //Rain and AQI
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: primaryForegroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rain",
                                      style:
                                          captionStyle.copyWith(fontSize: 20),
                                    ),
                                    Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          rainMeasure,
                                          style: headingStyle,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "mm",
                                          style: headingStyle.copyWith(
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      rainDesc,
                                      textAlign: TextAlign.center,
                                      style: captionStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          height: 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: primaryForegroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "AQI",
                                      style:
                                          captionStyle.copyWith(fontSize: 20),
                                    ),
                                    Text(
                                      "US - EPA",
                                      style: headingStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      AQI,
                                      style: headingStyle,
                                    ),
                                    Text(
                                      AQIDesc,
                                      textAlign: TextAlign.center,
                                      style:
                                          captionStyle.copyWith(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          //Forecast
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: primaryForegroundColor,
                          ),
                          margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Forecast",
                                style: headingStyle.copyWith(fontSize: 26),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ScrollConfiguration(
                                behavior: NoGlowScrollBehaviour(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: forecastsWidgetList,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                      Container(
                          //Alerts
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: primaryForegroundColor,
                          ),
                          margin: const EdgeInsets.only(top: 15, bottom: 12.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Alerts",
                                style: headingStyle.copyWith(fontSize: 26),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: alerts,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
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
    );
  }
}

void setLocationData({city, country, isday}) {
  userCountry = country;
  userCity = city;
  int val = DateTime.now().hour;
  if (isday ==1 ) {
    bgimage = "day";
  } else {
    bgimage = "night";
  }
}


class _MyAppStateCheckerState extends State<MainScreen> with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
    return Container(); // Replace this with your main widget.
  }
}
