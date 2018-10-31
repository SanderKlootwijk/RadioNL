import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtMultimedia 5.0
import Qt.labs.settings 1.0

MainView {
  id: root
  objectName: 'mainView'
  applicationName: 'radionl.sanderklootwijk'
  automaticOrientation: true

  width: units.gu(45)
  height: units.gu(75)

  Image {
    id: testImg
    anchors.right: parent.left
    source: "https://www.npo3fm.nl/templates/npo3fm/images/logo-npo3fm.png"
    onStatusChanged: if (testImg.status == Image.Ready) console.log('TestImg is loaded!')
  }

  Timer {
    id: delaytimer
    interval: 2500
    running: false
    repeat: false
    onTriggered: {
      if (loaded.text == 'Not loaded'){
        PopupUtils.open(noConnectionDialog)
        console.log('Oops! No internet connection.')
      }
      else{
        console.log('Yes! Working internet connection.')
      }
    }
  }

  Text {
    id: loaded
    visible: false
    text: testImg.status == Image.Ready ? 'Loaded' : 'Not loaded'
    Component.onCompleted: {
      delaytimer.start()
      console.log('hello!')
    }
  }

  Page {
    id: mainPage

    header: PageHeader {
      id: header
      title: i18n.tr("Radio NL")
      opacity: 1

      ActionBar {
        anchors.right: parent.right
        numberOfSlots: 1
        actions: [
        Action {
          id: settingsAction
          text: i18n.tr("Instellingen")
          iconName: "settings"
          onTriggered: openSettingsDialog()
        },
        Action {
          id: themeAction
          text: {
            if (settings.theme == "Ambiance"){
              "Nachtmodus"

            }
            else {
              "Dagmodus"
            }
          }
          iconSource: {
            if (settings.theme == "Ambiance"){
              "img/night-mode.svg"

            }
            else {
              "img/day-mode.svg"
            }
          }
          onTriggered: {
            if (settings.theme == "Ambiance"){
              Theme.name = "Ubuntu.Components.Themes.SuruDark"
              settings.theme = "SuruDark"
            }
            else {
              Theme.name = "Ubuntu.Components.Themes.Ambiance"
              settings.theme = "Ambiance"
            }
          }
        },
        Action {
          id: helpAction
          text: i18n.tr("Help")
          iconName: "help"
          onTriggered: {
            PopupUtils.open(tutorialMainDialog)
          }
        }
        ]
      }

      extension: Sections {
        id: sections
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
        }

        actions: [
        Action {
          text: i18n.tr("Landelijk")
          onTriggered: {
            settingsAction.visible = false
          }
        },
        Action {
          text: i18n.tr("Alternatief")
          onTriggered: {
            settingsAction.visible = false
          }
        },
        Action {
          text: i18n.tr("Regionaal")
          onTriggered: {
            if (settings.tutorialRegionaal == "true"){
              openTutorialRegionaalDialog()
              settingsAction.visible = true
            }
            else{
              settingsAction.visible = true
            }
          }
        }
        ]
        onSelectedIndexChanged: {
          tabView.currentIndex = selectedIndex
        }

      }
    }

    Settings {
      id: settings
      property string source: ""
      property string image: ""
      property string text: ""
      property string tutorialRegionaal: "true"
      property string gevisible: "false"
      property string utvisible: "false"
      property string zeevisible: "false"
      property string nohovisible: "false"
      property string frivisible: "false"
      property string grovisible: "false"
      property string drenvisible: "false"
      property string overvisible: "false"
      property string flevisible: "false"
      property string zuhovisible: "false"
      property string bravisible: "false"
      property string limvisible: "false"
      property string selectedIndex: ""
      property string theme: "Ambiance"
    }

    Component.onCompleted: {
      Theme.name = "Ubuntu.Components.Themes." + settings.theme
      player.source = settings.source
      bottomIMG.source = settings.image
      playerText.text = settings.text
    }

    VisualItemModel {
      id: tabs

      Item {
        id: landelijkPage
        width: tabView.width
        height: tabView.height

        Scrollbar {
          z: 1
          id: scrollLandelijk
          visible: true
          flickableItem: flickLandelijk
          align: Qt.AlignTrailing
        }

        Flickable {
          id: flickLandelijk
          width: parent.width
          height: parent.height - bottomMenu.height
          anchors {
            right: parent.right
            bottom: bottomMenu.top
          }
          contentWidth: zendersLandelijkColumn.width
          contentHeight: zendersLandelijkColumn.height

          Column {
            id: zendersLandelijkColumn
            width: mainPage.width

            /* NPO ZENDERS */

            ZenderLandelijk {
              naam: "NPO Radio 1"
              logo: "img/nporadio1.jpg"
              achtergrond: "img/nporadio1back.jpg"
              bron: "http://icecast.omroep.nl/radio1-bb-mp3"
            }

            ZenderLandelijk {
              naam: "NPO Radio 2"
              logo: "img/nporadio2.jpg"
              achtergrond: "img/nporadio2back.jpg"
              bron: "http://icecast.omroep.nl/radio2-bb-mp3"
            }

            ZenderLandelijk {
              naam: "NPO 3FM"
              logo: "img/npo3fm.jpg"
              achtergrond: "img/npo3fmback.jpg"
              bron: "http://icecast.omroep.nl/3fm-bb-mp3"
            }

            ZenderLandelijk {
              naam: "NPO Radio 4"
              logo: "img/nporadio4.jpg"
              achtergrond: "img/nporadio4back.jpg"
              bron: "http://icecast.omroep.nl/radio4-bb-mp3"
            }

            ZenderLandelijk {
              naam: "NPO Radio 5"
              logo: "img/nporadio5.jpg"
              achtergrond: "img/nporadio5back.jpg"
              bron: "http://icecast.omroep.nl/radio5-bb-mp3"
            }

            /* EINDE NPO ZENDERS */

            Rectangle {
              color: "transparent"
              height: units.gu(2)
              width: parent.width
            }

            /* COMMERCIEEL */

            ZenderLandelijk {
              naam: "Q-music"
              logo: "img/qmusic.jpg"
              achtergrond: "img/qmusicback.jpg"
              bron: "http://icecast-qmusic.cdp.triple-it.nl/Qmusic_nl_live_96.mp3"
            }

            ZenderLandelijk {
              naam: "Radio 538"
              logo: "img/radio538.jpg"
              achtergrond: "img/radio538back.jpg"
              bron: "http://18973.live.streamtheworld.com/RADIO538.mp3"
            }

            ZenderLandelijk {
              naam: "Sky Radio"
              logo: "img/skyradio.jpg"
              achtergrond: "img/skyradioback.jpg"
              bron: "http://playerservices.streamtheworld.com/api/livestream-redirect/SKYRADIO.mp3"
            }

            ZenderLandelijk {
              naam: "Radio 10"
              logo: "img/radio10.jpg"
              achtergrond: "img/radio10back.jpg"
              bron: "http://20853.live.streamtheworld.com/RADIO10.mp3"
            }

            ZenderLandelijk {
              naam: "Radio Veronica"
              logo: "img/radioveronica.jpg"
              achtergrond: "img/radioveronicaback.jpg"
              bron: "http://19993.live.streamtheworld.com/VERONICA.mp3"
            }

            ZenderLandelijk {
              naam: "100% NL"
              logo: "img/100pnl.jpg"
              achtergrond: "img/100pnlback.jpg"
              bron: "http://stream.100p.nl/100pctnl.mp3"
            }

            ZenderLandelijk {
              naam: "SLAM!"
              logo: "img/slam.jpg"
              achtergrond: "img/slamback.jpg"
              bron: "https://stream.slam.nl/slam_mp3"
            }

            /* EINDE COMMERCIEEL */

          }
        }
      }

      Item {
        id: alternatiefPage
        width: tabView.width
        height: tabView.height

        Scrollbar {
          z: 1
          id: scrollAlternatief
          visible: true
          flickableItem: flickAlternatief
          align: Qt.AlignTrailing
        }

        Flickable {
          id: flickAlternatief
          width: parent.width
          height: parent.height - bottomMenu.height
          anchors {
            right: parent.right
            bottom: bottomMenu.top
          }
          contentWidth: zendersAlternatiefColumn.width
          contentHeight: zendersAlternatiefColumn.height

          Column {
            id: zendersAlternatiefColumn
            width: mainPage.width
            //spacing: units.gu(1)

            /* ALTERNATIEF */

            ZenderLandelijk {
              naam: "BNR Nieuwsradio"
              logo: "img/bnr.jpg"
              achtergrond: "img/bnrback.jpg"
              bron: "http://icecast-bnr-cdp.triple-it.nl/bnr_mp3_96_04"
            }

            ZenderLandelijk {
              naam: "Classic FM"
              logo: "img/classicfm.jpg"
              achtergrond: "img/classicfmback.jpg"
              bron: "http://20073.live.streamtheworld.com/CLASSICFM.mp3"
            }

            ZenderLandelijk {
              naam: "Soul Radio"
              logo: "img/soulradio.jpg"
              achtergrond: "img/soulradioback.jpg"
              bron: "http://soulradio02.live-streams.nl/live"
            }

            ZenderLandelijk {
              naam: "Sublime FM"
              logo: "img/sublimefm.jpg"
              achtergrond: "img/sublimefmback.jpg"
              bron: "http://stream.sublimefm.nl/SublimeFM_mp3"
            }

            Rectangle {
              color: "transparent"
              height: units.gu(2)
              width: parent.width
            }

            ZenderLandelijk {
              naam: "Arrow Classic Rock"
              logo: "img/arrowclassicrock.jpg"
              achtergrond: "img/arrowclassicrockback.jpg"
              bron: "http://stream.gal.io/arrow"
            }

            ZenderLandelijk {
              naam: "Arrow Caz"
              logo: "img/arrowcaz.jpg"
              achtergrond: "img/arrowcazback.jpg"
              bron: "http://stream.arrowcaz.nl/caz128kmp3"
            }

            ZenderLandelijk {
              naam: "IndieXL"
              logo: "img/indiexl.jpg"
              achtergrond: "img/indiexlback.jpg"
              bron: "http://server-23.stream-server.nl:8438/stream?type=http&nocache=40388"
            }

            Rectangle {
              color: "transparent"
              height: units.gu(2)
              width: parent.width
            }

            ZenderLandelijk {
              naam: "NPO Radio 2 Soul & Jazz"
              logo: "img/nporadio2soul&jazz.jpg"
              achtergrond: "img/nporadio2back.jpg"
              bron: "http://icecast.omroep.nl/radio6-bb-mp3"
            }

            ZenderLandelijk {
              naam: "NPO 3FM KX"
              logo: "img/npo3fmkx.jpg"
              achtergrond: "img/npo3fmkxback.jpg"
              bron: "http://icecast.omroep.nl/3fm-serioustalent-mp3"
            }

            ZenderLandelijk {
              naam: "NPO SterrenNL"
              logo: "img/sterrennl.jpg"
              achtergrond: "img/sterrennlback.jpg"
              bron: "http://icecast.omroep.nl/radio2-sterrennl-mp3"
            }

            /* EINDE ALTERNATIEF */

          }
        }
      }

      Item {
        id: regionaalPage
        width: tabView.width
        height: tabView.height

        Scrollbar {
          z: 1
          id: scrollRegionaal
          visible: true
          flickableItem: flickRegionaal
          align: Qt.AlignTrailing
        }

        Flickable {
          id: flickRegionaal
          width: parent.width
          height: parent.height - bottomMenu.height
          anchors {
            right: parent.right
            bottom: bottomMenu.top
          }
          contentWidth: zendersRegionaalColumn.width
          contentHeight: zendersRegionaalColumn.height

          Column {
            id: zendersRegionaalColumn
            width: mainPage.width

            /* REGIO */

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: fritext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Friesland"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/friesland.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Omrop Fryslân"
              logo: "img/omropfryslan.jpg"
              achtergrond: "img/omropfryslanback.jpg"
              bron: "http://icecast.pmedia70.kpnstreaming.nl/omropfryslanlive-OmropFryslanRadio.mp3"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Waterstad FM"
              logo: "img/waterstadfm.jpg"
              achtergrond: "img/waterstadfmback.jpg"
              bron: "http://stream.waterstadfm.nl/waterstadfm"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Centraal"
              logo: "img/radiocentraal.jpg"
              achtergrond: "img/radiocentraalback.jpg"
              bron: "http://centraal.mm-stream.nl:8017/stream"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Noordoost Friesland"
              logo: "img/rtvnof.jpg"
              achtergrond: "img/rtvnofback.jpg"
              bron: "http://media02.streampartner.nl:8056/live"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Spannenburg"
              logo: "img/radiospannenburg.jpg"
              achtergrond: "img/radiospannenburgback.jpg"
              bron: "http://37.59.195.28:8132/;"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Leo FM"
              logo: "img/leofm.jpg"
              achtergrond: "img/leofmback.jpg"
              bron: "http://rs5.stream24.org:8390/;*.mp3"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: grotext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Groningen"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/groningen.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Simone FM"
              logo: "img/simonefm.jpg"
              achtergrond: "img/simonefmback.jpg"
              bron: "http://stream.stream.delivery/simonefm"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Compagnie"
              logo: "img/radiocompagnie.jpg"
              achtergrond: "img/radiocompagnieback.jpg"
              bron: "http://178.19.116.3:8000/stream"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Westerwolde"
              logo: "img/radiowesterwolde.jpg"
              achtergrond: "img/radiowesterwoldeback.jpg"
              bron: "http://server3.ic-stream.nl:6154/;"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Noord"
              logo: "img/rtvnoord.jpg"
              achtergrond: "img/rtvnoordback.jpg"
              bron: "http://icecast.omroep.nl/rtvnoord-bb-mp3"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "OOG Radio"
              logo: "img/oogradio.jpg"
              achtergrond: "img/oogradioback.jpg"
              bron: "http://icecast.streamone.net/yQYMPcsCPtcw"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Haren FM"
              logo: "img/harenfm.jpg"
              achtergrond: "img/harenfmback.jpg"
              bron: "http://icecast.streamonecloud.net/zzf29538s4p8"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Joy Radio"
              logo: "img/joyradio.jpg"
              achtergrond: "img/joyradioback.jpg"
              bron: "http://stream.joyradio.nl/joyradio"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: drentext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Drenthe"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/drenthe.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Drenthe"
              logo: "img/rtvdrenthe.jpg"
              achtergrond: "img/rtvdrentheback.jpg"
              bron: "http://icecast.omroep.nl/rtvnoord-bb-mp3"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "ZO!34"
              logo: "img/zo!34.jpg"
              achtergrond: "img/zo!34back.jpg"
              bron: "http://stream01.streamhier.nl:8024/stream"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Streekradio"
              logo: "img/streekradio.jpg"
              achtergrond: "img/streekradioback.jpg"
              bron: "http://livestream.streekradio.com/live"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: overtext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Overijssel"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/overijssel.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Rosita"
              logo: "img/radiorosita.jpg"
              achtergrond: "img/radiorositaback.jpg"
              bron: "http://audiostreamen.nl:8004/;"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Oost"
              logo: "img/rtvoost.jpg"
              achtergrond: "img/rtvoostback.jpg"
              bron: "http://ice.cr2.streamzilla.xlcdn.com:8000/sz=rtv_oost=RadioOost_mp3"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV SLOS"
              logo: "img/rtvslos.jpg"
              achtergrond: "img/rtvslosback.jpg"
              bron: "http://icecast.streamone.net/cjZFLu-AKwQW"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Twente FM"
              logo: "img/twentefm.jpg"
              achtergrond: "img/twentefmback.jpg"
              bron: "http://stream.twentefm.nl:8004/high"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Hengelo"
              logo: "img/radiohengelo.jpg"
              achtergrond: "img/radiohengeloback.jpg"
              bron: "http://stream1.icehosting.nl:8128/;stream.mp3"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Enschede FM"
              logo: "img/enschedefm.jpg"
              achtergrond: "img/enschedefmback.jpg"
              bron: "http://stream1.icehosting.nl:8126/;stream.mp3"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: fletext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Flevoland"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/flevoland.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Flevoland"
              logo: "img/omroepflevoland.jpg"
              achtergrond: "img/omroepflevolandback.jpg"
              bron: "http://streams.omroepflevoland.nl:8000/flevoland64k"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Lelystad"
              logo: "img/radiolelystad.jpg"
              achtergrond: "img/radiolelystadback.jpg"
              bron: "http://live.radiolelystad.nl:8000/listen"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Echnaton FM"
              logo: "img/echnatonfm.jpg"
              achtergrond: "img/echnatonfmback.jpg"
              bron: "http://icecast.streamone.nl/pXsb3sihz9"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Almere Radio"
              logo: "img/omroepalmereradio.jpg"
              achtergrond: "img/omroepalmereradioback.jpg"
              bron: "http://icecast.streamone.nl/Pi6mjq9XKC"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "URK FM"
              logo: "img/urkfm.jpg"
              achtergrond: "img/urkfmback.jpg"
              bron: "http://live.urkfm.nl:8000/urkfm.mp3"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Zeewolde"
              logo: "img/omroepzeewolde.jpg"
              achtergrond: "img/omroepzeewoldeback.jpg"
              bron: "http://stream.lokaleomroepzeewolde.nl:8000/normal"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Gelderland"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/gelderland.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Gelderland"
              logo: "img/omroepgelderland.jpg"
              achtergrond: "img/omroepgelderlandback.jpg"
              bron: "http://stream.omroepgelderland.nl/radiogelderland"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Keizerstad Hits"
              logo: "img/keizerstad.jpg"
              achtergrond: "img/keizerstadback.jpg"
              bron: "http://server-06.stream-server.nl:8800/;"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio 024"
              logo: "img/radio024.jpg"
              achtergrond: "img/radio024back.jpg"
              bron: "http://high.024.fm:8338/live"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RN7"
              logo: "img/rn7.jpg"
              achtergrond: "img/rn7back.jpg"
              bron: "https://icecast.streamone.net/i4NtlopQlQUk"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Achterhoek FM"
              logo: "img/achterhoekfm.jpg"
              achtergrond: "img/achterhoekfmback.jpg"
              bron: "https://ms3ic.mx-cd.net/169-699187/AchterhoekFM"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Nijkerk"
              logo: "img/omroepnijkerk.jpg"
              achtergrond: "img/omroepnijkerkback.jpg"
              bron: "http://studio.omroepn.nl:443/nfm.mp3;"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Zorgomroep Rivierenland"
              logo: "img/zorgomroeprivierenland.jpg"
              achtergrond: "img/zorgomroeprivierenlandback.jpg"
              bron: "http://zot.shoutcaststream.com:8048/;"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Favoriet FM"
              logo: "img/favorietfm.jpg"
              achtergrond: "img/favorietfmback.jpg"
              bron: "http://stream.rtv-favoriet.nl:8000/ffm-320-mp3?ver=452769"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Klasse FM"
              logo: "img/klassefm.jpg"
              achtergrond: "img/klassefmback.jpg"
              bron: "http://stream.klasse.fm:8070/;"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "4daagse radio"
              logo: "img/4daagseradio.jpg"
              achtergrond: "img/4daagseradioback.jpg"
              bron: "http://icecast.streamone.nl/k3MNdo0Azq?hash=1519746132620.mp3"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: uttext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Utrecht"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/utrecht.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio M Utrecht"
              logo: "img/mutrecht.jpg"
              achtergrond: "img/mutrechtback.jpg"
              bron: "http://icecast.omroep.nl/rtvutrecht-radio-m-bb-mp3"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "EVA | Amersfoort & Leusden"
              logo: "img/eva.jpg"
              achtergrond: "img/evaback.jpg"
              bron: "http://stream.mediagroep-eva.nl:8001/radio"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Midland FM"
              logo: "img/midlandfm.jpg"
              achtergrond: "img/midlandfmback.jpg"
              bron: "http://176.31.224.21:8204/;"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Bingo FM"
              logo: "img/bingofm.jpg"
              achtergrond: "img/bingofmback.jpg"
              bron: "http://icecast.omroep.nl/rtvutrecht-bingo-fm-bb-mp3"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Baarn"
              logo: "img/rtvbaarn.jpg"
              achtergrond: "img/rtvbaarnback.jpg"
              bron: "http://icecast.streamone.net/IJAFJ-oRIZUy"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "ValleiRadio.nl"
              logo: "img/valleiradio.jpg"
              achtergrond: "img/valleiradioback.jpg"
              bron: "http://server-25.stream-server.nl:8366/;"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: nohotext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Noord-Holland"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/noord-holland.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "NH Radio"
              logo: "img/nhradio.jpg"
              achtergrond: "img/nhradioback.jpg"
              bron: "http://rtvnh-ics1.streamgate.nl/rtvnh"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "6FM"
              logo: "img/zesfm.jpg"
              achtergrond: "img/zesfmback.jpg"
              bron: "http://6fm.nl:8000/mp3live"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "FunX Amsterdam"
              logo: "img/funxamsterdam.jpeg"
              achtergrond: "img/funxamsterdamback.jpg"
              bron: "http://icecast.omroep.nl/funx-amsterdam-bb-mp3"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "MeerRadio"
              logo: "img/meerradio.jpg"
              achtergrond: "img/meerradioback.jpg"
              bron: "http://www.meerradio.nl:8000/;stream.mp3"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Haarlem 105"
              logo: "img/haarlem105.jpg"
              achtergrond: "img/haarlem105back.jpg"
              bron: "http://studio.haarlem105.nl:8000/haarlem105.mp3"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Amstelveen"
              logo: "img/rtvamstelveen.jpg"
              achtergrond: "img/rtvamstelveenback.jpg"
              bron: "http://217.21.199.146:8084/stream?icy=http"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: zuhotext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Zuid-Holland"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/zuid-holland.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Havenstad Radio"
              logo: "img/havenstadradio.jpg"
              achtergrond: "img/havenstadradioback.jpg"
              bron: "http://mediaserv33.live-streams.nl:8056/stream"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Rijnmond"
              logo: "img/rtvrijnmond.jpg"
              achtergrond: "img/rtvrijnmondback.jpg"
              bron: "http://d2e9xgjjdd9cr5.cloudfront.net/icecast/rijnmond/radio-mp3"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep West"
              logo: "img/omroepwest.jpg"
              achtergrond: "img/omroepwestback.jpg"
              bron: "http://d3jhv0ayn0z3fg.cloudfront.net/icecast/omroepwest/radio"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "ZFM"
              logo: "img/zfm.jpg"
              achtergrond: "img/zfmback.jpg"
              bron: "http://www.kippingmultimediaal.nl:8000/ZFMmobiel"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "FunX Den Haag"
              logo: "img/funxdenhaag.jpg"
              achtergrond: "img/funxdenhaagback.jpg"
              bron: "http://icecast.omroep.nl/funx-denhaag-bb-mp3"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Den Haag FM"
              logo: "img/denhaagfm.jpg"
              achtergrond: "img/denhaagfmback.jpg"
              bron: "http://82.94.205.122/proxy/haagseomroep?mp=/denhaagfm"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: zeetext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Zeeland"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/zeeland.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Zeeland"
              logo: "img/omroepzeeland.jpg"
              achtergrond: "img/omroepzeelandback.jpg"
              bron: "http://livestream.zeelandnet.nl:8000/omroepzeeland_radio"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Tholen"
              logo: "img/omroeptholen.png"
              achtergrond: "img/omroeptholenback.jpg"
              bron: "http://stream.dotpoint.nl:8065/stream?type=http&nocache=125381"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Schouwen-Duiveland"
              logo: "img/radioschouwenduiveland.jpg"
              achtergrond: "img/radioschouwenduivelandback.jpg"
              bron: "http://radio.streamonecloud.net/dM21nd6oMi"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Scheldemond FM"
              logo: "img/scheldemondfm.jpg"
              achtergrond: "img/scheldemondfmback.jpg"
              bron: "http://stream.scheldemondfm.nl:8200/;"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Terneuzen FM"
              logo: "img/terneuzenfm.jpg"
              achtergrond: "img/terneuzenfmback.jpg"
              bron: "http://terneuzenfm.shoutcaststream.com:8076/;stream/1"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Reimerswaal"
              logo: "img/radioreimerswaal.jpg"
              achtergrond: "img/radioreimerswaalback.jpg"
              bron: "http://s44.myradiostream.com:6410/;listen.mp3"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: bratext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Noord-Brabant"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/noord-brabant.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Glow FM"
              logo: "img/glowfm.jpg"
              achtergrond: "img/glowfmback.jpg"
              bron: "http://stream.glowfm.nl:8000/glowfm.mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Kempen FM"
              logo: "img/kempenfm.jpg"
              achtergrond: "img/kempenfmback.jpg"
              bron: "http://91.213.69.167:40030/;"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Maasland FM"
              logo: "img/maaslandfm.jpg"
              achtergrond: "img/maaslandfmback.jpg"
              bron: "http://icecast.streamone.nl/f5Snk8SjbA"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Brabant"
              logo: "img/omroepbrabant.jpg"
              achtergrond: "img/omroepbrabantback.jpg"
              bron: "http://d3slqp9xhts6qb.cloudfront.net/icecast/omroepbrabant/mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Centraal"
              logo: "img/omroepcentraal.jpg"
              achtergrond: "img/omroepcentraalback.jpg"
              bron: "http://84.81.102.147:8000/;"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Veldhoven"
              logo: "img/omroepveldhoven.jpg"
              achtergrond: "img/omroepveldhovenback.jpg"
              bron: "http://77.166.186.207:8000/Veldhoven"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio 8FM"
              logo: "img/radio8fm.jpg"
              achtergrond: "img/radio8fmback.jpg"
              bron: "http://server-83.stream-server.nl/stream"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Helmond"
              logo: "img/omroephelmond.jpg"
              achtergrond: "img/omroephelmondback.jpg"
              bron: "http://stream.omroephelmond.nl:8024/;"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Horizon"
              logo: "img/radiohorizon.jpg"
              achtergrond: "img/radiohorizonback.jpg"
              bron: "http://rtvhorizon.nl:8001/;"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Kontakt"
              logo: "img/radiokontakt.jpg"
              achtergrond: "img/radiokontaktback.jpg"
              bron: "http://lokaal.kontaktfm.nl:8005/;"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Langstraat FM"
              logo: "img/langstraatfm.jpg"
              achtergrond: "img/langstraatfmback.jpg"
              bron: "https://mediaserv30.live-streams.nl:18001/stream"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Studio040"
              logo: "img/studio040.jpg"
              achtergrond: "img/studio040back.jpg"
              bron: "http://stream.studio040.nl:8000/studio040.mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Best"
              logo: "img/omroepbest.jpg"
              achtergrond: "img/omroepbestback.jpg"
              bron: "http://109.235.33.237:8000/omroep.mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Efteling Kids Radio"
              logo: "img/eftelingkidsradio.jpg"
              achtergrond: "img/eftelingkidsradioback.jpg"
              bron: "https://20133.live.streamtheworld.com/TLPSTR07.mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Rectangle {
              color: "transparent"
              height: units.gu(3)
              width: parent.width
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }

              Text {
                id: limtext
                height: units.gu(2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gu(4.25)
                text: "Limburg"
                color: theme.palette.normal.baseText
              }

              Image {
                source: "img/limburg.png"
                height: units.gu(1.5)
                width: units.gu(2.5)
                anchors {
                  left: parent.left
                  leftMargin: units.gu(1)
                  verticalCenter: parent.verticalCenter
                }
              }
            }

            ZenderRegionaal {
              naam: "Maasland Radio"
              logo: "img/maaslandradio.jpg"
              achtergrond: "img/maaslandradioback.jpg"
              bron: "http://maaslandradio.shoutcaststream.com:8006/stream"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Venray"
              logo: "img/omroepvenray.jpg"
              achtergrond: "img/omroepvenrayback.jpg"
              bron: "http://icecast.omroepvenray.nl/lov.mp3"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "L1 Radio"
              logo: "img/l1radio.jpg"
              achtergrond: "img/l1radioback.jpg"
              bron: "http://icecast.omroep.nl/l1-radio-sb-mp3"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Reindonk"
              logo: "img/omroepreindonk.jpg"
              achtergrond: "img/omroepreindonkback.jpg"
              bron: "https://ms5ic.mx-cd.net/157-661257/Radio_Reindonk"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Maastricht Radio"
              logo: "img/rtvmaastrichtradio.jpg"
              achtergrond: "img/rtvmaastrichtradioback.jpg"
              bron: "http://stream.rtvmaastricht.nl:8081/rtv/radio_audio/icecast.audio"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Radio Grensland"
              logo: "img/radiogrensland.jpg"
              achtergrond: "img/radiogrenslandback.jpg"
              bron: "http://212.83.138.48:8468/stream"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "RTV Roermond"
              logo: "img/rtvroermond.jpg"
              achtergrond: "img/rtvroermondback.jpg"
              bron: "http://icecast.streamone.net/LyYFt64ABl8S"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Omroep Venlo"
              logo: "img/omroepvenlo.jpg"
              achtergrond: "img/omroepvenloback.jpg"
              bron: "https://icecast.streamone.net/2ZYEDcIAN8Yw"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderRegionaal {
              naam: "Weert FM"
              logo: "img/weertfm.jpg"
              achtergrond: "img/weertfmback.jpg"
              bron: "http://weertfm.mooo.com:9000/wfm3"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            /*  REGIONAAL */

          }
        }
      }
    }


    ListView {
      id: tabView
      anchors {
        top: mainPage.header.bottom
        bottom: parent.bottom
        left: parent.left
        right: parent.right
      }
      model: tabs
      currentIndex: 0

      orientation: Qt.Horizontal
      snapMode: ListView.SnapOneItem
      highlightRangeMode: ListView.StrictlyEnforceRange
      highlightMoveDuration: UbuntuAnimation.FastDuration

      onCurrentIndexChanged: {
        sections.selectedIndex = currentIndex
      }

    }

    Rectangle {
      id: bottomMenu
      z: 4
      width: parent.width
      height: units.gu(6)
      color: theme.palette.normal.background
      anchors {
        bottom: parent.bottom
      }

      Image {
        id: bottomIMG
        z: 5
        source: ""
        height: parent.height - units.gu(0.1)
        width: parent.height - units.gu(0.1)
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }
      /*/ TIJDELIJK UITGESCHAKELD. Opnieuw ontwerpen met behulp van bufferstate audio.
      AnimatedImage {
      height: units.gu(4)
      width: height
      visible: {
      if (player.playbackState == true) {
      false
    }
    else {
    true
  }
}
anchors.right: playerIcon.left
anchors.rightMargin: units.gu(3)
anchors.verticalCenter: parent.verticalCenter
source: "img/loading.gif"

Rectangle {
z: 3
anchors.fill: parent
color: theme.palette.normal.background
visible: {
if (playerIcon.name == "media-playback-stop") {
false
}
else {
true
}
}
}
}
/*/
Audio {
  id: player
  source: " "
}

Rectangle {
  z: 10
  width: parent.width
  height: units.gu(0.1)
  color: theme.palette.normal.base
}

Text {
  id: playerText
  visible: {
    if (player.playbackState == true) {
      true
    }
    else {
      false
    }
  }
  text: " "
  color: theme.palette.normal.baseText
  anchors {
    verticalCenter: parent.verticalCenter
    left: bottomIMG.right
    leftMargin: units.gu(3)
  }
}

Rectangle {
  id: playerIconHolder
  color: theme.palette.normal.background
  height: parent.height
  width: height * 1.5
  anchors {
    verticalCenter: parent.verticalCenter
    right: parent.right
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      if (player.playbackState == true) {
        player.stop()
        playerIcon.name = "media-playback-start"
      }
      else {
        player.play()
        playerIcon.name = "media-playback-stop"
      }
    }
  }

  Icon {
    id: playerIcon
    z: 3
    width: units.gu(3.2)
    height: width
    anchors {
      verticalCenter: parent.verticalCenter
      right: parent.right
      rightMargin: units.gu(3)
    }
    //color: "#000000"
    name: "media-playback-start"
  }
}
}
}
Component {
  id: noConnectionDialog
  Dialog {
    id: dialogue
    title: "Oeps!"
    text: "Deze app vereist een actieve internetverbinding! Controleer je netwerkinstellingen en probeer het opnieuw."
    Button {
      text: "Sluiten"
      color: "#00adda"
      onClicked: Qt.quit()
    }

    Button {
      text: "Toch Proberen"
      color: "#888888"
      onClicked: PopupUtils.close(dialogue)
    }
  }
}

Component {
  id: tutorialMainDialog
  Dialog {
    id: dialogue3
    text: "Welkom bij Radio NL, dé app waarin je alle Nederlandse radio stations op één plek vindt! Boven in het scherm kan je wisselen tussen landelijke, alternatieve en regionale zenders. Veel luisterplezier!"
    Button {
      text: "Ik begrijp het!"
      color: "#00adda"
      onClicked: {
        PopupUtils.close(dialogue3)
      }
    }
  }
}

SettingsDialog {
  id: settingsDialog
}

function openSettingsDialog() {
  var sd = PopupUtils.open(settingsDialog);
}

TutorialRegionaalDialog {
  id: tutorialRegionaalDialog
}

function openTutorialRegionaalDialog() {
  var sd = PopupUtils.open(tutorialRegionaalDialog);
}
}
