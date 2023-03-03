import QtQuick 2.9
import Lomiri.Components 1.3

Item {
    id: bottomMenu

    width: parent.width
    height: units.gu(9)

    // Grey line on top of bottomMenu

    Rectangle {
        z: 10
        width: parent.width
        height: units.gu(0.1)
        color: theme.palette.normal.base
    }

    LomiriShape {
        id: bottomMenuShape
        height: units.gu(7)
        width: height

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        // Put radio station logo in LomiriShape
        source: Image {
                    source: settings.logo
                }

        aspect: LomiriShape.Inset
    }

    // Put labels and icon in a 'box'
    Item {
        width: parent.width - units.gu(11)
        height: units.gu(4.5)

        anchors {
            left: bottomMenuShape.right
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        Label {
            width: parent.width - bottomMenuShape.width - playerIcon.width

            anchors {
                left: parent.left
                top: parent.top
            }

            text: i18n.tr("Now playing")

            elide: Text.ElideRight
            font.bold: true
        }

        Label {
            width: parent.width - bottomMenuShape.width - playerIcon.width

            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            text: settings.name

            elide: Text.ElideRight
        }

        Icon {
            id: playerIcon

            width: units.gu(3)
            height: units.gu(3)

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: units.gu(2)
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