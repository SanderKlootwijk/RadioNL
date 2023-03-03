import QtQuick 2.9
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3
import "components"

Item {
    id: tabRegional

    Scrollbar {
        z: 1
        id: scrollRegional

        flickableItem: flickRegional
        align: Qt.AlignTrailing
    }

    Flickable {
        id: flickRegional

        anchors.fill: parent

        contentWidth: columnRegional.width
        contentHeight: columnRegional.height

        Column {
            id: columnRegional

            width: tabRegional.width
                
            ListItem {
                id: firstRunListItem
                width: parent.width
                height: stationDividerLabel.contentHeight + units.gu(4)
                
                visible: settings.provinceName == "FirstRun"

                Label {
                    id: stationDividerLabel

                    width: parent.width - units.gu(4)

                    anchors.centerIn: parent
                    
                    text: i18n.tr("Choose a province from the app settings, to show regional radio stations below")
                    
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            /* FRIESLAND */

            Column {
                width: parent.width

                visible: settings.provinceName == "Friesland"            
                
                StationDivider {
                    text: "Friesland"
                }

                Station {
                    name: "Omrop Fryslân"
                    subText: "Ofstimd op dy!"
                    logo: "img/omropfryslan.jpg"
                    source: "https://d3pvma9xb2775h.cloudfront.net/icecast/omropfryslan/radio.mp3"
                }

                Station {
                    name: "Waterstad FM"
                    subText: "Radio uit het Hart van Friesland"
                    logo: "img/waterstadfm.jpg"
                    source: "http://stream.waterstadfm.nl/waterstadfm"
                }

                Station {
                    name: "Radio Centraal"
                    subText: "Lokale omroep Weststellingwerf"
                    logo: "img/radiocentraal.jpg"
                    source: "https://mcp-2.mm-stream.nl:8017/stream"
                }

                Station {
                    name: "RTV Noordoost Friesland"
                    subText: "Nieuws uit Noordoost Friesland"
                    logo: "img/rtvnof.jpg"
                    source: "http://media02.streampartner.nl:8056/live"
                }

                Station {
                    name: "Leo Middelsé"
                    subText: "Omroep voor Leeuwarden en omstreken"
                    logo: "img/leofm.jpg"
                    source: "https://ms5ic.mx-cd.net/238-2265270/LEO_Middelse_Radio"
                }
            }

            /* END OF FRIESLAND */

            /* GRONINGEN */

            Column {
                width: parent.width

                visible: settings.provinceName == "Groningen"            
                
                StationDivider {
                    text: "Groningen"
                }

                Station {
                    name: "Simone FM"
                    subText: "Échte radio"
                    logo: "img/simonefm.jpg"
                    source: "https://stream.simone.nl/simone"
                }

                Station {
                    name: "Radio Westerwolde"
                    subText: "Het nieuwsportaal van de regio!"
                    logo: "img/radiowesterwolde.jpg"
                    source: "http://icecast.radiowesterwolde.nl:8000/G1_RWW"
                }

                Station {
                    name: "RTV Noord"
                    subText: "Het nieuws uit Groningen"
                    logo: "img/rtvnoord.jpg"
                    source: "https://media.rtvnoord.nl/icecast/rtvnoord/radio?.mp3"
                }

                Station {
                    name: "OOG Radio"
                    subText: "Nieuws uit Groningen"
                    logo: "img/oogradio.jpg"
                    source: "https://olon.az.icecast.ebsd.ericsson.net/oog_radio"
                }

                Station {
                    name: "Joy Radio"
                    subText: "Hits only!"
                    logo: "img/joyradio.jpg"
                    source: "http://stream.joyradio.nl/joyradio"
                }
            }

            /* END OF GRONINGEN */

            /* DRENTHE */

            Column {
                width: parent.width

                visible: settings.provinceName == "Drenthe"            
                
                StationDivider {
                    text: "Drenthe"
                }

                Station {
                    name: "RTV Drenthe"
                    subText: "Altijd in de buurt"
                    logo: "img/rtvdrenthe.jpg"
                    source: "https://cdn.rtvdrenthe.nl/icecast/rtvdrenthe/rtvradio"
                }

                Station {
                    name: "ZO!34"
                    subText: "De stem van Zuidoost-Drenthe"
                    logo: "img/zo!34.jpg"
                    source: "https://mcp-2.mm-stream.nl:7000/stream"
                }
            }

            /* END OF DRENTHE */

            /* OVERIJSSEL */

            Column {
                width: parent.width

                visible: settings.provinceName == "Overijssel"            
                
                StationDivider {
                    text: "Overijssel"
                }

                Station {
                    name: "Radio Rosita"
                    subText: "Nonstop de beste mix"
                    logo: "img/radiorosita.jpg"
                    source: "http://audiostreamen.nl:8004/;"
                }

                Station {
                    name: "RTV Oost"
                    subText: "Thuis in Overijssel"
                    logo: "img/rtvoost.jpg"
                    source: "http://streams.rtvoost.nl/audio/oost/mp3"
                }

                Station {
                    name: "RTV SLOS"
                    subText: "Lokale omroep Steenwijkerland"
                    logo: "img/rtvslos.jpg"
                    source: "https://olon.az.icecast.ebsd.ericsson.net/mix105_steenwijkerland"
                }

                Station {
                    name: "Twente FM"
                    subText: "Het radiostation voor Noordoost Twente"
                    logo: "img/twentefm.jpg"
                    source: "http://stream.twentefm.nl:8004/high"
                }

                Station {
                    name: "Radio Hengelo"
                    subText: "De lokale omroep van en voor Hengelo"
                    logo: "img/radiohengelo.jpg"
                    source: "http://stream1.icehosting.nl:8128/;stream.mp3"
                }

                Station {
                    name: "Enschede FM"
                    subText: "24/7 de lekkerste hits op het internet"
                    logo: "img/enschedefm.jpg"
                    source: "http://stream1.icehosting.nl:8126/;stream.mp3"
                }
            }

            /* END OF OVERIJSSEL */

            /* FLEVOLAND */

            Column {
                width: parent.width

                visible: settings.provinceName == "Flevoland"            
                
                StationDivider {
                    text: "Flevoland"
                }

                Station {
                    name: "Omroep Flevoland"
                    subText: "Het laatste nieuws voor Flevoland"
                    logo: "img/omroepflevoland.jpg"
                    source: "https://stream.omroepflevoland.nl/icecast/omroepflevoland/stream1"
                }

                Station {
                    name: "Radio Lelystad"
                    subText: "Altijd in de lucht!"
                    logo: "img/radiolelystad.jpg"
                    source: "http://live.radiolelystad.nl:8000/listen"
                }

                Station {
                    name: "Omroep Almere Radio"
                    subText: "Hét nieuwsplatform voor Almere en Omstreken"
                    logo: "img/omroepalmereradio.jpg"
                    source: "https://stream.rcast.net/65615"
                }

                Station {
                    name: "URK FM"
                    subText: "De lokale omroep voor de gemeente Urk"
                    logo: "img/urkfm.jpg"
                    source: "http://live.urkfm.nl:8000/urkfm.mp3"
                }

                Station {
                    name: "Lokale Omroep Zeewolde"
                    subText: "Uw nieuwsbron uit Zeewolde"
                    logo: "img/omroepzeewolde.jpg"
                    source: "http://stream.lokaleomroepzeewolde.nl:8000/normal"
                }
            }

            /* END OF FLEVOLAND */

            /* GELDERLAND */

            Column {
                width: parent.width

                visible: settings.provinceName == "Gelderland"            
                
                StationDivider {
                    text: "Gelderland"
                }

                Station {
                    name: "Omroep Gelderland"
                    subText: "Altijd in de buurt!"
                    logo: "img/omroepgelderland.jpg"
                    source: "http://stream.omroepgelderland.nl/radiogelderland"
                }

                Station {
                    name: "Keizerstad Hits"
                    subText: "Jouw nummer 1 in Gelderland"
                    logo: "img/keizerstad.jpg"
                    source: "http://server-06.stream-server.nl:8800/;"
                }

                Station {
                    name: "RN7"
                    subText: "De streekomroep voor Nijmegen"
                    logo: "img/rn7.jpg"
                    source: "https://stream.stream.delivery/rn7"
                }

                Station {
                    name: "Favoriet FM"
                    subText: "Jouw Favoriet!"
                    logo: "img/favorietfm.jpg"
                    source: "http://stream.rtv-favoriet.nl:8000/ffm-320-mp3?ver=452769"
                }

                Station {
                    name: "Klasse FM"
                    subText: "Gewoon gezellig!"
                    logo: "img/klassefm.jpg"
                    source: "https://mediaserv38.live-streams.nl:18023/stream"
                }
            }

            /* END OF GELDERLAND */

            /* UTRECHT */

            Column {
                width: parent.width

                visible: settings.provinceName == "Utrecht"            
                
                StationDivider {
                    text: "Utrecht"
                }

                Station {
                    name: "Radio M Utrecht"
                    subText: "Nieuws- en sportzender van de provincie Utrecht"
                    logo: "img/mutrecht.jpg"
                    source: "https://media.rtvutrecht.nl/radiomutrecht-bb-mp3"
                }

                Station {
                    name: "EVA | Amersfoort & Leusden"
                    subText: "De lokale omroep voor Amersfoort en Leusden"
                    logo: "img/eva.jpg"
                    source: "http://stream.mediagroep-eva.nl:8001/radio"
                }

                Station {
                    name: "Radio Midland"
                    subText: "Voor elkaar"
                    logo: "img/midlandfm.jpg"
                    source: "https://caster04.streampakket.com/proxy/8216/stream;"
                }

                Station {
                    name: "Bingo FM"
                    subText: "Nederlandstalige muziek!"
                    logo: "img/bingofm.jpg"
                    source: "https://media.rtvutrecht.nl/bingofm-bb-mp3"
                }

                Station {
                    name: "ValleiRadio.nl"
                    subText: "Radio voor iedereen!"
                    logo: "img/valleiradio.jpg"
                    source: "http://server-25.stream-server.nl:8366/;"
                }
            }

            /* END OF UTRECHT */

            /* NOORD-HOLLAND */

            Column {
                width: parent.width

                visible: settings.provinceName == "Noord-Holland"            
                
                StationDivider {
                    text: "Noord-Holland"
                }

                Station {
                    name: "NH Radio"
                    subText: "Informeert, inspireert en verbindt"
                    logo: "img/nhradio.jpg"
                    source: "http://ice.cr1.streamzilla.xlcdn.com:8000/sz%3Dnhnieuws%3DNHRadio_mp3"
                }

                Station {
                    name: "FunX Amsterdam"
                    subText: "The Sound of the City"
                    logo: "img/funxamsterdam.jpeg"
                    source: "http://icecast.omroep.nl/funx-amsterdam-bb-mp3"
                }

                Station {
                    name: "MeerRadio"
                    subText: "Lokale omroep an Haarlemmermeer"
                    logo: "img/meerradio.jpg"
                    source: "https://olon.az.icecast.ebsd.ericsson.net/meer_radio"
                }
            }

            /* END OF NOORD-HOLLAND */

            /* ZUID-HOLLAND */

            Column {
                width: parent.width

                visible: settings.provinceName == "Zuid-Holland"            
                
                StationDivider {
                    text: "Zuid-Holland"
                }

                Station {
                    name: "Havenstad Radio"
                    subText: "Rotterdams lekkerste popzender"
                    logo: "img/havenstadradio.jpg"
                    source: "http://mediaserv33.live-streams.nl:8056/stream"
                }

                Station {
                    name: "RTV Rijnmond"
                    subText: "Wij zijn erbij!"
                    logo: "img/rtvrijnmond.jpg"
                    source: "http://d2e9xgjjdd9cr5.cloudfront.net/icecast/rijnmond/radio-mp3"
                }

                Station {
                    name: "Omroep West"
                    subText: "Het laatste nieuws, weer en verkeer"
                    logo: "img/omroepwest.jpg"
                    source: "http://d3jhv0ayn0z3fg.cloudfront.net/icecast/omroepwest/radio"
                }

                Station {
                    name: "ZFM"
                    subText: "Dag en nacht hits en nieuws vanuit het hart van Zuid-Holland"
                    logo: "img/zfm.jpg"
                    source: "http://www.kippingmultimediaal.nl:8000/ZFMmobiel"
                }

                Station {
                    name: "FunX Den Haag"
                    subText: "The Sound of the City"
                    logo: "img/funxdenhaag.jpg"
                    source: "http://icecast.omroep.nl/funx-denhaag-bb-mp3"
                }

                Station {
                    name: "Den Haag FM"
                    subText: "100% Haags!"
                    logo: "img/denhaagfm.jpg"
                    source: "http://82.94.205.122/proxy/haagseomroep?mp=/denhaagfm"
                }
            }

            /* END OF ZUID-HOLLAND */

            /* ZEELAND */

            Column {
                width: parent.width

                visible: settings.provinceName == "Zeeland"            
                
                StationDivider {
                    text: "Zeeland"
                }

                Station {
                    name: "Omroep Zeeland"
                    subText: "Regionale omroep voor de provincie Zeeland"
                    logo: "img/omroepzeeland.jpg"
                    source: "http://livestream.zeelandnet.nl:8000/omroepzeeland_radio"
                }

                Station {
                    name: "Omroep Tholen"
                    subText: "Regionale omroep voor regio Tholen"
                    logo: "img/omroeptholen.jpg"
                    source: "http://stream.dotpoint.nl:8065/stream?type=http&nocache=125381"
                }

                Station {
                    name: "Radio Schouwen-Duiveland"
                    subText: "Moet je horen!"
                    logo: "img/radioschouwenduiveland.jpg"
                    source: "http://212.115.192.105:45121/radioschoudui"
                }

                Station {
                    name: "Scheldemond FM"
                    subText: "Omroep voor West Zeeuws Vlaanderen"
                    logo: "img/scheldemondfm.jpg"
                    source: "http://stream.scheldemondfm.nl:8200/;"
                }

                Station {
                    name: "Terneuzen FM"
                    subText: "Dé regionale zender van Terneuzen"
                    logo: "img/terneuzenfm.jpg"
                    source: "http://terneuzenfm.shoutcaststream.com:8076/;stream/1"
                }
            }

            /* END OF ZEELAND */

            /* NOORD-BRABANT */

            Column {
                width: parent.width

                visible: settings.provinceName == "Noord-Brabant"            
                
                StationDivider {
                    text: "Noord-Brabant"
                }

                Station {
                    name: "Glow FM"
                    subText: "Hits Till It Hurts"
                    logo: "img/glowfm.jpg"
                    source: "http://stream.glowfm.nl:8000/glowfm.mp3"
                }

                Station {
                    name: "Kempen FM"
                    subText: "Hét 'Feelgood' Radiostation van de Kempen!"
                    logo: "img/kempenfm.jpg"
                    source: "https://mediacp.audiostreamen.nl/musicbiz"
                }

                Station {
                    name: "Omroep Brabant"
                    subText: "Regionale omroep voor de provincie Noord-Brabant"
                    logo: "img/omroepbrabant.jpg"
                    source: "http://av.omroepbrabant.nl/icecast/omroepbrabant/mp3"
                }

                Station {
                    name: "Omroep Veldhoven"
                    subText: "Het laatste nieuws voor én door Veldhoven"
                    logo: "img/omroepveldhoven.jpg"
                    source: "http://77.166.186.207:8000/Veldhoven"
                }

                Station {
                    name: "Omroep Helmond"
                    subText: "Altijd dichtbij"
                    logo: "img/omroephelmond.jpg"
                    source: "http://stream.omroephelmond.nl:8024/;"
                }

                Station {
                    name: "Radio Horizon"
                    subText: "Streekomroep voor Cranendonck en Heeze-Leende"
                    logo: "img/radiohorizon.jpg"
                    source: "https://www.rtvhorizon.nl/radiostream/mp3"
                }

                Station {
                    name: "Radio Kontakt"
                    subText: "Lokale radio voor de gemeente Laarbeek"
                    logo: "img/radiokontakt.jpg"
                    source: "http://lokaal.kontaktfm.nl:8005/;"
                }

                Station {
                    name: "Langstraat FM"
                    subText: "Radio: Waalwijk, Loon op Zand"
                    logo: "img/langstraatfm.jpg"
                    source: "https://mediaserv30.live-streams.nl:18001/stream"
                }

                Station {
                    name: "Studio040"
                    subText: "Lokale radio voor Eindhoven"
                    logo: "img/studio040.jpg"
                    source: "http://stream.studio040.nl:8000/studio040.mp3"
                }

                Station {
                    name: "Omroep Best"
                    subText: "Lokale omroep van de gemeente Best"
                    logo: "img/omroepbest.jpg"
                    source: "http://109.235.33.237:8000/omroep.mp3"
                }

                Station {
                    name: "Efteling Kids Radio"
                    subText: "Radio voor kinderen"
                    logo: "img/eftelingkidsradio.jpg"
                    source: "http://ice.cr2.streamzilla.xlcdn.com:8000/sz=efteling=hdstream"
                }
            }

            /* END OF NOORD-BRABANT */

            /* LIMBURG */

            Column {
                width: parent.width

                visible: settings.provinceName == "Limburg"            
                
                StationDivider {
                    text: "Limburg"
                }

                Station {
                    name: "Maasland Radio"
                    subText: "Jouw Regio Radio"
                    logo: "img/maaslandradio.jpg"
                    source: "http://maaslandradio.shoutcaststream.com:8006/stream"
                }

                Station {
                    name: "Omroep Venray"
                    subText: "Ook voor jou!"
                    logo: "img/omroepvenray.jpg"
                    source: "http://icecast.omroepvenray.nl/lov.mp3"
                }

                Station {
                    name: "L1 Radio"
                    subText: "Liefde voor Limburg"
                    logo: "img/l1radio.jpg"
                    source: "http://d34pj260kw1xmk.cloudfront.net/icecast/l1/radio-bb-mp3"
                }

                Station {
                    name: "RTV Maastricht Radio"
                    subText: "Lokale radio voor Maastricht"
                    logo: "img/rtvmaastrichtradio.jpg"
                    source: "http://stream.rtvmaastricht.nl:8081/rtv/radio_audio/icecast.audio"
                }

                Station {
                    name: "Radio Grensland"
                    subText: "Een grenzeloos idee!"
                    logo: "img/radiogrensland.jpg"
                    source: "https://antares.dribbcast.com/proxy/grensland?mp=/stream"
                }

                Station {
                    name: "Omroep Venlo"
                    subText: "Lokale omroep van de gemeente Venlo"
                    logo: "img/omroepvenlo.jpg"
                    source: "https://olon.az.icecast.ebsd.ericsson.net/omroep_venlo"
                }

                Station {
                    name: "Weert FM"
                    subText: "Lokale omroep voor Weert en Nederweert"
                    logo: "img/weertfm.jpg"
                    source: "http://weertfm.mooo.com:9000/wfm3"
                }
            }

            /* END OF LIMBURG */

        }
    }
}