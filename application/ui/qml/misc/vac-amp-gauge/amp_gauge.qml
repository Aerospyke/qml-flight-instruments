import QtQuick 2.15

CircularGauge {
  id: amp_gauge_root
  minimumValue: -60
  maximumValue: 60
  stepSize: 0.01
  value: 0

  style: CircularGaugeStyle {
    id: style
    progressArcThickness: 0 // Disable Progress Arc
    minimumValueAngle: 135
    maximumValueAngle: 225
    tickmarkStepSize: 30
    labelStepSize: 30
    minorTickmarkCount: 2

    labelInset: 0.275 * style.outerRadius
    tickmarkInset: 0.02 * style.outerRadius

    tickmarkLabelPixelSize: Math.max(6, Math.round(0.1 * style.outerRadius))

    tickmark: Rectangle {
      color: "#ffffff"
      width: 0.02 * style.outerRadius
      height: 0.115 * style.outerRadius
      radius: 0.01 * style.outerRadius
      antialiasing: true
    }

    minorTickmark: Rectangle {
      color: "#ffffff"
      width: 0.02 * style.outerRadius
      height: 0.075 * style.outerRadius
      radius: 0.01 * style.outerRadius
      antialiasing: true
    }

    tickmarkLabel: Text {
      property real value: 0
      text: value > 0 ? "+" + value : value
      color: "#ffffff"
      font.family: "Century Gothic"
      font.pixelSize: style.tickmarkLabelPixelSize
      font.weight: Font.Black
      antialiasing: true
    }

    needle: GaugeNeedleStandard {
      width: 0.075 * style.outerRadius
      height: 0.95 * style.outerRadius
    }

  }
}
