$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type p_1 from picture within w_main
end type
type cb_unreg_dll from commandbutton within w_main
end type
type cb_reg_dll from commandbutton within w_main
end type
type cb_pi from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 1563
integer height = 1120
boolean titlebar = true
string title = "ExpoComClient"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean center = true
p_1 p_1
cb_unreg_dll cb_unreg_dll
cb_reg_dll cb_reg_dll
cb_pi cb_pi
end type
global w_main w_main

type prototypes
Function boolean QueryPerformanceFrequency ( &
	Ref Double lpFrequency &
	) Library "kernel32.dll"

Function boolean QueryPerformanceCounter ( &
	Ref Double lpPerformanceCount &
	) Library "kernel32.dll"

end prototypes

type variables
Double idbl_frequency = 0
Double idbl_start, idbl_elapsed
end variables

on w_main.create
this.p_1=create p_1
this.cb_unreg_dll=create cb_unreg_dll
this.cb_reg_dll=create cb_reg_dll
this.cb_pi=create cb_pi
this.Control[]={this.p_1,&
this.cb_unreg_dll,&
this.cb_reg_dll,&
this.cb_pi}
end on

on w_main.destroy
destroy(this.p_1)
destroy(this.cb_unreg_dll)
destroy(this.cb_reg_dll)
destroy(this.cb_pi)
end on

type p_1 from picture within w_main
integer x = 37
integer y = 16
integer width = 1408
integer height = 616
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type cb_unreg_dll from commandbutton within w_main
integer x = 704
integer y = 884
integer width = 293
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Unreg DLL"
end type

event clicked;String ls_assemblypath, ls_ClassFileName
String ls_Run

ls_ClassFileName ="COMServer.comhost.dll"

IF messagebox("Registrar", "¿ Quere Des-Registrar las Librerias ?" +"~r~n"+ "(Se requiere permiso de administrador)", question!, yesno!, 1) = 2 THEN RETURN

ls_assemblypath = GetCurrentDirectory() +"\"

ls_Run = "regsvr32.exe /u "+char(34)+ls_assemblypath + ls_ClassFileName +char(34)

Run(ls_Run, Minimized!)

end event

type cb_reg_dll from commandbutton within w_main
integer x = 375
integer y = 884
integer width = 293
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reg DLL"
end type

event clicked;String ls_assemblypath
String ls_Run,  ls_ClassFileName

 ls_ClassFileName = "COMServer.comhost.dll"

IF messagebox("Registrar", "¿ Quere Registrar las Librerias ?" +"~r~n"+ "(Se requiere permiso de administrador)", question!, yesno!, 1) = 2 THEN RETURN

ls_assemblypath = GetCurrentDirectory() +"\"

ls_Run = "regsvr32.exe "+char(34)+ls_assemblypath+ ls_ClassFileName +char(34)

Run(ls_Run, Minimized!)


end event

type cb_pi from commandbutton within w_main
integer x = 503
integer y = 676
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ComputePi"
end type

event clicked;Dec ld_pi
String ls_msg, ls_error
OleObject ComServer
String ls_ClassName = "COMServer.Server"
Long ll_status

ComServer = CREATE OleObject
ll_status = ComServer.ConnectToNewObject(ls_ClassName)

If ll_status <> 0 Then
	CHOOSE CASE ll_status
		CASE -1 
			ls_error ="Invalid Call: the argument is the Object property of a control"
		CASE -2
			ls_error ="Class name not found"
		CASE -3 
			ls_error =" Object could not be created"
		CASE -4
			ls_error ="Could not connect to object"
		CASE -9
			ls_error ="Other error"
		CASE -15
			ls_error ="COM+ is not loaded on this computer"
		CASE -16
			ls_error ="Invalid Call: this function not applicable"
	END CHOOSE
	messagebox("Error", ls_error)
	RETURN
END IF	

TRY
   	ld_pi = ComServer.ComputePi()
CATCH (runtimeerror er)   
   MessageBox("Runtime Error", er.GetMessage())
	RETURN
END TRY  

ls_msg=string(ld_pi)
messagebox("Exito", ls_msg)

Destroy COMServer

end event

