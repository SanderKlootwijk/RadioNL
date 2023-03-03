import QtQuick 2.9
import QtGraphicalEffects 1.0
import Lomiri.Components 1.3

Page {
    id: playerPage

    width: units.gu(40)

    header: PageHeader {
              id: playerPageHeader

              title: i18n.tr("Now playing")
            }

    // Grey line left to playerPage

    Rectangle {
        z: 10
        width: units.gu(0.1)
        height: parent.height
        color: theme.palette.normal.base
    }

    Image {
      id: playerPageImage

      width: parent.width
      height: width

      anchors {
          horizontalCenter: parent.horizontalCenter
          top: playerPageHeader.bottom
      }

      source: settings.logo + "_large.jpg"
    }

    FastBlur {      
      anchors.fill: playerPageImage

      source: playerPageImage
      radius: 32
    }

    Image {
      width: playerPageImage.width / 1.8
      height: width

      anchors.centerIn: playerPageImage

      source: settings.logo + "_large.jpg"
    }


    // Put labels and icon in a 'box'
    Item {
        width: parent.width - units.gu(4)

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: playerPageImage.bottom
            bottom: parent.bottom
        }

        Label {
            width: parent.width - units.gu(4)

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: stationLabel.top
            }

            text: i18n.tr("Now playing")

            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
        }

        Label {
            id: stationLabel
            width: parent.width - units.gu(4)

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: playerIcon.top
                bottomMargin: units.gu(2)
            }

            text: settings.name

            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        }

        Icon {
            id: playerIcon

            width: units.gu(3)
            height: units.gu(3)

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            name: player.playbackState == true ? "media-playback-stop" : "media-playback-start"

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    onClicked: {
                        if (player.playbackState == true) {
                        player.stop()
                        reconnectTimer.running = false
                        }
                        else {
                        player.play()
                        player.stop()
                        reconnectTimer.running = true
                        }
                    }
                }
            }
        }

        // Buffer rectangle. If the audio player is loading, the ActivityIndicator will show
        Rectangle {
          z: 1
          id: bufferRectangle

          width: units.gu(3)
          height: width

          visible: {
            if (player.playbackState == true) {
              if (player.position < 20) {
                true
              }
              else {
                false
              }
            }
            else {
              false
            }
          }

          anchors {
            centerIn: playerIcon
          }

          color: theme.palette.normal.background

          ActivityIndicator {
            running: true
            anchors.fill: parent
          }
        }
    }
}