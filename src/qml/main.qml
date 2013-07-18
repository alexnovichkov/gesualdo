import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.1

import org.alexnovichkov.gesualdo 1.0 as Gesualdo

ApplicationWindow {
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300

    property bool wasChanged: {
        return true
    }

    property var urlsToAdd: []

    title: wasChanged?qsTr("Gesualdo - Tags Editor for Classical Music")+'*':
                       qsTr("Gesualdo - Tags Editor for Classical Music")+'9'

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

    FancyAction {
        id: addDirAct
        text: qsTr("\&Add folder...")
        enabled: true
        shortcut: qsTr("ctrl+o")//QKeySequence::Open
        iconName: "folder-new"
        onTriggered: addDir()
    }
    FancyAction {
        id: addFilesAct
        text: qsTr("Add &files...")
        enabled: true
        shortcut: qsTr("Shift+Ctrl+O")//QKeySequence::Open
        iconName: "document-new"
        onTriggered: addFiles()
    }
    FancyAction {
        id: saveAct
        text: qsTr("&Save current tab")
        enabled: true
        shortcut: qsTr("Ctrl+s")//QKeySequence::Save
        iconName: "document-save"
        onTriggered: saveTags()
    }
    FancyAction {
        id: saveAllAct
        text: qsTr("Save all &tabs")
        enabled: true
        shortcut: qsTr("Shift+Ctrl+s")
        onTriggered: saveAll()
    }
    FancyAction {
        id: renameAct
        text: qsTr("&Rename files...")
        enabled: true
        shortcut: qsTr("Ctrl+R")
        iconName: "document-save-as"
        onTriggered: renameFiles()
    }
    FancyAction {
        id: fillAct
        text: qsTr("&Fill tags...")
        enabled: true
        shortcut: qsTr("Ctrl+F")
        iconName: "fill"
        onTriggered: fill()
    }
    FancyAction {
        id: rereadTagsAct
        text: qsTr("&Reread tags")
        enabled: true
        iconName: "view-refresh"
        onTriggered: rereadTags()
    }
    FancyAction {
        id: helpAct
        text: qsTr("&Help")
        shortcut: qsTr("F1")//QKeySequence::HelpContents
        iconName: "help-contents"
        onTriggered: showHelp()
    }
    FancyAction {
        id: aboutAct
        text: qsTr("&About Gesualdo")
        iconName: "help-about"
        onTriggered: aboutBox.show()
    }
    FancyAction {
        id: aboutQtAct
        text: qsTr("About &Qt")
        onTriggered: aboutQt()
    }
    FancyAction {
        id: settingsAct
        text: qsTr("&Settings...")
        iconName: "preferences-system"
        onTriggered: showSettingsDialog()
    }
    FancyAction {
        id: delFilesAct
        text: qsTr("Re&move from the list")
        enabled: true
        shortcut: qsTr("Delete")
        iconName: "edit-delete"
        onTriggered: delFiles()
    }
    FancyAction {
        id: delAllFilesAct
        text: qsTr("C&lear the list")
        enabled: true
        shortcut: qsTr("Ctrl+Delete")
        iconName: "edit-clear"
        onTriggered: delAllFiles()
    }
    FancyAction {
        id: playAct
        text: qsTr("&Play selected")
        enabled: true
        shortcut: qsTr("Ctrl+P")
        iconName: "media-playback-start"
        onTriggered: play()
    }
    FancyAction {
        id: removeTagsAct
        text: qsTr("Clear all tags")
        enabled: true
        iconName: "Delete"
        onTriggered: removeAllTags()
    }
    FancyAction {
        id: cutAct
        text: qsTr("Cu&t")
        enabled: true
        shortcut: qsTr("Ctrl+X") //QKeySequence::Cut
        iconName: "edit-cut"
        onTriggered: cut()
    }
    FancyAction {
        id: copyAct
        text: qsTr("&Copy")
        enabled: true
        shortcut: qsTr("Ctrl+C") //QKeySequence::Copy
        iconName: "edit-copy"
        onTriggered: copy()
    }
    FancyAction {
        id: pasteAct
        text: qsTr("&Paste")
        enabled: true
        shortcut: qsTr("Ctrl+V") //QKeySequence::Paste
        iconName: "edit-paste"
        onTriggered: paste()
    }
    FancyAction {
        id: copyToClipboardAct
        text: qsTr("Copy to clipboard")
        enabled: true
        shortcut: qsTr("Shift+Ctrl+C")
        onTriggered: copyToClipboard()
    }
    FancyAction {
        id: pasteFromClipboardAct
        text: qsTr("Paste from clipboard")
        enabled: true
        shortcut: qsTr("Shift+Ctrl+V")
        onTriggered: pasteFromClipboard()
    }
    FancyAction {
        id: newTagAct
        text: qsTr("&Add new tag...")
        enabled: true
        shortcut: qsTr("Ctrl+N") //QKeySequence::New
        iconName: "list-add"
        onTriggered: newTag()
    }
    FancyAction {
        id: splitAct
        text: qsTr("Split &disc...")
        iconName: "media-import-audio-cd"
        onTriggered: showSplitDialog()
    }
    FancyAction {
        id: exitAct
        text: qsTr("E&xit")
        shortcut: qsTr("Ctrl+Q")
        iconName: "application-exit"
        onTriggered: maybeClose()
    }
    FancyAction {
        id: newTabAct
        text: qsTr("&New tab")
        enabled: true
        shortcut: qsTr("Ctrl+T") //QKeySequence::AddTab
        iconName: "newTab"
        onTriggered: newTab()
    }
    FancyAction {
        id: closeTabAct
        text: qsTr("&Close the tab")
        shortcut: qsTr("Ctrl+W") //QKeySequence::Close
        onTriggered: closeCurrentTab()
    }
    FancyAction {
        id: closeOtherTabsAct
        text: qsTr("Close &other tabs")
        onTriggered: closeOtherTabs()
    }
    FancyAction {
        id: renameTabAct
        text: qsTr("&Rename the tab...")
        onTriggered: renameTab()
    }
    FancyAction {
        id: replaygainAct
        text: qsTr("ReplayGain info...")
        enabled: true
        onTriggered: replaygain()
    }
    FancyAction {
        id: addFromDirViewAct
        text: qsTr("List this folder")
        onTriggered: addFromDirView()
    }
    FancyAction {
        id: addFromDirViewWithSubfoldersAct
        text: qsTr("List this folder with all subfolders")
        onTriggered: addFromDirViewWithSubfolders()
    }
    FancyAction {
        id: undoAct
        text: qsTr("&Undo")
        enabled: true
        shortcut: qsTr("Ctrl+Z") //QKeySequence::Undo
        iconName: "edit-undo"
        onTriggered: undo()
    }
    FancyAction {
        id: redoAct
        text: qsTr("&Redo")
        enabled: true
        shortcut: qsTr("Shift+Ctrl+Z") //QKeySequence::Undo
        iconName: "edit-redo"
        onTriggered: redo()
    }

    toolBar: ToolBar {
        id: mainToolBar
        width: parent.width
        RowLayout {
            anchors.fill: parent
            spacing: 0
            ToolButton {action: addDirAct}
            ToolButton {action: addFilesAct}
            ToolButton {action: splitAct}
            ToolBarSeparator {}
            ToolButton {action: saveAct}
            ToolButton {action: rereadTagsAct}
            ToolBarSeparator {}
            ToolButton {action: undoAct}
            ToolButton {action: redoAct}
            ToolBarSeparator {}
            ToolButton {action: renameAct}
            ToolButton {action: fillAct}
            ToolButton {action: removeTagsAct}
            ToolButton {action: delAllFilesAct}
            ToolBarSeparator {}
            ToolButton {action: playAct}
            ToolBarSeparator {}
            ToolButton {action: cutAct}
            ToolButton {action: copyAct}
            ToolButton {action: pasteAct}
            ToolButton {action: newTagAct}
            Item { Layout.fillWidth: true }
        }
    }

    menuBar: MenuBar {
        Menu {
            id: fileMenu
            title: qsTr("&File")
            MenuItem { action: addDirAct }
            MenuItem { action: addFilesAct }
            MenuItem { action: splitAct }
            MenuSeparator {}
            MenuItem { action: saveAct }
            MenuItem { action: saveAllAct }
            MenuItem { action: rereadTagsAct }
            MenuItem { action: delFilesAct }
            MenuItem { action: delAllFilesAct }
            MenuSeparator {}
            MenuItem { action: exitAct }
        }
        Menu {
            title: qsTr("&Edit")
            MenuItem { action: undoAct }
            MenuItem { action: redoAct }
            MenuItem { action: cutAct }
            MenuItem { action: copyAct }
            MenuItem { action: pasteAct }
            MenuItem { action: copyToClipboardAct }
            MenuItem { action: pasteFromClipboardAct }
            MenuSeparator {}
            MenuItem { action: removeTagsAct }
            MenuItem { action: newTagAct }
            MenuSeparator {}
            MenuItem { action: settingsAct }
        }
        Menu {
            title: qsTr("&Tools")
            MenuItem { action: renameAct }
            MenuItem { action: fillAct }
            MenuItem { action: playAct }
            MenuItem { action: replaygainAct }
            MenuSeparator {}
        }
        Menu {
            title: qsTr("Tab&s")
            MenuItem { action: newTabAct }
            MenuItem { action: closeTabAct }
            MenuItem { action: closeOtherTabsAct }
            MenuItem { action: renameTabAct }
        }
        Menu {
            title: qsTr("&Help")
            MenuItem { action: helpAct }
            MenuItem { action: aboutAct }
            MenuItem { action: aboutQtAct }
        }
    }

    Gesualdo.Model {
        id: model
    }

    FileDialog {
        id: fileDialog
        nameFilters: ["Audio files (*.mp3 *.mpc *.ogg *.flac *.oga *.wv *.spx *.tta *.ape *.opus *.wma *.asf *.m4a *.m4b *.m4p *.3g2 *.mp4 *.wav *.aiff *.aif)"]
        onAccepted: {
            model.filesToAdd = fileDialog.fileUrls
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

    function addDir() {
        fileDialog.title = qsTr("Gesualdo - adding folder")
        //fileDialog.folder = Settings.lastDirectory
        fileDialog.selectFolder = true
        fileDialog.selectMultiple = false

        fileDialog.open()
    }

    function addFiles() {
        fileDialog.title = qsTr("Gesualdo - adding files")
        //fileDialog.folder = Settings.lastDirectory
        fileDialog.selectFolder = false
        fileDialog.selectMultiple = true

        fileDialog.open()
    }
}


