import QtQuick 2.9
import Lomiri.Components 1.3

ListItem {
    id: stationDivider

    height: units.gu(5)

    property alias text: stationDividerLabel.text

    Label {
        id: stationDividerLabel

        anchors.centerIn: parent
    }
}