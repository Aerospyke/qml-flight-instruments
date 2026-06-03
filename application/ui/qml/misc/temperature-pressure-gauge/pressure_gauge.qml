import QtQuick 2.15

CircularGauge {
  id: root
  minimumValue: 0
  maximumValue: 115
  stepSize: 0.1
  value: 0

  property double minimumValueAngle: -135
  property double maximumValueAngle: -45

  style: CircularGaugeStyle {
    id: style
    parentGauge: root

    tickmarkHeight: 0.115 * outerRadius

    minimumValueAngle: root.minimumValueAngle
    maximumValueAngle: root.maximumValueAngle
    dialCenterOffsetX: 0.06 * outerRadius
    tickmarkStepSize: 5
    labelStepSize: 5
    minorTickmarkCount: 0

    labelInset: 0.275 * outerRadius
    tickmarkInset: 0.02 * outerRadius

    tickmarkLabelPixelSize: Math.max(6, Math.round(0.1 * outerRadius))

    tickmark: Rectangle {
      property real value: 0

      color: value === 115 || value === 20 ? "#e30000" : "#ffffff"
      width: 0.02 * style.outerRadius
      height: style.tickmarkHeight
      radius: 0.01 * style.outerRadius
      antialiasing: true
      visible: value === 0 ||
          value === 20 ||
          value === 40 ||
          value === 60 ||
          value === 80 ||
          value === 100 ||
          value === 115
    }

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
        visible: value === 0 ||
            value === 20 ||
            value === 60 ||
            value === 100 ||
            value === 115
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
            context.lineWidth = style.greenArcLineWidth
            context.beginPath()
            context.arc(style.outerRadius + style.dialCenterOffsetX,
                style.outerRadius + style.dialCenterOffsetY,
                style.greenArcRadius,
                (style.valueToAngle(90) - 90) * Math.PI / 180.0,
                (style.valueToAngle(50) - 90) * Math.PI / 180.0, true)
            context.strokeStyle = "#00c300"
            context.stroke()
          }
        }
      }
    }
  }
}
