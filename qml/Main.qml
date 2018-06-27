import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.0
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
              source: "https://www.buienradar.nl/resources/images/logor.svg"
              onStatusChanged: if (testImg.status == Image.Ready) console.log('TestImg is loaded!')


          }

          Timer {
              id: delaytimer
              interval: 2000
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
    anchors.fill: parent
    header: PageHeader {
      id: header
      height: units.gu(9)
      title: i18n.tr('Radio NL')

Sections {
  anchors.bottom: parent.bottom
  anchors.horizontalCenter: parent.horizontalCenter
  actions: [
  Action {
    text: "Landelijk"
    onTriggered: {
      scrollLandelijk.visible = true
      flickLandelijk.state = "landelijk"
      flickRegionaal.state = "landelijk"
      scrollRegionaal.visible = false
    }
  },
  Action {
    text: "Regionaal"
    onTriggered: {
      if (settings.tutorialRegionaal == "true"){
          PopupUtils.open(tutorialRegionaalDialog)
          scrollRegionaal.visible = true
          flickLandelijk.state = "regionaal"
          flickRegionaal.state = "regionaal"
          scrollLandelijk.visible = false
      }
      else{
        scrollRegionaal.visible = true
        flickLandelijk.state = "regionaal"
        flickRegionaal.state = "regionaal"
        scrollLandelijk.visible = false
      }
    }
  }
  ]
}
}

Settings {
  id: settings
  property string source: ""
  property string image: ""
  property string text: ""
  property string tutorialMain: "true"
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
}

//Component.onCompleted: { player.source = settings.source; bottomIMG.source = settings.image; playerText.text = settings.text }

Component.onCompleted: {
  if (settings.tutorialMain == "true"){
      PopupUtils.open(tutorialMainDialog)
      player.source = settings.source
      bottomIMG.source = settings.image
      playerText.text = settings.text
  }
  else{
    player.source = settings.source
    bottomIMG.source = settings.image
    playerText.text = settings.text
  }
}

Flickable {
  id: flickLandelijk
  width: parent.width
  height: parent.height - units.gu(15)
  anchors {
    right: parent.right
    bottom: bottomMenu.top
  }
  contentWidth: zendersLandelijkColumn.width
  contentHeight: zendersLandelijkColumn.height

  states: State {
    name: "regionaal"
    AnchorChanges { target: flickLandelijk; anchors.right: parent.left }
  }

  State {
    name: "landeljk"
    AnchorChanges { target: flickLandelijk; anchors.right: parent.right }
  }

  transitions: Transition {
    // smoothly reanchor myRect and move into new position
    AnchorAnimation { duration: 250 }
  }

  Column {
    id: zendersLandelijkColumn
    width: root.width
    //spacing: units.gu(1)

    /* NPO ZENDERS */

    Rectangle {
      id: nporadio1
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/nporadio1.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/radio1-bb-mp3"
            settings.source = "http://icecast.omroep.nl/radio1-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "NPO Radio 1"
            settings.text = "NPO Radio 1"
            bottomIMG.source = "img/nporadio1.jpg"
            settings.image = "img/nporadio1.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/nporadio1back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: nporadio2
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "grey"

      Image {
        z: 3
        source: "img/nporadio2.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/radio2-bb-mp3"
            settings.source = "http://icecast.omroep.nl/radio2-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "NPO Radio 2"
            settings.text = "NPO Radio 2"
            bottomIMG.source = "img/nporadio2.jpg"
            settings.image = "img/nporadio2.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/nporadio2back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: npo3fm
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/npo3fm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/3fm-bb-mp3"
            settings.source = "http://icecast.omroep.nl/3fm-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "NPO 3FM"
            settings.text = "NPO 3FM"
            bottomIMG.source = "img/npo3fm.jpg"
            settings.image = "img/npo3fm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/npo3fmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: nporadio4
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/nporadio4.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/radio4-bb-mp3"
            settings.source = "http://icecast.omroep.nl/radio4-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "NPO Radio 4"
            settings.text = "NPO Radio 4"
            bottomIMG.source = "img/nporadio4.jpg"
            settings.image = "img/nporadio4.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/nporadio4back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: nporadio5
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/nporadio5.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/radio5-bb-mp3"
            settings.source = "http://icecast.omroep.nl/radio5-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "NPO Radio 5"
            settings.text = "NPO Radio 5"
            bottomIMG.source = "img/nporadio5.jpg"
            settings.image = "img/nporadio5.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/nporadio5back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    /* EINDE NPO ZENDERS */

    Rectangle {
      color: "transparent"
      height: units.gu(2)
      width: parent.width
    }

    /* COMMERCIEEL */

    Rectangle {
      id: qmusic
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/qmusic.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast-qmusic.cdp.triple-it.nl/Qmusic_nl_live_96.mp3"
            settings.source = "http://icecast-qmusic.cdp.triple-it.nl/Qmusic_nl_live_96.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Q-music"
            settings.text = "Q-music"
            bottomIMG.source = "img/qmusic.jpg"
            settings.image = "img/qmusic.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/qmusicback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: radio538
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radio538.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://18973.live.streamtheworld.com/RADIO538.mp3"
            settings.source = "http://18973.live.streamtheworld.com/RADIO538.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio 538"
            settings.text = "Radio 538"
            bottomIMG.source = "img/radio538.jpg"
            settings.image = "img/radio538.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radio538back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: skyradio
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/skyradio.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://playerservices.streamtheworld.com/api/livestream-redirect/SKYRADIO.mp3"
            settings.source = "http://playerservices.streamtheworld.com/api/livestream-redirect/SKYRADIO.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Sky Radio"
            settings.text = "Sky Radio"
            bottomIMG.source = "img/skyradio.jpg"
            settings.image = "img/skyradio.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/skyradioback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: radio10
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radio10.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://20853.live.streamtheworld.com/RADIO10.mp3"
            settings.source = "http://20853.live.streamtheworld.com/RADIO10.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio 10"
            settings.text = "Radio 10"
            bottomIMG.source = "img/radio10.jpg"
            settings.image = "img/radio10.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radio10back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: radioveronica
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radioveronica.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://19993.live.streamtheworld.com/VERONICA.mp3"
            settings.source = "http://19993.live.streamtheworld.com/VERONICA.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio Veronica"
            settings.text = "Radio Veronica"
            bottomIMG.source = "img/radioveronica.jpg"
            settings.image = "img/radioveronica.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radioveronicaback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: honderdpnl
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/100pnl.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.100p.nl/100pctnl.mp3"
            settings.source = "http://stream.100p.nl/100pctnl.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "100% NL"
            settings.text = "100% NL"
            bottomIMG.source = "img/100pnl.jpg"
            settings.image = "img/100pnl.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/100pnlback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: slam
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/slam.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "https://stream.slam.nl/slam_mp3"
            settings.source = "https://stream.slam.nl/slam_mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "SLAM!"
            settings.text = "SLAM!"
            bottomIMG.source = "img/slam.jpg"
            settings.image = "img/slam.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/slamback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    /* EINDE COMMERCIEEL */


  }
}

Flickable {
  id: flickRegionaal
  width: parent.width
  height: parent.height - units.gu(15)
  anchors {
    left: parent.right
    bottom: bottomMenu.top
  }
  contentWidth: zendersRegionaalColumn.width
  contentHeight: zendersRegionaalColumn.height

  states: State {
    name: "regionaal"
    AnchorChanges { target: flickRegionaal; anchors.left: parent.left }
  }
  State {
    name: "landelijk"
    AnchorChanges { target: flickRegionaal; anchors.left: parent.right }
  }

  transitions: Transition {
    // smoothly reanchor myRect and move into new position
    AnchorAnimation { duration: 250 }
  }

  Column {
    id: zendersRegionaalColumn
    width: root.width
    //spacing: units.gu(1)

    /* REGIO */

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: fritext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Friesland"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: fritext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.frivisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (settings.frivisible == "false") {
            settings.frivisible = "true"
          }
          else {
            settings.frivisible = "false"
          }
      }
    }
    }

    Rectangle {
      id: omropfryslan
      visible: {
        if (settings.frivisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/omropfryslan.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.pmedia70.kpnstreaming.nl/omropfryslanlive-OmropFryslanRadio.mp3"
            settings.source = "http://icecast.pmedia70.kpnstreaming.nl/omropfryslanlive-OmropFryslanRadio.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Omrop Fryslân"
            settings.text = "Omrop Fryslân"
            bottomIMG.source = "img/omropfryslan.jpg"
            settings.image = "img/omropfryslan.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/omropfryslanback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      id: waterstadfm
      visible: {
        if (settings.frivisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/waterstadfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.waterstadfm.nl/waterstadfm"
            settings.source = "http://stream.waterstadfm.nl/waterstadfm"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Waterstad FM"
            settings.text = "Waterstad FM"
            bottomIMG.source = "img/waterstadfm.jpg"
            settings.image = "img/waterstadfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/waterstadfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      id: radiocentraal
      visible: {
        if (settings.frivisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radiocentraal.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://centraal.mm-stream.nl:8017/stream"
            settings.source = "http://centraal.mm-stream.nl:8017/stream"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio Centraal"
            settings.text = "Radio Centraal"
            bottomIMG.source = "img/radiocentraal.jpg"
            settings.image = "img/radiocentraal.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radiocentraalback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      id: rtvnof
      visible: {
        if (settings.frivisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/rtvnof.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://media02.streampartner.nl:8056/live"
            settings.source = "http://media02.streampartner.nl:8056/live"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "RTV Noordoost Friesland"
            settings.text = "RTV Noordoost Friesland"
            bottomIMG.source = "img/rtvnof.jpg"
            settings.image = "img/rtvnof.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/rtvnofback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      id: radiospannenburg
      visible: {
        if (settings.frivisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radiospannenburg.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://37.59.195.28:8132/;"
            settings.source = "http://37.59.195.28:8132/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio Spannenburg"
            settings.text = "Radio Spannenburg"
            bottomIMG.source = "img/radiospannenburg.jpg"
            settings.image = "img/radiospannenburg.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radiospannenburgback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      id: leofm
      visible: {
        if (settings.frivisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/leofm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://rs5.stream24.org:8390/;*.mp3"
            settings.source = "http://rs5.stream24.org:8390/;*.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Leo FM"
            settings.text = "Leo FM"
            bottomIMG.source = "img/leofm.jpg"
            settings.image = "img/leofm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/leofmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: grotext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Groningen"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: grotext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.grovisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: drentext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Drenthe"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: drentext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.drenvisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: overtext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Overijssel"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: overtext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.overvisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: fletext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Flevoland"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: fletext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.flevisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Gelderland"
        id: getext
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: getext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.gevisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (settings.gevisible == "false") {
            settings.gevisible = "true"
          }
          else {
            settings.gevisible = "false"
          }
      }
    }
    }

    Rectangle {
      id: omroepgelderland
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/omroepgelderland.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.omroepgelderland.nl/radiogelderland"
            settings.source = "http://stream.omroepgelderland.nl/radiogelderland"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Omroep Gelderland"
            settings.text = "Omroep Gelderland"
            bottomIMG.source = "img/omroepgelderland.jpg"
            settings.image = "img/omroepgelderland.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/omroepgelderlandback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }

      }
    }

    Rectangle {
      id: keizerstad
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/keizerstad.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://server-06.stream-server.nl:8800/;"
            settings.source = "http://server-06.stream-server.nl:8800/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Keizerstad Hits"
            settings.text = "Keizerstad Hits"
            bottomIMG.source = "img/keizerstad.jpg"
            settings.image = "img/keizerstad.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/keizerstadback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: radio024
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radio024.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://high.024.fm:8338/live"
            settings.source = "http://high.024.fm:8338/live"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio 024"
            settings.text = "Radio 024"
            bottomIMG.source = "img/radio024.jpg"
            settings.image = "img/radio024.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radio024back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: rn7
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/rn7.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "https://icecast.streamone.net/i4NtlopQlQUk"
            settings.source = "https://icecast.streamone.net/i4NtlopQlQUk"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "RN7"
            settings.text = "RN7"
            bottomIMG.source = "img/rn7.jpg"
            settings.image = "img/rn7.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/rn7back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: rtvtotaal
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/rtvtotaal.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast01.rodney.it/rtvtotaal"
            settings.source = "http://icecast01.rodney.it/rtvtotaal"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "RTV Totaal"
            settings.text = "RTV Totaal"
            bottomIMG.source = "img/rtvtotaal.jpg"
            settings.image = "img/rtvtotaal.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/rtvtotaalback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: achterhoekfm
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/achterhoekfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.streamone.nl/h7MniPPz5a?.mp3"
            settings.source = "http://icecast.streamone.nl/h7MniPPz5a?.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Achterhoek FM"
            settings.text = "Achterhoek FM"
            bottomIMG.source = "img/achterhoekfm.jpg"
            settings.image = "img/achterhoekfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/achterhoekfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: omroepnijkerk
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/omroepnijkerk.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://studio.omroepn.nl:443/nfm.mp3;"
            settings.source = "http://studio.omroepn.nl:443/nfm.mp3;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Omroep Nijkerk"
            settings.text = "Omroep Nijkerk"
            bottomIMG.source = "img/omroepnijkerk.jpg"
            settings.image = "img/omroepnijkerk.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/omroepnijkerkback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: zorgomroeprivierenland
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/zorgomroeprivierenland.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://zot.shoutcaststream.com:8048/;"
            settings.source = "http://zot.shoutcaststream.com:8048/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Zorgomroep Rivierenland"
            settings.text = "Zorgomroep Rivierenland"
            bottomIMG.source = "img/zorgomroeprivierenland.jpg"
            settings.image = "img/zorgomroeprivierenland.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/zorgomroeprivierenlandback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: favorietfm
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/favorietfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.rtv-favoriet.nl/ffm-320-mp3"
            settings.source = "http://stream.rtv-favoriet.nl/ffm-320-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Favoriet FM"
            settings.text = "Favoriet FM"
            bottomIMG.source = "img/favorietfm.jpg"
            settings.image = "img/favorietfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/favorietfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: klassefm
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/klassefm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.klasse.fm:8070/;"
            settings.source = "http://stream.klasse.fm:8070/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Klasse.FM"
            settings.text = "Klasse.FM"
            bottomIMG.source = "img/klassefm.jpg"
            settings.image = "img/klassefm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/klassefmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: vierdaagseradio
      visible: {
        if (settings.gevisible == "false") {
          false
        }
        else {
          true
        }
    }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/4daagseradio.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.streamone.nl/k3MNdo0Azq?hash=1519746132620.mp3"
            settings.source = "http://icecast.streamone.nl/k3MNdo0Azq?hash=1519746132620.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "4daagse radio"
            settings.text = "4daagse radio"
            bottomIMG.source = "img/4daagseradio.jpg"
            settings.image = "img/4daagseradio.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/4daagseradioback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: uttext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Utrecht"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: uttext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.utvisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (settings.utvisible == "false") {
            settings.utvisible = "true"
          }
          else {
            settings.utvisible = "false"
          }
      }
    }
    }

    Rectangle {
      id: mutrecht
      visible: {
        if (settings.utvisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/mutrecht.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/rtvutrecht-radio-m-bb-mp3"
            settings.source = "http://icecast.omroep.nl/rtvutrecht-radio-m-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio M Utrecht"
            settings.text = "Radio M Utrecht"
            bottomIMG.source = "img/mutrecht.jpg"
            settings.image = "img/mutrecht.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/mutrechtback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: eva
      visible: {
        if (settings.utvisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/eva.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.mediagroep-eva.nl:8001/radio"
            settings.source = "http://stream.mediagroep-eva.nl:8001/radio"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "EVA | Amersfoort & Leusden"
            settings.text = "EVA | Amersfoort & Leusden"
            bottomIMG.source = "img/eva.jpg"
            settings.image = "img/eva.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/evaback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: midlandfm
      visible: {
        if (settings.utvisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/midlandfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://s6streampakket.com:8204/;"
            settings.source = "http://s6streampakket.com:8204/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Midland FM"
            settings.text = "Midland FM"
            bottomIMG.source = "img/midlandfm.jpg"
            settings.image = "img/midlandfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/midlandfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: bingofm
      visible: {
        if (settings.utvisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/bingofm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/rtvutrecht-bingo-fm-bb-mp3"
            settings.source = "http://icecast.omroep.nl/rtvutrecht-bingo-fm-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Bingo FM"
            settings.text = "Bingo FM"
            bottomIMG.source = "img/bingofm.jpg"
            settings.image = "img/bingofm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/bingofmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: rtvbaarn
      visible: {
        if (settings.utvisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/rtvbaarn.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.streamone.net/IJAFJ-oRIZUy"
            settings.source = "http://icecast.streamone.net/IJAFJ-oRIZUy"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "RTV Baarn"
            settings.text = "RTV Baarn"
            bottomIMG.source = "img/rtvbaarn.jpg"
            settings.image = "img/rtvbaarn.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/rtvbaarnback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: valleiradio
      visible: {
        if (settings.utvisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/valleiradio.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://server-25.stream-server.nl:8366/;"
            settings.source = "http://server-25.stream-server.nl:8366/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "ValleiRadio.nl"
            settings.text = "ValleiRadio.nl"
            bottomIMG.source = "img/valleiradio.jpg"
            settings.image = "img/valleiradio.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/valleiradioback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: nohotext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Noord-Holland"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: nohotext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.nohovisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (settings.nohovisible == "false") {
            settings.nohovisible = "true"
          }
          else {
            settings.nohovisible = "false"
          }
      }
    }
    }

    Rectangle {
      id: nhradio
      visible: {
        if (settings.nohovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/nhradio.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://rtvnh-ics1.streamgate.nl/rtvnh"
            settings.source = "http://rtvnh-ics1.streamgate.nl/rtvnh"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "NH Radio"
            settings.text = "NH Radio"
            bottomIMG.source = "img/nhradio.jpg"
            settings.image = "img/nhradio.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/nhradioback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: zesfm
      visible: {
        if (settings.nohovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/zesfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://6fm.nl:8000/mp3live"
            settings.source = "http://6fm.nl:8000/mp3live"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "6FM"
            settings.text = "6FM"
            bottomIMG.source = "img/zesfm.jpg"
            settings.image = "img/zesfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/zesfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: funxamsterdam
      visible: {
        if (settings.nohovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/funxamsterdam.jpeg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/funx-amsterdam-bb-mp3"
            settings.source = "http://icecast.omroep.nl/funx-amsterdam-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "FunX Amsterdam"
            settings.text = "FunX Amsterdam"
            bottomIMG.source = "img/funxamsterdam.jpeg"
            settings.image = "img/funxamsterdam.jpeg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/funxamsterdamback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: meerradio
      visible: {
        if (settings.nohovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/meerradio.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://www.meerradio.nl:8000/;stream.mp3"
            settings.source = "http://www.meerradio.nl:8000/;stream.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "MeerRadio"
            settings.text = "MeerRadio"
            bottomIMG.source = "img/meerradio.jpg"
            settings.image = "img/meerradio.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/meerradioback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: haarlem105
      visible: {
        if (settings.nohovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/haarlem105.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://studio.haarlem105.nl:8000/haarlem105.mp3"
            settings.source = "http://studio.haarlem105.nl:8000/haarlem105.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Haarlem 105"
            settings.text = "Haarlem 105"
            bottomIMG.source = "img/haarlem105.jpg"
            settings.image = "img/haarlem105.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/haarlem105back.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: rtvamstelveen
      visible: {
        if (settings.nohovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/rtvamstelveen.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://217.21.199.146:8084/stream?icy=http"
            settings.source = "http://217.21.199.146:8084/stream?icy=http"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "RTV Amstelveen"
            settings.text = "RTV Amstelveen"
            bottomIMG.source = "img/rtvamstelveen.jpg"
            settings.image = "img/rtvamstelveen.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/rtvamstelveenback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: zuhotext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Zuid-Holland"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: zuhotext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.zuhovisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (settings.zuhovisible == "false") {
            settings.zuhovisible = "true"
          }
          else {
            settings.zuhovisible = "false"
          }
      }
    }
    }

    Rectangle {
      id: havenstadradio
      visible: {
        if (settings.zuhovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/havenstadradio.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://mediaserv33.live-streams.nl:8056/stream"
            settings.source = "http://mediaserv33.live-streams.nl:8056/stream"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Havenstad Radio"
            settings.text = "Havenstad Radio"
            bottomIMG.source = "img/havenstadradio.jpg"
            settings.image = "img/havenstadradio.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/havenstadradioback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: rtvrijnmond
      visible: {
        if (settings.zuhovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/rtvrijnmond.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://d2e9xgjjdd9cr5.cloudfront.net/icecast/rijnmond/radio-mp3"
            settings.source = "http://d2e9xgjjdd9cr5.cloudfront.net/icecast/rijnmond/radio-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "RTV Rijnmond"
            settings.text = "RTV Rijnmond"
            bottomIMG.source = "img/rtvrijnmond.jpg"
            settings.image = "img/rtvrijnmond.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/rtvrijnmondback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: omroepwest
      visible: {
        if (settings.zuhovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/omroepwest.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://d3jhv0ayn0z3fg.cloudfront.net/icecast/omroepwest/radio"
            settings.source = "http://d3jhv0ayn0z3fg.cloudfront.net/icecast/omroepwest/radio"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Omroep West"
            settings.text = "Omroep West"
            bottomIMG.source = "img/omroepwest.jpg"
            settings.image = "img/omroepwest.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/omroepwestback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: zfm
      visible: {
        if (settings.zuhovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/zfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://www.kippingmultimediaal.nl:8000/ZFMmobiel"
            settings.source = "http://www.kippingmultimediaal.nl:8000/ZFMmobiel"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "ZFM"
            settings.text = "ZFM"
            bottomIMG.source = "img/zfm.jpg"
            settings.image = "img/zfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/zfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: funxdenhaag
      visible: {
        if (settings.zuhovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/funxdenhaag.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://icecast.omroep.nl/funx-denhaag-bb-mp3"
            settings.source = "http://icecast.omroep.nl/funx-denhaag-bb-mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "FunX Den Haag"
            settings.text = "FunX Den Haag"
            bottomIMG.source = "img/funxdenhaag.jpg"
            settings.image = "img/funxdenhaag.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/funxdenhaagback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: denhaagfm
      visible: {
        if (settings.zuhovisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/denhaagfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://82.94.205.122/proxy/haagseomroep?mp=/denhaagfm"
            settings.source = "http://82.94.205.122/proxy/haagseomroep?mp=/denhaagfm"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Den Haag FM"
            settings.text = "Den Haag FM"
            bottomIMG.source = "img/denhaagfm.jpg"
            settings.image = "img/denhaagfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors {
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/denhaagfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: zeetext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Zeeland"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: zeetext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.zeevisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if (settings.zeevisible == "false") {
            settings.zeevisible = "true"
          }
          else {
            settings.zeevisible = "false"
          }
      }
    }
    }

    Rectangle {
      id: omroepzeeland
      visible: {
        if (settings.zeevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/omroepzeeland.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://livestream.zeelandnet.nl:8000/omroepzeeland_radio"
            settings.source = "http://livestream.zeelandnet.nl:8000/omroepzeeland_radio"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Omproep Zeeland"
            settings.text = "Omroep Zeeland"
            bottomIMG.source = "img/omroepzeeland.jpg"
            settings.image = "img/omroepzeeland.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/omroepzeelandback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: omroeptholen
      visible: {
        if (settings.zeevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/omroeptholen.png"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.dotpoint.nl:8065/stream?type=http&nocache=125381"
            settings.source = "http://stream.dotpoint.nl:8065/stream?type=http&nocache=125381"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Omroep Tholen"
            settings.text = "Omroep Tholen"
            bottomIMG.source = "img/omroeptholen.png"
            settings.image = "img/omroeptholen.png"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/omroeptholenback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: radioschouwenduiveland
      visible: {
        if (settings.zeevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radioschouwenduiveland.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://radio.streamonecloud.net/dM21nd6oMi"
            settings.source = "http://radio.streamonecloud.net/dM21nd6oMi"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio Schouwen-Duiveland"
            settings.text = "Radio Schouwen-Duiveland"
            bottomIMG.source = "img/radioschouwenduiveland.jpg"
            settings.image = "img/radioschouwenduiveland.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radioschouwenduivelandback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: scheldemondfm
      visible: {
        if (settings.zeevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/scheldemondfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://stream.scheldemondfm.nl:8200/;"
            settings.source = "http://stream.scheldemondfm.nl:8200/;"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Scheldemond FM"
            settings.text = "Scheldemond FM"
            bottomIMG.source = "img/scheldemondfm.jpg"
            settings.image = "img/scheldemondfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/scheldemondfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: terneuzenfm
      visible: {
        if (settings.zeevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/terneuzenfm.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://terneuzenfm.shoutcaststream.com:8076/;stream/1"
            settings.source = "http://terneuzenfm.shoutcaststream.com:8076/;stream/1"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Terneuzen FM"
            settings.text = "Terneuzen FM"
            bottomIMG.source = "img/terneuzenfm.jpg"
            settings.image = "img/terneuzenfm.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/terneuzenfmback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      id: radioreimerswaal
      visible: {
        if (settings.zeevisible == "false") {
          false
        }
        else {
          true
        }
      }
      width: parent.width
      height: bottomMenu.height * 1.5
      color: "transparent"

      Image {
        z: 3
        source: "img/radioreimerswaal.jpg"
        height: parent.height
        width: parent.height
        anchors {
          left: parent.left
          bottom: parent.bottom
        }
      }

      Icon {
        z: 3
        width: bottomMenu.height / 1.5
        height: bottomMenu.height / 1.5
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          rightMargin: units.gu(3)
        }
        color: "white"
        name: "media-playback-start"

        MouseArea {
          anchors.fill: parent
          onClicked: {
            player.stop()
            player.source = "http://s44.myradiostream.com:6410/;listen.mp3"
            settings.source = "http://s44.myradiostream.com:6410/;listen.mp3"
            player.play()
            playerIcon.name = "media-playback-stop"
            playerText.text = "Radio Reimerswaal"
            settings.text = "Radio Reimerswaal"
            bottomIMG.source = "img/radioreimerswaal.jpg"
            settings.image = "img/radioreimerswaal.jpg"
          }
        }
      }

      Rectangle {
        z: 1
        width: parent.width - parent.height
        height: parent.height
        anchors{
          right: parent.right
          bottom: parent.bottom
        }
        color: "grey"
        clip: true

        Image {
          width: parent.width
          height: parent.height
          fillMode: Image.PreserveAspectCrop
          source: "img/radioreimerswaalback.png"
          smooth: true
          z: parent.z + 1
          opacity: 0.5
        }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: bratext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Noord-Brabant"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: bratext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.bravisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }
    }

    Rectangle {
      color: "transparent"
      height: units.gu(3)
      width: parent.width

      Text {
        id: limtext
        height: units.gu(2)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: units.gu(4.25)
        text: "Limburg"
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

      Image {
        height: units.gu(1.5)
        width: height
        anchors {
          left: limtext.right
          leftMargin: units.gu(0.75)
          verticalCenter: parent.verticalCenter
        }
        source: {
          if (settings.limvisible == "false") {
            "img/arrow-up.svg"
          }
          else {
            "img/arrow-down.svg"
          }
      }
      }
    }

    /*  REGIONAAL */

  }
}
Rectangle {
  id: bottomMenu
  z: 4
  width: parent.width
  height: units.gu(6)
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
      color: "white"
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

  Audio {
    id: player
    source: " "
  }

  Rectangle {
    width: parent.width
    height: units.gu(0.1)
    color: UbuntuColors.lightGrey
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
    anchors {
      verticalCenter: parent.verticalCenter
      left: bottomIMG.right
      leftMargin: units.gu(3)
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
    color: "#000000"
    name: "media-playback-start"

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
  }
}
Scrollbar {
  id: scrollLandelijk
  visible: true
  flickableItem: flickLandelijk
  align: Qt.AlignTrailing
}
Scrollbar {
  id: scrollRegionaal
  visible: false
  flickableItem: flickRegionaal
  align: Qt.AlignTrailing
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
            id: tutorialRegionaalDialog
            Dialog {
                id: dialogue2
                AnimatedImage {
                  source: "img/gifje.gif"
                  height: width / 0.6
                }
                text: "Klik op het vinkje naast jouw provincie en luister naar je favoriete regionale zender!"
                Button {
                    text: "Ik begrijp het!"
                    color: "#00adda"
                    onClicked: {
                      PopupUtils.close(dialogue2)
                      settings.tutorialRegionaal = "false"
                    }
                }
            }
}

Component {
            id: tutorialMainDialog
            Dialog {
                id: dialogue3
                AnimatedImage {
                  source: "img/gifje2.gif"
                  height: width / 0.6
                }
                text: "Welkom bij Radio NL, dé app waarin je alle Nederlandse radio stations op één plek vindt! Boven in het scherm kan je wisselen tussen landelijke en regionale zenders. Veel luisterplezier!"
                Button {
                    text: "Ik begrijp het!"
                    color: "#00adda"
                    onClicked: {
                      PopupUtils.close(dialogue3)
                      settings.tutorialMain = "false"
                    }
                }
            }
}
}
