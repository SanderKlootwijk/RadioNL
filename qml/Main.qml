import QtQuick 2.9
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

  Keys.onSpacePressed: {
    if (player.playbackState == true) {
      player.stop()
    }
    else {
      player.play()
    }
  }

  width: units.gu(45)
  height: units.gu(75)

  Image {
    id: testImg
    anchors.right: parent.left
    source: "https://www.npo3fm.nl/svg/npo_3fm_logo.svg"
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
      else {
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
    visible: true
    height: parent.height
    width: {
      if (parent.width < units.gu(100)) {
        parent.width
      }
      else {
        parent.width - units.gu(40)
      }
    }

    header: PageHeader {
      id: header
      title: "Radio NL"
      opacity: 1

      ActionBar {
        id: actionBar
        anchors.right: parent.right
        height: playerPageHeader.height
        numberOfSlots: 1
        actions: [
        Action {
          id: settingsAction
          text: "Instellingen"
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
              // bottomEdge moet geopend en gesloten worden voordat het nieuwe thema is toegepast. Anders toont zich een lege pagina:
              bottomEdge.commit()
              bottomEdge.collapse()
            }
            else {
              Theme.name = "Ubuntu.Components.Themes.Ambiance"
              settings.theme = "Ambiance"
              // bottomEdge moet geopend en gesloten worden voordat het nieuwe thema is toegepast. Anders toont zich een lege pagina:
              bottomEdge.commit()
              bottomEdge.collapse()
            }
          }
        },
        Action {
          id: helpAction
          text: "Help"
          iconName: "help"
          onTriggered: {
            PopupUtils.open(tutorialMainDialog)
          }
        },
        Action {
          id: infoAction
          text: "Over"
          iconName: "info"
          onTriggered: {
            PopupUtils.open(aboutDialog)
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
          text: "Landelijk"
          onTriggered: {
            settingsAction.visible = false
          }
        },
        Action {
          text: "Alternatief"
          onTriggered: {
            settingsAction.visible = false
          }
        },
        Action {
          text: "Regionaal"
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
    }

    Component.onCompleted: {
      Theme.name = "Ubuntu.Components.Themes." + settings.theme
      player.source = settings.source
      playerText.text = settings.text
      bottomIMG.source = settings.image
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
          height: {
            if (root.width < units.gu(100)) {
              parent.height - bottomMenu.height - units.gu(4)
            }
            else {
              parent.height - units.gu(4)
            }
          }

          anchors {
            right: parent.right
            top: parent.top
          }

          contentWidth: zendersLandelijkColumn.width
          contentHeight: zendersLandelijkColumn.height - units.gu(0.1)

          Column {
            id: zendersLandelijkColumn
            width: mainPage.width

            ZenderDivider {
              text: "Nederlandse Publieke Omroep"
            }

            /* NPO ZENDERS */

            Zender {
              naam: "NPO Radio 1"
              subText: "Het nieuws van alle kanten"
              logo: "img/nporadio1.jpg"
              bron: "http://icecast.omroep.nl/radio1-bb-mp3"
            }

            Zender {
              naam: "NPO Radio 2"
              subText: "Er is maar één NPO Radio 2"
              logo: "img/nporadio2.jpg"
              bron: "http://icecast.omroep.nl/radio2-bb-mp3"
            }

            Zender {
              naam: "NPO 3FM"
              subText: "Laat je horen"
              logo: "img/npo3fm.jpg"
              bron: "http://icecast.omroep.nl/3fm-bb-mp3"
            }

            Zender {
              naam: "NPO Radio 4"
              subText: "Klassiek komt bij je binnen"
              logo: "img/nporadio4.jpg"
              bron: "http://icecast.omroep.nl/radio4-bb-mp3"
            }

            Zender {
              naam: "NPO Radio 5"
              subText: "Je voelt je thuis bij NPO Radio 5"
              logo: "img/nporadio5.jpg"
              bron: "http://icecast.omroep.nl/radio5-bb-mp3"
            }

            /* EINDE NPO ZENDERS */

            ZenderDivider {
              text: "Commerciële zenders"
            }

            /* COMMERCIEEL */

            Zender {
              naam: "Q-music"
              subText: "Q sounds better with you"
              logo: "img/qmusic.jpg"
              bron: "http://icecast-qmusic.cdp.triple-it.nl/Qmusic_nl_live_96.mp3"
            }

            Zender {
              naam: "Radio 538"
              subText: "Één station, alle hits"
              logo: "img/radio538.jpg"
              bron: "https://22593.live.streamtheworld.com/RADIO538.mp3?dist=tunein"
            }

            Zender {
              naam: "Sky Radio"
              subText: "The feel good station"
              logo: "img/skyradio.jpg"
              bron: "http://22613.live.streamtheworld.com/SKYRADIO.mp3?dist=tunein"
            }

            Zender {
              naam: "Radio 10"
              subText: "De grootste hits aller tijden!"
              logo: "img/radio10.jpg"
              bron: "http://19993.live.streamtheworld.com/RADIO10.mp3?dist=tunein"
            }

            Zender {
              naam: "Radio Veronica"
              subText: "WE. LOVE. MUSIC"
              logo: "img/radioveronica.jpg"
              bron: "https://20873.live.streamtheworld.com/VERONICA.mp3?dist=tunein"
            }

            Zender {
              naam: "100% NL"
              subText: "De beste muziek van Nederland"
              logo: "img/100pnl.jpg"
              bron: "https://20853.live.streamtheworld.com/100PNL_MP3_SC?dist=tunein"
            }

            Zender {
              naam: "SLAM!"
              subText: "Play Music, Play Life"
              logo: "img/slam.jpg"
              bron: "https://stream.slam.nl/slam_mp3?dist=tunein"
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
          height: {
            if (root.width < units.gu(100)) {
              parent.height - bottomMenu.height - units.gu(4)
            }
            else {
              parent.height - units.gu(4)
            }
          }

          anchors {
            right: parent.right
            top: parent.top
          }

          contentWidth: zendersAlternatiefColumn.width
          contentHeight: zendersAlternatiefColumn.height - units.gu(0.1)

          Column {
            id: zendersAlternatiefColumn
            width: mainPage.width

            ZenderDivider {
              text: "Commerciële zenders"
            }

            /* ALTERNATIEF */

            Zender {
              naam: "BNR Nieuwsradio"
              subText: "#IkhoorbijBNR"
              logo: "img/bnr.jpg"
              bron: "http://21283.live.streamtheworld.com/BNR_NIEUWSRADIO.mp3?DIST=TuneIn&TGT=TuneIn"
            }

            Zender {
              naam: "classicnl"
              subText: "Klassiek voor iedereen"
              logo: "img/classicnl.jpg"
              bron: "http://22723.live.streamtheworld.com/CLASSICFM.mp3?DIST=TuneIn&TGT=TuneIn"
            }

            Zender {
              naam: "Soul Radio"
              subText: "Soul muziek"
              logo: "img/soulradio.jpg"
              bron: "http://21233.live.streamtheworld.com/SOULRADIO.mp3"
            }

            Zender {
              naam: "Sublime FM"
              subText: "Join the Groove"
              logo: "img/sublimefm.jpg"
              bron: "http://stream.sublimefm.nl/SublimeFM_mp3"
            }

            ZenderDivider {}

            Zender {
              naam: "KINK"
              subText: "No Alternative"
              logo: "img/kink.jpg"
              bron: "https://21293.live.streamtheworld.com/KINK.mp3"
            }

            Zender {
              naam: "IndieXL"
              subText: "Durf te ontdekken, luister IndieXL!"
              logo: "img/indiexl.jpg"
              bron: "http://server-23.stream-server.nl:8438/stream?type=http&nocache=40388"
            }

            ZenderDivider {}

            Zender {
              naam: "Arrow Classic Rock"
              subText: "Classic en modern rock"
              logo: "img/arrowclassicrock.jpg"
              bron: "http://stream.gal.io/arrow"
            }

            Zender {
              naam: "Arrow Caz"
              subText: "Your Hits, More Music"
              logo: "img/arrowcaz.jpg"
              bron: "http://stream.arrowcaz.nl/caz128kmp3"
            }

            ZenderDivider {}

            Zender {
              naam: "ZTACK"
              subText: "Shuffle Your Day"
              logo: "img/ztack.jpg"
              bron: "https://audio.ztack.nl/radio/8000/ztack"
            }

            Zender {
              naam: "Joe"
              subText: "All the way"
              logo: "img/joe.jpg"
              bron: "https://icecast-qmusicnl-cdp.triple-it.nl/Joe_nl_1_96.mp3"
            }

            //NPO

            ZenderDivider {
              text: "Nederlandse Publieke Omroep"
            }

            Zender {
              naam: "NPO Radio 2 Soul & Jazz"
              subText: "Soul & Jazz muziek"
              logo: "img/nporadio2soul&jazz.jpg"
              bron: "http://icecast.omroep.nl/radio6-bb-mp3"
            }

            Zender {
              naam: "NPO 3FM KX"
              subText: "For the love of music"
              logo: "img/npo3fmkx.jpg"
              bron: "http://icecast.omroep.nl/3fm-serioustalent-mp3"
            }

            Zender {
              naam: "NPO Sterren NL"
              subText: "De nummer 1 in Nederlandstalige muziek"
              logo: "img/sterrennl.jpg"
              bron: "http://icecast.omroep.nl/radio2-sterrennl-mp3"
            }

            // FunX zenders

            ZenderDivider {
              text: "FunX Zenders"
            }

            Zender {
              naam: "FunX NL"
              subText: "The Sound of the City"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-bb-mp3"
            }

            Zender {
              naam: "FunX Amsterdam"
              subText: "Amsterdam"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-amsterdam-bb-mp3"
            }

            Zender {
              naam: "FunX Rotterdam"
              subText: "Rotterdam"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-rotterdam-bb-mp3"
            }

            Zender {
              naam: "FunX Den Haag"
              subText: "Den Haag"
              logo: "img/funx.jpg"
              bron: "http://icecast.omroep.nl/funx-denhaag-bb-mp3"
            }

            Zender {
              naam: "FunX Utrecht"
              subText: "Utrecht"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-utrecht-bb-mp3"
            }

            Zender {
              naam: "FunX Arab"
              subText: "Arabische muziek (Raï)"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-arab-bb-mp3"
            }

            Zender {
              naam: "FunX Dance"
              subText: "Dance muziek"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-dance-bb-mp3"
            }

            Zender {
              naam: "FunX Hip Hop"
              subText: "Hip Hop"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-hiphop-bb-mp3"
            }

            Zender {
              naam: "FunX Latin"
              subText: "Latin muziek"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-latin-bb-mp3"
            }

            Zender {
              naam: "FunX Reggae"
              subText: "Reggae"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-reggae-bb-mp3"
            }

            Zender {
              naam: "FunX Slow Jamz"
              subText: "Slow Jamz"
              logo: "img/funx.jpg"
              bron: "https://icecast.omroep.nl/funx-slowjamz-bb-mp3"
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
          height: {
            if (root.width < units.gu(100)) {
              parent.height - bottomMenu.height - units.gu(4)
            }
            else {
              parent.height - units.gu(4)
            }
          }

          anchors {
            right: parent.right
            top: parent.top
          }

          contentWidth: zendersRegionaalColumn.width
          contentHeight: zendersRegionaalColumn.height - units.gu(0.1)

          Column {
            id: zendersRegionaalColumn
            width: mainPage.width

            /* REGIO */

            ZenderDivider {
              text: "Friesland"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Omrop Fryslân"
              subText: "Ofstimd op dy!"
              logo: "img/omropfryslan.jpg"
              bron: "https://d3pvma9xb2775h.cloudfront.net/icecast/omropfryslan/radio.mp3"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Waterstad FM"
              subText: "Radio uit het Hart van Friesland"
              logo: "img/waterstadfm.jpg"
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

            Zender {
              naam: "Radio Centraal"
              subText: "Lokale omroep Weststellingwerf"
              logo: "img/radiocentraal.jpg"
              bron: "https://mcp-2.mm-stream.nl:8017/stream"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "RTV Noordoost Friesland"
              subText: "Nieuws uit Noordoost Friesland"
              logo: "img/rtvnof.jpg"
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

            // Stream niet betrouwbaar
            /*Zender {
              naam: "Radio Spannenburg"
              subText: "It hert fan De Fryske Marren"
              logo: "img/radiospannenburg.jpg"
              bron: "https://stream.radiospannenburg.nl/radiospannenburg"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            Zender {
              naam: "Leo Middelsé"
              subText: "Omroep voor Leeuwarden en omstreken"
              logo: "img/leofm.jpg"
              bron: "https://ms5ic.mx-cd.net/238-2265270/LEO_Middelse_Radio"
              visible: {
                if (settings.frivisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderDivider {
              text: "Groningen"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Simone FM"
              subText: "Échte radio"
              logo: "img/simonefm.jpg"
              bron: "https://stream.simone.nl/simone"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Radio Westerwolde"
              subText: "Het nieuwsportaal van de regio!"
              logo: "img/radiowesterwolde.jpg"
              bron: "http://icecast.radiowesterwolde.nl:8000/G1_RWW"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "RTV Noord"
              subText: "Het nieuws uit Groningen"
              logo: "img/rtvnoord.jpg"
              bron: "https://media.rtvnoord.nl/icecast/rtvnoord/radio?.mp3"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "OOG Radio"
              subText: "Nieuws uit Groningen"
              logo: "img/oogradio.jpg"
              bron: "https://olon.az.icecast.ebsd.ericsson.net/oog_radio"
              visible: {
                if (settings.grovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Joy Radio"
              subText: "Hits only!"
              logo: "img/joyradio.jpg"
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

            ZenderDivider {
              text: "Drenthe"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "RTV Drenthe"
              subText: "Altijd in de buurt"
              logo: "img/rtvdrenthe.jpg"
              bron: "https://cdn.rtvdrenthe.nl/icecast/rtvdrenthe/rtvradio"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "ZO!34"
              subText: "De stem van Zuidoost-Drenthe"
              logo: "img/zo!34.jpg"
              bron: "https://mcp-2.mm-stream.nl:7000/stream"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // Streekradio is overgegaan in DNO radio, zie wijzijndno.nl
            /*/Zender {
              naam: "Streekradio"
              subText: ""
              logo: "img/streekradio.jpg"
              bron: "http://livestream.streekradio.com/live"
              visible: {
                if (settings.drenvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }/*/

            ZenderDivider {
              text: "Overijssel"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Radio Rosita"
              subText: "Nonstop de beste mix"
              logo: "img/radiorosita.jpg"
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

            Zender {
              naam: "RTV Oost"
              subText: "Thuis in Overijssel"
              logo: "img/rtvoost.jpg"
              bron: "http://streams.rtvoost.nl/audio/oost/mp3"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "RTV SLOS"
              subText: "Lokale omroep Steenwijkerland"
              logo: "img/rtvslos.jpg"
              bron: "https://olon.az.icecast.ebsd.ericsson.net/mix105_steenwijkerland"
              visible: {
                if (settings.overvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Twente FM"
              subText: "Het radiostation voor Noordoost Twente"
              logo: "img/twentefm.jpg"
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

            Zender {
              naam: "Radio Hengelo"
              subText: "De lokale omroep van en voor Hengelo"
              logo: "img/radiohengelo.jpg"
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

            Zender {
              naam: "Enschede FM"
              subText: "24/7 de lekkerste hits op het internet"
              logo: "img/enschedefm.jpg"
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

            ZenderDivider {
              text: "Flevoland"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Omroep Flevoland"
              subText: "Het laatste nieuws voor Flevoland"
              logo: "img/omroepflevoland.jpg"
              bron: "https://stream.omroepflevoland.nl/icecast/omroepflevoland/stream1"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Radio Lelystad"
              subText: "Altijd in de lucht!"
              logo: "img/radiolelystad.jpg"
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

            Zender {
              naam: "Omroep Almere Radio"
              subText: "Hét nieuwsplatform voor Almere en Omstreken"
              logo: "img/omroepalmereradio.jpg"
              bron: "https://players.rcast.net/stream/65615.mp3"
              visible: {
                if (settings.flevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "URK FM"
              subText: "De lokale omroep voor de gemeente Urk"
              logo: "img/urkfm.jpg"
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

            Zender {
              naam: "Lokale Omroep Zeewolde"
              subText: "Uw nieuwsbron uit Zeewolde"
              logo: "img/omroepzeewolde.jpg"
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

            ZenderDivider {
              text: "Gelderland"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Omroep Gelderland"
              subText: "Altijd in de buurt!"
              logo: "img/omroepgelderland.jpg"
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

            Zender {
              naam: "Keizerstad Hits"
              subText: "Jouw nummer 1 in Gelderland"
              logo: "img/keizerstad.jpg"
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

            // Zender opgeheven? Stream is uit de lucht.
            /*Zender {
              naam: "Radio 024"
              subText: "De beste classics & hits!"
              logo: "img/radio024.jpg"
              bron: "http://stream.radio024.nl/radio024.mp3"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            Zender {
              naam: "RN7"
              subText: "De streekomroep voor Nijmegen"
              logo: "img/rn7.jpg"
              bron: "https://stream.stream.delivery/rn7"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // Overgegaan in UniekFM
            /*Zender {  
              naam: "Achterhoek FM"
              subText: "Lokale omroep voor de gemeente Lochem"
              logo: "img/achterhoekfm.jpg"
              bron: "https://ms3ic.mx-cd.net/169-699187/AchterhoekFM"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            Zender {
              naam: "Favoriet FM"
              subText: "Jouw Favoriet!"
              logo: "img/favorietfm.jpg"
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

            Zender {
              naam: "Klasse FM"
              subText: "Gewoon gezellig!"
              logo: "img/klassefm.jpg"
              bron: "https://mediaserv38.live-streams.nl:18023/stream"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // Offline??
            /*/Zender {
              naam: "4daagse radio"
              subText: ""
              logo: "img/4daagseradio.jpg"
              bron: "http://icecast.streamone.nl/k3MNdo0Azq?hash=1519746132620.mp3"
              visible: {
                if (settings.gevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }/*/

            ZenderDivider {
              text: "Utrecht"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Radio M Utrecht"
              subText: "Nieuws- en sportzender van de provincie Utrecht"
              logo: "img/mutrecht.jpg"
              bron: "https://media.rtvutrecht.nl/radiomutrecht-bb-mp3"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "EVA | Amersfoort & Leusden"
              subText: "De lokale omroep voor Amersfoort en Leusden"
              logo: "img/eva.jpg"
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

            Zender {
              naam: "Midland FM"
              subText: "Voor elkaar"
              logo: "img/midlandfm.jpg"
              bron: "https://caster04.streampakket.com/proxy/8216/stream;"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Bingo FM"
              subText: "Nederlandstalige muziek!"
              logo: "img/bingofm.jpg"
              bron: "https://media.rtvutrecht.nl/bingofm-bb-mp3"
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // Geen goede streaming URL meer beschikbaar
            /*Zender {
              naam: "RTV Baarn"
              subText: "Lokale omroep uit Baarn"
              logo: "img/rtvbaarn.jpg"
              bron: ""
              visible: {
                if (settings.utvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            Zender {
              naam: "ValleiRadio.nl"
              subText: "Radio voor iedereen!"
              logo: "img/valleiradio.jpg"
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

            ZenderDivider {
              text: "Noord-Holland"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "NH Radio"
              subText: "Informeert, inspireert en verbindt"
              logo: "img/nhradio.jpg"
              bron: "http://ice.cr1.streamzilla.xlcdn.com:8000/sz%3Dnhnieuws%3DNHRadio_mp3"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // 6FM is overgegaan in NH Gooi radio, aanpassen

            /*/Zender {
              naam: "6FM"
              subText: ""
              logo: "img/zesfm.jpg"
              bron: "http://6fm.nl:8000/mp3live"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }/*/

            Zender {
              naam: "FunX Amsterdam"
              subText: "The Sound of the City"
              logo: "img/funxamsterdam.jpeg"
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

            Zender {
              naam: "MeerRadio"
              subText: "Lokale omroep an Haarlemmermeer"
              logo: "img/meerradio.jpg"
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

            //Stream niet betrouwbaar
            /*Zender {
              naam: "Haarlem105"
              subText: "Van stad tot strand!"
              logo: "img/haarlem105.jpg"
              bron: "http://stream.tbmp.nl:8010/haarlem105.web"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            //Stream niet betrouwbaar
            /*Zender {
              naam: "RTV Amstelveen"
              subText: "Lokale Omroep Amstelveen"
              logo: "img/rtvamstelveen.jpg"
              bron: "http://radio.rtva.nl/station"
              visible: {
                if (settings.nohovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            ZenderDivider {
              text: "Zuid-Holland"
              visible: {
                if (settings.zuhovisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Havenstad Radio"
              subText: "Rotterdams lekkerste popzender"
              logo: "img/havenstadradio.jpg"
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

            Zender {
              naam: "RTV Rijnmond"
              subText: "Wij zijn erbij!"
              logo: "img/rtvrijnmond.jpg"
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

            Zender {
              naam: "Omroep West"
              subText: "Het laatste nieuws, weer en verkeer"
              logo: "img/omroepwest.jpg"
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

            Zender {
              naam: "ZFM"
              subText: "Dag en nacht hits en nieuws vanuit het hart van Zuid-Holland"
              logo: "img/zfm.jpg"
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

            Zender {
              naam: "FunX Den Haag"
              subText: "The Sound of the City"
              logo: "img/funxdenhaag.jpg"
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

            Zender {
              naam: "Den Haag FM"
              subText: "100% Haags!"
              logo: "img/denhaagfm.jpg"
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

            ZenderDivider {
              text: "Zeeland"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Omroep Zeeland"
              subText: "Regionale omroep voor de provincie Zeeland"
              logo: "img/omroepzeeland.jpg"
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

            Zender {
              naam: "Omroep Tholen"
              subText: "Regionale omroep voor regio Tholen"
              logo: "img/omroeptholen.jpg"
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

            Zender {
              naam: "Radio Schouwen-Duiveland"
              subText: "Moet je horen!"
              logo: "img/radioschouwenduiveland.jpg"
              bron: "http://212.115.192.105:45121/radioschoudui"
              visible: {
                if (settings.zeevisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Scheldemond FM"
              subText: "Omroep voor West Zeeuws Vlaanderen"
              logo: "img/scheldemondfm.jpg"
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

            Zender {
              naam: "Terneuzen FM"
              subText: "Dé regionale zender van Terneuzen"
              logo: "img/terneuzenfm.jpg"
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

            ZenderDivider {
              text: "Noord-Brabant"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Glow FM"
              subText: "Hits Till It Hurts"
              logo: "img/glowfm.jpg"
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

            Zender {
              naam: "Kempen FM"
              subText: "Hét 'Feelgood' Radiostation van de Kempen!"
              logo: "img/kempenfm.jpg"
              bron: "https://mediacp.audiostreamen.nl/musicbiz"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Omroep Brabant"
              subText: "Regionale omroep voor de provincie Noord-Brabant"
              logo: "img/omroepbrabant.jpg"
              bron: "http://av.omroepbrabant.nl/icecast/omroepbrabant/mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            //Stream offline
            /*Zender {
              naam: "Omroep Centraal"
              subText: "Lokale omroep Gemert-Bakel"
              logo: "img/omroepcentraal.jpg"
              bron: "http://84.81.102.147:8000/;"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }*/

            Zender {
              naam: "Omroep Veldhoven"
              subText: "Het laatste nieuws voor én door Veldhoven"
              logo: "img/omroepveldhoven.jpg"
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

            Zender {
              naam: "Omroep Helmond"
              subText: "Altijd dichtbij"
              logo: "img/omroephelmond.jpg"
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

            Zender {
              naam: "Radio Horizon"
              subText: "Streekomroep voor Cranendonck en Heeze-Leende"
              logo: "img/radiohorizon.jpg"
              bron: "https://www.rtvhorizon.nl/radiostream/mp3"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Radio Kontakt"
              subText: "Lokale radio voor de gemeente Laarbeek"
              logo: "img/radiokontakt.jpg"
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

            Zender {
              naam: "Langstraat FM"
              subText: "Radio: Waalwijk, Loon op Zand"
              logo: "img/langstraatfm.jpg"
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

            Zender {
              naam: "Studio040"
              subText: "Lokale radio voor Eindhoven"
              logo: "img/studio040.jpg"
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

            Zender {
              naam: "Omroep Best"
              subText: "Lokale omroep van de gemeente Best"
              logo: "img/omroepbest.jpg"
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

            Zender {
              naam: "Efteling Kids Radio"
              subText: "Radio voor kinderen"
              logo: "img/eftelingkidsradio.jpg"
              bron: "http://ice.cr2.streamzilla.xlcdn.com:8000/sz=efteling=hdstream"
              visible: {
                if (settings.bravisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            ZenderDivider {
              text: "Limburg"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Maasland Radio"
              subText: "Jouw Regio Radio"
              logo: "img/maaslandradio.jpg"
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

            Zender {
              naam: "Omroep Venray"
              subText: "Ook voor jou!"
              logo: "img/omroepvenray.jpg"
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

            Zender {
              naam: "L1 Radio"
              subText: "Liefde voor Limburg"
              logo: "img/l1radio.jpg"
              bron: "http://d34pj260kw1xmk.cloudfront.net/icecast/l1/radio-bb-mp3"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // Veranderd in omroep horst aan de maas??
            /*/
            Zender {
              naam: "Omroep Reindonk"
              subText: ""
              logo: "img/omroepreindonk.jpg"
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
            /*/

            Zender {
              naam: "RTV Maastricht Radio"
              subText: "Lokale radio voor Maastricht"
              logo: "img/rtvmaastrichtradio.jpg"
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

            Zender {
              naam: "Radio Grensland"
              subText: "Een grenzeloos idee!"
              logo: "img/radiogrensland.jpg"
              bron: "https://antares.dribbcast.com/proxy/grensland?mp=/stream"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            // Overgegaan in ML5

            /*/
            Zender {
              naam: "RTV Roermond"
              subText: "Nieuws en sport uit Limburg"
              logo: "img/rtvroermond.jpg"
              bron: "http://icecast.streamone.net/LyYFt64ABl8S"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }/*/

            Zender {
              naam: "Omroep Venlo"
              subText: "Lokale omroep van de gemeente Venlo"
              logo: "img/omroepvenlo.jpg"
              bron: "https://olon.az.icecast.ebsd.ericsson.net/omroep_venlo"
              visible: {
                if (settings.limvisible == "false") {
                  false
                }
                else {
                  true
                }
              }
            }

            Zender {
              naam: "Weert FM"
              subText: "Lokale omroep voor Weert en Nederweert"
              logo: "img/weertfm.jpg"
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

    // bottomMenu; this menu contains te current playing radio station and player. It hides when the screen is bigger then units.gu(100), e.g. tablets or computers
    Rectangle {
      z: 4
      id: bottomMenu

      width: parent.width
      height: units.gu(9)

      color: theme.palette.normal.background

      anchors {
        bottom: parent.bottom
        bottomMargin: units.gu(4)
      }

      visible: {
        if (root.width < units.gu(100)) {
          true
        }
        else {
          false
        }
      }

      // Grey line on top of bottomMenu

      Rectangle {
        z: 10
        width: parent.width
        height: units.gu(0.1)
        color: theme.palette.normal.base
      }

      // Contents of the menu are below

      UbuntuShape {
        id: bottomIMGShape
        height: units.gu(7)
        width: height

        anchors {
          left: parent.left
          leftMargin: units.gu(1)
          verticalCenter: parent.verticalCenter
        }

        // Put radio station logo in UbuntuShape
        source: Image {
          id: bottomIMG

          // Source is blank, it gets set by the 'zender' component
          source: ""
        }

        aspect: UbuntuShape.Inset
      }

      Audio {
        id: player

        // Source is blank, it gets set by the 'zender' component
        source: " "
      }

      // Put labels in a 'box'

      Item {
        width: parent.width - units.gu(9)
        height: units.gu(4.5)

        anchors {
          left: bottomIMGShape.right
          leftMargin: units.gu(1)
          verticalCenter: parent.verticalCenter
        }

        visible: {
          if (player.playbackState == true) {
            true
          }
          else {
            false
          }
        }

        Label {
          anchors {
            left: parent.left
            top: parent.top
          }

          text: "Nu aan het spelen"

          font.bold: true
        }

        Label {
          id: playerText

          anchors {
            left: parent.left
            bottom: parent.bottom
          }

          // playerText is blank, it gets set by the 'zender' component
          text: " "
        }
      }

      // Put the playerIcon in a Rectangle to make the MouseArea bigger
      Rectangle {
        id: playerIconHolder

        height: parent.height
        width: height * 1.5

        color: theme.palette.normal.background

        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            if (player.playbackState == true) {
              player.stop()
            }
            else {
              player.play()
            }
          }
        }

        // Player icon
        Icon {
          z: 3
          id: playerIcon

          width: units.gu(3)
          height: width

          anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: units.gu(3)
          }

          name: {
            if (player.playbackState == true) {
              "media-playback-stop"
            }
            else {
              "media-playback-start"
            }
          }
        }

        // Buffer rectangle. If the audio player is loading, the ActivityIndicator will show
        Rectangle {
          z: 4
          id: buffer
          visible: {
            if (player.playbackState == true) {
              if (player.bufferProgress < 0.20) {
                true
              }
              else {
                false
              }
            }
            else {
              false
            }
          }

          anchors.fill: parent
          color: theme.palette.normal.background

          ActivityIndicator {
            width: units.gu(3.2)
            height: width

            running: true
            anchors.centerIn: parent
          }
        }
      }
    }

    // Needed to open the bottomEdge in desktop mode. Temporary solution.
    MouseArea {
      z: 10

      width: bottomEdge.width
      height: units.gu(4)

      anchors {
        bottom: parent.bottom
        left: parent.left
      }

      onClicked: {
        bottomEdge.commit()
      }
    }

    // The bottomEdge cointains the favorite radio station set by the user.
    BottomEdge {

      id: bottomEdge

      hint.iconName: "go-up"

      height: {
        if (root.width < units.gu(65)) {
          parent.width / 4 + units.gu(7)
        }
        else {
          units.gu(18)
        }
      }

      contentComponent: Page {
        PageHeader {
          id: bottomHeader
          title: "Favorieten"
        }
        width: root.width
        height: root.height

        Row {
          anchors {
            top: bottomHeader.bottom
            topMargin: units.gu(1)
            horizontalCenter: parent.horizontalCenter
          }
          width: parent.width - units.gu(2)
          spacing: units.gu(1)
          //Slot 1
          UbuntuShape {
            id: slot1
            width: {
              if (root.width < units.gu(65)){
                parent.width / 4 - units.gu(0.8)
              }
              else{
                units.gu(10)
              }
            }
            height: width
            source: Image {
              id: slot1img
              source: settings.slot1img
            }

            MouseArea {
              id: mouseArea;
              anchors.fill: parent
              onClicked: {
                if (settings.slot1source == "") {
                }
                else {
                  player.stop()
                  player.source = settings.slot1source
                  player.play()
                  playerText.text = settings.slot1text
                  bottomIMG.source = settings.slot1img
                  settings.source = player.source
                  settings.text = playerText.text
                  settings.image = bottomIMG.source
                  bottomEdge.collapse()
                }
              }
              onPressAndHold: {
                slot1img.source = bottomIMG.source
                settings.slot1img = bottomIMG.source
                settings.slot1text = playerText.text
                settings.slot1source = player.source
              }
            }

            states: State {
              name: "pressed"; when: mouseArea.pressed
              PropertyChanges { target: slot1; scale: 1.03 }
            }

            transitions: Transition {
              NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
            }
          }

          //Slot 2
          UbuntuShape {
            id: slot2
            width: {
              if (root.width < units.gu(65)){
                parent.width / 4 - units.gu(0.8)
              }
              else{
                units.gu(10)
              }
            }
            height: width
            source: Image {
              id: slot2img
              source: settings.slot2img
            }

            MouseArea {
              id: mouseArea2;
              anchors.fill: parent
              onClicked: {
                if (settings.slot2source == "") {
                }
                else {
                  player.stop()
                  player.source = settings.slot2source
                  player.play()
                  playerText.text = settings.slot2text
                  bottomIMG.source = settings.slot2img
                  settings.source = player.source
                  settings.text = playerText.text
                  settings.image = bottomIMG.source
                  bottomEdge.collapse()
                }
              }
              onPressAndHold: {
                slot2img.source = bottomIMG.source
                settings.slot2img = bottomIMG.source
                settings.slot2text = playerText.text
                settings.slot2source = player.source
              }
            }

            states: State {
              name: "pressed"; when: mouseArea2.pressed
              PropertyChanges { target: slot2; scale: 1.03 }
            }

            transitions: Transition {
              NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
            }
          }

          //Slot 3
          UbuntuShape {
            id: slot3
            width: {
              if (root.width < units.gu(65)){
                parent.width / 4 - units.gu(0.8)
              }
              else{
                units.gu(10)
              }
            }
            height: width
            source: Image {
              id: slot3img
              source: settings.slot3img
            }

            MouseArea {
              id: mouseArea3;
              anchors.fill: parent
              onClicked: {
                if (settings.slot3source == "") {
                }
                else {
                  player.stop()
                  player.source = settings.slot3source
                  player.play()
                  playerText.text = settings.slot3text
                  bottomIMG.source = settings.slot3img
                  settings.source = player.source
                  settings.text = playerText.text
                  settings.image = bottomIMG.source
                  bottomEdge.collapse()
                }
              }
              onPressAndHold: {
                slot3img.source = bottomIMG.source
                settings.slot3img = bottomIMG.source
                settings.slot3text = playerText.text
                settings.slot3source = player.source
              }
            }

            states: State {
              name: "pressed"; when: mouseArea3.pressed
              PropertyChanges { target: slot3; scale: 1.03 }
            }

            transitions: Transition {
              NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
            }
          }

          //Slot 4
          UbuntuShape {
            id: slot4
            width: {
              if (root.width < units.gu(65)){
                parent.width / 4 - units.gu(0.8)
              }
              else{
                units.gu(10)
              }
            }
            height: width
            source: Image {
              id: slot4img
              source: settings.slot4img
            }

            MouseArea {
              id: mouseArea4;
              anchors.fill: parent
              onClicked: {
                if (settings.slot4source == "") {
                }
                else {
                  player.stop()
                  player.source = settings.slot4source
                  player.play()
                  playerText.text = settings.slot4text
                  bottomIMG.source = settings.slot4img
                  settings.source = player.source
                  settings.text = playerText.text
                  settings.image = bottomIMG.source
                  bottomEdge.collapse()
                }
              }
              onPressAndHold: {
                slot4img.source = bottomIMG.source
                settings.slot4img = bottomIMG.source
                settings.slot4text = playerText.text
                settings.slot4source = player.source
              }
            }

            states: State {
              name: "pressed"; when: mouseArea4.pressed
              PropertyChanges { target: slot4; scale: 1.03 }
            }

            transitions: Transition {
              NumberAnimation { properties: "scale"; duration: 50; easing.type: Easing.InOutQuad }
            }
          }
        }
      }
      Rectangle {
        width: parent.width
        height: units.gu(4)
        anchors.bottom: parent.bottom

        color: theme.palette.normal.background

        Rectangle {
          width: parent.width
          height: units.gu(0.1)
          color: theme.palette.normal.base
        }
      }
    }
  }

  // PlayerPage. It shows up when the screen is bigger then units.gu(100), e.g. tablets or computers
  Rectangle {
    id: playerPage

    height: parent.height
    width: units.gu(39.9)//parent.width / 4

    color: theme.palette.normal.background

    anchors {
      right: parent.right
      bottom: root.bottom
    }

    visible: {
      if (parent.width < units.gu(100)) {
        false
      }
      else {
        true
      }
    }

    // Content below

    Rectangle {
      z: 30
      width: units.gu(0.1)
      height: parent.height - playerPageHeader.height + units.gu(0.1)
      color: theme.palette.normal.base
      anchors.right: parent.left
      anchors.bottom: parent.bottom
    }

    MouseArea {
      // Ensures that in tablet mode the page behind the playpage is not 'touched'
      anchors.fill: parent
    }

    PageHeader {
      z: 20
      id: playerPageHeader
      title: "Nu aan het afspelen"
    }

    Rectangle {
      z: 10
      height: centerIMG.height / 7
      width: centerIMG.width

      anchors {
        left: parent.left
        bottom: centerIMG.bottom
      }

      color: "#111111"
      opacity: 0.8

      Text {
        color: "white"

        anchors {
          verticalCenter: parent.verticalCenter
          left: parent.left
          leftMargin: units.gu(2)
        }

        text: {
          if (settings.image == "") {
            "Selecteer een zender..."
          }
          else {
            playerText.text
          }
        }

        font.pointSize: parent.height / 3
      }
    }

    Image {
      z: 5
      id: centerIMG
      height: width
      width: parent.width

      anchors {
        left: parent.left
        top: playerPageHeader.bottom
      }

      // Fetch the larger image for the playerPage
      source: bottomIMG.source + "_large.jpg"

    }

    Rectangle {
      z: 9
      height: centerIMG.height
      width: centerIMG.width

      color: theme.palette.normal.background

      anchors {
        horizontalCenter: centerIMG.horizontalCenter
        verticalCenter: centerIMG.verticalCenter
      }

      visible: {
        if (settings.image == "") {
          true
        }
        else {
          false
        }
      }
    }

    Image {
      z: 7
      height: width
      width: centerIMG.width / 1.8

      anchors {
        horizontalCenter: centerIMG.horizontalCenter
        verticalCenter: centerIMG.verticalCenter
      }

      source: centerIMG.source

    }

    FastBlur {
      z: 5
      anchors.fill: centerIMG

      source: centerIMG
      radius: 32
    }

    // This rectangle cointains te player button from the playerPage
    Rectangle {
      z: 10
      height: parent.height - centerIMG.height - playerPageHeader.height
      width: parent.width

      color: theme.palette.normal.background

      anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
      }

      Icon {
        z: 3
        width: units.gu(5)
        height: width

        anchors {
          verticalCenter: parent.verticalCenter
          horizontalCenter: parent.horizontalCenter
        }

        name: playerIcon.name

        MouseArea {
          anchors.fill: parent
          onClicked: {
            if (player.playbackState == true) {
              player.stop()
            }
            else {
              player.play()
            }
          }
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
        color: theme.palette.normal.activity
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
      text: "<b>Van categorie wisselen</b><br>Bovenin het scherm kun je wisselen tussen landelijke, alternatieve en regionale zenders.<br> <br><b>Favorieten toevoegen</b><br>Veeg vanaf de onderkant van het scherm omhoog om de favorieten te tonen.<br> <br>Houd een (leeg) slot lang ingedrukt en het huidig spelende radiostation wordt aan de favorieten toegevoegd.<br> <br>Tik op een bestaande favoriet om het radiostation af te spelen."
      Button {
        text: "Sluiten"
        color: theme.palette.normal.activity
        onClicked: {
          PopupUtils.close(dialogue3)
        }
      }
    }
  }

  Component {
    id: aboutDialog
    Dialog {
      id: dialogue4
      title: "Over Radio NL"
      Text {
        text: '<b>Versie: 2.1</b> <br><b>Broncode:</b> <a href="https://github.com/SanderKlootwijk/RadioNL">GitHub</a><br><b>Licentie:</b> <a href="https://tldrlegal.com/license/mit-license">MIT Licentie</a><br><br> <br>© 2018-2020 Sander Klootwijk'
        color: theme.palette.normal.baseText
        horizontalAlignment: Text.AlignHCenter
        onLinkActivated: Qt.openUrlExternally(link)
      }
      Button {
        text: "Sluiten"
        color: theme.palette.normal.activity
        onClicked: {
          PopupUtils.close(dialogue4)
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
