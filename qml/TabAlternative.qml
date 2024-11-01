import QtQuick 2.9
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3
import "components"

Item {
    id: tabAlternative

    Scrollbar {
        z: 1
        id: scrollAlternative

        flickableItem: flickAlternative
        align: Qt.AlignTrailing
    }

    Flickable {
        id: flickAlternative

        anchors.fill: parent

        contentWidth: columnAlternative.width
        contentHeight: columnAlternative.height

        Column {
            id: columnAlternative

            width: tabAlternative.width

            /* COMMERCIAL STATIONS */

            StationDivider {
                  text: i18n.tr("Commercial Stations")
            }

            Station {
                name: "BNR Nieuwsradio"
                subText: "Blijf Scherp."
                logo: "img/bnr.jpg"
                source: "https://stream.bnr.nl/bnr_mp3_128_20"
            }

            Station {
                name: "classicnl"
                subText: "Klassiek voor iedereen"
                logo: "img/classicnl.jpg"
                source: "https://stream.classic.nl/classicnl.mp3"
            }

            Station {
                name: "Soul Radio"
                subText: "Soul muziek"
                logo: "img/soulradio.jpg"
                source: "https://playerservices.streamtheworld.com/api/livestream-redirect/SOULRADIO.mp3"
            }

            Station {
                name: "Sublime FM"
                subText: "Let's get it on!"
                logo: "img/sublimefm.jpg"
                source: "http://stream.sublimefm.nl/SublimeFM_mp3"
            }

            StationDivider {}

            Station {
                name: "KINK"
                subText: "Alternative Rock_Radio"
                logo: "img/kink.jpg"
                source: "https://playerservices.streamtheworld.com/api/livestream-redirect/KINK.mp3"
            }

            Station {
                name: "IndieXL"
                subText: "Durf te ontdekken, luister IndieXL!"
                logo: "img/indiexl.jpg"
                source: "http://server-23.stream-server.nl:8438/stream?type=http&nocache=40388"
            }

            StationDivider {}

            Station {
                name: "Arrow Classic Rock"
                subText: "Classic en modern rock"
                logo: "img/arrowclassicrock.jpg"
                source: "http://stream.gal.io/arrow"
            }

            Station {
                name: "Arrow Caz"
                subText: "Your Hits, More Music"
                logo: "img/arrowcaz.jpg"
                source: "http://stream.arrowcaz.nl/caz128kmp3"
            }

            StationDivider {}

            Station {
                name: "ZTACK"
                subText: "Shuffle Your Day"
                logo: "img/ztack.jpg"
                source: "https://audio.ztack.nl/radio/8000/ztack"
            }

            Station {
                name: "Joe"
                subText: "Good times, great music"
                logo: "img/joe.jpg"
                source: "https://stream.joe.nl/joe/mp3"
            }

            /* END OF COMMERCIAL STATIONS */

            /* PUBLIC STATIONS */

            StationDivider {
                text: i18n.tr("Dutch Public Broadcasting")
            }

            Station {
                name: "NPO Radio 2 Soul & Jazz"
                subText: "De hele dag relaxte muziek"
                logo: "img/nporadio2soul&jazz.jpg"
                source: "http://icecast.omroep.nl/radio6-bb-mp3"
            }

            Station {
                name: "NPO Campus Radio"
                subText: "Tune in to tomorrow"
                logo: "img/npocampusradio.jpg"
                source: "http://icecast.omroep.nl/3fm-serioustalent-mp3"
            }

            Station {
                name: "NPO Sterren NL"
                subText: "De nummer 1 in Nederlandstalige muziek"
                logo: "img/sterrennl.jpg"
                source: "http://icecast.omroep.nl/radio2-sterrennl-mp3"
            }

            // FunX stations

            StationDivider {
                text: i18n.tr("FunX Stations")
            }

            Station {
                name: "FunX NL"
                subText: "your city your sound"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-bb-mp3"
            }

            Station {
                name: "FunX Amsterdam"
                subText: "Amsterdam"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-amsterdam-bb-mp3"
            }

            Station {
                name: "FunX Rotterdam"
                subText: "Rotterdam"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-rotterdam-bb-mp3"
            }

            Station {
                name: "FunX Den Haag"
                subText: "Den Haag"
                logo: "img/funx.jpg"
                source: "http://icecast.omroep.nl/funx-denhaag-bb-mp3"
            }

            Station {
                name: "FunX Utrecht"
                subText: "Utrecht"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-utrecht-bb-mp3"
            }

            Station {
                name: "FunX Arab"
                subText: "Arabische muziek (Raï)"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-arab-bb-mp3"
            }

            Station {
                name: "FunX Dance"
                subText: "Dance muziek"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-dance-bb-mp3"
            }

            Station {
                name: "FunX Hip Hop"
                subText: "Hip Hop"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-hiphop-bb-mp3"
            }

            Station {
                name: "FunX Latin"
                subText: "Latin muziek"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-latin-bb-mp3"
            }

            Station {
                name: "FunX Reggae"
                subText: "Reggae"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-reggae-bb-mp3"
            }

            Station {
                name: "FunX Slow Jamz"
                subText: "Slow Jamz"
                logo: "img/funx.jpg"
                source: "https://icecast.omroep.nl/funx-slowjamz-bb-mp3"
            }            

            /* END OF PUBLIC STATIONS */
        }
    }
}