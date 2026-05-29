import QtQuick
import QtQuick.Shapes

Item {
  id: root

  // ==================== Core Properties ====================
  property real value: 0
  property real minimumValue: 0
  property real maximumValue: 100
  property real stepSize: 1.0

  property var style: CircularGaugeStyle
  {
  }

  // ==================== Calculated Values ====================
  readonly property real angleRange: style.maximumValueAngle - style.minimumValueAngle
  readonly property real normalizedValue: Math.max(0, Math.min(1,
      (value - minimumValue) / (maximumValue - minimumValue)))

  readonly property real outerRadius: Math.min(width, height) / 2

  // Expose outerRadius to the style object
  Component.onCompleted: {
    style.outerRadius = Qt.binding(function () {
      return root.outerRadius;
    })
  }

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

  // Progress Arc
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

  // Major Tickmarks
  Repeater {
    model: Math.floor((maximumValue - minimumValue) / style.tickmarkStepSize) + 1

    Item {
      property real angle: style.minimumValueAngle + (index * style.tickmarkStepSize) / (maximumValue - minimumValue) * root.angleRange

      x: root.width / 2
      y: root.height / 2

      Loader {
        sourceComponent: style.tickmark
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.tickmarkInset
        rotation: parent.angle
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

  // Labels
  Repeater {
    model: Math.floor((maximumValue - minimumValue) / style.labelStepSize) + 1

    Item {
      property real angle: style.minimumValueAngle + (index * style.labelStepSize) / (maximumValue - minimumValue) * root.angleRange

      x: root.width / 2
      y: root.height / 2

      Loader {
        sourceComponent: style.tickmarkLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: -outerRadius + style.labelInset
        rotation: parent.angle + 90
      }
    }
  }

  // Minor Tickmarks
  Repeater {
    model: Math.floor((maximumValue - minimumValue) / style.tickmarkStepSize * style.minorTickmarkCount) + 1

    Item {
      property real angle: style.minimumValueAngle +
          (index * style.tickmarkStepSize) /
          (style.minorTickmarkCount * (maximumValue - minimumValue)) * root.angleRange

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

  // Needle
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

  // Foreground
  Loader {
    anchors.fill: parent
    sourceComponent: style.foreground
  }
}