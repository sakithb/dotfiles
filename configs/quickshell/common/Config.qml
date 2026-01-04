pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property color colBg: "#252422"
    readonly property color colBgSecondary: "#403D39"
    readonly property color colFg: "#FFFCF2"

    readonly property string fontFamily: "Noto Sans"
    readonly property string fontFamilyFixed: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 10

    readonly property int barHeight: 36
    readonly property int barPaddingX: 6
	readonly property int barPaddingY: 6

	readonly property int barBtnPaddingX: 12
	readonly property int barBtnRadius: 99
	readonly property color barBtnCol: "#00000000"
	readonly property color barBtnColHover: "#7F403D39"
	readonly property color barBtnColPressed: "#FF403D39"

    readonly property int popupPadding: 12
	readonly property int popupRadius: 12

	readonly property int itemSpacing: 8
	readonly property int itemRadius: 6
}
