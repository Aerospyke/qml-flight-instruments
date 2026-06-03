import QtQuick 2.15

CircularGauge {
  id: temperature_gauge_root
  minimumValue: 75
  maximumValue: 245
  stepSize: 0.1
  value: 0

  style: CircularGaugeStyle {
    id: style
    parentGauge: temperature_gauge_root
    // Component.onCompleted: {
    //   // print("Parent Gauge: ", parentGauge)
    //   // print("Direct Temp Root: ", temperature_gauge_root)
    //   // print("OuterRadius: ", style.outerRadius)
    //   // print("OuterRadius 2 : ", outerRadius)
    // }
    minimumValueAngle: 45
    maximumValueAngle: -45
    tickmarkStepSize: 5
    labelStepSize: 5
    minorTickmarkCount: 0
    tickmarkHeight: 0.115 * outerRadius
    labelInset: 0.275 * outerRadius
    tickmarkInset: 0.02 * outerRadius

    tickmark: Rectangle {
      property real value: 0

      // property real angle: style.valueToAngle(value)
      // property real tick_x_position: (style.outerRadius - 10) * Math.cos(Math.PI / 180 * angle)
      // property real tick_y_position: (style.outerRadius - 10) * Math.sin(Math.PI / 180 * angle)
      //
      // rotation: parent.angle + 90
      // x: tick_x_position - width * 0.5
      // y: tick_y_position - height * 0.5

      color: value === 245 ? "#e30000" : "#ffffff"
      width: 0.02 * style.outerRadius
      height: style.tickmarkHeight
      radius: 0.01 * style.outerRadius
      antialiasing: true
      visible: value === 75 ||
          value === 100 ||
          value === 150 ||
          value === 200 ||
          value === 245
    }

    tickmarkLabelPixelSize: Math.max(6, Math.round(0.1 * outerRadius))

    tickmarkLabel: Component {
      Text {
        property real value: 0

        text: value
        color: "#ffffff"
        font.family: "Century Gothic"
        font.weight: Font.Black
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        antialiasing: true
        visible: value === 75 ||
            value === 100 ||
            value === 150 ||
            value === 200 ||
            value === 245
      }
    }

    foreground: Item {
    }

    needle: GaugeNeedleStandard {
      width: 0.075 * style.outerRadius
      height: 0.95 * style.outerRadius
    }

    background: Item {
      id: background
      width: 2 * style.outerRadius
      height: 2 * style.outerRadius

      CustomCanvas {
        anchors.fill: parent
        onPaint: {
          if (context) {
            context.reset()
            context.lineWidth = 0.075 * style.outerRadius
            context.beginPath()
            context.arc(style.outerRadius,
                style.outerRadius,
                style.outerRadius - context.lineWidth / 4,
                (style.valueToAngle(245)) * Math.PI / 180.0,
                (style.valueToAngle(100)) * Math.PI / 180.0)
            context.strokeStyle = "#00c300"
            context.stroke()
          }
        }
      }
    }
  }
}
