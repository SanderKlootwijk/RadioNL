import QtQuick 2.9
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3

Page {
    id: settingsPage

    header: PageHeader {
                id: settingsPageHeader

                title: i18n.tr('Settings')
            }
    
    Scrollbar {
        z: 1
        id: scrollSettings

        flickableItem: flickSettings
        align: Qt.AlignTrailing
    }

    Flickable {
        id: flickSettings

        anchors {
            fill: parent
            topMargin: settingsPageHeader.height
        }

        contentWidth: columnSettings.width
        contentHeight: columnSettings.height
    
        Column {
            id: columnSettings

            width: settingsPage.width

            ListItem {
                id: darkModeListItem

                onClicked: darkModeSwitch.checked ? darkModeSwitch.checked = false : darkModeSwitch.checked = true

                Label {
                    width: parent.width - units.gu(10)

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: units.gu(2)
                    }

                    text: i18n.tr("Dark mode")

                    elide: Text.ElideRight
                }

                Switch {
                    id: darkModeSwitch
                    checked: settings.darkMode
                    onCheckedChanged: settings.darkMode = checked
                    
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: units.gu(2)
                    } 
                }
            }

            ListItem {
                id: autoPlayOnStartListItem

                enabled: settings.source == "empty" ? false : true

                onClicked: autoPlaySwitch.checked ? autoPlaySwitch.checked = false : autoPlaySwitch.checked = true

                Label {
                    width: parent.width - units.gu(10)

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: units.gu(2)
                    }
                    
                    text: i18n.tr("Automatic playback on startup")

                    elide: Text.ElideRight
                }

                Switch {
                    id: autoPlaySwitch
                    checked: settings.autoPlayOnStart
                    onCheckedChanged: settings.autoPlayOnStart = checked
                    
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: units.gu(2)
                    } 
                }
            }

            ListItem {
                id: provinceListItem

                onClicked: pageStack.push(Qt.resolvedUrl("ProvinceSettingsPage.qml"))

                Label {
                    width: parent.width - provinceLabel.width - units.gu(10)

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: units.gu(2)
                    }
                    
                    text: i18n.tr("Province")

                    elide: Text.ElideRight
                }

                Label {
                    id: provinceLabel

                    anchors{
                        verticalCenter: parent.verticalCenter
                        right: nextIcon.left
                        rightMargin: units.gu(1)
                    }
                    
                    text: {
                        if(settings.provinceName == "FirstRun") {
                            i18n.tr("No province set")
                        }
                        else {
                            settings.provinceName
                        }
                    }
                }

                Icon {
                    id: nextIcon

                    height: units.gu(2.5)
                    width: units.gu(2.5)

                    name: 'next'
                    
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: units.gu(2)    
                    }
                }     
            }
        }
    }
}