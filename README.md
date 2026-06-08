# QML Flight Instruments

This an update of [Berkbavas QML port](https://github.com/berkbavas/QmlFlightInstruments)
of [Marek M. Cel](http://marekcel.pl/)'
s [QFlightinstruments](https://github.com/marek-cel/QFlightinstruments). This update:

- Is compatible with Qt6 (tested against 6.11.0). This required many changes, including the replacement of the Qt Quick
  Extras CircularGauge with a custom circular gauge.
- Replaces the Qt project structure with a pure CMake build system

SVG files are from Marek's repository. See `application/ui/images/LICENSE` for copyright.

## Features

- **Electronic Flight Instrument System (EFIS)**
    - Electronic Attitude Direction Indicator (EADI)
    - Electronic Horizontal Situation Indicator (EHSI)
- **Basic Six**
    - Airspeed Indicator (ASI)
    - Attitude Indicator (AI)
    - Altimeter (ALT)
    - Turn Coordinator (TC)
    - Heading Indicator (HI)
    - Vertical Speed Indicator (VSI)
- **Additional Gauges**
    - Fuel Tank
    - Exhaust Gas Temperature (EGT) & Fuel Flow
    - Propeller
    - Battery
    - Temperature & Pressure

## Building (standalone demo)

1. Install **Qt 6.11.0**.
2. Open `CMakeLists.txt` in **Your IDE Of Choice**.
3. Update the root `CMakeLists.txt` file to reflect your **QT_INSTALL_LOCATION** and **QT_VERSION_TO_USE**
    - Optionally, update **APPLICATION_URI**, **APPLICATION_BUNDLE_GUI_ID** and **APPLICATION_ICON_PATH** for macOS
      deployment
4. Build and run the project.

I have only test on macOS so far, but plan on building in Linux in the near future. Testing on Windows would be
appreciated!

## Using as a reusable Qt module (recommended)

The flight instruments are now packaged as a proper static library + QML module in the `FlightInstruments/`
subdirectory. This lets you reuse the instruments (QML components, images, fonts, and the `PrimaryFlightData`
model) in other Qt applications without copying files around.

### In your consuming project's CMakeLists.txt

```cmake
# Add the instruments module (adjust the path to wherever you placed / submodule'd this repo)
add_subdirectory(${CMAKE_SOURCE_DIR}/../qml-flight-instruments/FlightInstruments)

# ... later when declaring your app ...
set(LINKED_LIBRARIES_INTERNAL
    qml_flight_instruments   # <--- this pulls in all QML, images, fonts and the C++ model
    # ... other internal libs
)

# Then use the normal find_and_setup_qt (or your own qt_add_executable + target_link_libraries) and
# list LINKED_LIBRARIES_INTERNAL. The resources from the instruments will be available automatically.
```

### From QML in the consuming app

Classic resource loading (no changes required to most existing instrument QML):

```qml
// Load a full pre-built display as a Window (or use the individual gauges inside your own UI)
Loader {
    source: "qrc:/qml/EfisRootDisplay.qml"
}
```

Or with the QML module import:

```qml
import FlightInstruments

Item {
    // PrimaryFlightData is registered as a QML type thanks to qt_add_qml_module
    PrimaryFlightData {
        id: telemetry
        // bind properties from your own data source / model here
    }

    ElectronicAttitudeDirectionIndicator {
        // bind the various adi/asi/alt/... properties to telemetry.*
    }
}
```

All SVG assets and fonts remain available under the original prefixes (`qrc:/images/...`, `qrc:/fonts/...`)
because the module embeds the original `.qrc`.

See `FlightInstruments/CMakeLists.txt` for the exact target name and alias (`QmlFlightInstruments::qml_flight_instruments`).

## Credits & License

- Original code and SVGs by Marek M. Cel. See [QFlightinstruments](https://github.com/marek-cel/QFlightinstruments).
- Additional gauges and QML port by this project.
- This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
