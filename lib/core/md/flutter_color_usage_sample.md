Flutter Color Usage Examples

1. Predefined Colors

color: Colors.black,
color: Colors.red,
color: Colors.blueAccent,

2. Custom RGBO Color

color: Color.fromRGBO(255, 0, 0, 1.0),
color: Color.fromRGBO(0, 128, 128, 0.5),

3. Custom Hex Color

color: Color(0xFF123456),
color: Color(0xAAFF5733), // With transparency

4. Material Color Shades

color: Colors.green[300],
color: Colors.purple[700],

5. ARGB Color

color: Color.fromARGB(255, 0, 255, 0),
color: Color.fromARGB(128, 255, 255, 0),

6. HSV Color (Using Flutter's HSVColor)

color: HSVColor.fromAHSV(1.0, 120, 1.0, 1.0).toColor(),

7. Derived Theme Colors

color: Theme.of(context).primaryColor,
color: Theme.of(context).accentColor,

8. Custom Color Variables