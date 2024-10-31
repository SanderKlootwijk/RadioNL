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
                id: themeTitle

                height: units.gu(6.25)

                divider.colorFrom: theme.palette.normal.background
                divider.colorTo: theme.palette.normal.background

                Label {
                    id: themeTitleLabel
                    width: parent.width - units.gu(4)

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: units.gu(1.25)
                        left: parent.left
                        leftMargin: units.gu(2)
                    }
                    
                    text: i18n.tr("Theme") + ":"

                    elide: Text.ElideRight
                }
            }

            ListItem {
                id: themeListItem

                height: themeOptionSelector.height + units.gu(2)

                OptionSelector {
                    id: themeOptionSelector

                    width: parent.width - units.gu(4)

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                    }

                    model: [i18n.tr("System"), "Ambiance", "Suru Dark"]

                    onSelectedIndexChanged: settings.theme = selectedIndex

                    Component.onCompleted: selectedIndex = settings.theme
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