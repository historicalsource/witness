

	.FUNCT	DIR-PRINT,DIR,CNT=0
?PRG1:	GET	DIR-STRINGS,CNT
	EQUAL?	STACK,DIR \?CND3
	PRINTI	"the "
	ADD	CNT,1
	GET	DIR-STRINGS,STACK
	PRINT	STACK
	RTRUE	
?CND3:	INC	'CNT
	JUMP	?PRG1


	.FUNCT	GLOBAL-ROOM-F,TIM,VAL
	EQUAL?	PRSA,V?KNOCK \?ELS5
	PRINTR	"Knocking on the walls reveals nothing unusual."
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?SEARCH \FALSE
	GETP	HERE,P?LINE
	EQUAL?	STACK,OUTSIDE-LINE-C \?ELS12
	SET	'TIM,10
	JUMP	?CND10
?ELS12:	GETP	HERE,P?CORRIDOR
	ZERO?	STACK /?ELS14
	SET	'TIM,3
	JUMP	?CND10
?ELS14:	GETP	HERE,P?SIZE
	ADD	2,STACK >TIM
?CND10:	PRINTI	"(You'd do better to examine or search one thing at a time. Searching a whole room or area thoroughly would take hours. A cursory search would take about "
	PRINTN	TIM
	PRINTI	" minutes, and it might not reveal much. Would you like to do it anyway?)"
	CALL	YES?
	ZERO?	STACK /?ELS23
	CALL	INT-WAIT,TIM >VAL
	EQUAL?	M-FATAL,VAL /TRUE
	ZERO?	VAL /?ELS30
	PRINTR	"Your cursory search revealed nothing new."
?ELS30:	PRINTR	"You didn't get a chance to finish looking over the place."
?ELS23:	PRINTR	"Okeh."


	.FUNCT	WINDOW-F,RM,POP
	CALL	WINDOW-ROOM,HERE,PRSO >RM
	EQUAL?	PRSA,V?BRUSH \?ELS5
	PRINTR	"The window is clean enough without your interference."
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTI	"The window is a simple wooden sash, locked tight against the cold."
	CALL	OUTSIDE?,HERE
	ZERO?	STACK \?CND12
	PRINTI	" There's some sort of electric relay on one edge, with white wires attached."
?CND12:	CRLF	
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?LOOK-OUTSIDE,V?LOOK-INSIDE \?ELS18
	ZERO?	RM /?ELS21
	PRINTI	"The window is damp and foggy, but you can see"
	CALL	POPULATION,RM >POP
	ZERO?	POP \?ELS27
	JUMP	?CND25
?ELS27:	EQUAL?	POP,1 \?ELS29
	PRINTI	" someone in"
	JUMP	?CND25
?ELS29:	PRINTI	" some people in"
?CND25:	CALL	THE?,RM
	PRINTI	" "
	PRINTD	RM
	PRINTI	" "
	GETP	HERE,P?LINE
	EQUAL?	STACK,OUTSIDE-LINE-C \?ELS42
	PUSH	STR?11
	JUMP	?CND38
?ELS42:	PUSH	STR?12
?CND38:	PRINT	STACK
	PRINTR	"side."
?ELS21:	PRINTR	"The window is too foggy to see through."
?ELS18:	EQUAL?	PRSA,V?KNOCK \?ELS50
	CALL	WINDOW-KNOCK,RM
	ZERO?	STACK \FALSE
	PRINTR	"There's no answer."
?ELS50:	EQUAL?	PRSA,V?MUNG \?ELS59
	PRINTI	"Vandalism is for private "
	CALL	TANDY?
	ZERO?	STACK /?ELS64
	PRINTI	"eye"
	JUMP	?CND62
?ELS64:	PRINTI	"dick"
?CND62:	PRINTR	"s, not famous police detectives!"
?ELS59:	EQUAL?	PRSA,V?UNLOCK /?THN75
	EQUAL?	PRSA,V?LOCK,V?CLOSE,V?OPEN \FALSE
?THN75:	FSET?	PRSO,RMUNGBIT \?CND77
	PRINTI	"It's really broken. "
?CND77:	PRINTR	"You can't."


	.FUNCT	GENERIC-WINDOW-F,OBJ
	CALL	WINDOW-IN?,HERE
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN8
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS7
?THN8:	RETURN	WINDOW
?ELS7:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"window"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	WINDOW-KNOCK,RM
	CALL	INHABITED?,RM
	ZERO?	STACK /FALSE
	PRINTR	"Someone looks up at you inquisitively."


	.FUNCT	WINDOW-IN?,RM
	EQUAL?	RM,FRONT-YARD,KITCHEN,BUTLER-ROOM /TRUE
	EQUAL?	RM,OFFICE-PORCH,OFFICE /TRUE
	EQUAL?	RM,BACK-YARD,MONICA-ROOM /TRUE
	EQUAL?	RM,ROCK-GARDEN,LINDER-ROOM,TUB-ROOM /TRUE
	RFALSE	


	.FUNCT	TOILET-F,RARG=100
	EQUAL?	RARG,100 \FALSE
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTR	"You have stooped to a new low by snooping around toilet bowls."


	.FUNCT	GENERIC-BATH-DOOR-F,OBJ
	EQUAL?	HERE,MONICA-ROOM \?ELS5
	RETURN	MONICA-BATH-DOOR
?ELS5:	EQUAL?	HERE,LINDER-ROOM \?ELS7
	RETURN	LINDER-BATH-DOOR
?ELS7:	EQUAL?	HERE,BUTLER-ROOM,BUTLER-BATH \?ELS9
	RETURN	BUTLER-BATH-DOOR
?ELS9:	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN12
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS11
?THN12:	RETURN	GENERIC-BATHROOM-DOOR
?ELS11:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"bathroom door"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	GENERIC-BEDROOM-F,OBJ
	EQUAL?	OBJ,HERE,GLOBAL-HERE \?ELS5
	RETURN	GLOBAL-ROOM
?ELS5:	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN8
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS7
?THN8:	RETURN	GENERIC-BEDROOM
?ELS7:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"bedroom"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	GENERIC-BEDROOM-DOOR-F,OBJ
	EQUAL?	HERE,MONICA-ROOM,HALL-2 \?ELS5
	RETURN	MONICA-DOOR
?ELS5:	EQUAL?	HERE,LINDER-ROOM,LIVING-ROOM \?ELS7
	RETURN	LINDER-DOOR
?ELS7:	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN10
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS9
?THN10:	RETURN	GENERIC-BEDROOM-DOOR
?ELS9:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"bedroom door"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	GENERIC-BACK-DOOR-F,OBJ
	EQUAL?	PRSA,V?SHOOT \?ELS5
	FSET?	P-IT-OBJECT,DOORBIT \?ELS5
	FSET?	P-IT-OBJECT,LOCKED \?ELS5
	RETURN	P-IT-OBJECT
?ELS5:	EQUAL?	HERE,OFFICE-PORCH,OFFICE \?ELS9
	RETURN	OFFICE-BACK-DOOR
?ELS9:	EQUAL?	HERE,BACK-YARD,MONICA-ROOM \?ELS11
	RETURN	MONICA-BACK-DOOR
?ELS11:	EQUAL?	HERE,ROCK-GARDEN,LINDER-ROOM \?ELS13
	RETURN	LINDER-BACK-DOOR
?ELS13:	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN16
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS15
?THN16:	RETURN	GENERIC-BACK-DOOR
?ELS15:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"back door"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	GENERIC-BATHROOM-F,OBJ
	EQUAL?	OBJ,HERE,GLOBAL-HERE \?ELS5
	RETURN	GLOBAL-ROOM
?ELS5:	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN8
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS7
?THN8:	RETURN	GENERIC-BATHROOM
?ELS7:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"bathroom"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	NULL-F,A1,A2
	RFALSE	


	.FUNCT	DDESC,STR1,DOOR,STR2
	PRINT	STR1
	FSET?	DOOR,OPENBIT \?ELS5
	PRINTI	"open"
	JUMP	?CND3
?ELS5:	PRINTI	"closed"
?CND3:	PRINT	STR2
	CRLF	
	RTRUE	


	.FUNCT	DOOR-ROOM,RM,DR,P=0,TBL
?PRG1:	NEXTP	RM,P >P
	ZERO?	P /FALSE
	LESS?	P,LOW-DIRECTION /FALSE
	GETPT	RM,P >TBL
	PTSIZE	TBL
	EQUAL?	DEXIT,STACK \?PRG1
	GETB	TBL,DEXITOBJ
	EQUAL?	DR,STACK \?PRG1
	GETB	TBL,REXIT
	RETURN	STACK


	.FUNCT	FIND-FLAG,RM,FLAG,EXCLUDED=0,O
	FIRST?	RM >O /?KLU12
?KLU12:	
?PRG1:	ZERO?	O /FALSE
	FSET?	O,FLAG \?ELS7
	EQUAL?	O,EXCLUDED /?ELS7
	RETURN	O
?ELS7:	NEXT?	O >O /?KLU13
?KLU13:	JUMP	?PRG1


	.FUNCT	GLOBAL-HERE-F,FLG=0,F,HR
	EQUAL?	PRSA,V?ASK-ABOUT,V?WHAT \FALSE
	FIRST?	HERE >F /?KLU24
?KLU24:	
?PRG6:	ZERO?	F \?ELS10
	JUMP	?REP7
?ELS10:	FSET?	F,CONTBIT \?ELS12
	CALL	INHABITED?,F
	ZERO?	STACK /?ELS12
	SET	'FLG,TRUE-VALUE
	SET	'HR,HERE
	SET	'HERE,F
	CALL	GLOBAL-HERE-F
	SET	'HERE,HR
	JUMP	?CND8
?ELS12:	FSET?	F,PERSON \?CND8
	EQUAL?	F,PLAYER /?CND8
	SET	'FLG,TRUE-VALUE
	CALL	DESCRIBE-OBJECT,F,TRUE-VALUE,0
?CND8:	NEXT?	F >F /?KLU25
?KLU25:	JUMP	?PRG6
?REP7:	ZERO?	FLG \TRUE
	PRINTR	"There's nobody else here."


	.FUNCT	LOCKED-F,OBJ
	EQUAL?	HERE,FRONT-YARD \?ELS5
	EQUAL?	PRSA,V?THROUGH,V?SEARCH-OBJECT-FOR /?THN11
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE \?ELS10
?THN11:	RETURN	DINING-DOOR
?ELS10:	EQUAL?	PRSA,V?WALK-TO \FALSE
	RETURN	FRONT-DOOR
?ELS5:	EQUAL?	PRSA,V?SHOOT \FALSE
	FSET?	P-IT-OBJECT,DOORBIT \FALSE
	FSET?	P-IT-OBJECT,LOCKED \FALSE
	RETURN	P-IT-OBJECT


	.FUNCT	META-LOC,OBJ
?PRG1:	LOC	OBJ
	ZERO?	STACK /FALSE
	LOC	OBJ
	EQUAL?	STACK,LOCAL-GLOBALS,GLOBAL-OBJECTS \?CND6
	LOC	OBJ
	RETURN	STACK
?CND6:	IN?	OBJ,ROOMS \?ELS11
	RETURN	OBJ
?ELS11:	LOC	OBJ >OBJ
	JUMP	?PRG1


	.FUNCT	OUTSIDE?,RM
	EQUAL?	RM,GARAGE /TRUE
	GETP	RM,P?LINE
	EQUAL?	STACK,OUTSIDE-LINE-C /TRUE
	RFALSE	


	.FUNCT	PHONE-IN?,RM
	EQUAL?	RM,LIVING-ROOM,OFFICE,MONICA-ROOM /TRUE
	RFALSE	


	.FUNCT	WINDOW-ROOM,RM,WINDOW,P=0,L
	EQUAL?	RM,FRONT-YARD \?ELS5
	EQUAL?	WINDOW,KITCHEN-WINDOW \?ELS10
	RETURN	KITCHEN
?ELS10:	EQUAL?	WINDOW,BUTLER-WINDOW \FALSE
	RETURN	BUTLER-ROOM
?ELS5:	EQUAL?	RM,KITCHEN,BUTLER-ROOM \?ELS14
	RETURN	FRONT-YARD
?ELS14:	EQUAL?	RM,OFFICE-PORCH \?ELS16
	RETURN	OFFICE
?ELS16:	EQUAL?	RM,OFFICE \?ELS18
	RETURN	OFFICE-PORCH
?ELS18:	EQUAL?	RM,BACK-YARD \?ELS20
	RETURN	MONICA-ROOM
?ELS20:	EQUAL?	RM,MONICA-ROOM \?ELS22
	RETURN	BACK-YARD
?ELS22:	EQUAL?	RM,ROCK-GARDEN \?ELS24
	EQUAL?	WINDOW,LINDER-WINDOW \?ELS29
	RETURN	LINDER-ROOM
?ELS29:	EQUAL?	WINDOW,BATH-WINDOW \FALSE
	RETURN	TUB-ROOM
?ELS24:	EQUAL?	RM,LINDER-ROOM,TUB-ROOM \FALSE
	RETURN	ROCK-GARDEN


	.FUNCT	GROUND-SURFACE
	EQUAL?	HERE,FRONT-YARD,ROCK-GARDEN \?ELS5
	RETURN	STR?13
?ELS5:	EQUAL?	HERE,DRIVEWAY,DRIVEWAY-ENTRANCE \?ELS7
	RETURN	STR?14
?ELS7:	EQUAL?	HERE,FRONT-PORCH,OFFICE-PORCH \?ELS9
	RETURN	STR?15
?ELS9:	EQUAL?	HERE,BACK-YARD \?ELS11
	RETURN	STR?16
?ELS11:	ZERO?	GROUND-MUDDY /?ELS13
	RETURN	STR?17
?ELS13:	RETURN	STR?18


	.FUNCT	FRONT-PORCH-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	DDESC,STR?22,FRONT-DOOR,STR?23
	CALL	DDESC,STR?24,FRONT-GATE,STR?25
	CALL	THIS-IS-IT,DOORBELL
	RSTACK	


	.FUNCT	DOORBELL-F
	EQUAL?	PRSA,V?RING,V?PUSH \FALSE
	ZERO?	WELCOMED \?ELS8
	FSET?	CORPSE,INVISIBLE \?ELS8
	CALL	WELCOME
	RTRUE	
?ELS8:	CALL	YOU-RANG
	PRINTR	"The door bell rings, loud and clear."


	.FUNCT	DRIVEWAY-F,ARG=0
	EQUAL?	PRSA,V?FOLLOW,V?CLIMB-UP \FALSE
	EQUAL?	PRSO,DRIVEWAY-OBJECT \FALSE
	EQUAL?	HERE,DRIVEWAY-ENTRANCE \?ELS12
	CALL	PERFORM,V?WALK,P?NORTH
	RTRUE	
?ELS12:	EQUAL?	HERE,GARAGE,SIDE-YARD \?ELS14
	CALL	PERFORM,V?WALK,P?WEST
	RTRUE	
?ELS14:	PRINTR	"It's not clear which direction you mean."


	.FUNCT	SIDE-YARD-F,RARG=0
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a little-used side yard, hidden from the street by the fence. The back yard lies to the east and the driveway to the west."
	CRLF	
	FSET?	SIDE-FOOTPRINTS,INVISIBLE /FALSE
	CALL	DESCRIBE-OBJECT,SIDE-FOOTPRINTS,TRUE-VALUE,0
	FSET	SIDE-FOOTPRINTS,TOUCHBIT
	RTRUE	
?ELS5:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	HERE,SIDE-YARD \FALSE
	ZERO?	GROUND-MUDDY /FALSE
	EQUAL?	PRSA,V?FOLLOW,V?WALK \FALSE
	SET	'SIDE-FOOTPRINTS-CONFUSED,TRUE-VALUE
	RFALSE	


	.FUNCT	SIDE-FOOTPRINTS-F,ARG=0
	EQUAL?	ARG,M-OBJDESC \?ELS5
	ZERO?	SIDE-FOOTPRINTS-CONFUSED /?ELS10
	FSET?	SIDE-FOOTPRINTS,TOUCHBIT \?ELS16
	PRINTR	"Fresh foot prints go here and there in the yard."
?ELS16:	FSET	SIDE-FOOTPRINTS,TOUCHBIT
	PRINTR	"You notice fresh foot prints going here and there in the yard."
?ELS10:	FSET?	SIDE-FOOTPRINTS,TOUCHBIT \?ELS29
	PRINTR	"A fresh row of foot prints goes from the back yard to the driveway."
?ELS29:	FSET	SIDE-FOOTPRINTS,TOUCHBIT
	PRINTR	"You notice a fresh row of foot prints going from the back yard to the driveway."
?ELS5:	ZERO?	SIDE-FOOTPRINTS-CONFUSED /?ELS37
	EQUAL?	PRSA,V?EXAMINE,V?ANALYZE \?ELS37
	PRINTR	"There are too many foot prints here now."
?ELS37:	EQUAL?	PRSA,V?EXAMINE \?ELS43
	PRINTR	"The prints are lined up in an even row, as if made by a careful walker."
?ELS43:	EQUAL?	PRSA,V?ANALYZE \?ELS47
	LOC	SIDE-FOOTPRINTS-CAST
	EQUAL?	STACK,LIMBO /?ELS52
	PRINTR	"You already did that!"
?ELS52:	ZERO?	FINGERPRINT-OBJ \?THN57
	ZERO?	DUFFY-AT-CORONER /?ELS56
?THN57:	CALL	DO-FINGERPRINT
	RTRUE	
?ELS56:	MOVE	SIDE-FOOTPRINTS-CAST,PLAYER
	CALL	ANAFOOT
	RSTACK	
?ELS47:	EQUAL?	PRSA,V?FOLLOW \?ELS62
	EQUAL?	HERE,DRIVEWAY-ENTRANCE \?ELS65
	CALL	GOTO,SIDE-YARD
	RTRUE	
?ELS65:	EQUAL?	HERE,SIDE-YARD,OFFICE-PATH \TRUE
	CALL	GOTO,DRIVEWAY-ENTRANCE
	RTRUE	
?ELS62:	EQUAL?	PRSA,V?MAKE \FALSE
	EQUAL?	PRSO,BACK-FOOTPRINTS-CAST,SIDE-FOOTPRINTS-CAST,GENERIC-CAST \FALSE
	CALL	PERFORM,V?ANALYZE,SIDE-FOOTPRINTS
	RTRUE	


	.FUNCT	SIDE-FOOTPRINTS-CAST-F
	EQUAL?	PRSA,V?COMPARE \FALSE
	EQUAL?	PRSO,BACK-FOOTPRINTS-CAST,BACK-FOOTPRINTS /?THN8
	EQUAL?	PRSI,BACK-FOOTPRINTS-CAST,BACK-FOOTPRINTS \FALSE
?THN8:	PRINTR	"The two sets of foot prints don't seem to match up."


	.FUNCT	ANAFOOT
	PRINTR	"Sgt. Duffy appears with his kit for casting with plaster of Paris. He quickly makes a cast of the foot prints and hands it to you, saying ""I hope you find this as useful as it is heavy."""


	.FUNCT	OFFICE-PORCH-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are standing on a small concrete slab outside Linder's office. A sign between the door and the window reads ""PACIFIC TRADE ASSOCIATES"". To the north is a tidy lawn, extending east to the edge of the woods. A path of stepping stones leads south to the back gate."
	CRLF	
	FSET?	BACK-FOOTPRINTS,INVISIBLE /FALSE
	CALL	DESCRIBE-OBJECT,BACK-FOOTPRINTS,TRUE-VALUE,0
	FSET	BACK-FOOTPRINTS,TOUCHBIT
	RTRUE	


	.FUNCT	BACK-FOOTPRINTS-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The prints are uneven and widely spaced, as if made by someone running."
?ELS5:	EQUAL?	PRSA,V?ANALYZE \?ELS9
	LOC	BACK-FOOTPRINTS-CAST
	EQUAL?	STACK,LIMBO /?ELS14
	PRINTR	"You already did that!"
?ELS14:	ZERO?	FINGERPRINT-OBJ \?THN19
	ZERO?	DUFFY-AT-CORONER /?ELS18
?THN19:	CALL	DO-FINGERPRINT
	RTRUE	
?ELS18:	MOVE	BACK-FOOTPRINTS-CAST,PLAYER
	CALL	ANAFOOT
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?FOLLOW \?ELS24
	PRINTI	"You would probably get lost in the woods."
	PRINTR	" Even with a path to follow."
?ELS24:	EQUAL?	PRSA,V?MAKE \FALSE
	EQUAL?	PRSO,BACK-FOOTPRINTS-CAST,SIDE-FOOTPRINTS-CAST,GENERIC-CAST \FALSE
	CALL	PERFORM,V?ANALYZE,BACK-FOOTPRINTS
	RTRUE	


	.FUNCT	GENERIC-FOOTPRINTS-F,OBJ
	EQUAL?	HERE,OFFICE-PORCH \?ELS5
	RETURN	BACK-FOOTPRINTS
?ELS5:	EQUAL?	HERE,SIDE-YARD \?ELS7
	RETURN	SIDE-FOOTPRINTS
?ELS7:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"foot prints"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	GENERIC-CAST-F,OBJ
	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN6
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS5
?THN6:	RETURN	GENERIC-CAST
?ELS5:	EQUAL?	PRSA,V?MAKE \FALSE
	RETURN	GENERIC-CAST


	.FUNCT	OFFICE-WINDOW-F,RM
	CALL	WINDOW-ROOM,HERE,PRSO >RM
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	CALL	WINDOW-F
	FSET?	OFFICE-WINDOW,RMUNGBIT \?ELS8
	PRINTI	"All the panes of the window are cracked, and many are in pieces on the "
	PRINTI	"floor."
	EQUAL?	HERE,OFFICE \?CND16
	FSET?	PIECE-OF-PUTTY,TOUCHBIT /?CND19
	PRINTI	" A chunk of putty dangles like a wax bean."
?CND19:	FSET?	PIECE-OF-WIRE,TOUCHBIT /?CND16
	PRINTI	" Along one edge of the window you can see the end of a piece of green wire."
?CND16:	CRLF	
	RTRUE	
?ELS8:	EQUAL?	HERE,OFFICE \TRUE
	FSET?	PIECE-OF-WIRE,TOUCHBIT /TRUE
	PRINTR	"There's also a piece of green wire running from the frame to the putty."
?ELS5:	CALL	GO-AWAY
	ZERO?	STACK \TRUE
	EQUAL?	PRSA,V?LOOK-OUTSIDE,V?LOOK-INSIDE \?ELS38
	ZERO?	RM /?ELS38
	FSET?	OFFICE-WINDOW,RMUNGBIT \?ELS38
	PRINTI	"Through the broken window you can see"
	CALL	THE?,RM
	PRINTI	" "
	PRINTD	RM
	PRINTI	" "
	GETP	HERE,P?LINE
	EQUAL?	STACK,OUTSIDE-LINE-C \?ELS49
	PUSH	STR?11
	JUMP	?CND45
?ELS49:	PUSH	STR?12
?CND45:	PRINT	STACK
	PRINTR	"side."
?ELS38:	EQUAL?	PRSA,V?THROUGH \?ELS53
	ZERO?	RM /?ELS53
	FSET?	OFFICE-WINDOW,RMUNGBIT \?ELS53
	PRINTR	"You would probably cut yourself on the broken glass."
?ELS53:	EQUAL?	PRSO,OFFICE-WINDOW \?ELS59
	CALL	PERFORM,PRSA,WINDOW,PRSI
	RTRUE	
?ELS59:	EQUAL?	PRSI,OFFICE-WINDOW \FALSE
	CALL	PERFORM,PRSA,PRSO,WINDOW
	RTRUE	


	.FUNCT	GO-AWAY
	EQUAL?	PRSA,V?KNOCK \FALSE
	CALL	META-LOC,LINDER
	EQUAL?	STACK,OFFICE \FALSE
	IN?	PLAYER,OFFICE /FALSE
	PRINTI	"Someone peeks through the window at you, then disappears and"
	PRINTR	" shouts ""Go away!"""


	.FUNCT	PIECE-OF-WIRE-F
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	FSET?	PRSO,TOUCHBIT /?ELS5
	PRINTR	"The wire goes into the window frame and disappears."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	ZERO?	SHOT-FIRED \FALSE
	PRINTI	"You can't."
	PRINTR	" It's stuck tight."


	.FUNCT	PIECE-OF-PUTTY-F
	EQUAL?	PRSA,V?TAKE \FALSE
	ZERO?	SHOT-FIRED \FALSE
	PRINTI	"You can't."
	PRINTR	" It's stuck tight."


	.FUNCT	OFFICE-BACK-DOOR-F
	CALL	GO-AWAY
	ZERO?	STACK \TRUE
	EQUAL?	PRSA,V?SGIVE,V?GIVE \FALSE
	EQUAL?	PRSO,THREAT-NOTE /?THN10
	EQUAL?	PRSI,THREAT-NOTE \FALSE
?THN10:	LOC	LINDER
	ZERO?	STACK /?ELS16
	CALL	PERFORM,V?GIVE,THREAT-NOTE,LINDER
	RTRUE	
?ELS16:	PRINTR	"It's too late to give Linder anything."


	.FUNCT	LAWN-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The lawn is well manicured."


	.FUNCT	MONICA-ROOM-F,RARG=0
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	I-PROMPT-2
	RSTACK	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTR	"On one side is a modern-style bed, with piles of well-thumbed detective stories stacked on the table beside it. Opposite the bed is a long dressing table that seems to serve also as desk and workbench. In the corner sits a small table for a portable phonograph and records, and a book case with more books and pulps. Movie posters cover the walls. A handsome door with cedar veneer leads north, and a door and window face outside."


	.FUNCT	MONICA-TABLE-F
	EQUAL?	PRSA,V?SEARCH /?THN6
	EQUAL?	PRSA,V?LOOK-ON,V?LOOK-INSIDE,V?EXAMINE \FALSE
?THN6:	IN?	MEDICAL-REPORT,MONICA-ROOM \?ELS12
	EQUAL?	P-ADVERB,W?CAREFULLY \?ELS12
	FCLEAR	TUMOR,INVISIBLE
	FCLEAR	MEDICAL-REPORT,INVISIBLE
	CALL	THIS-IS-IT,MEDICAL-REPORT
	PRINTR	"Among make-up, letters, and tools, you find a medical report."
?ELS12:	PRINTR	"This table is pretty messy. Anyone but Monica would have a tough time finding anything on it."


	.FUNCT	CAN-HEAR-RECORD?
	ZERO?	TUNE-ON /FALSE
	EQUAL?	PRSO,MONICA-DOOR \?ELS11
	EQUAL?	HERE,HALL-2 /TRUE
?ELS11:	EQUAL?	PRSO,MONICA-BATH-DOOR \?ELS13
	EQUAL?	HERE,BATHROOM /TRUE
?ELS13:	EQUAL?	PRSO,MONICA-BACK-DOOR \FALSE
	EQUAL?	HERE,BACK-YARD /TRUE
	RFALSE


	.FUNCT	RECORDS-F,TUNE
	EQUAL?	PRSA,V?LISTEN,V?PLAY \?ELS5
	PRINTI	"You pick a record at random and start it playing. It's """
?PRG8:	CALL	PICK-ONE,SONG-TABLE >TUNE
	ZERO?	TUNE-ON /?REP9
	EQUAL?	TUNE,TUNE-ON \?REP9
	JUMP	?PRG8
?REP9:	SET	'TUNE-ON,TUNE
	PRINT	TUNE-ON
	PRINTI	"."""
	CRLF	
	CALL	QUEUE,I-TUNE-OFF,4
	PUT	STACK,0,1
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's a large and varied record collection. Monica's not very choosy about her music."


	.FUNCT	I-TUNE-OFF,TBL
	EQUAL?	HERE,MONICA-ROOM \?ELS5
	PRINTI	"The record is over, and not too soon."
	CRLF	
	IN?	MONICA,HERE \TRUE
	ZERO?	MONICA-TIED-TO \TRUE
	PRINTI	"Monica walks over to the phonograph and puts the record away. Then she chooses another one and starts it up. It's """
	CALL	PICK-ONE,SONG-TABLE >TUNE-ON
	PRINT	TUNE-ON
	PRINTI	"."""
	CRLF	
	CALL	QUEUE,I-TUNE-OFF,4
	PUT	STACK,0,1
	RTRUE	
?ELS5:	IN?	MONICA,MONICA-ROOM \FALSE
	ZERO?	MONICA-TIED-TO \FALSE
	CALL	PICK-ONE,SONG-TABLE >TUNE-ON
	CALL	QUEUE,I-TUNE-OFF,4
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	MASTER-BATH-COUNTER-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTR	"On the counter are a shaver, tooth paste, and so on."


	.FUNCT	SHOWER-F
	GET	P-PRSO,0
	EQUAL?	1,STACK \FALSE
	EQUAL?	PRSA,V?THROUGH,V?TAKE \FALSE
	PRINTR	"Anyone can see that you really need a shower. In fact, this is one of your better ideas so far on this case. But your clothes would get awful wet, and you must have better things to do."


	.FUNCT	LINDER-ROOM-F,ARG=0
	EQUAL?	ARG,M-ENTER \?ELS5
	CALL	I-PROMPT-2
	RSTACK	
?ELS5:	EQUAL?	ARG,M-LOOK \FALSE
	PRINTI	"The bedroom is elegant but not tidy. A four-poster bed, chair and dresser, made of teak and mahogany, look hand-crafted. There are doors on the west and south walls, and a door and window to the east look outside. Clothes and newspapers are scattered about. It seems that Linder misse"
	FSET?	CORPSE,INVISIBLE \?ELS14
	PUSH	STR?50
	JUMP	?CND10
?ELS14:	PUSH	STR?51
?CND10:	PRINT	STACK
	PRINTR	" the woman's touch."


	.FUNCT	MASTER-BEDROOM-DRESSER-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The dresser is a beautiful piece of cabinetry."
?ELS5:	EQUAL?	PRSA,V?OPEN,V?SEARCH,V?LOOK-INSIDE \FALSE
	PRINTR	"You open all the drawers and find only shirts, socks, underwear, hankies, and so on. What a disappointment."


	.FUNCT	LIVING-ROOM-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"A huge fieldstone fireplace on the south wall holds a blazing fire, filling the living room with warmth and light. Grouped in front of the fire are a glass-topped coffee table and a rattan davenport and club chair, with cushions covered in a print showing bamboo plants in the style of Japanese brush-painting. A lamp with a printed shade and a telephone sit on the table."
	CRLF	
	PRINTI	"On the north wall are a liquor cabinet and a console radio made of light-colored wood. "
	ZERO?	RADIO-ON /?CND10
	PRINTI	"The radio is playing. "
?CND10:	CALL	DDESC,STR?52,LINDER-DOOR,STR?53
	RSTACK	


	.FUNCT	CAN-HEAR-RADIO?
	ZERO?	RADIO-ON /FALSE
	EQUAL?	PRSO,DINING-DOOR \?ELS11
	EQUAL?	HERE,FRONT-YARD /TRUE
?ELS11:	EQUAL?	PRSO,FRONT-DOOR \?ELS13
	EQUAL?	HERE,FRONT-PORCH /TRUE
?ELS13:	EQUAL?	PRSO,LIVING-DINING-DOOR \?ELS15
	EQUAL?	HERE,DINING-ROOM /TRUE
?ELS15:	EQUAL?	PRSO,KITCHEN-HALL-DOOR,KITCHEN-DINING-DOOR \?ELS17
	EQUAL?	HERE,KITCHEN /TRUE
?ELS17:	EQUAL?	PRSO,LINDER-DOOR \FALSE
	EQUAL?	HERE,LINDER-ROOM /TRUE
	RFALSE


	.FUNCT	RADIO-F,ARG=0,PGM
	ZERO?	RADIO-ON /?ELS5
	EQUAL?	PRSA,V?LISTEN \?ELS5
	SUB	PRESENT-TIME,480
	DIV	STACK,15
	ADD	1,STACK
	GET	RADIO-TABLE,STACK >PGM
	PRINTI	"You can hardly avoid it. "
	EQUAL?	PGM,RADIO-ON \?ELS12
	PRINTI	"It's "
	JUMP	?CND10
?ELS12:	PRINTI	"You"
	PRINTI	" spin the dial and find "
?CND10:	SET	'RADIO-ON,PGM
	PRINT	RADIO-ON
	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?LISTEN,V?PLAY,V?LAMP-ON \?ELS22
	ZERO?	RADIO-ON /?ELS25
	PRINTI	"It's already on. You"
	JUMP	?CND23
?ELS25:	PRINTI	"You turn on the radio,"
?CND23:	SUB	PRESENT-TIME,480
	DIV	STACK,15
	ADD	1,STACK
	GET	RADIO-TABLE,STACK >RADIO-ON
	PRINTI	" spin the dial and find "
	PRINT	RADIO-ON
	PRINTR	"."
?ELS22:	EQUAL?	PRSA,V?LAMP-OFF \?ELS36
	ZERO?	RADIO-ON /?ELS39
	IN?	MONICA,HERE \?ELS39
	PRINTI	"Monica looks at you with disgust as you turn off the radio."
	CRLF	
	JUMP	?CND37
?ELS39:	PRINTI	"The radio is now off."
	CRLF	
?CND37:	SET	'RADIO-ON,FALSE-VALUE
	RTRUE	
?ELS36:	EQUAL?	PRSA,V?TURN-UP \?ELS49
	ZERO?	RADIO-ON /?ELS54
	PRINTR	"The radio is already pretty loud. Any louder would probably make the neighbors complain."
?ELS54:	PRINTR	"It's not on!"
?ELS49:	EQUAL?	PRSA,V?TURN-DOWN \FALSE
	ZERO?	RADIO-ON /?ELS68
	IN?	MONICA,HERE \?ELS74
	ZERO?	MONICA-TIED-TO \?ELS74
	PRINTR	"Monica stops you from turning down the volume. She seems strangely interested in the radio program."
?ELS74:	PRINTR	"You can't."
?ELS68:	PRINTR	"It's not on!"


	.FUNCT	SILVERWARE-F
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"You could probably hock this stuff for a bundle, but you'd never get away with it, since the butler will no doubt count it again when you leave."


	.FUNCT	FOODS-F
	EQUAL?	PRSA,V?TAKE,V?EAT \FALSE
	PRINTR	"Your parents must have taught you better manners than that."


	.FUNCT	K-CLOCK-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The time on the kitchen clock is "
	CALL	TIME-PRINT,PRESENT-TIME
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"The clock is humming electrically."


	.FUNCT	APPLIANCE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It's as modern as yesterday, like everything in the kitchen."
?ELS5:	EQUAL?	PRSA,V?USE,V?LAMP-ON,V?LAMP-OFF \FALSE
	PRINTR	"The butler is probably very proud and jealous of these sparkling modern gadgets, and he wouldn't like you using them."


	.FUNCT	HALL-1-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the north end of the central hallway. Just to the north, you can see warm yellow light in the living room."
	IN?	MONICA,LIVING-ROOM \?CND8
	IN?	LINDER,LIVING-ROOM \?CND8
	ZERO?	LINDER-FOLLOWS-YOU \?CND8
	PRINTI	" You can hear voices talking excitedly."
?CND8:	CRLF	
	RTRUE	


	.FUNCT	HALL-2-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is near the middle of the central hallway. At the north end, you can see the living room; to the east and west are bedroom doors. "
	FSET?	MONICA-DOOR,OPENBIT \?ELS12
	FSET?	BUTLER-DOOR,OPENBIT \?ELS17
	PRINTR	"Both doors are open."
?ELS17:	PRINTR	"The door to the east is open."
?ELS12:	FSET?	BUTLER-DOOR,OPENBIT \?ELS25
	PRINTR	"The door to the west is open."
?ELS25:	PRINTR	"Both doors are closed."


	.FUNCT	BUTLER-ROOM-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	DDESC,STR?78,BUTLER-DOOR,STR?79
	CALL	DDESC,STR?80,BUTLER-BATH-DOOR,STR?81
	RSTACK	


	.FUNCT	BUTLER-BATH-F,RARG=0
	EQUAL?	RARG,M-LOOK /?THN6
	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
?THN6:	CALL	DDESC,STR?82,BUTLER-BATH-DOOR,STR?79
	RSTACK	


	.FUNCT	ENTRY-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	DDESC,STR?84,FRONT-DOOR,STR?79
	RSTACK	


	.FUNCT	FLOWER-F
	EQUAL?	PRSA,V?PICK \?ELS5
	PRINTR	"What? And spoil the arrangement?!"
?ELS5:	EQUAL?	PRSA,V?SMELL \FALSE
	PRINTR	"Someone chose these flowers for looks, not aroma."


	.FUNCT	SCROLL-F
	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI	"The scroll is written with a fine brush. Freely translated, it reads:

"
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"The WITNESS: An INTERLOGIC Mystery
        from Infocom, Inc.
          by Stu Galley
       based on an idea by
   Marc Blank and Dave Lebling
 Copyright (c) 1983 Infocom, Inc.
       All rights reserved.
      WITNESS and INTERLOGIC
  are trademarks of Infocom, Inc.
"
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	SHOE-PLATFORM-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTI	"Several pairs of shoes are in a row, ready for inspection."
	IN?	MUDDY-SHOES,SHOE-PLATFORM \?CND8
	FSET?	MUDDY-SHOES,INVISIBLE /?CND8
	PRINTI	" One pair of boots would not pass."
?CND8:	CRLF	
	RTRUE	


	.FUNCT	OTHER-SHOES-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"They're just ordinary shoes, nothing to get excited about."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"That wouldn't do you any good."


	.FUNCT	FRONT-DOOR-F,VAL=0
	EQUAL?	PRSA,V?KNOCK \?ELS5
	EQUAL?	PRSO,FRONT-DOOR \?ELS10
	ZERO?	WELCOMED \?ELS10
	FSET?	CORPSE,INVISIBLE \?ELS10
	EQUAL?	HERE,FRONT-PORCH \?ELS17
	CALL	WELCOME
	RSTACK	
?ELS17:	PRINTR	"You can't reach the front door."
?ELS10:	CALL	DOOR-ROOM,HERE,FRONT-DOOR
	CALL	INHABITED?,STACK
	ZERO?	STACK /?ELS23
	PRINTR	"A muffled voice says, ""Come in!"""
?ELS23:	PRINTR	"There is no answer at the door."
?ELS5:	EQUAL?	PRSA,V?WALK-TO \FALSE
	EQUAL?	HERE,DRIVEWAY-ENTRANCE,GARAGE \?CND32
	SET	'VAL,TRUE-VALUE
	CALL	GOTO,DRIVEWAY
?CND32:	EQUAL?	HERE,DRIVEWAY,FRONT-YARD \?CND35
	SET	'VAL,TRUE-VALUE
	CALL	GOTO,FRONT-PORCH
?CND35:	RETURN	VAL


	.FUNCT	CLOSET-STUFF-F
	EQUAL?	PRSA,V?USE,V?MOVE,V?TAKE \?ELS5
	PRINTR	"You have no need for them."
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?SEARCH,V?READ \FALSE
	PRINTI	"You go through"
	CALL	THE-PRSO-PRINT
	PRINTR	" and find nothing of interest."


	.FUNCT	OFFICE-F,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	ZERO?	LINDER-FOLLOWS-YOU /?ELS5
	EQUAL?	PRSO,LINDER,CLOCK-WIRES /?ELS5
	EQUAL?	PRSA,V?THROUGH /?THN8
	EQUAL?	PRSA,V?HIDE-BEHIND,V?FOLLOW,V?WALK \?ELS5
?THN8:	PRINTR	"Linder says with frustration, ""I wish you wouldn't try to go off while we're trying to talk."""
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is obviously the office of Mr. Linder's company, Pacific Trade Associates. "
	CALL	OFFICE-DESK-F,M-OBJDESC
	PRINTI	"Behind it is a large ornately-carved chair, like a cruiser escorting a battle ship"
	IN?	LINDER,CARVED-CHAIR \?CND18
	PRINTI	", where Linder sits imperiously"
?CND18:	PRINTI	". A simple wooden chair, polished smooth by visitors, flanks the desk on the other side. On the north wall is a lounge, upholstered in green velvet and a bit lumpy, with a framed wood-block picture hanging over it. On the outside wall, next to a door and window, stands a grandfather clock, ticking relentlessly. A file cabinet stands in the corner."
	CRLF	
	FSET?	OFFICE-DOOR,OPENBIT \?CND25
	PRINTI	"The door to the interior hallway is open."
	CRLF	
?CND25:	FSET?	OFFICE-BACK-DOOR,OPENBIT \?CND30
	PRINTI	"The door leading outside is open."
	CRLF	
?CND30:	FSET?	OFFICE-WINDOW,OPENBIT \TRUE
	PRINTR	"The window facing the back yard is open."


	.FUNCT	OFFICE-DESK-F,ARG=0
	EQUAL?	ARG,M-OBJDESC /?THN6
	ZERO?	ARG \?ELS5
	EQUAL?	PRSA,V?LOOK-ON,V?LOOK-INSIDE,V?EXAMINE \?ELS5
?THN6:	PRINTI	"At the west end of the office, a massive desk of teak and mahogany faces toward the window. It has no drawers, but the top is covered with piles of letters, some newspapers, a telephone, and various souvenirs from the Far East."
	EQUAL?	MONICA-TIED-TO,OFFICE-DESK \?CND12
	PRINTI	" Monica is fastened to the desk with a "
	PRINTD	MONICA-TIED-WITH
	PRINTI	"."
?CND12:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LOOK-UNDER \?ELS18
	PRINTR	"You can see dirt and grime, old chewing gum in various colors, and a pair of black wires going from a button into the floor."
?ELS18:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR	"You can't. It doesn't have drawers."


	.FUNCT	NEWSPAPERS-F
	EQUAL?	PRSA,V?USE,V?MOVE,V?TAKE \?ELS5
	PRINTR	"You have no need for them."
?ELS5:	EQUAL?	PRSA,V?EXAMINE,V?SEARCH,V?READ \FALSE
	PRINTR	"Today's L.A. Times has the usual sort of stories: secret records of the police intelligence squad were seized in connection with an attempt to assassinate private detective Harry Raymond; ""Two Officers Die in Battle With Maniac""; ""Slayer of Tijuana Girl Executed under Fugitive Law""; and ""Austria Near Hitler Yoke."""


	.FUNCT	CARVED-CHAIR-F,ARG=0
	EQUAL?	ARG,M-OBJDESC \?ELS5
	CALL	PRINT-CONT,CARVED-CHAIR
	RTRUE	
?ELS5:	ZERO?	ARG \FALSE
	EQUAL?	PRSA,V?EXAMINE /?THN11
	EQUAL?	PRSA,V?SEARCH-OBJECT-FOR \?ELS10
?THN11:	PRINTR	"The chair looks like teak, covered with carvings of vines and slithery creatures that you wouldn't like to meet in a jungle."
?ELS10:	FSET?	CORPSE,INVISIBLE \FALSE
	EQUAL?	PRSA,V?TAKE,V?SIT,V?CLIMB-ON \FALSE
	GET	P-PRSO,0
	EQUAL?	1,STACK \FALSE
	EQUAL?	PRSO,CARVED-CHAIR \FALSE
	PRINTI	"Linder glares at you. "
	IN?	LINDER,CARVED-CHAIR \?ELS30
	PRINTI	"""I meant that you should sit in the customer's chair, not my lap!"" "
	JUMP	?CND28
?ELS30:	PRINTI	"""That's my chair. You take the other one."" "
?CND28:	PRINTR	"You are on your own feet again."


	.FUNCT	WOODEN-CHAIR-F,ARG=0
	ZERO?	ARG \FALSE
	EQUAL?	PRSA,V?TAKE,V?SIT,V?CLIMB-ON \FALSE
	GET	P-PRSO,0
	EQUAL?	1,STACK \FALSE
	EQUAL?	PRSO,WOODEN-CHAIR \FALSE
	MOVE	PLAYER,WOODEN-CHAIR
	PRINTI	"You are now sitting on the "
	PRINTD	PRSO
	PRINTI	"."
	CRLF	
	ZERO?	LINDER-EXPLAINED \TRUE
	CALL	I-LINDER-EXPLAIN
	RTRUE	


	.FUNCT	GENERIC-CHAIR-F,OBJ
	EQUAL?	PRSA,V?DISEMBARK \?ELS5
	LOC	WINNER
	IN?	STACK,ROOMS /?ELS5
	LOC	WINNER
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN10
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS9
?THN10:	RETURN	GENERIC-CHAIR
?ELS9:	EQUAL?	HERE,MONICA-ROOM,LINDER-ROOM,LIVING-ROOM /FALSE
	EQUAL?	HERE,DINING-ROOM,KITCHEN,OFFICE /FALSE
	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"chair"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	PAPERS-F
	EQUAL?	PRSA,V?TAKE /?THN6
	EQUAL?	PRSA,V?READ,V?LOOK-INSIDE,V?EXAMINE \FALSE
?THN6:	FSET	PAPERS,TOUCHBIT
	LOC	LINDER
	ZERO?	STACK /?ELS12
	CALL	PERFORM,V?ASK-ABOUT,LINDER,PAPERS
	RTRUE	
?ELS12:	PRINTI	"You look "
	EQUAL?	P-ADVERB,W?CAREFULLY \?ELS19
	PRINTI	"more thoroughly through the files and still"
	JUMP	?CND17
?ELS19:	PRINTI	"quickly through the files but"
?CND17:	PRINTR	" find nothing suspicious, so you decide to leave them alone."


	.FUNCT	CLOCK-F
	EQUAL?	HERE,OFFICE /?ELS5
	EQUAL?	PRSA,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT /?ELS5
	EQUAL?	PRSA,V?WHAT,V?TELL-ME,V?FIND /?ELS5
	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"clock"
	PRINTR	" here!)"
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS11
	PRINTI	"This is a full-blown ""grandfather"" clock, seven feet tall, run by weights and regulated by a pendulum, whose dial shows day, date, and phase of the moon besides the time. According to the dial, today is "
	LESS?	PRESENT-TIME,720 \?ELS16
	PRINTI	"Friday the 18"
	JUMP	?CND14
?ELS16:	PRINTI	"Saturday the 19"
?CND14:	PRINTI	"th, the moon is just past full, and the time is now "
	CALL	TIME-PRINT,PRESENT-TIME
	ZERO?	SHOT-FIRED /?CND25
	FCLEAR	CLOCK-POWDER,INVISIBLE
	EQUAL?	P-ADVERB,W?CAREFULLY \?ELS31
	PRINTI	" There is some kind of powder around the keyhole."
	JUMP	?CND25
?ELS31:	PRINTI	" And you notice that the keyhole looks darker than normal."
?CND25:	CRLF	
	RTRUE	
?ELS11:	EQUAL?	PRSA,V?LISTEN \?ELS39
	PRINTR	"The clock is ticking relentlessly."
?ELS39:	EQUAL?	PRSA,V?SEARCH,V?OPEN,V?LOOK-INSIDE \?ELS43
	FSET?	CLOCK,LOCKED /?ELS43
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE \?CND46
	FSET?	CLOCK,OPENBIT /?CND46
	PRINTR	"You'll have to open it first."
?CND46:	FSET	CLOCK,OPENBIT
	PRINTI	"As you'd expect, the case holds a long pendulum."
	IN?	INSIDE-GUN,CLOCK \?CND55
	FCLEAR	INSIDE-GUN,INVISIBLE
	PRINTI	" The surprise is a hand gun, pointing out into the room."
?CND55:	PRINTR	" You can also see some relays and things."
?ELS43:	EQUAL?	PRSA,V?LOOK-UNDER \?ELS63
	PRINTR	"All you see is a pair of green wires going from the case into the floor."
?ELS63:	EQUAL?	PRSA,V?LOCK \?ELS67
	EQUAL?	PRSO,CLOCK \?ELS67
	IN?	CLOCK-KEY,WINNER \?ELS72
	FSET	CLOCK,LOCKED
	SET	'USED-CLOCK-KEY,TRUE-VALUE
	PRINTR	"The door of the clock is now locked."
?ELS72:	PRINTR	"You don't have the right key."
?ELS67:	EQUAL?	PRSA,V?UNLOCK \?ELS80
	EQUAL?	PRSO,CLOCK \?ELS80
	IN?	CLOCK-KEY,WINNER \?ELS87
	FCLEAR	CLOCK,LOCKED
	SET	'USED-CLOCK-KEY,TRUE-VALUE
	PRINTR	"The door of the clock is now unlocked."
?ELS87:	PRINTR	"You don't have the right key."
?ELS80:	EQUAL?	PRSA,V?MOVE,V?PUSH \FALSE
	PRINTR	"It seems to be bolted to the floor."


	.FUNCT	KEY-HOLE-F
	EQUAL?	WINNER,PLAYER \?CND1
	EQUAL?	PRSA,V?SMELL,V?RUB-OVER /?THN6
	EQUAL?	PRSA,V?RUB,V?PUT,V?LOOK-INSIDE /?THN6
	EQUAL?	PRSA,V?KISS,V?EXAMINE,V?BRUSH \?CND1
?THN6:	SET	'PLAYER-NEAR-SHOT,PRESENT-TIME
?CND1:	EQUAL?	PRSA,V?EXAMINE \?ELS12
	PRINTI	"It's an impressive keyhole, wrapped in a fine brass escutcheon."
	ZERO?	SHOT-FIRED /?CND15
	FCLEAR	CLOCK-POWDER,INVISIBLE
	PRINTI	" There is some kind of powder around it."
?CND15:	CRLF	
	RTRUE	
?ELS12:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS22
	FSET?	CLOCK,OPENBIT /?ELS22
	PRINTR	"You can't see anything in there but darkness."
?ELS22:	EQUAL?	PRSA,V?PUT \FALSE
	ZERO?	LINDER-FOLLOWS-YOU /FALSE
	PRINTR	"Linder says, ""I wish you'd pay attention to me instead of that clock."""


	.FUNCT	CLOCK-POWDER-F
	EQUAL?	PRSA,V?ANALYZE \?ELS5
	FCLEAR	CLOCK-POWDER,NDESCBIT
	FCLEAR	CLOCK-POWDER,INVISIBLE
	CALL	DO-ANALYZE
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTR	"It looks like cheap gunpowder."
?ELS7:	EQUAL?	PRSA,V?SMELL \?ELS11
	PRINTR	"It has a pungent smell, like cheap gunpowder."
?ELS11:	GET	P-PRSO,0
	EQUAL?	1,STACK \FALSE
	EQUAL?	PRSA,V?TAKE \FALSE
	FCLEAR	CLOCK-POWDER,INVISIBLE
	FCLEAR	CLOCK-POWDER,NDESCBIT
	RFALSE	


	.FUNCT	CLOCK-WIRES-F
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	PRINTR	"The wires go into the floor and disappear."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTI	"You can't."
	PRINTR	" They're stuck tight."


	.FUNCT	OFFICE-BUTTON-F
	EQUAL?	PRSA,V?FIND \?ELS5
	PRINTR	"It's on the edge of the desk."
?ELS5:	EQUAL?	PRSA,V?RING,V?PUSH \FALSE
	ZERO?	BUTTON-FIXED /?ELS14
	CALL	PERFORM,V?PUSH,BUTTON
	RTRUE	
?ELS14:	ZERO?	SHOT-FIRED /?ELS17
	SET	'PLAYER-PUSHED-BUTTON,TRUE-VALUE
	PRINTR	"You hear a clicking sound from the direction of the clock."
?ELS17:	CALL	META-LOC,LINDER
	EQUAL?	STACK,OFFICE \?ELS22
	PRINTR	"Linder grabs your wrist and looks you hard in the eye. Then a wide smile breaks out on his face as he lets go. ""Sorry if I'm rough, but I don't want any interruptions right now."""
?ELS22:	SET	'PLAYER-PUSHED-BUTTON,TRUE-VALUE
	CALL	FIRE-SHOT
	RTRUE	


	.FUNCT	GARAGE-F,ARG=0
	EQUAL?	ARG,M-LOOK \FALSE
	PRINTI	"The garage, like a car port, has no door to keep the cars in. Doors lead north and east. The walls are decorated with spare tires and things. "
	FSET?	MONICA-CAR,INVISIBLE \?ELS10
	FSET?	MONICA-CAR,TOUCHBIT \?ELS13
	PRINTI	"The red MG is gone."
	JUMP	?CND8
?ELS13:	PRINTI	"Oil spots on the floor show that a car is often parked here."
	JUMP	?CND8
?ELS10:	FSET?	MONICA-CAR,TOUCHBIT \?ELS24
	PRINTI	"The red MG is parked here."
	JUMP	?CND8
?ELS24:	PRINTI	"One car is a sporty red MG convertible."
?CND8:	PRINTR	" The other car is a dark blue Bentley 3.5-liter sedan."


	.FUNCT	CAR-F,ARG=0
	EQUAL?	PRSO,MONICA-CAR \?ELS5
	FSET?	MONICA-CAR,INVISIBLE \?ELS5
	PRINTR	"It's not here."
?ELS5:	ZERO?	FILM-SEEN /?ELS11
	EQUAL?	PRSO,MONICA-CAR \?ELS11
	EQUAL?	PRSA,V?RUB \?ELS11
	PRINTR	"The hood is still warm from driving."
?ELS11:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS17
	PRINTR	"You can barely see a plush interior through the tinted glass, but nothing else of interest."
?ELS17:	EQUAL?	PRSA,V?UNLOCK,V?LOCK \?ELS21
	PRINTR	"You don't have the right key."
?ELS21:	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINTR	"The doors are locked."


	.FUNCT	CAR-WINDOW-F
	EQUAL?	HERE,GARAGE /?ELS5
	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"window"
	PRINTR	" here!)"
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS9
	PRINTR	"You can barely see a plush interior through the tinted glass, but nothing else of interest."
?ELS9:	EQUAL?	PRSA,V?MUNG \FALSE
	PRINTI	"Vandalism is for private "
	CALL	TANDY?
	ZERO?	STACK /?ELS18
	PRINTI	"eye"
	JUMP	?CND16
?ELS18:	PRINTI	"dick"
?CND16:	PRINTR	"s, not famous police detectives!"


	.FUNCT	GENERIC-CAR-F,OBJ
	EQUAL?	HERE,GARAGE /FALSE
	EQUAL?	PRSA,V?WHAT,V?TELL-ME /?THN8
	EQUAL?	PRSA,V?FIND,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS7
?THN8:	RETURN	GENERIC-CAR
?ELS7:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"car"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	WORKSHOP-WIRE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It looks just like ordinary wire."
?ELS5:	EQUAL?	PRSA,V?FIND \?ELS9
	PRINTR	"You can find wire here in almost any color you like."
?ELS9:	EQUAL?	PRSA,V?FOLLOW \FALSE
	PRINTR	"It just goes around and around the supply spool."


	.FUNCT	SPOOL-OF-WIRE-F
	EQUAL?	PRSA,V?COMPARE \FALSE
	EQUAL?	PRSI,PIECE-OF-WIRE /?THN8
	EQUAL?	PRSO,PIECE-OF-WIRE \FALSE
?THN8:	EQUAL?	P-ADVERB,W?CAREFULLY \?ELS14
	SET	'WIRE-MATCHED,TRUE-VALUE
	PRINTR	"The piece of green wire and the green spool fit together perfectly."
?ELS14:	PRINTR	"The piece of green wire and the green spool appear to be similar."


	.FUNCT	GENERIC-WIRE-F,OBJ
	EQUAL?	HERE,WORKSHOP \?ELS5
	EQUAL?	PRSA,V?FIND \FALSE
	RETURN	WORKSHOP-WIRE
?ELS5:	IN?	OBJ,GLOBAL-OBJECTS /FALSE
	EQUAL?	PRSA,V?TAKE,V?SEARCH-OBJECT-FOR /?THN15
	EQUAL?	PRSA,V?SGIVE,V?GIVE,V?WHAT /?THN15
	EQUAL?	PRSA,V?TELL-ME,V?FIND,V?ASK-CONTEXT-FOR /?THN15
	EQUAL?	PRSA,V?ASK-FOR,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS14
?THN15:	EQUAL?	OBJ,PIECE-OF-WIRE,SPOOL-OF-WIRE /?THN22
	EQUAL?	OBJ,CLOCK-WIRES,GENERIC-GREEN-WIRE \?ELS21
?THN22:	RETURN	GENERIC-GREEN-WIRE
?ELS21:	RETURN	GENERIC-WIRE
?ELS14:	SET	'P-WON,FALSE-VALUE
	PRINTI	"(You can't see any "
	PRINTI	"wire"
	PRINTI	" here!)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	JUNCTION-BOX-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"There's a snarl of colored wires, relays, pilot lights, and stuff that only an engineer could admire."


	.FUNCT	TOOLS-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The tools are standard gardening and carpentry tools, in excellent condition."
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"You have no use for them, unless you are looking for a new profession."


	.FUNCT	AIR-F
	EQUAL?	PRSA,V?SMELL \FALSE
	EQUAL?	HERE,FRONT-YARD \?ELS10
	PRINTR	"The smell of herbs permeates everything."
?ELS10:	EQUAL?	HERE,FRONT-PORCH \?ELS14
	PRINTR	"A breeze carries the faint smell of herbs through the air."
?ELS14:	GETP	HERE,P?LINE
	EQUAL?	STACK,OUTSIDE-LINE-C \?ELS18
	PRINTR	"The air is clear and fresh here."
?ELS18:	CALL	FRESH-AIR?,HERE
	ZERO?	STACK \TRUE
	PRINTR	"The air is rather musty here."


	.FUNCT	FRESH-AIR?,RM,P,L,TBL,O
	SET	'P,0
?PRG1:	NEXTP	HERE,P >P
	ZERO?	P /FALSE
	LESS?	P,LOW-DIRECTION /?PRG1
	GETPT	HERE,P >TBL
	PTSIZE	TBL >L
	EQUAL?	L,DEXIT \?PRG1
	GETB	TBL,DEXITOBJ >O
	FSET?	O,OPENBIT \?PRG1
	PRINTI	"There is a pleasant breeze coming through the "
	PRINTD	O
	PRINTR	"."


	.FUNCT	CORRIDOR-LOOK,ITM=0,C,Z,COR,VAL,FOUND=0
	GETP	HERE,P?CORRIDOR >C
	ZERO?	C /FALSE
?PRG6:	SUB	C,16 >Z
	LESS?	Z,0 /?ELS10
	SET	'COR,COR-16
	JUMP	?CND8
?ELS10:	SUB	C,8 >Z
	LESS?	Z,0 /?ELS12
	SET	'COR,COR-8
	JUMP	?CND8
?ELS12:	SUB	C,4 >Z
	LESS?	Z,0 /?ELS14
	SET	'COR,COR-4
	JUMP	?CND8
?ELS14:	SUB	C,2 >Z
	LESS?	Z,0 /?ELS16
	SET	'COR,COR-2
	JUMP	?CND8
?ELS16:	SUB	C,1 >Z
	LESS?	Z,0 /?REP7
	SET	'COR,COR-1
?CND8:	CALL	CORRIDOR-CHECK,COR,ITM >VAL
	ZERO?	FOUND \?CND21
	SET	'FOUND,VAL
?CND21:	SET	'C,Z
	JUMP	?PRG6
?REP7:	RETURN	FOUND


	.FUNCT	CORRIDOR-CHECK,COR,ITM,CNT=2,PAST=0,FOUND=0,RM,OBJ
?PRG1:	GET	COR,CNT >RM
	ZERO?	RM /FALSE
	EQUAL?	RM,HERE \?ELS7
	SET	'PAST,1
	JUMP	?CND3
?ELS7:	FIRST?	RM >OBJ \?CND3
?PRG10:	ZERO?	ITM /?ELS14
	EQUAL?	OBJ,ITM \?CND12
	GET	COR,PAST >FOUND
	JUMP	?REP11
?ELS14:	FSET?	OBJ,PERSON \?CND12
	CALL	IN-MOTION?,OBJ
	ZERO?	STACK \?CND12
	FSET?	OBJ,INVISIBLE /?CND12
	EQUAL?	OBJ,STILES \?ELS25
	ZERO?	DUFFY-WITH-STILES /?ELS25
	SET	'SEEN-DUFFY?,TRUE-VALUE
	PRINTI	"Sgt. Duffy, with "
	ZERO?	MET-STILES? /?ELS32
	PRINTI	"Stiles"
	JUMP	?CND30
?ELS32:	PRINTI	"someone"
?CND30:	PRINTI	" in tow,"
	JUMP	?CND23
?ELS25:	FSET?	OBJ,TOUCHBIT /?ELS43
	PRINTI	"Someone"
	JUMP	?CND23
?ELS43:	PRINTD	OBJ
?CND23:	PRINTI	" is "
	CALL	OUTSIDE?,RM
	ZERO?	STACK /?ELS54
	PRINTI	"off"
	JUMP	?CND52
?ELS54:	PRINTI	"down the hall"
?CND52:	PRINTI	" to "
	GET	COR,PAST
	CALL	DIR-PRINT,STACK
	PRINTI	"."
	CRLF	
?CND12:	NEXT?	OBJ >OBJ /?KLU72
?KLU72:	ZERO?	OBJ \?PRG10
?REP11:	ZERO?	FOUND /?CND3
	RETURN	FOUND
?CND3:	INC	'CNT
	JUMP	?PRG1


	.FUNCT	COR-DIR,HERE,THERE,COR,RM,PAST=0,CNT=2,?TMP1
	GETP	THERE,P?CORRIDOR >?TMP1
	GETP	HERE,P?CORRIDOR
	BAND	?TMP1,STACK
	CALL	GET-COR,STACK >COR
?PRG1:	GET	COR,CNT >RM
	EQUAL?	RM,HERE \?ELS5
	SET	'PAST,1
	JUMP	?REP2
?ELS5:	EQUAL?	RM,THERE \?CND3
	JUMP	?REP2
?CND3:	INC	'CNT
	JUMP	?PRG1
?REP2:	GET	COR,PAST
	RSTACK	


	.FUNCT	GET-COR,NUM
	EQUAL?	NUM,1 \?ELS5
	RETURN	COR-1
?ELS5:	EQUAL?	NUM,2 \?ELS7
	RETURN	COR-2
?ELS7:	EQUAL?	NUM,4 \?ELS9
	RETURN	COR-4
?ELS9:	EQUAL?	NUM,8 \?ELS11
	RETURN	COR-8
?ELS11:	RETURN	COR-16

	.ENDI
