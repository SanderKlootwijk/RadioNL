import QtQuick 2.9
import QtGraphicalEffects 1.0
import Lomiri.Components 1.3

Item {
    id: favoriteShape

    width: {
        if (root.width < units.gu(65)){
            parent.width / 4 - units.gu(0.8)
        }
        else {
            units.gu(10)
        }
    }
    height: width

    property string slotNumber

    LomiriShape {
        anchors.fill: parent

        backgroundColor: theme.palette.normal.base

        source: Image {
                    source: settings["slot" + slotNumber + "img"]
                }  
    
        states: State {
            name: "pressed"; when: mouseArea.pressed
            PropertyChanges { target: favoriteShape; scale: 1.03 }
        }

        transitions: Transition {
            NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
        }

        Label {
            id: helpLabel

            width: parent.width - units.gu(1)

            anchors.centerIn: parent

            visible: settings["slot" + slotNumber + "source"] == ""

            text: i18n.tr("Long press to add station...")

            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            textSize: Label.Small
        }

        MouseArea {
            id: mouseArea
            
            anchors.fill: parent

            onClicked: {
                if (settings["slot" + slotNumber + "source"] == "") {
                    // Do nothing
                }
                else {
                    player.source = settings["slot" + slotNumber + "source"]
                    player.play()
                    player.stop()
                    reconnectTimer.running = true

                    settings.name = settings["slot" + slotNumber + "text"]
                    settings.logo = settings["slot" + slotNumber + "img"]
                    settings.source = settings["slot" + slotNumber + "source"]
                }
            }

            onPressAndHold: {
                if (settings.source == "empty") {
                    // Do nothing
                }
                else {
                    settings["slot" + slotNumber + "text"] = settings.name
                    settings["slot" + slotNumber + "img"] = settings.logo
                    settings["slot" + slotNumber + "source"] = settings.source
                }
            }         
        }
    }
}