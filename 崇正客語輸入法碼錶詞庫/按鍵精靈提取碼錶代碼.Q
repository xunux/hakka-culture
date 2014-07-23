[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=c304a1a6-c9bc-4fe9-8847-f699981e2dca
Description=我的脚本8
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
While true


'点击切换到码表
MoveTo 360, 750
LeftClick 1

Delay 10

'按下一页
KeyPress "PageDown", 1


'移到页首
MoveTo 474, 256
LeftClick 1

'按下shift
KeyDown 16, 1

'移到码表页底
MoveTo 455, 595
LeftClick 1

'松开shift
KeyUp 16, 1

'Ctrl+C
KeyDown 17, 1
KeyPress 67, 1
KeyUp 17, 1

'切换到记事本编辑器
MoveTo 306, 753
LeftClick 1

Delay 10

'Ctrl+V
KeyDown 17, 1
KeyPress 86, 1
KeyUp 17, 1
	
Wend