forward
global type w_main from window
end type
type st_myversion from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type p_logo from picture within w_main
end type
type r_1 from rectangle within w_main
end type
type cb_pi from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2263
integer height = 1120
boolean titlebar = true
string title = "ExpoComClient"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean center = true
st_myversion st_myversion
st_platform st_platform
p_logo p_logo
r_1 r_1
cb_pi cb_pi
end type
global w_main w_main

type prototypes

end prototypes

type variables
nvo_server io_Server
end variables

forward prototypes
public subroutine wf_version (statictext ast_version, statictext ast_patform)
end prototypes

public subroutine wf_version (statictext ast_version, statictext ast_patform);String ls_version, ls_platform
environment env
integer rtn

rtn = GetEnvironment(env)

IF rtn <> 1 THEN 
	ls_version = string(year(today()))
	ls_platform="32"
ELSE
	ls_version = "20"+ string(env.pbmajorrevision)+ "." + string(env.pbbuildnumber)
	ls_platform= string(env.ProcessBitness)
END IF

ls_platform += " Bits"

ast_version.text=ls_version
ast_patform.text=ls_platform

end subroutine

on w_main.create
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.p_logo=create p_logo
this.r_1=create r_1
this.cb_pi=create cb_pi
this.Control[]={this.st_myversion,&
this.st_platform,&
this.p_logo,&
this.r_1,&
this.cb_pi}
end on

on w_main.destroy
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.p_logo)
destroy(this.r_1)
destroy(this.cb_pi)
end on

event open;io_Server = CREATE nvo_server

wf_version(st_myversion, st_platform)

end event

event closequery;destroy io_server
end event

type st_myversion from statictext within w_main
integer x = 1499
integer y = 56
integer width = 626
integer height = 64
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_platform from statictext within w_main
integer x = 1499
integer y = 144
integer width = 626
integer height = 64
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_logo from picture within w_main
integer x = 5
integer y = 4
integer width = 1253
integer height = 248
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 2190
integer height = 260
end type

type cb_pi from commandbutton within w_main
integer x = 855
integer y = 524
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
String ls_msg

ld_pi = io_Server.of_computepi()

//Checks the result
IF io_server.il_ErrorType < 0 THEN
  messagebox("Failed", io_Server.is_ErrorText)
  RETURN
ELSE
	ls_msg=string(ld_pi)
	messagebox("Exito", ls_msg)
END IF



end event

