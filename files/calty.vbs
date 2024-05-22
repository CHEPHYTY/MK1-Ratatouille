Set ws = CreateObject("WScript.Shell")

WScript.Sleep(1000)
ws.SendKeys("%y")
WScript.Sleep(500)
ws.SendKeys("%y")
WScript.Sleep(500)
ws.SendKeys("{ENTER}")
