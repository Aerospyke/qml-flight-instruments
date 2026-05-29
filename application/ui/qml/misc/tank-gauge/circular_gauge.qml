import QtQuick
import QtQuick.Shapes

Item {
  id: root

  // ==================== Public Properties ====================
  property real value: 0
  property real minValue: 0
  property real maxValue: 100

  property real startAngle: -135
  property real endAngle: 135

  property color backgroundColor: "#333333"
  property color progressColor: "#4CAF50"
  property color needleColor: "#E74C3C"
  property color tickColor: "#AAAAAA"
  property color labelColor: "#CCCCCC"

  property int majorTickCount: 10
  property int minorTickCount: 4

  property real outerRadius: Math.min(width, height) / 2
  property real needleLength: outerRadius * 0.85
  property real needleWidth: 6

  // ==================== Internal Calculations ====================
  readonly property real angleRange: endAngle - startAngle
  readonly property real normalizedValue: Math.max(0, Math.min(1,
      (value - minValue) / (maxValue - minValue)))

  // ==================== Background Arc ====================
  Shape {
    anchors.fill: parent
    antialiasing: true

    ShapePath {
      strokeColor: root.backgroundColor
      strokeWidth: 14
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: width / 2
        centerY: height / 2
        radiusX: root.outerRadius - 10
        radiusY: root.outerRadius - 10
        startAngle: root.startAngle
        sweepAngle: root.angleRange
      }
    }
  }

  // ==================== Progress Arc ====================
  Shape {
    anchors.fill: parent
    antialiasing: true

    ShapePath {
      strokeColor: root.progressColor
      strokeWidth: 14
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: width / 2
        centerY: height / 2
        radiusX: root.outerRadius - 10
        radiusY: root.outerRadius - 10
        startAngle: root.startAngle
        sweepAngle: root.normalizedValue * root.angleRange
      }
    }
  }

  // ==================== Tick Marks & Labels ====================
  Repeater {
    model: root.majorTickCount + 1

    Item {
      id: majorTick
      property real angle: root.startAngle + (index / root.majorTickCount) * root.angleRange

      x: width / 2
      y: height / 2

      Rectangle {  // Major Tick
        width: 3
        height: 18
        color: root.tickColor
        anchors.horizontalCenter: parent.horizontalCenter
        y: -root.outerRadius + 8
        transformOrigin: Item.Bottom
        rotation: majorTick.angle
      }

      Text {  // Label
        text: Math.round(root.minValue + (index / root.majorTickCount) * (root.maxValue - root.minValue))
        color: root.labelColor
        font.pixelSize: 14
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: -root.outerRadius + 32
        transformOrigin: Item.Center
        rotation: majorTick.angle + 90
      }
    }
  }

  // Minor ticks
  Repeater {
    model: (root.majorTickCount * root.minorTickCount) + 1

    Rectangle {
      visible: index % root.minorTickCount !== 0
      width: 2
      height: 10
      color: root.tickColor
      x: root.width / 2 - 1
      y: root.height / 2 - root.outerRadius + 12
      transformOrigin: Item.Bottom
      rotation: root.startAngle + (index / (root.majorTickCount * root.minorTickCount)) * root.angleRange
    }
  }

  // ==================== Needle ====================
  Item {
    id: needle
    anchors.centerIn: parent
    rotation: root.startAngle + root.normalizedValue * root.angleRange

    Rectangle {  // Needle
      width: root.needleWidth
      height: root.needleLength
      color: root.needleColor
      radius: 3
      anchors.horizontalCenter: parent.horizontalCenter
      y: -root.needleLength + 10
    }

    // Needle hub (center circle)
    Rectangle {
      width: 22
      height: 22
      radius: 11
      color: "#222222"
      border.color: root.needleColor
      border.width: 3
      anchors.centerIn: parent
    }
  }

  // ==================== Center Value Text ====================
  Text {
    anchors.centerIn: parent
    y: 25
    text: root.value.toFixed(0)
    font.pixelSize: 28
    font.bold: true
    color: "white"
  }
}