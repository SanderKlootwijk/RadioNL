import QtQuick 2.9
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3
import "components"

Page {
    id: favoritesPage

    PageHeader {
        id: favoritesPageHeader

        title: i18n.tr("Favorites")
    }

    Row {
        width: parent.width - units.gu(4)
        
        anchors {
            top: favoritesPageHeader.bottom
            topMargin: units.gu(1)
            bottomMargin: units.gu(2)
            horizontalCenter: parent.horizontalCenter
        }
        
        spacing: units.gu(1)

        FavoriteShape {
            slotNumber: "1"
        }

        FavoriteShape {
            slotNumber: "2"
        }

        FavoriteShape {
            slotNumber: "3"
        }

        FavoriteShape {
            slotNumber: "4"
        }
    }
}