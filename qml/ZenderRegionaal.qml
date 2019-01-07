import QtQuick 2.4
import Ubuntu.Components 1.3

Rectangle {
  id: zenderRegionaal
  width: parent.width
  height: bottomMenu.height * 1.5
  color: "transparent"

  property alias logo: logo.source
  property alias naam: naam.text
  property alias bron: bron.text
  property alias achtergrond: background.source

  Image {
    id: logo
    z: 3
    height: parent.height
    width: parent.height
    anchors {
      left: parent.left
      bottom: parent.bottom
    }
  }

  Text {
    id: naam
    visible: false
  }

  Text {
    id: bron
    visible: false
  }

  Icon {
    z: 3
    width: bottomMenu.height / 1.5
    height: bottomMenu.height / 1.5
    anchors {
      verticalCenter: parent.verticalCenter
      right: parent.right
      rightMargin: units.gu(3)
    }
    color: "white"
    name: "media-playback-start"

    MouseArea {
      anchors.fill: parent
      onClicked: {
        player.stop()
        player.source = bron.text
        settings.source = bron.text
        player.play()
        playerIcon.name = "media-playback-stop"
        playerText.text = naam.text
        settings.text = naam.text
        bottomIMG.source = logo.source
        settings.image = logo.source
      }
    }
  }

  Rectangle {
    z: 1
    width: parent.width - parent.height
    height: parent.height
    anchors{
      right: parent.right
      bottom: parent.bottom
    }
    color: "grey"

    Image {
      id: background
      width: parent.width
      height: parent.height
      fillMode: Image.PreserveAspectCrop
      smooth: true
      z: parent.z + 1
      opacity: 0.8
    }
  }
}
