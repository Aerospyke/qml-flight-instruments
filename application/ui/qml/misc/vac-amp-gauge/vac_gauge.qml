import QtQuick 2.15

CircularGauge {
  id: vac_gauge_root
  minimumValue: 3
  maximumValue: 7
  stepSize: 0.0001
  value: 0

  // property double minimumValueAngle: 135
  // property double maximumValueAngle: 45

  style: CircularGaugeStyle {
    id: style
    progressArcThickness: 0 // Disable Progress Arc
    minimumValueAngle: 45
    maximumValueAngle: -45
    // minimumValueAngle: root.minimumValueAngle
    // maximumValueAngle: root.maximumValueAngle
    tickmarkStepSize: 1
    labelStepSize: 1
    minorTickmarkCount: 0

    labelInset: 0.25 * style.outerRadius
    tickmarkInset: 0.02 * style.outerRadius

    tickmarkLabelPixelSize: Math.max(6, Math.round(0.1 * style.outerRadius))

    tickmark: Rectangle {
      color: "#ffffff"
      width: 0.02 * style.outerRadius
      height: 0.115 * style.outerRadius
      radius: 0.01 * style.outerRadius
      antialiasing: true
    }

    tickmarkLabel: Text {
      property real value: 0

      text: value
      color: "#ffffff"
      font.family: "Century Gothic"
      font.pixelSize: Math.max(6, 0.1 * style.outerRadius)
      font.weight: Font.Black
      antialiasing: true
    }

    // foreground: Item {
    // }

    needle: GaugeNeedleStandard {
      width: 0.075 * style.outerRadius
      height: 0.95 * style.outerRadius
    }

    background: Item {
      id: background
      width: 2 * style.outerRadius
      height: 2 * style.outerRadius
      // TODO: Does this need to be a property?
      property double radius: style.outerRadius

      CustomCanvas {
        anchors.fill: parent
        onPaint: {
          if (context) {
            context.reset()
            context.lineWidth = 0.075 * style.outerRadius
            context.beginPath()
            context.arc(style.outerRadius,
                style.outerRadius,
                style.outerRadius - context.lineWidth / 2,
                (style.valueToAngle(5.5)) * Math.PI / 180.0, (style.valueToAngle(4.5)) * Math.PI / 180.0,
                false)
            context.strokeStyle = "#00c300"
            context.stroke()
          }
        }
      }

      CustomTextMiscUtil {
        x: 1.4 * parent.radius
        // width: 70 / 300 * parent.radius
        // height: 90 / 300 * parent.radius
        color: "#ffffff"
        text: "IN.\nHg."
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Math.max(6, 0.05 * parent.width)
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        lineHeight: 0.8
        wrapMode: Text.Wrap
      }

    }
  }
}
