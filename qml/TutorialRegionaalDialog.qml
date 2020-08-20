import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Component {
  id: aboutDialog

  Dialog {
    signal closed();
    id: dialogue
    title: "Instellingen"

    Component.onCompleted: {
      selector.selectedIndex = -1
    }

    Label {
      width: parent.width
      wrapMode: Text.Wrap
      text: "Kies hieronder uw regio uit. U kunt uw keuze later aanpassen in de instellingen."
    }

    OptionSelector {
      id: selector
      expanded: true
      containerHeight: parent.height * 0.75
      anchors.horizontalCenter: parent.horizontalCenter
      model: ["Friesland","Groningen","Drenthe","Overijssel","Flevoland","Gelderland","Utrecht","Noord-Holland","Zuid-Holland","Zeeland","Noord-Brabant", "Limburg"]
      onSelectedIndexChanged: {
        switch(selector.selectedIndex) {
        case 0: {
          if (settings.frivisible == "false") {
            settings.frivisible = "true"
            settings.gevisible = "false"
            settings.utvisible = "false"
            settings.zeevisible = "false"
            settings.nohovisible = "false"
            settings.grovisible = "false"
            settings.drenvisible = "false"
            settings.overvisible = "false"
            settings.flevisible = "false"
            settings.zuhovisible = "false"
            settings.bravisible = "false"
            settings.limvisible = "false"
            settings.selectedIndex = "0"
            selector.containerHeight = units.gu(5)
            button.ready = true
          }
          break;
        }
      case 1: {
        if (settings.grovisible == "false") {
          settings.frivisible = "false"
          settings.gevisible = "false"
          settings.utvisible = "false"
          settings.zeevisible = "false"
          settings.nohovisible = "false"
          settings.grovisible = "true"
          settings.drenvisible = "false"
          settings.overvisible = "false"
          settings.flevisible = "false"
          settings.zuhovisible = "false"
          settings.bravisible = "false"
          settings.limvisible = "false"
          settings.selectedIndex = "1"
          selector.containerHeight = units.gu(5)
          button.ready = true
        }
        break;
      }
    case 2: {
      if (settings.drenvisible == "false") {
        settings.frivisible = "false"
        settings.gevisible = "false"
        settings.utvisible = "false"
        settings.zeevisible = "false"
        settings.nohovisible = "false"
        settings.grovisible = "false"
        settings.drenvisible = "true"
        settings.overvisible = "false"
        settings.flevisible = "false"
        settings.zuhovisible = "false"
        settings.bravisible = "false"
        settings.limvisible = "false"
        settings.selectedIndex = "2"
        selector.containerHeight = units.gu(5)
        button.ready = true
      }
      break;
    }
  case 3: {
    if (settings.overvisible == "false") {
      settings.frivisible = "false"
      settings.gevisible = "false"
      settings.utvisible = "false"
      settings.zeevisible = "false"
      settings.nohovisible = "false"
      settings.grovisible = "false"
      settings.drenvisible = "false"
      settings.overvisible = "true"
      settings.flevisible = "false"
      settings.zuhovisible = "false"
      settings.bravisible = "false"
      settings.limvisible = "false"
      settings.selectedIndex = "3"
      selector.containerHeight = units.gu(5)
      button.ready = true
    }
    break;
  }
case 4: {
  if (settings.flevisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "false"
    settings.zeevisible = "false"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "true"
    settings.zuhovisible = "false"
    settings.bravisible = "false"
    settings.limvisible = "false"
    settings.selectedIndex = "4"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 5: {
  if (settings.gevisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "true"
    settings.utvisible = "false"
    settings.zeevisible = "false"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "false"
    settings.bravisible = "false"
    settings.limvisible = "false"
    settings.selectedIndex = "5"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 6: {
  if (settings.utvisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "true"
    settings.zeevisible = "false"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "false"
    settings.bravisible = "false"
    settings.limvisible = "false"
    settings.selectedIndex = "6"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 7: {
  if (settings.nohovisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "false"
    settings.zeevisible = "false"
    settings.nohovisible = "true"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "false"
    settings.bravisible = "false"
    settings.limvisible = "false"
    settings.selectedIndex = "7"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 8: {
  if (settings.zuhovisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "false"
    settings.zeevisible = "false"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "true"
    settings.bravisible = "false"
    settings.limvisible = "false"
    settings.selectedIndex = "8"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 9: {
  if (settings.zeevisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "false"
    settings.zeevisible = "true"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "false"
    settings.bravisible = "false"
    settings.limvisible = "false"
    settings.selectedIndex = "9"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 10: {
  if (settings.bravisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "false"
    settings.zeevisible = "false"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "false"
    settings.bravisible = "true"
    settings.limvisible = "false"
    settings.selectedIndex = "10"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
case 11: {
  if (settings.limvisible == "false") {
    settings.frivisible = "false"
    settings.gevisible = "false"
    settings.utvisible = "false"
    settings.zeevisible = "false"
    settings.nohovisible = "false"
    settings.grovisible = "false"
    settings.drenvisible = "false"
    settings.overvisible = "false"
    settings.flevisible = "false"
    settings.zuhovisible = "false"
    settings.bravisible = "false"
    settings.limvisible = "true"
    settings.selectedIndex = "11"
    selector.containerHeight = units.gu(5)
    button.ready = true
  }
  break;
}
}
}
}



Button {
  id: button
  width: parent.width

  property var ready: false

  text: {
    if (button.ready == false) {
      "Annuleren"
    }
    else {
      "Sluiten"
    }
  }
  color: theme.palette.normal.activity

  onClicked: {
    if (button.ready == false) {
      scrollLandelijk.visible = true
      flickLandelijk.state = "landelijk"
      flickRegionaal.state = "landelijk"
      scrollRegionaal.visible = false
      settingsAction.visible = false
      sections.selectedIndex = 0
      PopupUtils.close(dialogue);
      closed();
    }
    else {
      settings.tutorialRegionaal = "false"
      PopupUtils.close(dialogue);
      closed();
    }
  }
}
}
}
