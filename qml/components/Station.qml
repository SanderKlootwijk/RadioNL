import QtQuick 2.9
import Lomiri.Components 1.3

ListItem {
    id: station

    height: units.gu(9)

    property string logo
    property string name
    property string subText
    property string source

    onClicked: {
        if (player.source == station.source) {
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
        else {
            player.source = source
            
            settings.name = name
            settings.logo = logo
            settings.source = source

            player.play()
            player.stop()
            reconnectTimer.running = true
        }
    }

    LomiriShape {
        id: logoShape
        height: units.gu(7)
        width: units.gu(7)

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        // Put radio station logo in LomiriShape
        source: Image {
                    source: logo
                }

        aspect: LomiriShape.Inset
    }

    // Put labels and icon in a 'box'
    Item {
        width: parent.width - units.gu(11)
        height: units.gu(4.5)

        anchors {
            left: logoShape.right
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        Label {
            width: parent.width - logoShape.width - startIcon.width

            anchors {
                left: parent.left
                top: parent.top
            }

            text: name

            elide: Text.ElideRight
            font.bold: true
        }

        Label {
            width: parent.width - logoShape.width - startIcon.width

            anchors {
                left: parent.left
                bottom: parent.bottom
            }

            text: subText

            elide: Text.ElideRight
            maximumLineCount: 1
        }

        Icon {
            id: startIcon

            width: units.gu(3)
            height: units.gu(3)

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: units.gu(2)
            }

            name: {
                if (player.source == station.source) {
                    player.playbackState == true ? "media-playback-stop" : "media-playback-start"
                }
                else {
                    "media-playback-start"
                }
            }
        }
    }
}