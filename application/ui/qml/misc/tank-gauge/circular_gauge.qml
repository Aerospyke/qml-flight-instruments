import QtQuick
import QtQuick.Shapes

Item {
  id: root

  // ==================== Core Properties (Original API) ====================
  property real value: 0
  property real minimumValue: 0
  property real maximumValue: 100
  property real stepSize: 1.0          // Added - original property

  // Style
  property var style: CircularGaugeStyle
  {
  }

  // ==================== Calculated Values ====================
  readonly property real angleRange: style.maximumValueAngle - style.minimumValueAngle
  readonly property real normalizedValue: Math.max(0, Math.min(1,
      (value - minimumValue) / (maximumValue - minimumValue)))

  readonly property real outerRadius: Math.min(width, height) / 2

  // ==================== Background ====================
  Loader {
    anchors.fill: parent
    sourceComponent: style.background
  }

  // Background Arc (fallback)
  Shape {
    anchors.fill: parent
    antialiasing: true
    visible: !style.background

    ShapePath {
      strokeColor: style.backgroundColor
      strokeWidth: style.backgroundThickness
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: width / 2
        centerY: height / 2
        radiusX: outerRadius - 10
        radiusY: outerRadius - 10
        startAngle: style.minimumValueAngle
        sweepAngle: root.angleRange
      }
    }
  }

  // ==================== Progress Arc ====================
  Shape {
    anchors.fill: parent
    antialiasing: true
    visible: style.progressThickness > 0

    ShapePath {
      strokeColor: style.progressColor
      strokeWidth: style.progressThickness
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: width / 2
        centerY: height / 2
        radiusX: outerRadius - 10
        radiusY: outerRadius - 10
        startAngle: style.minimumValueAngle
        sweepAngle: root.normalizedValue * root.angleRange
      }
    }
  }

  // ==================== Major Tickmarks ====================
  Repeater {
    model: Math.floor((root.maximumValue - root.minimumValue) / style.tickmarkStepSize) + 1

    Item {
      property real angle: style.minimumValueAngle +
          (index * style.tickmarkStepSize) /
          (root.maximumValue - root.minimumValue) * root.angleRange
      property real labelValue: root.minimumValue + index * style.tickmarkStepSize

      x: root.width / 2
      y: root.height / 2

      Loader {
        sourceComponent: style.tickmark
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.tickmarkInset
        rotation: parent.angle
        property int index: model.index
        property real value: parent.labelValue
      }

      Rectangle {
        visible: !style.tickmark
        width: style.majorTickmarkWidth
        height: style.majorTickmarkLength
        color: style.tickmarkColor
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.tickmarkInset
        transformOrigin: Item.Bottom
        rotation: parent.angle
      }
    }
  }

  // ==================== Labels ====================
  Repeater {
    model: Math.floor((root.maximumValue - root.minimumValue) / style.labelStepSize) + 1

    Item {
      property real angle: style.minimumValueAngle +
          (index * style.labelStepSize) /
          (root.maximumValue - root.minimumValue) * root.angleRange
      property real labelValue: root.minimumValue + index * style.labelStepSize

      x: root.width / 2
      y: root.height / 2

      Loader {
        sourceComponent: style.tickmarkLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.labelInset
        rotation: parent.angle + 90
        property int index: model.index
        property real value: parent.labelValue
      }
    }
  }

  // ==================== Minor Tickmarks ====================
  Repeater {
    model: Math.floor((root.maximumValue - root.minimumValue) / style.tickmarkStepSize * style.minorTickmarkCount) + 1

    Item {
      property real angle: style.minimumValueAngle +
          (index * style.tickmarkStepSize) /
          (style.minorTickmarkCount * (root.maximumValue - root.minimumValue)) *
          root.angleRange

      x: root.width / 2
      y: root.height / 2

      Loader {
        sourceComponent: style.minorTickmark
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.minorTickmarkInset
        rotation: parent.angle
      }

      Rectangle {
        visible: !style.minorTickmark && (index % style.minorTickmarkCount !== 0)
        width: style.minorTickmarkWidth
        height: style.minorTickmarkLength
        color: style.minorTickmarkColor
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.minorTickmarkInset
        transformOrigin: Item.Bottom
        rotation: parent.angle
      }
    }
  }

  // ==================== Needle ====================
  Item {
    anchors.centerIn: parent
    rotation: style.minimumValueAngle + root.normalizedValue * root.angleRange

    Loader {
      sourceComponent: style.needle
      anchors.horizontalCenter: parent.horizontalCenter
      y: style.needleYOffset !== undefined ? style.needleYOffset : -outerRadius * 0.75
    }

    Rectangle {
      visible: !style.needle
      width: style.needleWidth
      height: style.needleLength * outerRadius
      color: style.needleColor
      radius: 2
      anchors.horizontalCenter: parent.horizontalCenter
      y: -style.needleLength * outerRadius + 12
    }

    Rectangle {  // Hub
      width: 26
      height: 26
      radius: 13
      color: "#1e1e1e"
      border.color: style.needleColor
      border.width: 3
      anchors.centerIn: parent
    }
  }

  // Value Text
  Text {
    anchors.centerIn: parent
    y: style.valueTextYOffset
    text: style.valueText(root.value)
    font.pixelSize: style.valueFontSize
    font.bold: true
    color: style.valueTextColor
  }

  Loader {
    anchors.fill: parent
    sourceComponent: style.foreground
  }
}