import QtQuick 2.9
import Ubuntu.Components 1.3

ListItem {
  id: zenderLandelijk

  height: units.gu(9)

  property alias logo: logo.source
  property alias naam: naam.text
  property alias subText: subText.text
  property alias bron: bron.text
  property alias achtergrond: background.source

  UbuntuShape {
    id: logoShape
    height: units.gu(7)
    width: height

    anchors {
      left: parent.left
      leftMargin: units.gu(1)
      verticalCenter: parent.verticalCenter
    }

    // Put radio station logo in UbuntuShape
    source: Image {
      id: logo
    }

    aspect: UbuntuShape.Inset
  }

  // Put labels in a 'box'

  Item {
    width: parent.width - units.gu(9)
    height: units.gu(4.5)

    anchors {
      left: logoShape.right
      leftMargin: units.gu(1)
      verticalCenter: parent.verticalCenter
    }
    Label {
      id: naam
      font.bold: true

      anchors {
        left: parent.left
        top: parent.top
      }
    }

    Label {
      id: subText

      width: parent.width - logoShape.width - startIcon.width

      maximumLineCount: 1

      elide: Text.ElideRight

      anchors {
        left: parent.left
        bottom: parent.bottom
      }
    }
  }

  Text {
    id: bron
    visible: false
  }

  Icon {
    z: 3
    id: startIcon
    width: units.gu(3)
    height: width
    anchors {
      verticalCenter: parent.verticalCenter
      right: parent.right
      rightMargin: units.gu(3)
    }

    name: {
      if (player.playbackState == true) {
        if (playerText.text == naam.text) {
          "media-playback-stop"
        }
        else {
          "media-playback-start"
        }
      }
      else {
        "media-playback-start"
      }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: {
        if (player.playbackState == true) {
          if (playerText.text == naam.text) {
            player.stop()
          }
          else {
            player.stop()
            player.source = bron.text
            settings.source = bron.text
            player.play()
            playerText.text = naam.text
            settings.text = naam.text
            bottomIMG.source = logo.source
            settings.image = logo.source
          }
        }
        else {
          player.stop()
          player.source = bron.text
          settings.source = bron.text
          player.play()
          playerText.text = naam.text
          settings.text = naam.text
          bottomIMG.source = logo.source
          settings.image = logo.source
        }
      }
    }
  }

  Rectangle {
    visible: false
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
      visible: false
      width: parent.width
      height: parent.height
      fillMode: Image.PreserveAspectCrop
      smooth: true
      z: parent.z + 1
      opacity: 0.8
    }
  }
}
