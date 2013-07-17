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

    title: qsTr("Gesualdo - ")+window_title

    Button {
        text: "Push Me"
        anchors.centerIn: parent
        onClicked: {
            Qt.quit();
        }
    }
}


