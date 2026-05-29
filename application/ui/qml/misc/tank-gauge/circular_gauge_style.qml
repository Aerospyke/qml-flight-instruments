import QtQuick

QtObject {
  // Angles
  property real minimumValueAngle: -135
  property real maximumValueAngle: 135

  // Background
  property Component background: null
  property color backgroundColor: "#333333"
  property real backgroundThickness: 14

  // Progress
  property color progressColor: "#4CAF50"
  property real progressThickness: 14

  // Tickmarks
  property real tickmarkStepSize: 10
  property int majorTickmarkCount: 10
  property Component tickmark: null
  property real majorTickmarkLength: 18
  property real majorTickmarkWidth: 3
  property color tickmarkColor: "#AAAAAA"

  // Minor Tickmarks
  property int minorTickmarkCount: 4
  property Component minorTickmark: null
  property real minorTickmarkLength: 10
  property real minorTickmarkWidth: 2
  property color minorTickmarkColor: "#777777"

  property real tickmarkInset: 12
  property real minorTickmarkInset: 16

  // Labels
  property real labelStepSize: 10
  property Component tickmarkLabel: defaultTickmarkLabel
  property color labelColor: "#CCCCCC"
  property real labelFontSize: 13
  property real labelInset: 38

  property Component defaultTickmarkLabel: Text
  {
    text: Math.round(value)
    color: labelColor
    font.pixelSize: labelFontSize
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
  }

  // Needle
  property Component needle: null
  property color needleColor: "#E74C3C"
  property real needleLength: 0.78
  property real needleWidth: 6
  property real needleYOffset: -10

  // Value Text
  property color valueTextColor: "white"
  property real valueFontSize: 28
  property real valueTextYOffset: 25

  function valueText(currentValue) {
    return currentValue.toFixed(0)
  }

  // Foreground
  property Component foreground: null
}