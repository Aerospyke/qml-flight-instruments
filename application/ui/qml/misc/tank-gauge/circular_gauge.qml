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

  Component.onCompleted: {
    style.parentGauge = Qt.binding(() => root)
  }

  // ==================== Background ====================
  Loader {
    anchors.fill: parent
    sourceComponent: style.background
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
        radiusX: style.outerRadius - 10
        radiusY: style.outerRadius - 10
        startAngle: style.valueToAngle(0)
        sweepAngle: style.valueToAngle(root.value) - startAngle
      }
    }
  }

  // Minor Tickmarks
  Repeater {
    model: Math.floor((maximumValue - minimumValue) / style.tickmarkStepSize * style.minorTickmarkCount) + 1

    Item {
      property real angle: style.valueToAngle((index * style.tickmarkStepSize) / style.minorTickmarkCount)
      x: root.width / 2
      y: root.height / 2

      anchors.centerIn: root
      property real tick_x_position: (style.outerRadius - 10) * Math.cos(3.14159 / 180 * angle)
      property real tick_y_position: (style.outerRadius - 10) * Math.sin(3.14159 / 180 * angle)

      Loader {
        sourceComponent: style.minorTickmark

        rotation: parent.angle + 90
        x: tick_x_position - width * 0.5
        y: tick_y_position - height * 0.5
      }

      // Fallback, if minor Tickmark not defined
      Rectangle {
        visible: !style.minorTickmark && (index % style.minorTickmarkCount !== 0)
        width: style.minorTickmarkWidth
        height: style.minorTickmarkLength
        color: style.minorTickmarkColor
        anchors.horizontalCenter: parent.horizontalCenter
        y: -style.outerRadius + style.minorTickmarkInset
        transformOrigin: Item.Bottom
        rotation: parent.angle
      }
    }
  }

  // Major Tickmarks
  Repeater {
    model: Math.floor((maximumValue - minimumValue) / style.tickmarkStepSize) + 1
    // model: 12

    Item {
      anchors.centerIn: root
      property real angle: style.valueToAngle(index * style.tickmarkStepSize)
      property real tick_x_position: (style.outerRadius - 10) * Math.cos(3.14159 / 180 * angle)
      property real tick_y_position: (style.outerRadius - 10) * Math.sin(3.14159 / 180 * angle)

      Loader {
        sourceComponent: style.tickmark
        rotation: parent.angle + 90
        x: tick_x_position - width * 0.5
        y: tick_y_position - height * 0.5

      }
    }
  }

  Repeater {
    model: Math.floor((maximumValue - minimumValue) / style.labelStepSize) + 1

    Item {
      id: labelContainer

      property real angleDeg: style.valueToAngle(index * style.labelStepSize)

      property real labelRadius: style.outerRadius - style.labelInset

      property real xPos: root.width / 2 + labelRadius * Math.cos(angleDeg * Math.PI / 180)
      property real yPos: root.height / 2 + labelRadius * Math.sin(angleDeg * Math.PI / 180)

      Loader {
        sourceComponent: style.tickmarkLabel

        // Force property assignment after loading
        onLoaded: {
          item.value = root.minimumValue + index * style.labelStepSize
        }

        x: labelContainer.xPos - width / 2
        y: labelContainer.yPos - height / 2
        rotation: labelContainer.angleDeg + 90
      }
    }
  }

  // Needle (Either explicit style.needle, or fallback rectangle if no style.needle defined)
  Item {
    anchors.centerIn: parent
    rotation: 90.0 + style.valueToAngle(root.value)

    Loader {
      sourceComponent: style.needle
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.verticalCenter
    }

    // Fallback, if no needle style is defined
    Rectangle {
      visible: !style.needle
      width: style.needleWidth
      height: style.needleLength * style.outerRadius
      color: style.needleColor
      radius: 2
      anchors.horizontalCenter: parent.horizontalCenter
      y: -style.needleLength * style.outerRadius + 12
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