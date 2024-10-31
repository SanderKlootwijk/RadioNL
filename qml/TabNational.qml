import QtQuick 2.9
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3
import "components"

Item {
    id: tabNational

    Scrollbar {
        z: 1
        id: scrollNational

        flickableItem: flickNational
        align: Qt.AlignTrailing
    }

    Flickable {
        id: flickNational

        anchors.fill: parent

        contentWidth: columnNational.width
        contentHeight: columnNational.height

        Column {
            id: columnNational

            width: tabNational.width

            /* PUBLIC STATIONS */

            StationDivider {
                text: i18n.tr("Dutch Public Broadcasting")
            }

            Station {
                name: "NPO Radio 1"
                subText: "Wie luistert, weet meer"
                logo: "img/nporadio1.jpg"
                source: "http://icecast.omroep.nl/radio1-bb-mp3"
            }

            Station {
                name: "NPO Radio 2"
                subText: "Er is maar één NPO Radio 2"
                logo: "img/nporadio2.jpg"
                source: "http://icecast.omroep.nl/radio2-bb-mp3"
            }

            Station {
                name: "NPO 3FM"
                subText: "We Want More"
                logo: "img/npo3fm.jpg"
                source: "http://icecast.omroep.nl/3fm-bb-mp3"
            }

            Station {
                name: "NPO Radio 4"
                subText: "Zo mooi is klassiek"
                logo: "img/nporadio4.jpg"
                source: "http://icecast.omroep.nl/radio4-bb-mp3"
            }

            Station {
                name: "NPO Radio 5"
                subText: "Je voelt je thuis bij NPO Radio 5"
                logo: "img/nporadio5.jpg"
                source: "http://icecast.omroep.nl/radio5-bb-mp3"
            }

            /* END OF PUBLIC STATIONS */

            /* COMMERCIAL STATIONS */

            StationDivider {
                text: i18n.tr("Commercial Stations")
            }

            Station {
                name: "Q-music"
                subText: "Q sounds better with you"
                logo: "img/qmusic.jpg"
                source: "https://icecast-qmusicnl-cdp.triple-it.nl/Qmusic_nl_live.mp3"
            }

            Station {
                name: "Radio 538"
                subText: "Jouw hits, jouw 538!"
                logo: "img/radio538.jpg"
                source: "https://22593.live.streamtheworld.com/RADIO538.mp3?dist=tunein"
            }

            Station {
                name: "Sky Radio"
                subText: "The Feel Good Station"
                logo: "img/skyradio.jpg"
                source: "http://22613.live.streamtheworld.com/SKYRADIO.mp3?dist=tunein"
            }

            Station {
                name: "Radio 10"
                subText: "De grootste hits aller tijden!"
                logo: "img/radio10.jpg"
                source: "http://stream.radio10.nl/radio10"
            }

            Station {
                name: "Radio Veronica"
                subText: "WE. LOVE. MUSIC"
                logo: "img/radioveronica.jpg"
                source: "https://playerservices.streamtheworld.com/api/livestream-redirect/VERONICA.mp3"
            }

            Station {
                name: "100% NL"
                subText: "Maakt je dag!"
                logo: "img/100pnl.jpg"
                source: "https://stream.100p.nl/100pctnl.mp3"
            }

            Station {
                name: "SLAM!"
                subText: "Boost Your Life"
                logo: "img/slam.jpg"
                source: "https://stream.slam.nl/slam_mp3?dist=tunein"
            }

            /* END OF COMMERCIAL STATIONS */
        }
    }
}