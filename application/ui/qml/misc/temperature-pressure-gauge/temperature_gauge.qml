import QtQuick 2.15

CircularGauge {
  id: root
  minimumValue: 75
  maximumValue: 245
  stepSize: 0.1
  value: 0

  // property double minimumValueAngle: 135
  // property double maximumValueAngle: 45

  style: CircularGaugeStyle {
    id: style

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

    tickmarkLabel: Text {
      property real value: 0
      text: value
      color: "#ffffff"
      font.family: "Century Gothic"
      font.pixelSize: Math.max(6, 0.1 * style.outerRadius).toFixed(0)
      font.weight: Font.Black
      antialiasing: true
      visible: value === 75 ||
          value === 100 ||
          value === 150 ||
          value === 200 ||
          value === 245
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
                style.outerRadius - style.tickmarkInset - context.lineWidth / 2,
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
