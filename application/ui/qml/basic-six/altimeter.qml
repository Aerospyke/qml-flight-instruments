import QtQuick 2.0

Item {
  width: 2 * radius
  height: 2 * radius

  required property double radius
  property double altitude: 0
  property double pressure: 28

  CustomImageBasicSix {
    anchors.fill: parent
    source: "qrc:/images/alt_face_1.svg"
    rotation: {
      let value = pressure

      if (value < 28.0)
        value = 28.0
      else if (value > 31.5)
        value = 31.5

      return (value - 28.0) * 100.0
    }
  }

  CustomImageBasicSix {
    anchors.fill: parent
    source: "qrc:/images/alt_face_2.svg"
  }

  CustomImageBasicSix {
    anchors.fill: parent
    source: "qrc:/images/alt_face_3.svg"
    rotation: 0.0036 * altitude
  }

  CustomImageBasicSix {
    anchors.fill: parent
    source: "qrc:/images/alt_hand_1.svg"
    rotation: 0.036 * altitude
  }

  CustomImageBasicSix {
    anchors.fill: parent
    source: "qrc:/images/alt_hand_2.svg"
    rotation: 0.36 * (altitude % 1000)
  }

  CustomImageBasicSix {
    anchors.fill: parent
    source: "qrc:/images/alt_case.svg"
  }
}
