import QtQuick 2.9
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.11
import "components"

MainView {
    id: root

    width: units.gu(125)
    height: units.gu(85)
    
    objectName: 'mainView'
    applicationName: 'radionl.sanderklootwijk'
    automaticOrientation: true

    property string version: "3.0.0"

    Component.onCompleted: {
        // On first run, with an empty source
        if (settings.source == "empty") {
            connectionTimer.start()
        }
        // Autoplay disabled
        else if (settings.autoPlayOnStart == false) {
            player.source = settings.source
            connectionTimer.start()
        }
        // Autoplay enabled
        else {
            player.source = settings.source
            player.play()
            player.stop()
            reconnectTimer.running = true
            connectionTimer.start()
        }
    }

    // Keyboard controls
    Keys.onSpacePressed: player.playbackState == true ? player.stop() : player.play()

    // App settings
    Settings {
        id: settings

        // Settings
        property bool darkMode: false
        property bool autoPlayOnStart: false
        property string provinceName: "FirstRun"

        // Current station
        property string logo
        property string name
        property string source: "empty"

        //Slot 1
        property string slot1img: ""
        property string slot1text: ""
        property string slot1source: ""

        //Slot 2
        property string slot2img: ""
        property string slot2text: ""
        property string slot2source: ""

        //Slot 3
        property string slot3img: ""
        property string slot3text: ""
        property string slot3source: ""
        
        //Slot 4
        property string slot4img: ""
        property string slot4text: ""
        property string slot4source: ""

        onDarkModeChanged: {
            Theme.name = darkMode ? "Lomiri.Components.Themes.SuruDark" : "Lomiri.Components.Themes.Ambiance"
            bottomEdge.commit()
            bottomEdge.collapse()
        }

        Component.onCompleted: {
            Theme.name = darkMode ? "Lomiri.Components.Themes.SuruDark" : "Lomiri.Components.Themes.Ambiance"
            bottomEdge.commit()
            bottomEdge.collapse()
        }
    }

    // Network check
    Image {
        id: testImg
        anchors.right: parent.left
        source: "https://www.npo3fm.nl/svg/npo_3fm_logo.svg"
    }

    Timer {
        id: connectionTimer
        interval: 1500
        running: false
        repeat: false
        onTriggered: {
            if (testImg.status == Image.Ready) {
                console.log('Yes! Working internet connection.')
                if (connectionPopover.opacity == 1) {
                    connectionPopoverTimer.start()
                }
            }
            else {
                console.log('Oops! No internet connection, trying again.')
                if (connectionPopover.opacity == 0) {
                    connectionPopoverFadeIn.start()
                    player.stop()
                }
                testImg.source = ""
                testImg.source = "https://www.npo3fm.nl/svg/npo_3fm_logo.svg"
                start()
            }
        }
    }    

    // Audio player
    Audio {
        id: player
    }

    // Timer to resume player in case connection is lost
    Timer {
        id: reconnectTimer

        interval: 100
        running: false
        repeat: true

        onTriggered: { if (player.position < 20) { player.pause(), player.play() } }
    }

    PageStack {
        id: pageStack

        anchors {
            fill: parent
            rightMargin: {
                if (root.width < units.gu(115)) {
                    0
                }
                else if (settings.name < 1) {
                    0
                }
                else {
                    units.gu(40)
                }
            }
        }

        Component.onCompleted: push(mainPage)

        Page {
            id: mainPage

            visible: false

            anchors {
                fill: parent
            }

            header: PageHeader {
                        id: mainPageHeader

                        title: i18n.tr("Radio NL")
                        
                        extension: Sections {
                                        id: mainPageHeaderSections

                                        anchors {
                                            left: parent.left
                                            leftMargin: units.gu(2)
                                            bottom: parent.bottom
                                        }

                                        model: [i18n.tr("National"), i18n.tr("Alternative"), i18n.tr("Regional")]

                                        onSelectedIndexChanged: mainPageTabView.currentIndex = selectedIndex
                                    }

                        trailingActionBar {
                            numberOfSlots: 1

                            actions: [
                                Action {
                                    text: i18n.tr("Settings")
                                    iconName: "settings"
                                    onTriggered: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
                                },
                                Action {
                                    text: i18n.tr("About")
                                    iconName: "info"
                                    onTriggered: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                                }
                            ]
                        }
                    }

            // Connection popover
            Rectangle {
                z: 1
                id: connectionPopover

                width: connectionIcon.width + connectionLabel.width + units.gu(4)
                height: units.gu(5)

                anchors {
                    top: mainPageHeader.bottom
                    topMargin: units.gu(2)
                    horizontalCenter: parent.horizontalCenter
                }
                
                opacity: 0
                radius: 15
                color: theme.palette.normal.foreground
                border.width: units.gu(0.1)
                border.color: theme.palette.normal.base

                NumberAnimation on opacity {
                    id: connectionPopoverFadeIn
                    running: false
                    from: 0
                    to: 1
                    duration: LomiriAnimation.SlowDuration
                }

                NumberAnimation on opacity {
                    id: connectionPopoverFadeOut
                    running: false
                    from: 1
                    to: 0
                    duration: LomiriAnimation.SlowDuration
                }

                Timer {
                    id: connectionPopoverTimer
                    interval: 1500
                    running: false
                    repeat: false
                    
                    onTriggered: connectionPopoverFadeOut.start()
                }

                Row {
                    id: connectionPopoverRow

                    anchors.centerIn: parent
                    
                    spacing: units.gu(1)

                    Icon {
                        id: connectionIcon

                        width: units.gu(3)
                        height: units.gu(3)
                        
                        anchors.verticalCenter: parent.verticalCenter
                        
                        name: testImg.status == Image.Ready ? "wifi-full" : "wifi-no-connection"
                    }

                    Label {
                        id: connectionLabel

                        anchors.verticalCenter: parent.verticalCenter

                        text: testImg.status == Image.Ready ? i18n.tr("You are back online") : i18n.tr("You appear to be offline")
                    }
                }
            }

            VisualItemModel {
                id: mainPageTabs

                TabNational {
                    width: mainPageTabView.width
                    height: mainPageTabView.height
                }

                TabAlternative {
                    width: mainPageTabView.width
                    height: mainPageTabView.height
                }

                TabRegional {
                    width: mainPageTabView.width
                    height: mainPageTabView.height
                }
            }

            ListView {
                id: mainPageTabView

                anchors {
                    fill: parent
                    topMargin: mainPageHeader.height
                    bottomMargin: {
                        if (settings.name < 1) {
                            0
                        }
                        else if (root.width > units.gu(115)) {
                            bottomEdgeItem.height - units.gu(0.1)
                        }
                        else {
                            bottomMenu.height + bottomEdgeItem.height - units.gu(0.1)
                        }
                    }
                }

                model: mainPageTabs

                currentIndex: 0

                orientation: Qt.Horizontal

                snapMode: ListView.SnapOneItem

                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightMoveDuration: LomiriAnimation.FastDuration

                onCurrentIndexChanged: mainPageHeaderSections.selectedIndex = currentIndex

                clip: true
            }

            BottomMenu {
                id: bottomMenu

                visible: {
                    if (settings.name < 1) {
                        false
                    }
                    else if (root.width < units.gu(115)) {
                        true
                    }
                    else {
                        false
                    }
                }

                anchors {
                    bottom: parent.bottom
                    bottomMargin: units.gu(4)
                }
            }

            Item {
                id: bottomEdgeItem
                
                width: parent.width
                height: units.gu(4)
                
                anchors.bottom: parent.bottom

                visible: if(settings.name < 1) { false } else { true }

                // Put grey line on top of bottomEdgeItem
                Rectangle {
                    width: parent.width
                    height: units.gu(0.1)
                    color: theme.palette.normal.base
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: bottomEdge.commit()
                }
            }

            BottomEdge {
                id: bottomEdge

                visible: bottomEdgeItem.visible

                height: {
                    if (root.width < units.gu(65)) {
                        parent.width / 4 + units.gu(7)
                    }
                    else {
                        units.gu(18)
                    }
                }

                hint.iconName: "go-up"

                contentComponent: FavoritesPage {
                                        width: root.width
                                        height: root.height
                                    }
            }
        }
    }

    PlayerPage {
        id: playerPage

        visible: {
            if (root.width < units.gu(115)) {
                false
            }
            else if (settings.name < 1) {
                false
            }
            else {
                true
            }
        }

        height: parent.height
        width: units.gu(40)

        anchors.left: pageStack.right
    }
}
