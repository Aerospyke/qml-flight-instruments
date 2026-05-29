import QtQuick 2.15

CircularGauge {
  id: root
  minimumValue: -60
  maximumValue: 60
  stepSize: 0.01
  value: 0

  property double minimumValueAngle: -135
  property double maximumValueAngle: -45

  style: CircularGaugeStyle {
    id: style
    minimumValueAngle: root.minimumValueAngle
    maximumValueAngle: root.maximumValueAngle
    tickmarkStepSize: 30
    labelStepSize: 30
    minorTickmarkCount: 1

    labelInset: 0.275 * outerRadius
    tickmarkInset: 0.02 * outerRadius

    tickmark: Rectangle {
      color: "#ffffff"
      width: 0.02 * outerRadius
      height: 0.115 * outerRadius
      radius: 0.01 * outerRadius
      antialiasing: true
    }

    minorTickmark: Rectangle {
      color: "#ffffff"
      width: 0.02 * outerRadius
      height: 0.075 * outerRadius
      radius: 0.01 * outerRadius
      antialiasing: true
    }

    tickmarkLabel: Text {
      text: styleData.value > 0 ? "+" + styleData.value : styleData.value
      color: "#ffffff"
      font.family: "Century Gothic"
      font.pixelSize: Math.max(6, 0.1 * outerRadius)
      font.weight: Font.Black
      antialiasing: true
    }

    foreground: Item {
    }

    needle: CustomNeedle {
      width: 0.075 * outerRadius
      height: 0.95 * outerRadius
    }

    background: Item {
    }
  }
}
