import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.1

ApplicationWindow {
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300

    title: qsTr("Gesualdo - Tags Editor for Classical Music")+wasChanged()

    Window {
        id: aboutBox

        width: 280
        height: 150
        title: qsTr("About Gesualdo")
        modality: Qt.WindowModal

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Label {
                    id: aboutLabel
                    textFormat: Text.RichText
                    wrapMode: Text.WordWrap
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignLeft
                    text: qsTr("<b>Gesualdo, a Simple Tag Editor</b><br>released under the GPL 3"+
                               "<br>Version:" +" <br>Copyright 2013 Alex Novichkov"+
                               "<br>Web site: <a href=http://github.com/alexnovichkov/gesualdo>http://github.com/alexnovichkov/gesualdo</a>"+
                               "<br>E-mail: <a href=mailto:aleksej.novichkov@gmail.com>aleksej.novichkov@gmail.com</a><hr>")
                }
            }
            Button {
                text: qsTr("OK")
                isDefault: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                onClicked: aboutBox.close()
            }
            Keys.onReturnPressed: aboutBox.close()
            focus: true
        }
    }

    Button {
        text: "Push Me"
        anchors.centerIn: parent
        onClicked: {
            //Qt.quit();
            aboutBox.show()
        }
    }

    function wasChanged() {
        return ""
    }
}


