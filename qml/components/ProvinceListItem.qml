import QtQuick 2.9
import Lomiri.Components 1.3

ListItem {
    id: provinceListItem

    height: units.gu(5)

    property string province

    Label {
        anchors{
            verticalCenter: parent.verticalCenter
    
            left: parent.left
            leftMargin: units.gu(2)
        }

        text: province
    }

    Icon {
        height: units.gu(2)
        width: units.gu(2)

        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.gu(2)    
        }

        visible: settings.provinceName == province

        name: 'toolkit_tick'
    }
    
    onClicked: settings.provinceName = province
}