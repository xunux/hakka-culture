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
MacroID=50a7277c-2a96-463a-96c2-d2b0dd5ba0fe
Description=崇正客語码表提取
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
VBSBegin
	Const a = 8
	filepath = "C:\hakka_syndict.txt"
	total = 148748
	page_size = 19
	pages = total \ page_size + 1
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
	'以Unicode编码，追加形式打开文件，若不存在则创建
	'Set fo = objFSO.OpenTextFile("C:\崇正輸入法碼錶.txt", a, True, -1)
	'創建新文件，以Unicode编码方式打開
	set fo = objFSO.CreateTextFile(filepath, True, True)
	Set objHTML=CreateObject("htmlfile")  'xmlfile、mhtmlfile都可以
	ClipboardText = objHTML.ParentWindow.ClipboardData.GetData("text")
VBSEnd

'激活切换到码表
Hwnd = Plugin.Window.Find(0, "输入编码表详细视图 - 崇正客語輸入法 v0.21 Beta")
Call Plugin.Window.Active(Hwnd)
Delay 100

sRect = Plugin.Window.GetWindowRect(Hwnd)
//下面这句用于分割字符串,将横坐标和纵坐标分成两个字符串   
MyArray = Split(sRect, "|")
//下面这句将字符串转换成数值   
W1 = Clng(MyArray(0)): H1 = Clng(MyArray(1))   
W2 = Clng(MyArray(2)) : H2 = Clng(MyArray(3))

dx1 = 60
dy1 = 135
dx2 = 60
dy2 = 140
dx3 = 60
dy3 = 464

temp = ""
i = 100
j = pages \ i + 1

'按下Home键，跳转到第一个页面页首
KeyPress 36,1
'移动到页首，复制第一条记录
MoveTo w1+dx1, h1+dy1
LeftClick 1
'Ctrl+C
KeyDown 17, 1
KeyPress 67, 1
KeyUp 17, 1

'将首页第一条记录复制下来
VBSBegin
	ClipboardText = objHTML.ParentWindow.ClipboardData.GetData("text")
VBSEnd
temp = temp + ClipboardText
		
For j
	For i
		'按下一页
		KeyPress "PageDown", 1
		
		'移到页首第二个，因为页首第一条记录总是与上一页最后一条记录相同
		MoveTo w1+dx2, h1+dy2
		LeftClick 1
		
		'按下shift
		KeyDown 16, 1
		
		'移到码表页底
		MoveTo w1+dx3, h1+dy3
		'MoveTo 439, 585
		LeftClick 1
		
		'松开shift
		KeyUp 16, 1
		
		'Ctrl+C
		KeyDown 17, 1
		KeyPress 67, 1
		KeyUp 17, 1
		
		VBSBegin
			ClipboardText = objHTML.ParentWindow.ClipboardData.GetData("text")
		VBSEnd
		temp = temp + ClipboardText
		'Call Plugin.File.WriteFile(f, ClipboardText)
	Next
	VBSBegin
		fo.write temp
	VBSEnd	
	temp = ""
Next


VBSBegin
	fo.close 
VBSEnd
