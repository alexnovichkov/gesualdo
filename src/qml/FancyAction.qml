import QtQuick 2.1
import QtQuick.Controls 1.0
import "helpers.js" as Helpers

/*
  FancyAction adds shortcut to the tooltip text in a fancy way
  Usage:
  FancyAction {
      //... stuff usual for Action
      fancyTooltip: qsTr("tooltip text")
  }
*/

Action {
    property string basicTooltip: Helpers.removeMnemonics(text)
    tooltip: shortcut === "" ? basicTooltip : basicTooltip+" <font color=gray size=-1>"+shortcut+"</font>"
    iconSource: "../icons/"+iconName+".png"
}
