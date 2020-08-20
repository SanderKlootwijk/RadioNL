import QtQuick 2.9
import Ubuntu.Components 1.3

ListItem {
  id: zenderDivider

  height: units.gu(5)

  property alias text: text.text

  Label {
    id: text

    anchors {
      centerIn: parent
    }
  }
}
