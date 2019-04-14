"PLACES for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

"Other possible generics: cabinet counter footprints hallway shelf"

"Directions"

<GLOBAL DIR-STRINGS
	<PTABLE  P?NORTH "north" P?SOUTH "south"
		P?EAST "east" P?WEST "west"
		P?NW "northwest" P?NE "northeast"
		P?SW "southwest" P?SE "southeast"
		P?DOWN "downstairs" P?UP "upstairs"
		P?IN "in" P?OUT "out">>

<ROUTINE DIR-PRINT (DIR "AUX" (CNT 0))
	 #DECL ((DIR CNT) FIX)
	 <REPEAT ()
		 <COND (<==? <GET ,DIR-STRINGS .CNT> .DIR>
			<COND (T ;<NOT <EQUAL? .DIR ,P?UP ,P?DOWN>>
			       <TELL "the ">)>
			<PRINT <GET ,DIR-STRINGS <+ .CNT 1>>>
			<RTRUE>)>
		 <SET CNT <+ .CNT 1>>>>

"The usual globals"

<OBJECT ROOMS>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(SYNONYM ROOM PLACE WALL WALLS)
	(DESC "place" ;"room")
	;(GENERIC WALL-F)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ("AUX" TIM VAL)
	 <COND (<VERB? KNOCK>
		<TELL "Knocking on the walls reveals nothing unusual." CR>)
	       (<VERB? SEARCH EXAMINE>
		<COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
		       <SET TIM 10>)
		      (<NOT <0? <GETP ,HERE ,P?CORRIDOR>>>
		       <SET TIM 3>)
		      (T <SET TIM <+ 2 <GETP ,HERE ,P?SIZE>>>)>
		<TELL
"(You'd do better to examine or search one thing at a time. Searching a
whole room or area thoroughly would take hours. A cursory search would take
about " N .TIM " minutes, and it might not reveal much. Would you like
to do it anyway?)">
		<COND (<YES?>
		       <COND (<==? ,M-FATAL <SET VAL <INT-WAIT .TIM>>>
			      <RTRUE>)
			     (.VAL
			      <TELL
"Your cursory search revealed nothing new." CR>)
			     (T
			      <TELL
"You didn't get a chance to finish looking over the place." CR>)>)
		      (T <TELL "Okeh." CR>)>)>>

;<ROUTINE WALL-F ()
 <COND (<OUTSIDE? ,HERE> ,HOUSE) (T ,GLOBAL-ROOM)>>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW PANE PANES FRAME)
	(FLAGS NDESCBIT WINDOWBIT LOCKED)
	(GENERIC GENERIC-WINDOW-F ;LOCKED-F)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ("AUX" (RM <WINDOW-ROOM ,HERE ,PRSO>) POP)
	 <COND (<VERB? BRUSH>
		<TELL
"The window is clean enough without your interference." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The window is a simple wooden sash, locked tight against the cold.">
		<COND (<NOT <OUTSIDE? ,HERE>>
		       <TELL
" There's some sort of electric relay on one edge, with white wires
attached.">)>
		<CRLF>)
	       (<VERB? LOOK-INSIDE LOOK-OUTSIDE>
		<COND (.RM
		       <TELL"The window is damp and foggy, but you can see">
		       <SET POP <POPULATION .RM>>
		       <COND (<0? .POP> T)
			     (<1? .POP> <TELL " someone in">)
			     (T <TELL " some people in">)>
		       <THE? .RM>
		       <TELL " " D .RM " "
			     <COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
				    "in")
				   (T "out")>
			     "side." CR>)
		      (T
		       <TELL "The window is too foggy to see through." CR>)>
		<RTRUE>)
	       (<VERB? KNOCK>
		<COND (<NOT <WINDOW-KNOCK .RM>>
		       <TELL "There's no answer." CR>)>)
	       (<VERB? MUNG>
		<TELL "Vandalism is for private ">
		<COND (<TANDY?> <TELL "eye">)
		      (T <TELL "dick">)>
		<TELL "s, not famous police detectives!" CR>)
	       (<VERB? OPEN CLOSE LOCK UNLOCK>
		<COND (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL "It's really broken. ">)>
		<TELL "You can't." CR>)>>

<ROUTINE GENERIC-WINDOW-F (OBJ)
	<COND (<WINDOW-IN? ,HERE> <RFALSE>)
	      (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	       ,WINDOW)
	      (T
	       <SETG P-WON <>>
	       <TELL "(You can't see any " "window" " here!)" CR>
	       ,NOT-HERE-OBJECT)>>

<ROUTINE WINDOW-KNOCK (RM)
	 <COND (<INHABITED? .RM>
		<TELL "Someone looks up at you inquisitively." CR>)>>

<ROUTINE WINDOW-IN? (RM)
	<OR <EQUAL? .RM ,FRONT-YARD ,KITCHEN ,BUTLER-ROOM>
	    <EQUAL? .RM ,OFFICE-PORCH ,OFFICE>
	    <EQUAL? .RM ,BACK-YARD ,MONICA-ROOM>
	    <EQUAL? .RM ,ROCK-GARDEN ,LINDER-ROOM ,TUB-ROOM>>
	;<AND <0? <BAND 31 <GETP .RM ,P?CORRIDOR>>> ;"not HALL-n or outside"
	     <NOT <EQUAL? .RM ,BATHROOM ,TOILET-ROOM ,BUTLER-BATH>>
	     <NOT <EQUAL? .RM ,STORAGE-CLOSET ,LIVING-ROOM ,WORKSHOP>>>>

;<ROUTINE WINDOW-SHOP (RM STR "AUX" (P <POPULATION .RM>))
	 <COND (<0? .P> <CRLF> <RTRUE>)
	       (T <TELL "You can vaguely see ">)>
	 <COND (<1? .P>
		<TELL "someone">)
	       (T
		<PRINTN .P>
		<TELL " people">)>
	 <TELL " inside the " .STR "." CR>>

<OBJECT SINK
	(IN LOCAL-GLOBALS)
	(DESC "sink")
	(SYNONYM SINK BASIN FAUCET SPIGOT)
	(FLAGS NDESCBIT FURNITURE)>

<OBJECT TOILET
	(IN LOCAL-GLOBALS)
	(DESC "toilet")
	(SYNONYM TOILET)
	(FLAGS NDESCBIT FURNITURE SURFACEBIT VEHBIT)
	(ACTION TOILET-F)>

<ROUTINE TOILET-F ("OPTIONAL" (RARG 100))
	 <COND (<NOT <==? .RARG 100>> <RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"You have stooped to a new low by snooping around toilet bowls." CR>)
	       ;(<VERB? FLUSH>
		<TELL "\"Whhoooossshhhhh!\"" CR>)>>

<OBJECT GENERIC-BATHROOM-DOOR
	(IN GLOBAL-OBJECTS)
	(DESC "bathroom door")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-BATH-DOOR-F (OBJ)
 <COND (<EQUAL? ,HERE ,MONICA-ROOM> ,MONICA-BATH-DOOR)
       (<EQUAL? ,HERE ,LINDER-ROOM> ,LINDER-BATH-DOOR)
       (<EQUAL? ,HERE ,BUTLER-ROOM ,BUTLER-BATH> ,BUTLER-BATH-DOOR)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-BATHROOM-DOOR)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "bathroom door" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT GENERIC-BEDROOM
	(IN GLOBAL-OBJECTS)
	(DESC "bedroom")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-BEDROOM-F (OBJ)
 <COND (<EQUAL? .OBJ ,HERE ,GLOBAL-HERE> ,GLOBAL-ROOM)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-BEDROOM)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "bedroom" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT GENERIC-BEDROOM-DOOR
	(IN GLOBAL-OBJECTS)
	(DESC "bedroom door")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-BEDROOM-DOOR-F (OBJ)
 <COND (<EQUAL? ,HERE ,MONICA-ROOM ,HALL-2> ,MONICA-DOOR)
       (<EQUAL? ,HERE ,LINDER-ROOM ,LIVING-ROOM> ,LINDER-DOOR)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-BEDROOM-DOOR)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "bedroom door" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT GENERIC-BACK-DOOR
	(IN GLOBAL-OBJECTS)
	(DESC "back door")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-BACK-DOOR-F (OBJ)
 <COND (<AND <VERB? SHOOT>
	     <FSET? ,P-IT-OBJECT ,DOORBIT>
	     <FSET? ,P-IT-OBJECT ,LOCKED>>
	,P-IT-OBJECT)
       (<EQUAL? ,HERE ,OFFICE-PORCH ,OFFICE> ,OFFICE-BACK-DOOR)
       (<EQUAL? ,HERE ,BACK-YARD ,MONICA-ROOM> ,MONICA-BACK-DOOR)
       (<EQUAL? ,HERE ,ROCK-GARDEN ,LINDER-ROOM> ,LINDER-BACK-DOOR)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-BACK-DOOR)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "back door" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT GENERIC-BATHROOM
	(IN GLOBAL-OBJECTS)
	(DESC "bathroom")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-BATHROOM-F (OBJ)
 <COND (<EQUAL? .OBJ ,HERE ,GLOBAL-HERE> ,GLOBAL-ROOM)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-BATHROOM)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "bathroom" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<ROUTINE NULL-F ("OPTIONAL" A1 A2)
	<RFALSE>>

<ROUTINE DDESC (STR1 DOOR STR2)
	 #DECL ((STR1) <OR STRING ZSTRING> (DOOR) OBJECT
		(STR2) <OR FALSE STRING ZSTRING>)
	 <TELL .STR1>
	 <COND (<FSET? .DOOR ,OPENBIT> <TELL "open">)
	       (T <TELL "closed">)>
	 <TELL .STR2 CR>>

<ROUTINE DOOR-ROOM (RM DR "AUX" (P 0) TBL)
	 #DECL ((RM DR) OBJECT (P) FIX)
	 <REPEAT ()
		 <COND (<OR <0? <SET P <NEXTP .RM .P>>>
			    <L? .P ,LOW-DIRECTION>>
			<RFALSE>)
		       (<AND <==? ,DEXIT <PTSIZE <SET TBL <GETPT .RM .P>>>>
			     <==? .DR <GETB .TBL ,DEXITOBJ>>>
			<RETURN <GETB .TBL ,REXIT>>)>>>

<ROUTINE FIND-FLAG (RM FLAG "OPTIONAL" (EXCLUDED <>) "AUX" (O <FIRST? .RM>))
	<REPEAT ()
	 <COND (<NOT .O> <RETURN <>>)
	       (<AND <FSET? .O .FLAG> <NOT <==? .O .EXCLUDED>>>
		<RETURN .O>)
	       (T <SET O <NEXT? .O>>)>>>

<OBJECT GLOBAL-HERE
	(IN GLOBAL-OBJECTS)
	(DESC "here")
	(SYNONYM HERE)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-HERE-F)>

<ROUTINE GLOBAL-HERE-F ("AUX" (FLG <>) F HR)
	 <COND (<VERB? WHAT ASK-ABOUT>
		<SET F <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)
			      (<AND <FSET? .F ,CONTBIT> <INHABITED? .F>>
			       <SET FLG T>
			       <SET HR ,HERE>
			       <SETG HERE .F>
			       <GLOBAL-HERE-F>
			       <SETG HERE .HR>)
			      (<AND <FSET? .F ,PERSON> <NOT <==? .F ,PLAYER>>>
			       <SET FLG T>
			       <DESCRIBE-OBJECT .F T 0>)>
			<SET F <NEXT? .F>>>
		<COND (<NOT .FLG> <TELL "There's nobody else here." CR>)>
		<RTRUE>)>>

<ROUTINE LOCKED-F (OBJ)
 <COND (<==? ,HERE ,FRONT-YARD>
	<COND (<VERB? EXAMINE LOOK-INSIDE SEARCH SEARCH-OBJECT-FOR THROUGH>
	       ,DINING-DOOR)
	      (<VERB? WALK-TO> ,FRONT-DOOR)
	      (T <RFALSE>)>)
       (<AND <VERB? SHOOT>
	     <FSET? ,P-IT-OBJECT ,DOORBIT>
	     <FSET? ,P-IT-OBJECT ,LOCKED>>
	,P-IT-OBJECT)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT <LOC .OBJ>>
			<RFALSE>)>
		 <COND (<EQUAL? <LOC .OBJ> ,LOCAL-GLOBALS ,GLOBAL-OBJECTS>
			<RETURN <LOC .OBJ>>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (ELSE
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OUTSIDE? (RM)
	<OR <==? .RM ,GARAGE>
	    <==? <GETP .RM ,P?LINE> ,OUTSIDE-LINE-C>>>

<ROUTINE PHONE-IN? (RM)
	<EQUAL? .RM ,LIVING-ROOM ,OFFICE ,MONICA-ROOM>>

<ROUTINE WINDOW-ROOM (RM WINDOW "AUX" (P 0) L)
	 #DECL ((RM WINDOW) OBJECT (P L) FIX)
	 <COND (<==? .RM ,FRONT-YARD>
		<COND (<==? .WINDOW ,KITCHEN-WINDOW> ,KITCHEN)
		      (<==? .WINDOW ,BUTLER-WINDOW> ,BUTLER-ROOM)>)
	       (<EQUAL? .RM ,KITCHEN ,BUTLER-ROOM> ,FRONT-YARD)
	       (<==? .RM ,OFFICE-PORCH> ,OFFICE)
	       (<==? .RM ,OFFICE> ,OFFICE-PORCH)
	       (<==? .RM ,BACK-YARD> ,MONICA-ROOM)
	       (<==? .RM ,MONICA-ROOM> ,BACK-YARD)
	       (<==? .RM ,ROCK-GARDEN>
		<COND (<==? .WINDOW ,LINDER-WINDOW> ,LINDER-ROOM)
		      (<==? .WINDOW ,BATH-WINDOW> ,TUB-ROOM)>)
	       (<EQUAL? .RM ,LINDER-ROOM ,TUB-ROOM> ,ROCK-GARDEN)>>

"Grounds of Linder House"

<ROUTINE GROUND-SURFACE ()
 <COND (<EQUAL? ,HERE ,FRONT-YARD ,ROCK-GARDEN>
	"gravel")
       (<EQUAL? ,HERE ,DRIVEWAY ,DRIVEWAY-ENTRANCE>
	"peastone")
       (<EQUAL? ,HERE ,FRONT-PORCH ,OFFICE-PORCH> "concrete")
       (<EQUAL? ,HERE ,BACK-YARD> "grass")
       (,GROUND-MUDDY "mud")
       (T "dirt")>>

<ROOM FRONT-YARD
	(IN ROOMS)
	(DESC "front yard")
	(FLAGS RLANDBIT ONBIT)
	(LDESC
"You are in the front yard of the Linder property. Most of the space is
occupied by a kitchen garden full of vegetables and herbs. A wooden
fence surrounds the yard on the west and north sides. To the east is the
house, with a French door and two windows. To the south is a gate that
leads to the front porch.")
	;(ADJECTIVE FRONT)
	;(SYNONYM YARD)
	(EAST TO DINING-ROOM IF DINING-DOOR IS OPEN)
	(WEST "A wooden fence blocks your way.")
	(NORTH "A wooden fence blocks your way.")
	(SOUTH TO FRONT-PORCH IF FRONT-GATE IS OPEN)
	(UP "You can't go that way.")
	(DOWN "You can't go that way.")	;"just to establish properties"
	(GLOBAL HOUSE DINING-DOOR KITCHEN-WINDOW BUTLER-WINDOW
		FRONT-GATE FRONT-DOOR FENCE)
	(LINE 4)
	(STATION FRONT-YARD)>

<OBJECT KITCHEN-GARDEN
	(IN FRONT-YARD)
	(ADJECTIVE KITCHEN)
	(SYNONYM GARDEN VEGETABLE HERB HERBS)
	(DESC "kitchen garden")
	(FLAGS NDESCBIT)>

<OBJECT FRONT-GATE 
	(IN LOCAL-GLOBALS)
	(ADJECTIVE FRONT ;GARDEN)
	(SYNONYM GATE)
	(DESC "front gate")
	(FLAGS DOORBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM FRONT-PORCH
	(IN ROOMS)
	(DESC "front porch")
	(ACTION FRONT-PORCH-F)
	;(ADJECTIVE FRONT)
	;(SYNONYM PORCH ;STOOP)
	(FLAGS RLANDBIT ONBIT ON-NOT-IN)
	(IN   TO ENTRY IF FRONT-DOOR IS OPEN)
	(EAST TO ENTRY IF FRONT-DOOR IS OPEN)
	(SOUTH TO DRIVEWAY)
	(WEST "A wooden fence blocks your way.")
	(NORTH TO FRONT-YARD IF FRONT-GATE IS OPEN)
	(GLOBAL HOUSE FRONT-DOOR FRONT-GATE FENCE DRIVEWAY-OBJECT)
	(LINE 4)
	(STATION FRONT-PORCH)
	(CORRIDOR 4)>

<ROUTINE FRONT-PORCH-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
		<DDESC
"The front porch is in an alcove, sheltered from the weather by the
walls and overhanging roof. A yellowish electric light hangs near
the " ,FRONT-DOOR " front door to the east, giving you a
dim view of the
driveway to the south and the front yard behind a gate to the north.">
		<DDESC
"The gate is " ,FRONT-GATE
". A door bell glows at you, almost daring you to ring it.">
		<THIS-IS-IT ,DOORBELL>)>>

<OBJECT DOORBELL
	(DESC "door bell")
	(ADJECTIVE DOOR)
	(SYNONYM BELL DOORBELL)
	(IN FRONT-PORCH)
	(FLAGS NDESCBIT)
	(ACTION DOORBELL-F)>

<ROUTINE DOORBELL-F ()
 <COND (<VERB? PUSH RING>
	<COND (<AND <NOT ,WELCOMED>
		    <FSET? ,CORPSE ,INVISIBLE>>
	       <WELCOME>)
	      (T <YOU-RANG>
	       <TELL "The door bell rings, loud and clear." CR>)>
	<RTRUE>)>>
]
<ROOM DRIVEWAY
	(IN ROOMS)
	(DESC "driveway")
	(LDESC
"The driveway, paved with peastone, runs from the entrance at the south
end in a curve to a two-car garage at the east end. North of you is the
front porch, the entrance to the house.")
	;(ADJECTIVE DRIVE)
	;(SYNONYM DRIVEWAY WAY)
	(FLAGS RLANDBIT ONBIT ON-NOT-IN)
	(NORTH TO FRONT-PORCH)
	(SOUTH TO DRIVEWAY-ENTRANCE)
	(EAST TO GARAGE)
	(WEST "A wooden fence blocks your way.")
	(GLOBAL HOUSE FRONT-DOOR FENCE DRIVEWAY-OBJECT)
	(LINE 4)
	(STATION DRIVEWAY)
	(CORRIDOR 12)>

<OBJECT DRIVEWAY-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "driveway")
	(LDESC
"The driveway, paved with peastone, runs from the entrance at the south
end in a curve to a two-car garage at the east end.")
	(ADJECTIVE DRIVE)
	(SYNONYM DRIVEWAY WAY)
	(ACTION DRIVEWAY-F)>

<ROUTINE DRIVEWAY-F ("OPTIONAL" (ARG <>))
 <COND (<AND <VERB? CLIMB-UP FOLLOW> <DOBJ? DRIVEWAY-OBJECT>>
	<COND (<==? ,HERE ,DRIVEWAY-ENTRANCE>
	       <PERFORM ,V?WALK ,P?NORTH> <RTRUE>)
	      (<==? ,HERE ,GARAGE ,SIDE-YARD ;,OFFICE-PATH>
	       <PERFORM ,V?WALK ,P?WEST> <RTRUE>)
	      (T <TELL "It's not clear which direction you mean." CR>)>)>>

<ROOM DRIVEWAY-ENTRANCE
	(IN ROOMS)
	(DESC "driveway entrance")
	(FDESC
"You are standing at the foot of the driveway, the entrance to the
Linder property. The entire lot is screened from the street and the
neighbors by a wooden fence, except on the east
side, which fronts on dense bamboo woods. The house looks like a mixture of
a California bungalow and East Asian influences. From here you can
see the driveway leading north and, beyond that, the front door.")
	(LDESC
"This is the entrance to the driveway from the street, which lies to the
south. To the north is the driveway, and to the east is the side yard.")
	;(ADJECTIVE DRIVEWAY ;DRIVE ;CAR ;AUTO ;STREET)
	;(SYNONYM ENTRANCE ;GATE)
	(FLAGS RLANDBIT ONBIT)
	(NORTH TO DRIVEWAY)
	(WEST "A wooden fence blocks your way.")
	(EAST TO SIDE-YARD)
	(SOUTH
"You can't leave the property yet. It would mean your job.")
	(GLOBAL HOUSE WOODS FRONT-DOOR FENCE DRIVEWAY-OBJECT SIDE-FOOTPRINTS)
	(LINE 4)
	(STATION DRIVEWAY-ENTRANCE)
	(CORRIDOR 6)>

<ROOM LIMBO
	(IN ROOMS)
	(DESC "limbo")
	(FLAGS RLANDBIT ONBIT)
	(CONTFCN NULL-F)
	(NORTH TO DRIVEWAY-ENTRANCE)
	(LINE 4)
	(STATION DRIVEWAY-ENTRANCE)>
[
<ROOM SIDE-YARD
	(IN ROOMS)
	(ACTION SIDE-YARD-F)
	(DESC "side yard")
	;(ADJECTIVE SIDE ;LITTLE)
	;(SYNONYM YARD)
	(FLAGS RLANDBIT ONBIT)
	(NORTH "You can't enter the house from here.")
	(WEST TO DRIVEWAY-ENTRANCE)
	(EAST TO OFFICE-PATH)
	(SOUTH "A wooden fence blocks your way.")
	(GLOBAL HOUSE FENCE DRIVEWAY-OBJECT SIDE-FOOTPRINTS)
	(LINE 4)
	(STATION SIDE-YARD)
	(CORRIDOR 2)>

<ROUTINE SIDE-YARD-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
		<TELL 
"This is a little-used side yard, hidden from the street by the fence.
The back yard lies to the east and the driveway to the west." CR>)
	       (<==? .RARG ,M-FLASH>
		<COND (<AND <NOT <FSET? ,SIDE-FOOTPRINTS ,INVISIBLE>>
			    <NOT <FSET? ,SIDE-FOOTPRINTS ,TOUCHBIT>>>
		       <DESCRIBE-OBJECT ,SIDE-FOOTPRINTS T 0>
		       <FSET ,SIDE-FOOTPRINTS ,TOUCHBIT>)>)
	       (<AND <==? .RARG ,M-BEG>
		     <==? ,HERE ,SIDE-YARD>
		     ,GROUND-MUDDY
		     <VERB? WALK FOLLOW>>
		<SETG SIDE-FOOTPRINTS-CONFUSED T>
		<RFALSE>)>>

<OBJECT SIDE-FOOTPRINTS
	(IN LOCAL-GLOBALS ;SIDE-YARD)
	(DESC "set of footprints")
	(ADJECTIVE FOOT)
	(SYNONYM FOOTPRINTS PRINTS SET)
	(FLAGS INVISIBLE)
	(GENERIC GENERIC-FOOTPRINTS-F)
	(DESCFCN SIDE-FOOTPRINTS-F)
	(ACTION SIDE-FOOTPRINTS-F)>

<GLOBAL SIDE-FOOTPRINTS-CONFUSED <>>
<ROUTINE SIDE-FOOTPRINTS-F ("OPTIONAL" (ARG <>))
 <COND (<==? .ARG ,M-OBJDESC>
	<COND (,SIDE-FOOTPRINTS-CONFUSED
	       <COND (<FSET? ,SIDE-FOOTPRINTS ,TOUCHBIT>
		      <TELL
"Fresh foot prints go here and there in the yard." CR>)
		     (T
		      <FSET ,SIDE-FOOTPRINTS ,TOUCHBIT>
		      <TELL
"You notice fresh foot prints going here and there in the yard."
CR>)>)
	      (T
	       <COND (<FSET? ,SIDE-FOOTPRINTS ,TOUCHBIT>
		      <TELL
"A fresh row of foot prints goes from the back yard to the driveway." CR>)
		     (T
		      <FSET ,SIDE-FOOTPRINTS ,TOUCHBIT>
		      <TELL
"You notice a fresh row of foot prints going from the back yard to the
driveway." CR>)>)>)
       (<AND ,SIDE-FOOTPRINTS-CONFUSED <VERB? ANALYZE EXAMINE>>
	<TELL "There are too many foot prints here now." CR>)
       (<VERB? EXAMINE>
	<TELL
"The prints are lined up in an even row, as if made by a careful walker." CR>)
       (<VERB? ANALYZE>
	<COND (<NOT <EQUAL? <LOC ,SIDE-FOOTPRINTS-CAST> ,LIMBO>>
	       <TELL "You already did that!" CR>)
	      (<OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER>
	       <DO-FINGERPRINT>
	       <RTRUE>)
	      (T <MOVE ,SIDE-FOOTPRINTS-CAST ,PLAYER>
	       <ANAFOOT>)>)
       (<VERB? FOLLOW>
	<COND (<EQUAL? ,HERE ,DRIVEWAY-ENTRANCE>
	       <GOTO ,SIDE-YARD>)
	      (<EQUAL? ,HERE ,SIDE-YARD ,OFFICE-PATH>
	       <GOTO ,DRIVEWAY-ENTRANCE>)>
	<RTRUE>)
       (<AND <VERB? MAKE>
	     <DOBJ? GENERIC-CAST SIDE-FOOTPRINTS-CAST BACK-FOOTPRINTS-CAST>>
	<PERFORM ,V?ANALYZE ,SIDE-FOOTPRINTS>
	<RTRUE>)>>

<OBJECT SIDE-FOOTPRINTS-CAST
	(DESC "side-yard cast")
	(IN LIMBO)
	(ADJECTIVE SIDE-YARD SIDE)
	(SYNONYM CAST)
	(SIZE 9)
	(FLAGS TAKEBIT)
	(GENERIC GENERIC-CAST-F)
	(ACTION SIDE-FOOTPRINTS-CAST-F)>

<ROUTINE SIDE-FOOTPRINTS-CAST-F ()
 <COND (<AND <VERB? COMPARE>
	     <OR <DOBJ? BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>
		 <IOBJ? BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>>>
	<TELL "The two sets of foot prints don't seem to match up." CR>)>>

<ROUTINE ANAFOOT ()
	<TELL
"Sgt. Duffy appears with his kit for casting with plaster of Paris.
He quickly makes a cast of the foot prints and hands it to you,
saying \"I hope you find this as useful as it is heavy.\"" CR>>
][
<ROOM OFFICE-PATH
	(IN ROOMS)
	(DESC "office path")
	(LDESC
"You are on a path made of stepping stones, which leads from the back
gate at the south to Linder's office at the north. In the east you
can see a thick woods. To the west is the side yard.")
	;(ADJECTIVE OFFICE STONE)
	;(SYNONYM PATH)
	(FLAGS RLANDBIT ONBIT ON-NOT-IN AN)
	(NORTH TO OFFICE-PORCH)
	(EAST "You would probably get lost in the woods.")
	(WEST TO SIDE-YARD)
	(SOUTH
"You can't leave the property yet. It would mean your job.")
	(GLOBAL HOUSE WOODS ;DRIVEWAY-OBJECT SIDE-FOOTPRINTS)
	(LINE 4)
	(STATION OFFICE-PATH)
	(CORRIDOR 3)>

<OBJECT WOODS
	(IN LOCAL-GLOBALS)
	(DESC "bamboo woods")
	(ADJECTIVE DENSE THICK DARK BAMBOO)
	(SYNONYM WOODS FOREST THICKET)
	(TEXT
"Bamboo, thick and tall, screens the entire lot on the east side.")
	;(ACTION LAKE-F)>

<OBJECT BACK-GATE
	(IN OFFICE-PATH)
	(ADJECTIVE BACK OFFICE)
	(SYNONYM GATE)
	(DESC "back gate")
	(FLAGS DOORBIT NDESCBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>
][
<ROOM OFFICE-PORCH
	(IN ROOMS)
	(DESC "office porch")
	(ACTION OFFICE-PORCH-F)
	;(ADJECTIVE OFFICE BACK)
	;(SYNONYM PORCH)
	(FLAGS RLANDBIT ONBIT ON-NOT-IN AN)
	(NORTH TO BACK-YARD)
	(SOUTH TO OFFICE-PATH)
	(EAST "You would probably get lost in the woods.")
	(WEST TO OFFICE IF OFFICE-BACK-DOOR IS OPEN)
	(IN TO OFFICE IF OFFICE-BACK-DOOR IS OPEN)
	(GLOBAL HOUSE OFFICE-BACK-DOOR OFFICE-WINDOW LAWN WOODS
		;PIECE-OF-WIRE ;PIECE-OF-PUTTY BROKEN-GLASS BACK-FOOTPRINTS)
	(LINE 4)
	(STATION OFFICE-PORCH)
	(CORRIDOR 1)>

<ROUTINE OFFICE-PORCH-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"You are standing on a small concrete slab outside Linder's office. A sign
between the door and the window reads \"PACIFIC TRADE ASSOCIATES\". To the
north is a tidy lawn, extending east to the edge of the woods. A path of
stepping stones leads south to the back gate." CR>)
	       (<==? .RARG ,M-FLASH>
		<COND (<AND <NOT <FSET? ,BACK-FOOTPRINTS ,INVISIBLE>>
			    <NOT <FSET? ,BACK-FOOTPRINTS ,TOUCHBIT>>>
		       <DESCRIBE-OBJECT ,BACK-FOOTPRINTS T 0>
		       <FSET ,BACK-FOOTPRINTS ,TOUCHBIT>)>)>>

<OBJECT BACK-FOOTPRINTS
	(IN LOCAL-GLOBALS ;OFFICE-PORCH)
	(DESC "set of footprints")
	(ADJECTIVE FOOT)
	(SYNONYM FOOTPRINTS PRINTS SET)
	(FLAGS INVISIBLE)
	(FDESC "You notice some fresh foot prints heading east.")
	(LDESC "Fresh foot prints head east.")
	(GENERIC GENERIC-FOOTPRINTS-F)
	(ACTION BACK-FOOTPRINTS-F)>

"<GLOBAL BACK-FOOTPRINTS-CONFUSED <>>"

<ROUTINE BACK-FOOTPRINTS-F ()
 <COND ;(<AND ,BACK-FOOTPRINTS-CONFUSED <VERB? ANALYZE EXAMINE>>
	<TELL "There are too many foot prints here now." CR>)
       (<VERB? EXAMINE>
	<TELL
"The prints are uneven and widely spaced, as if made by someone running." CR>)
       (<VERB? ANALYZE>
	<COND (<NOT <EQUAL? <LOC ,BACK-FOOTPRINTS-CAST> ,LIMBO>>
	       <TELL "You already did that!" CR>)
	      (<OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER>
	       <DO-FINGERPRINT>
	       <RTRUE>)
	      (T <MOVE ,BACK-FOOTPRINTS-CAST ,PLAYER>
	       <ANAFOOT>)>)
       (<VERB? FOLLOW>
	<TELL "You would probably get lost in the woods."
		" Even with a path to follow." CR>)
       (<AND <VERB? MAKE>
	     <DOBJ? GENERIC-CAST SIDE-FOOTPRINTS-CAST BACK-FOOTPRINTS-CAST>>
	<PERFORM ,V?ANALYZE ,BACK-FOOTPRINTS>
	<RTRUE>)>>

<ROUTINE GENERIC-FOOTPRINTS-F (OBJ)
	<COND (<EQUAL? ,HERE ,OFFICE-PORCH>	,BACK-FOOTPRINTS)
	      (<EQUAL? ,HERE ,SIDE-YARD>	,SIDE-FOOTPRINTS)
	      (T
	       <SETG P-WON <>>
	       <TELL "(You can't see any " "foot prints" " here!)" CR>
	       ,NOT-HERE-OBJECT)>>

<OBJECT BACK-FOOTPRINTS-CAST
	(DESC "back-yard cast")
	(IN LIMBO)
	(ADJECTIVE BACK-YARD BACK)
	(SYNONYM CAST)
	(SIZE 9)
	(FLAGS TAKEBIT)
	(GENERIC GENERIC-CAST-F)
	;(ACTION SIDE-FOOTPRINTS-F)>

<ROUTINE GENERIC-CAST-F (OBJ)
 <COND (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-CAST)
       (<VERB? MAKE> ,GENERIC-CAST)>>

<OBJECT GENERIC-CAST
	(IN GLOBAL-OBJECTS)
	(DESC "cast")
	(SYNONYM $GNRC)>
]
<OBJECT OFFICE-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "office window")
	(ADJECTIVE OFFICE)
	(SYNONYM WINDOW PANE PANES FRAME)
	(FLAGS WINDOWBIT AN)
	(GENERIC GENERIC-WINDOW-F)
	(ACTION OFFICE-WINDOW-F)>

<ROUTINE OFFICE-WINDOW-F ("AUX" (RM <WINDOW-ROOM ,HERE ,PRSO>))
 <COND ;(<VERB? ASK-ABOUT> <RFALSE>)
       (<VERB? EXAMINE>
	<WINDOW-F>
	<COND (<FSET? ,OFFICE-WINDOW ,RMUNGBIT>
	       <TELL
"All the panes of the window are cracked, and many are in pieces on the ">
	       <COND ;(<0? ,DIFFICULTY> <TELL "ground outside">)
		     ;(<1? ,DIFFICULTY> <TELL "floor and ground">)
		     (T <TELL "floor.">)>
	       <COND (<==? ,HERE ,OFFICE>
		      <COND (<NOT <FSET? ,PIECE-OF-PUTTY ,TOUCHBIT>>
			     <TELL
" A chunk of putty dangles like a wax bean.">)>
		      <COND (<NOT <FSET? ,PIECE-OF-WIRE ,TOUCHBIT>>
			     <TELL
" Along one edge of the window you can see the end of a piece of green wire."
;"?etc.">)>)>
	       <CRLF>)
	      (<AND ;<==? ,P-ADVERB ,W?CAREFULLY>
		    <==? ,HERE ,OFFICE>
		    <NOT <FSET? ,PIECE-OF-WIRE ,TOUCHBIT>>>
	       <TELL
"There's also a piece of green wire running from the frame to the putty."
CR>)>
	<RTRUE>)
       (<GO-AWAY> <RTRUE>)
       (<AND <VERB? LOOK-INSIDE LOOK-OUTSIDE>
	     .RM <FSET? ,OFFICE-WINDOW ,RMUNGBIT>>
	<TELL "Through the broken window you can see">
	<THE? .RM>
	<TELL " " D .RM " "
		<COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C> "in")
		      (T "out")>
		"side." CR>
	<RTRUE>)
       (<AND <VERB? THROUGH> .RM <FSET? ,OFFICE-WINDOW ,RMUNGBIT>>
	<TELL "You would probably cut yourself on the broken glass." CR>)
       (<DOBJ? OFFICE-WINDOW> <PERFORM ,PRSA ,WINDOW ,PRSI> <RTRUE>)
       (<IOBJ? OFFICE-WINDOW> <PERFORM ,PRSA ,PRSO ,WINDOW> <RTRUE>)>>

<ROUTINE GO-AWAY ()
 <COND (<AND <VERB? KNOCK>
	     <==? <META-LOC ,LINDER> ,OFFICE>
	     <NOT <IN? ,PLAYER ,OFFICE>>>
	<TELL
"Someone peeks through the window at you, then disappears and"
" shouts \"Go away!\"" CR>)>>

<OBJECT PIECE-OF-WIRE
	(IN OFFICE)
	(DESC "green wire piece")
	(ADJECTIVE GREEN WIRE)
	(SYNONYM WIRE PIECE)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(GENERIC GENERIC-WIRE-F)
	(SIZE 1)
	(ACTION PIECE-OF-WIRE-F)>

<ROUTINE PIECE-OF-WIRE-F ()
 <COND (<AND <VERB? FOLLOW> <NOT <FSET? ,PRSO ,TOUCHBIT>>>
	<TELL "The wire goes into the window frame and disappears." CR>)
       (<AND <VERB? TAKE> <NOT ,SHOT-FIRED>>
	<TELL "You can't." " It's stuck tight." CR>)>>

<OBJECT PIECE-OF-PUTTY
	(IN OFFICE)
	(DESC "chunk of putty")
	(SYNONYM CHUNK PUTTY)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(SIZE 1)
	(ACTION PIECE-OF-PUTTY-F)>

<ROUTINE PIECE-OF-PUTTY-F ()
 <COND (<AND <VERB? TAKE> <NOT ,SHOT-FIRED>>
	<TELL "You can't." " It's stuck tight." CR>)>>

<OBJECT OFFICE-BACK-DOOR
	(IN LOCAL-GLOBALS)
	(ADJECTIVE BACK OUTSIDE)
	(SYNONYM DOOR LOCK)
	(DESC "back door")
	(FLAGS LOCKED DOORBIT)
	(GENERIC GENERIC-BACK-DOOR-F ;LOCKED-F)
	(ACTION OFFICE-BACK-DOOR-F)>

<ROUTINE OFFICE-BACK-DOOR-F ()
 <COND (<GO-AWAY> <RTRUE>)
       (<AND <VERB? GIVE SGIVE>		;"GIVE NOTE BACK"
	     <OR <DOBJ? THREAT-NOTE> <IOBJ? THREAT-NOTE>>>
	<COND (<LOC ,LINDER>
	       <PERFORM ,V?GIVE ,THREAT-NOTE ,LINDER>
	       <RTRUE>)
	      (T <TELL "It's too late to give Linder anything." CR>)>)>>

<ROOM BACK-YARD
	(IN ROOMS)
	(DESC "back yard")
	;(ADJECTIVE BACK)
	;(SYNONYM YARD)
	(LDESC
"You are on a neatly manicured lawn, east of Monica's bedroom. The lawn
extends east to the edge of the woods. From here you can go to a rock
garden in the north or the entrance to Linder's office in the south.
There's a door into the house, and a window.")
	(FLAGS RLANDBIT ONBIT)
	(NORTH TO ROCK-GARDEN)
	(SOUTH TO OFFICE-PORCH)
	(EAST "You would probably get lost in the woods.")
	(WEST TO MONICA-ROOM IF MONICA-BACK-DOOR IS OPEN)
	(GLOBAL HOUSE MONICA-BACK-DOOR WINDOW LAWN WOODS)
	(LINE 4)
	(STATION BACK-YARD)
	(CORRIDOR 1)>

<OBJECT LAWN
	(IN LOCAL-GLOBALS)
	(DESC "lawn")
	(SYNONYM LAWN GRASS)
	(ADJECTIVE GREEN)
	(ACTION LAWN-F)>

<ROUTINE LAWN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The lawn is well manicured." CR>)>>

<OBJECT MONICA-BACK-DOOR
	(IN LOCAL-GLOBALS)
	(ADJECTIVE BACK OUTSIDE)
	(SYNONYM DOOR LOCK)
	(DESC "back door")
	(FLAGS LOCKED DOORBIT)
	(GENERIC GENERIC-BACK-DOOR-F ;LOCKED-F)
	;(ACTION BACK-DOOR-F)>

<ROOM ROCK-GARDEN
	(IN ROOMS)
	(DESC "rock garden")
	;(ADJECTIVE ROCK JAPANESE BACK)
	;(SYNONYM GARDEN)
	(LDESC
"This is a rock garden in the Japanese style, east of Linder's bedroom.
A few smooth round boulders lie partly buried in a bed of gravel,
which is carefully raked to be reminiscent of flowing water.
A sequence of smaller rocks forms a zig-zag path from the bedroom door to
the south edge of the garden, where the lawn begins.
There's a door into the house, and a couple of windows.")
	(FLAGS RLANDBIT ONBIT)
	(NORTH "A wooden fence blocks your way.")
	(EAST "You would probably get lost in the woods.")
	(SOUTH TO BACK-YARD)
	(WEST TO LINDER-ROOM IF LINDER-BACK-DOOR IS OPEN)
	(GLOBAL HOUSE LINDER-BACK-DOOR LINDER-WINDOW BATH-WINDOW
		LAWN WOODS FENCE)
	(LINE 4)
	(STATION ROCK-GARDEN)
	(CORRIDOR 1)>

<OBJECT ROCKS
	(IN ROCK-GARDEN ;LOCAL-GLOBALS)
	(DESC "rocks")
	(ADJECTIVE SMOOTH ROUND)
	(SYNONYM ROCKS ROCK BOULDER)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT)
	(CAPACITY 150)
	;(ACTION ROSE-F)>

;"<OBJECT GLOBAL-ROCKS
	(IN GLOBAL-OBJECTS)
	(DESC 'rocks')
	(ADJECTIVE ROCK)
	(SYNONYM ROCKS GARDEN ROCK)>"

"? <OBJECT BENCH ...>"

<OBJECT LINDER-BACK-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR LOCK)
	(ADJECTIVE BACK OUTSIDE)
	(DESC "back door")
	(FLAGS LOCKED DOORBIT)
	(GENERIC GENERIC-BACK-DOOR-F ;LOCKED-F)
	;(ACTION BACK-DOOR-F)>

"Inside the house"
)>[
<ROOM MONICA-ROOM
	(IN ROOMS)
	(DESC "Monica's bedroom")
	;(ADJECTIVE MONICA BED HER)
	;(SYNONYM BEDROOM ROOM)
	(GENERIC GENERIC-BEDROOM-F)
	(ACTION MONICA-ROOM-F)
	(FLAGS RLANDBIT ONBIT)
	(EAST TO BACK-YARD IF MONICA-BACK-DOOR IS OPEN)
	(OUT  TO BACK-YARD IF MONICA-BACK-DOOR IS OPEN)
	(WEST TO HALL-2 IF MONICA-DOOR IS OPEN)
	(NORTH TO BATHROOM IF MONICA-BATH-DOOR IS OPEN)
	(GLOBAL MONICA-DOOR MONICA-BACK-DOOR MONICA-BATH-DOOR WINDOW
		BED MIRROR TELEPHONE CLOSET)
	(PSEUDO "CHAIR" RANDOM-PSEUDO)
	(LINE 3)
	(STATION MONICA-ROOM)>

<ROUTINE MONICA-ROOM-F ("OPTIONAL" (RARG <>))
	<COND (<==? .RARG ,M-ENTER> <I-PROMPT-2>)
	      (<==? .RARG ,M-LOOK>
	       <TELL
"On one side is a modern-style bed, with piles of well-thumbed detective
stories stacked on the table beside it. Opposite the bed is a long
dressing table that seems to serve also as desk and workbench. In the
corner sits a small table for a portable phonograph and records, and a
book case with more books and pulps. Movie posters cover the walls. A
handsome door with cedar veneer leads north, and a door and window face
outside." CR>)>>

<OBJECT MONICA-TABLE
	(IN MONICA-ROOM)
	(ADJECTIVE DRESSING WORK)
	(SYNONYM TABLE DESK BENCH)
	(DESC "dressing table")
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT)
	(CAPACITY 50)
	(ACTION MONICA-TABLE-F)>

<ROUTINE MONICA-TABLE-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE LOOK-ON SEARCH>
	<COND (<AND <IN? ,MEDICAL-REPORT ,MONICA-ROOM>
		    <==? ,P-ADVERB ,W?CAREFULLY>>
	       <FCLEAR ,TUMOR ,INVISIBLE>
	       <FCLEAR ,MEDICAL-REPORT ,INVISIBLE>
	       <THIS-IS-IT ,MEDICAL-REPORT>
	       <TELL
"Among make-up, letters, and tools, you find a medical report." CR>)
	      (T <TELL
"This table is pretty messy. Anyone but Monica would have a tough time
finding anything on it." CR>)>)>>

<OBJECT MONICA-TABLE-STUFF
	(IN MONICA-TABLE)
	(SYNONYM MAKE-UP STUFF ;MAKEUP LETTER TOOLS)
	(DESC "stuff on the table")
	(FLAGS NDESCBIT TRYTAKEBIT READBIT)
	(ACTION CLOSET-STUFF-F)>

;<ROUTINE MONICA-TABLE-STUFF-F ()
 <COND (<VERB? TAKE>
	<TELL "You have no use for them." CR>)>>

<OBJECT MOVIE-POSTERS
	(IN MONICA-ROOM)
	(DESC "bunch of movie posters")
	(ADJECTIVE MOVIE)
	(SYNONYM POSTER)
	(TEXT "These are posters for many of Clark Gable's movies.")
	(FLAGS NDESCBIT)> 

<OBJECT BOOK-CASE
	(IN MONICA-ROOM)
	(ADJECTIVE BOOK)
	(SYNONYM BOOKCASE CASE BOOK BOOKS)
	(DESC "book case")
	(FLAGS NDESCBIT READBIT)
	(TEXT "Good idea! But one important book isn't in the book case.")>

<GLOBAL TUNE-ON <>>

<ROUTINE CAN-HEAR-RECORD? ()
 <COND (<AND ,TUNE-ON
	     <OR <AND <DOBJ? MONICA-DOOR> <==? ,HERE ,HALL-2>>
		 <AND <DOBJ? MONICA-BATH-DOOR> <==? ,HERE ,BATHROOM>>
		 <AND <DOBJ? MONICA-BACK-DOOR> <==? ,HERE ,BACK-YARD>>>>
	<RTRUE>)>>

<OBJECT RECORDS
	(IN MONICA-ROOM)
	(DESC "record collection")
	(SYNONYM RECORD MUSIC)
	(FLAGS NDESCBIT)
	(ACTION RECORDS-F)>

<ROUTINE RECORDS-F ("AUX" TUNE)
	 <COND (<VERB? PLAY LISTEN>
		<TELL
"You pick a record at random and start it playing. It's \"">
		<REPEAT ()
			<SET TUNE <PICK-ONE ,SONG-TABLE>>
			<COND (<AND ,TUNE-ON <==? .TUNE ,TUNE-ON>> T)
			      (T <RETURN>)>>
		<SETG TUNE-ON .TUNE>
		<TELL ,TUNE-ON ".\"" CR>
		<ENABLE <QUEUE I-TUNE-OFF 4>>)
	       (<VERB? EXAMINE>
		<TELL
"It's a large and varied record collection. Monica's not very
choosy about her music." CR>)>>

<ROUTINE I-TUNE-OFF ("AUX" TBL)
	 <COND (<==? ,HERE ,MONICA-ROOM>
		<TELL
"The record is over, and not too soon." CR>
		<COND (<AND <IN? ,MONICA ,HERE> <NOT ,MONICA-TIED-TO>>
		       <TELL
"Monica walks over to the phonograph and puts the record away. Then she
chooses another one and starts it up. It's \"">
		       <SETG TUNE-ON <PICK-ONE ,SONG-TABLE>>
		       <TELL ,TUNE-ON ".\"" CR>
		       <ENABLE <QUEUE I-TUNE-OFF 4>>)>
		<RTRUE>)
	       (<AND <IN? ,MONICA ,MONICA-ROOM> <NOT ,MONICA-TIED-TO>>
		<SETG TUNE-ON <PICK-ONE ,SONG-TABLE>>
		<ENABLE <QUEUE I-TUNE-OFF 4>>
		<RFALSE>)>>

<GLOBAL SONG-TABLE
	<PLTABLE "Alexander's Ragtime Band"
		"I'm an Old Cowhand"
		"Mexicali Rose"
		"Pennies from Heaven"
		"Sweet Leilani"
		"When I Grow Too Old to Dream">>
]
<OBJECT MONICA-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE BEDROOM)
	(DESC "bedroom door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT OPENBIT)
	(GENERIC GENERIC-BEDROOM-DOOR-F)
	;(ACTION HIDE-LOOK-DOOR-F)>

<OBJECT MONICA-BATH-DOOR
	(ADJECTIVE CEDAR BATH BATHROOM)
	(SYNONYM DOOR)
	(DESC "cedar door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT OPENBIT)
	(GENERIC GENERIC-BATH-DOOR-F)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM BATHROOM
	(IN ROOMS)
	(DESC "bathroom")
	;(ADJECTIVE BATH MASTER)
	;(SYNONYM ROOM BATHROOM)
	(GENERIC GENERIC-BATHROOM-F)
	(LDESC
"This room has only a large cabinet with counter, sink and mirror.
On the counter are a shaver, toothpaste, and so on.
The tub and toilet must be in separate rooms.
There are doors on all four walls: the one to the north looks like redwood,
the one to the south like cedar, and the other two like ordinary doors.")
	;(DESCFCN BATHROOM-F)
	(FLAGS RLANDBIT ONBIT)
	;(ACTION BATHROOM-F)
	(WEST TO TOILET-ROOM IF TOILET-DOOR IS OPEN)
	(EAST TO TUB-ROOM IF TUB-DOOR IS OPEN)
	(SOUTH TO MONICA-ROOM IF MONICA-BATH-DOOR IS OPEN)
	(NORTH TO LINDER-ROOM IF LINDER-BATH-DOOR IS OPEN)
	;(OUT PER RETRACE-F)
	(GLOBAL MONICA-BATH-DOOR LINDER-BATH-DOOR TOILET-DOOR TUB-DOOR
		CABINET MIRROR SINK)
	(PSEUDO "SHAVER" RANDOM-PSEUDO "TOOTHPASTE" RANDOM-PSEUDO)
	(LINE 3)
	(STATION BATHROOM)>

;<OBJECT SHAVER
	(IN MASTER-BATH-COUNTER)
	(DESC "Schick Shaver")
	(ADJECTIVE SCHICK DRY)
	(SYNONYM SHAVER)
	(FLAGS NDESCBIT)>

<OBJECT MASTER-BATH-COUNTER
	(IN BATHROOM)
	(DESC "counter")
	(ADJECTIVE LONG BATH BATHROOM)
	(SYNONYM COUNTER PULLMAN)
	(FLAGS NDESCBIT FURNITURE SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 50)
	(ACTION MASTER-BATH-COUNTER-F)>

<ROUTINE MASTER-BATH-COUNTER-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
	<TELL "On the counter are a shaver, tooth paste, and so on." CR>)>>

	<OBJECT TUB-DOOR
		(SYNONYM DOOR)
		(ADJECTIVE TUB BATHTUB BATH)
		(DESC "tub door")
		(IN LOCAL-GLOBALS)
		(FLAGS DOORBIT)
		;(ACTION HIDE-LOOK-DOOR-F)>
][
<ROOM TUB-ROOM
	(IN ROOMS)
	(DESC "tub room")
	;(ADJECTIVE TUB)
	;(SYNONYM ROOM)
	(LDESC
"This is a separate room, completely lined with tile, for bathing in the
Japanese style. On one side is a shower head and drain, where you could
wash away surface dirt. On the other side is a deep tub, to be filled
with steaming water up to your neck. Potted plants give the room a
tropical air. A window looks over the rock garden outside, and a door
leads west.")
	(FLAGS RLANDBIT ONBIT)
	(WEST TO BATHROOM IF TUB-DOOR IS OPEN)
	(OUT  TO BATHROOM IF TUB-DOOR IS OPEN)
	(GLOBAL TUB-DOOR BATH-WINDOW ;SHOWER BATHTUB SINK)
	(LINE 3)
	(STATION BATHROOM)>

<OBJECT BATH-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "bath window")
	(ADJECTIVE BATH)
	(SYNONYM WINDOW PANE PANES FRAME)
	(GENERIC GENERIC-WINDOW-F)
	(ACTION WINDOW-F)
	(FLAGS NDESCBIT WINDOWBIT)>

<OBJECT POTTED-PLANTS
	(IN TUB-ROOM)
	(DESC "potted plants")
	(SYNONYM PLANT PLANTS)
	(ADJECTIVE POTTED)
	(FLAGS NDESCBIT)>

<OBJECT BATHTUB
	(IN LOCAL-GLOBALS)
	(DESC "bathtub")
	(SYNONYM TUB BATHTUB)
	(ADJECTIVE BATH)
	(FLAGS NDESCBIT VEHBIT OPENBIT CONTBIT FURNITURE)
	(CAPACITY 50)>

<OBJECT SHOWER
	(ADJECTIVE SHOWER)
	(SYNONYM SHOWER HEAD)
	(DESC "shower")
	(IN TUB-ROOM ;LOCAL-GLOBALS)
	(FLAGS ;CONTBIT NDESCBIT TRYTAKEBIT FURNITURE)
	(ACTION SHOWER-F)>

<ROUTINE SHOWER-F ()
 	<COND (<AND <==? 1 <GET ,P-PRSO 0>> ;"only one dir. object"
		    <VERB? TAKE THROUGH>>
		<TELL
"Anyone can see that you really need a shower. In fact, this is
one of your better ideas so far on this case. But your clothes would get
awful wet, and you must have better things to do." CR>)>>
]
<OBJECT TOILET-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE TOILET)
	(DESC "toilet door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT OPENBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>

<ROOM TOILET-ROOM
	(IN ROOMS)
	(DESC "toilet room")
	(ADJECTIVE TOILET)
	(SYNONYM ROOM)
	(FLAGS RLANDBIT ONBIT)
	(LDESC
"This is a separate room for a toilet only."
;" and appropriate reading matter.")
	(EAST TO BATHROOM IF TOILET-DOOR IS OPEN)
	(OUT  TO BATHROOM IF TOILET-DOOR IS OPEN)
	(GLOBAL TOILET-DOOR TOILET)
	(LINE 3)
	(STATION BATHROOM)>

<OBJECT LINDER-BATH-DOOR
	(ADJECTIVE REDWOOD BATH BATHROOM)
	(SYNONYM DOOR)
	(DESC "redwood door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT)
	(GENERIC GENERIC-BATH-DOOR-F)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM LINDER-ROOM
	(IN ROOMS)
	(DESC "Linder's bedroom")
	(ADJECTIVE MASTER LINDER BED HIS)
	(SYNONYM BEDROOM ROOM)
	(GENERIC GENERIC-BEDROOM-F)
	(FLAGS RLANDBIT ONBIT)
	;(DESCFCN LINDER-ROOM-F)
	(ACTION LINDER-ROOM-F)
	(WEST TO LIVING-ROOM IF LINDER-DOOR IS OPEN)
	(EAST TO ROCK-GARDEN IF LINDER-BACK-DOOR IS OPEN)
	(OUT  TO ROCK-GARDEN IF LINDER-BACK-DOOR IS OPEN)
	(SOUTH TO BATHROOM IF LINDER-BATH-DOOR IS OPEN)
	(GLOBAL LINDER-DOOR LINDER-BACK-DOOR LINDER-BATH-DOOR
		CLOSET MIRROR LINDER-WINDOW BED CHAIR ;TELEPHONE ;TABLE)
	(LINE 1)
	(STATION LINDER-ROOM)>

<ROUTINE LINDER-ROOM-F ("OPTIONAL" (ARG <>))
	<COND (<==? .ARG ,M-ENTER>
	       <I-PROMPT-2>)
	      (<==? .ARG ,M-LOOK> ;<VERB? LOOK>
	       <TELL
"The bedroom is elegant but not tidy. A four-poster bed, chair and
dresser, made of teak and mahogany, look hand-crafted. There are doors
on the west and south walls, and a door and window to the east look
outside. Clothes and newspapers are scattered about. It seems that
Linder misse"
<COND (<FSET? ,CORPSE ,INVISIBLE> "s") (T "d")>
" the woman's touch." CR>)>>

<OBJECT LINDER-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "Linder's window")
	(ADJECTIVE LINDER HIS)
	(SYNONYM WINDOW PANE PANES FRAME)
	(GENERIC GENERIC-WINDOW-F)
	(ACTION WINDOW-F)
	(FLAGS NDESCBIT WINDOWBIT)>

<OBJECT LINDER-ROOM-STUFF
	(IN LINDER-ROOM)
	(SYNONYM CLOTHES NEWSPAPERS PAPERS STUFF)
	(DESC "stuff in the room")
	(FLAGS NDESCBIT TRYTAKEBIT READBIT)
	(ACTION CLOSET-STUFF-F)>

<OBJECT FOUR-POSTER
	(IN LINDER-ROOM)
	(DESC "four-poster bed")
	(ADJECTIVE FOUR FOUR-POSTER)
	(SYNONYM BED POSTER FOUR-POSTER)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT FURNITURE VEHBIT)
	(CAPACITY 30)
	;(ACTION BED-F)>

<OBJECT MASTER-BEDROOM-DRESSER
	(IN LINDER-ROOM)
	(DESC "dresser")
	(SYNONYM DRESSER)
	(FLAGS NDESCBIT CONTBIT OPENBIT FURNITURE)
	(CAPACITY 30)
	(ACTION MASTER-BEDROOM-DRESSER-F)>

<ROUTINE MASTER-BEDROOM-DRESSER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The dresser is a beautiful piece of cabinetry." CR>)
	       (<VERB? LOOK-INSIDE SEARCH OPEN>
		<TELL
"You open all the drawers and find only shirts, socks, underwear, hankies,
and so on. What a disappointment." CR>)>>
]
<OBJECT LINDER-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE BEDROOM)
	(DESC "bedroom door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT)
	(GENERIC GENERIC-BEDROOM-DOOR-F)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM LIVING-ROOM
	(IN ROOMS)
	(DESC "living room")
	(ADJECTIVE LIVING)
	(SYNONYM ROOM PARLOR PARLOUR)
	(FLAGS RLANDBIT ONBIT)
	(ACTION LIVING-ROOM-F)
	(EAST TO LINDER-ROOM IF LINDER-DOOR IS OPEN)
	(SOUTH TO HALL-1)
	(WEST TO DINING-ROOM IF LIVING-DINING-DOOR IS OPEN)
	(GLOBAL LINDER-DOOR LIVING-DINING-DOOR TELEPHONE LAMP ;WINDOW)
	(LINE 1)
	(STATION LIVING-ROOM)
	;(CORRIDOR 32)>

<ROUTINE LIVING-ROOM-F ("OPTIONAL" (RARG <>))
	 <COND ;(<AND ,RADIO-ON <==? .RARG ,M-ENTER>>
		<TELL "The radio is playing." CR>)
	       (<==? .RARG ,M-LOOK>
		;<SETG WELCOMED T>
		<TELL
"A huge fieldstone fireplace on the south wall holds a blazing fire,
filling the living room with warmth and light. Grouped in front of the
fire are a glass-topped coffee table and a rattan davenport and club
chair, with cushions covered in a print showing bamboo plants in the
style of Japanese brush-painting. A lamp with a printed shade and a
telephone sit on the table." CR>
		;<COND (<IN? ,MONICA ,SOFA>
		       <TELL
"Monica is sitting on the davenport, one arm stretched along its back
and the other holding a cigarette in the air. " CR>)
		      (<IN? ,MONICA ,LIVING-ROOM>
		       <TELL
"Monica is leaning against the mantle, looking at the fire. " CR>)>
		<TELL
"On the north wall are a liquor cabinet and a console radio made of
light-colored wood. ">
		<COND (,RADIO-ON <TELL "The radio is playing. ">)>
		<DDESC
"A single door in the east wall is " ,LINDER-DOOR ",
and at the west end of the room is a double door.">)>>

<OBJECT FIREPLACE
	(IN LIVING-ROOM)
	(DESC "fieldstone fireplace")
	(ADJECTIVE FIELDS STONE ;FIRE)
	(SYNONYM FIREPLACE ;PLACE)
	(FLAGS NDESCBIT)>

<OBJECT FIRE
	(IN LIVING-ROOM)
	(DESC "fire")
	(SYNONYM FIRE)
	(FLAGS NDESCBIT)>

<OBJECT WOOD-PILE
	(IN LIVING-ROOM)
	(DESC "wood pile")
	(ADJECTIVE WOOD)
	(SYNONYM PILE)
	(FLAGS NDESCBIT)>

<OBJECT SOFA
	(IN LIVING-ROOM)
	(DESC "davenport")
	(SYNONYM COUCH SOFA DAVENPORT DIVAN)
	(CAPACITY 30)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT VEHBIT FURNITURE)>

<OBJECT CLUB-CHAIR
	(IN LIVING-ROOM)
	(DESC "club chair")
	(ADJECTIVE CLUB)
	(SYNONYM CHAIR)
	(CAPACITY 20)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT VEHBIT FURNITURE)>

<OBJECT COFFEE-TABLE
	(IN LIVING-ROOM)
	(DESC "coffee table")
	(ADJECTIVE COFFEE)
	(SYNONYM TABLE)
	(FLAGS NDESCBIT FURNITURE CONTBIT SURFACEBIT OPENBIT)
	(CAPACITY 50)>

<OBJECT RADIO
	(IN LIVING-ROOM)
	(DESC "radio")
	;(DESCFCN RADIO-F)
	(ADJECTIVE CONSOLE)
	(SYNONYM RADIO VOLUME MUSIC PROGRAM ;CONSOLE)
	(TEXT
"It's a Stromberg-Carlson triple-range console. The exit in the bottom
is evidence of the Acoustical Labyrinth inside.")
	(FLAGS NDESCBIT)
	(ACTION RADIO-F)>

<GLOBAL RADIO-ON T>

<ROUTINE CAN-HEAR-RADIO? ()
 <COND (<AND ,RADIO-ON
	     <OR <AND <DOBJ? DINING-DOOR>	<==? ,HERE ,FRONT-YARD>>
		 <AND <DOBJ? FRONT-DOOR>	<==? ,HERE ,FRONT-PORCH>>
		 <AND <DOBJ? LIVING-DINING-DOOR> <==? ,HERE ,DINING-ROOM>>
		 <AND <DOBJ? KITCHEN-DINING-DOOR KITCHEN-HALL-DOOR>
						<==? ,HERE ,KITCHEN>>
		 <AND <DOBJ? LINDER-DOOR>	<==? ,HERE ,LINDER-ROOM>>>>
	<RTRUE>)>>

<GLOBAL RADIO-TABLE
	<PLTABLE "an Amos 'n' Andy serial"	;8
		"a Lum & Abner serial"
		"the Paul Whiteman orchestra"
		"the Paul Whiteman orchestra"
		"Nick Harris's \"Camera Clue Murder\""	;9
		"the March of Progress"
		"Kay Kyser's orchestra"
		"Kay Kyser's orchestra"
		"the L.A. Times news program"	;10
		"Ozzie Nelson's orchestra"
		"the Montoya Orchestra"
		"Phil Harris's orchestra"
		"the Duchin orchestra"	;11
		"a balalaika orchestra"
		"Ozzie Nelson's orchestra"
		"Ozzie Nelson's orchestra"
		"\"Rhapsody in Wax\""	;12
		"\"Rhapsody in Wax\""
		"\"Rhapsody in Wax\""
		"\"Rhapsody in Wax\""
		"a revival meeting with Oral Roberts"	;1
		"a revival meeting with Oral Roberts"
		"a revival meeting with Oral Roberts"
		"a revival meeting with Oral Roberts"
		"the Philadelphia Orchestra, conducted by Leopold Stokowski"	;2
		"the Philadelphia Orchestra, conducted by Leopold Stokowski"
		"the Philadelphia Orchestra, conducted by Leopold Stokowski"
		"the Philadelphia Orchestra, conducted by Leopold Stokowski"
		"Lowell Thomas, Radio Commentator"	;3
		"Lowell Thomas, Radio Commentator"
		"a program of classical music"
		"a program of classical music"
		"a revival meeting with Aimee Semple McPherson"	;4
		"a revival meeting with Aimee Semple McPherson"
		"a revival meeting with Aimee Semple McPherson"
		"a revival meeting with Aimee Semple McPherson"
		"a program of classical music"	;5
		"a program of classical music"
		"a program of classical music"
		"a program of classical music"
		"Boake Carter, Philco News Commentator"	;6
		"Boake Carter, Philco News Commentator"
		"a program of classical music"
		"a program of classical music"
		"\"Rise and Shine\""	;7
		"\"Rise and Shine\""
		"\"Rise and Shine\""
		"\"Rise and Shine\""
		"\"Between You, Me, and the Fence Post\"">>

<ROUTINE RADIO-F ("OPTIONAL" (ARG <>) "AUX" PGM)
 <COND (<AND ,RADIO-ON <VERB? LISTEN>>
	<SET PGM <GET ,RADIO-TABLE <+ 1 </ <- ,PRESENT-TIME 480> 15>>>>
	<TELL "You can hardly avoid it. ">
	<COND (<==? .PGM ,RADIO-ON> <TELL "It's ">)
	      (T <TELL "You" " spin the dial and find ">)>
	<SETG RADIO-ON .PGM>
	<TELL ,RADIO-ON "." CR>)
       (<VERB? LAMP-ON PLAY LISTEN>
	<COND (,RADIO-ON <TELL "It's already on. You">)
	      (T <TELL "You turn on the radio,">)>
	<SETG RADIO-ON <GET ,RADIO-TABLE <+ 1 </ <- ,PRESENT-TIME 480> 15>>>>
	<TELL " spin the dial and find " ,RADIO-ON "." CR>)
       (<VERB? LAMP-OFF>
	<COND (<AND ,RADIO-ON <IN? ,MONICA ,HERE>>
	       <TELL
"Monica looks at you with disgust as you turn off the radio." CR>)
	      (T <TELL "The radio is now off." CR>)>
	<SETG RADIO-ON <>>
	<RTRUE>)
       (<VERB? TURN-UP>
	<COND (,RADIO-ON
	       <TELL
"The radio is already pretty loud. Any louder would probably
make the neighbors complain." CR>)
	      (T <TELL "It's not on!" CR>)>)
       (<VERB? TURN-DOWN>
	<COND (,RADIO-ON
	       <COND (<AND <IN? ,MONICA ,HERE> <NOT ,MONICA-TIED-TO>>
		      <TELL
"Monica stops you from turning down the volume. She seems strangely
interested in the radio program." CR>)
		     (T <TELL "You can't." CR>)>)
	      (T <TELL "It's not on!" CR>)>)>>

<OBJECT LIQUOR-CABINET
	(IN LIVING-ROOM)
	(DESC "liquor cabinet")
	(ADJECTIVE LIQUOR)
	(SYNONYM CABINET)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT)
	(CAPACITY 20)>
]
<OBJECT LIVING-DINING-DOOR
	(ADJECTIVE DOUBLE)
	(SYNONYM DOOR)
	(DESC "double door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT OPENBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM DINING-ROOM
	(IN ROOMS)
	(DESC "dining room")
	(LDESC
"A table and benches, built out of blond wood for six people, sit in the
middle of the room. On the south wall is a swinging door that leads to
the kitchen, and on the east wall a double door to the living room.
Through a French door on the west wall you can see the front yard.")
	(ADJECTIVE DINING)
	(SYNONYM ROOM)
	(FLAGS RLANDBIT ONBIT)
	(EAST TO LIVING-ROOM IF LIVING-DINING-DOOR IS OPEN)
	(SOUTH TO KITCHEN IF KITCHEN-DINING-DOOR IS OPEN)
	(WEST TO FRONT-YARD IF DINING-DOOR IS OPEN)
	(OUT  TO FRONT-YARD IF DINING-DOOR IS OPEN)
	(GLOBAL DINING-DOOR LIVING-DINING-DOOR KITCHEN-DINING-DOOR WINDOW
		;CABINET CHAIR)
	(LINE 1)
	(STATION LIVING-ROOM)
	;(CORRIDOR 32)>

<OBJECT DINING-ROOM-TABLE
	(IN DINING-ROOM)
	(DESC "dining table")
	(ADJECTIVE LONG DINING)
	(SYNONYM TABLE)
	(FLAGS NDESCBIT FURNITURE CONTBIT SURFACEBIT OPENBIT VEHBIT)
	(CAPACITY 50)>

<OBJECT DINING-ROOM-BENCH
	(IN DINING-ROOM)
	(DESC "dining bench")
	(ADJECTIVE DINING)
	(SYNONYM BENCH BENCHES)
	(FLAGS NDESCBIT FURNITURE CONTBIT SURFACEBIT OPENBIT VEHBIT)
	(CAPACITY 50)>

<OBJECT DINING-DOOR
	(ADJECTIVE DINING ROOM FRENCH)
	(SYNONYM DOOR LOCK)
	(DESC "French door")
	(IN LOCAL-GLOBALS)
	(FLAGS LOCKED DOORBIT)
	(GENERIC LOCKED-F)
	;(ACTION HIDE-LOOK-DOOR-F)>
]
<OBJECT KITCHEN-DINING-DOOR
	(ADJECTIVE SWINGING)
	(SYNONYM DOOR)
	(DESC "swinging door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT OPENBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM KITCHEN
	(IN ROOMS)
	(DESC "kitchen")
	(LDESC
"The Linder kitchen is full of electric appliances: range and hood,
refrigerator, mixer, toaster, clock, and so on. Several white steel
cabinets make for plenty of storage space. To the north is the dining
room, to the east the hall.")
	(SYNONYM KITCHEN)
	(FLAGS RLANDBIT ONBIT)
	(NORTH TO DINING-ROOM IF KITCHEN-DINING-DOOR IS OPEN)
	(EAST TO HALL-1 IF KITCHEN-HALL-DOOR IS OPEN)
	(GLOBAL KITCHEN-DINING-DOOR KITCHEN-HALL-DOOR KITCHEN-WINDOW
		SINK ;TELEPHONE CABINET CHAIR)
	(LINE 1)
	(STATION HALL-1)>

<OBJECT KITCHEN-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "kitchen window")
	(ADJECTIVE KITCHEN)
	(SYNONYM WINDOW PANE PANES FRAME)
	(FLAGS NDESCBIT WINDOWBIT)
	(GENERIC GENERIC-WINDOW-F)
	(ACTION WINDOW-F)>
[
<OBJECT K-CABINETS
	(IN KITCHEN)
	(DESC "cabinet")
	(SYNONYM CABINET)
	(FLAGS NDESCBIT CONTBIT)
	(CAPACITY 50)
	;(ACTION K-CABINETS-F)>

<OBJECT SILVERWARE
	(IN K-CABINETS)
	(DESC "set of silverware")
	(SYNONYM SILVER SET)
	(FLAGS TRYTAKEBIT)
	(ACTION SILVERWARE-F)>

<ROUTINE SILVERWARE-F ()
 <COND ;(<VERB? COUNT>
	 <TELL "There are 16 complete place settings." CR>)
       ;(<VERB? EXAMINE>
	<TELL
"The silver has fine quality and design, not to mention exotic shapes
from Asia." CR>)
       (<VERB? TAKE>
	<TELL
"You could probably hock this stuff for a bundle, but you'd never get
away with it, since the butler will no doubt count it again when
you leave." CR>)>>

<OBJECT GLASSES
	(IN K-CABINETS)
	(DESC "glass collection")
	(SYNONYM GLASS GLASSES)
	(FLAGS TRYTAKEBIT)
	(ACTION SILVERWARE-F)>

;<ROUTINE GLASSES-F ()
	 <COND ;(<VERB? COUNT>
		<TELL "There are at least two dozen." CR>)
	       (<VERB? TAKE> <NO-TOUCH>)>>

<OBJECT CHINA
	(IN K-CABINETS)
	(SYNONYM CHINA SET)
	(DESC "set of china")
	(FLAGS TRYTAKEBIT)
	(ACTION SILVERWARE-F)>

;<ROUTINE CHINA-F ()
 <COND (<VERB? TAKE> <NO-TOUCH>)>>

;<OBJECT CUPS
	(IN KITCHEN)
	(SYNONYM GROUP CUPS TEACUP)
	(ADJECTIVE CUPS ANTIQUE TEA)
	(DESC "group of cups")
	(FLAGS NDESCBIT)
	;(ACTION CUPS-F)>

;<OBJECT PLATES
	(IN KITCHEN)
	(SYNONYM PLATE PLATES)
	(DESC "plates")
	(FLAGS NDESCBIT)
	;(ACTION PLATES-F)>
][
<OBJECT K-CUPBOARD
	(IN KITCHEN)
	(DESC "cupboard")
	(SYNONYM CUPBOARD)
	(FLAGS NDESCBIT CONTBIT)
	(CAPACITY 50)
	;(ACTION K-CABINETS-F)>

<OBJECT FOODS
	(IN K-CUPBOARD) 
	(DESC "bunch of canned food")
	(ADJECTIVE ;DRIED CANNED ;PACKAGED)
	(SYNONYM FOOD FOODS BUNCH)
	(FLAGS TRYTAKEBIT)
	(ACTION FOODS-F)>

<ROUTINE FOODS-F ()
	 <COND (<VERB? EAT TAKE>
		<TELL
"Your parents must have taught you better manners than that." CR>)>>
	]
<OBJECT K-CLOCK
	(IN KITCHEN)
	(ADJECTIVE KITCHEN)
	(SYNONYM CLOCK)
	(DESC "kitchen clock")
	(FLAGS NDESCBIT)
	;(SIZE 4)
	(ACTION K-CLOCK-F)>

<ROUTINE K-CLOCK-F ()
 <COND (<VERB? EXAMINE>
	<TELL "The time on the kitchen clock is ">
	<TIME-PRINT ,PRESENT-TIME>
	<CRLF>)
       (<VERB? LISTEN>
	<TELL "The clock is humming electrically." CR>)>>
[
<OBJECT REFRIGERATOR
	(IN KITCHEN)
	(DESC "refrigerator")
	(ADJECTIVE ELECTRIC)
	(SYNONYM APPLIANCE REFRIGERATOR FRIDGE ;MIXER)
	(FLAGS NDESCBIT CONTBIT)
	(CAPACITY 22)
	(ACTION APPLIANCE-F)>

<OBJECT COLD-FOODS
	(IN REFRIGERATOR) 
	(DESC "bunch of cold food")
	(ADJECTIVE COLD)
	(SYNONYM FOOD FOODS BUNCH)
	(FLAGS TRYTAKEBIT)
	(ACTION FOODS-F)>
]
<OBJECT RANGE
	(IN KITCHEN)
	(DESC "range")
	(ADJECTIVE ELECTRIC)
	(SYNONYM RANGE)
	(FLAGS NDESCBIT ;DUPLICATE)
	(ACTION APPLIANCE-F)>

<OBJECT HOOD
	(IN KITCHEN)
	(DESC "range hood")
	(ADJECTIVE ELECTRIC RANGE)
	(SYNONYM HOOD)
	(FLAGS NDESCBIT)
	(ACTION APPLIANCE-F)>

<OBJECT MIXER
	(IN KITCHEN)
	(DESC "mixer")
	(ADJECTIVE ELECTRIC)
	(SYNONYM MIXER)
	(FLAGS NDESCBIT)
	(ACTION APPLIANCE-F)>

<OBJECT TOASTER
	(IN KITCHEN)
	(DESC "toaster")
	(ADJECTIVE ELECTRIC)
	(SYNONYM TOASTER)
	(FLAGS NDESCBIT)
	(ACTION APPLIANCE-F)>

<ROUTINE APPLIANCE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's as modern as yesterday, like everything in the kitchen." CR>)
	       (<VERB? LAMP-OFF LAMP-ON USE>
		<TELL
"The butler is probably very proud and jealous of these sparkling
modern gadgets, and he wouldn't like you using them." CR>)>>
]
<OBJECT KITCHEN-HALL-DOOR
	(ADJECTIVE KITCHEN ;HALL)
	(SYNONYM DOOR)
	(DESC "kitchen door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT OPENBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>

<ROOM HALL-1
	(IN ROOMS)
	(DESC "hallway")
	(FLAGS RLANDBIT ONBIT)
	;(DESCFCN HALL-1-F)
	(ACTION  HALL-1-F)
	;(ADJECTIVE HALL)
	;(SYNONYM HALLWAY WAY)
	(SOUTH TO HALL-2)
	(NORTH TO LIVING-ROOM)
	(WEST TO KITCHEN IF KITCHEN-HALL-DOOR IS OPEN)
	(GLOBAL KITCHEN-HALL-DOOR)
	(LINE 1)
	(STATION HALL-1)
	(CORRIDOR 16)>

<ROUTINE HALL-1-F ("OPTIONAL" RARG)
	<COND (<EQUAL? .RARG ;,M-ENTER ,M-LOOK ;,M-OBJDESC>
	       <TELL
"This is the north end of the central hallway.
Just to the north, you can see warm yellow light in the living room.">
	       <COND (<AND <IN? ,MONICA ,LIVING-ROOM>
			   <IN? ,LINDER ,LIVING-ROOM>
			   <NOT ,LINDER-FOLLOWS-YOU>>
		      <TELL " You can hear voices talking excitedly.">)>
	       <CRLF>)>>

<ROOM HALL-2
	(IN ROOMS)
	(DESC "hallway")
	(FLAGS RLANDBIT ONBIT NDESCBIT)
	(ACTION HALL-2-F)
	;(ADJECTIVE HALL)
	;(SYNONYM HALLWAY WAY)
	(EAST TO MONICA-ROOM IF MONICA-DOOR IS OPEN)
	(WEST TO BUTLER-ROOM IF BUTLER-DOOR IS OPEN)
	(SOUTH TO HALL-3)
	(NORTH TO HALL-1)
	(GLOBAL MONICA-DOOR BUTLER-DOOR)
	(LINE 1)
	(STATION HALL-2)
	(CORRIDOR 16)>

<ROUTINE HALL-2-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is near the middle of the central hallway.
At the north end, you can see the living room; to the east and west are
bedroom doors. ">
		<COND (<FSET? ,MONICA-DOOR ,OPENBIT>
		       <COND (<FSET? ,BUTLER-DOOR ,OPENBIT>
			      <TELL "Both doors are open." CR>)
			     (T <TELL "The door to the east is open." CR>)>)
		      (<FSET? ,BUTLER-DOOR ,OPENBIT>
		       <TELL "The door to the west is open." CR>)
		      (T <TELL "Both doors are closed." CR>)>)>>

<OBJECT BUTLER-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE BUTLER HIS)
	(DESC "butler's door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM BUTLER-ROOM
	(IN ROOMS)
	(ACTION BUTLER-ROOM-F)
	(DESC "butler's room")
	(ADJECTIVE BUTLER HIS BED SERVANT)
	(SYNONYM BEDROOM ROOM)
	(GENERIC GENERIC-BEDROOM-F)
	(FLAGS RLANDBIT ONBIT)
	(EAST TO HALL-2 IF BUTLER-DOOR IS OPEN)
	(OUT TO HALL-2 IF BUTLER-DOOR IS OPEN)
	(NORTH TO BUTLER-BATH IF BUTLER-BATH-DOOR IS OPEN)
	(IN    TO BUTLER-BATH IF BUTLER-BATH-DOOR IS OPEN)
	(GLOBAL BUTLER-DOOR BUTLER-BATH-DOOR BUTLER-WINDOW CLOSET BED)
	(LINE 1)
	(STATION HALL-2)>

<ROUTINE BUTLER-ROOM-F ("OPTIONAL" (RARG <>))
	 <COND (<==? .RARG ,M-LOOK>
		<DDESC
"This is the bedroom of the butler, Mr. Phong, and is very simply
furnished. A single bed, flanked by bare wooden end tables, sits below a
closed window on the west end of the room. The floor is hardwood, with no
rug. The only exit is a door to the east, which is " ,BUTLER-DOOR ".">
		<DDESC
"Another door, now " ,BUTLER-BATH-DOOR", must lead to a private bathroom.">)>>

<OBJECT BUTLER-TABLE
	(IN BUTLER-ROOM)
	(ADJECTIVE BARE WOOD WOODEN END)
	(SYNONYM TABLE TABLES)
	(DESC "end table")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT FURNITURE AN)
	(CAPACITY 15)>

<OBJECT BUTLER-BATH-DOOR
	(ADJECTIVE ;BUTLER ;HIS BATH BATHROOM)
	(SYNONYM DOOR)
	(DESC ;"butler's " "bathroom door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT)
	(GENERIC GENERIC-BATH-DOOR-F)
	;(ACTION HIDE-LOOK-DOOR-F)>

<OBJECT BUTLER-WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "bedroom window")
	(SYNONYM WINDOW PANE PANES FRAME)
	(ADJECTIVE BUTLER HIS BEDROOM BED ROOM)
	(FLAGS NDESCBIT WINDOWBIT)
	(GENERIC GENERIC-WINDOW-F)
	(ACTION WINDOW-F)>
][
<ROOM BUTLER-BATH
	(IN ROOMS)
	(FLAGS RLANDBIT ONBIT)
	(DESC "butler's bathroom")
	(ACTION BUTLER-BATH-F)
	(ADJECTIVE BUTLER HIS BATH SERVANT)
	(SYNONYM ROOM BATHROOM)
	(GENERIC GENERIC-BATHROOM-F)
	(SOUTH TO BUTLER-ROOM IF BUTLER-BATH-DOOR IS OPEN)
	(OUT   TO BUTLER-ROOM IF BUTLER-BATH-DOOR IS OPEN)
	(GLOBAL MIRROR TOILET SINK BATHTUB BUTLER-BATH-DOOR)>

<ROUTINE BUTLER-BATH-F ("OPTIONAL" (RARG <>))
	 <COND (<OR <==? .RARG ,M-LOOK>
		    <AND <NOT .RARG> <VERB? EXAMINE>>>
		<DDESC
"This is Mr. Phong's bathroom, with the usual plumbing and not much
else. The door at the south side of the room is " ,BUTLER-BATH-DOOR ".">)>>

	;<OBJECT BUTLER-SHELVES
		(IN BUTLER-BATH)
		(DESC "shelf")
		(SYNONYM SHELVES SHELF)
		(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
		(CAPACITY 30)>
]
<ROOM HALL-3
	(IN ROOMS)
	(DESC "hallway")
	(LDESC
"This hallway seems to run the length of the house, from the garage
at the south end to the living room at the north. There is enough warm yellow
light flooding from the living room for you to see a few doors on each side
of the hall.")
	(FLAGS RLANDBIT ONBIT)
	(WEST TO ENTRY)
	(OUT TO ENTRY)
	(SOUTH TO HALL-4)
	(NORTH TO HALL-2)
	(LINE 1)
	(STATION HALL-3)
	(CORRIDOR 16)>
[
<ROOM ENTRY
	(IN ROOMS)
	(DESC "entry")
	(ACTION ENTRY-F)
	(SYNONYM ENTRY FOYER)
	(FLAGS RLANDBIT ONBIT AN)
	(WEST TO FRONT-PORCH IF FRONT-DOOR IS OPEN)
	(OUT  TO FRONT-PORCH IF FRONT-DOOR IS OPEN)
	(EAST TO HALL-3)
	(GLOBAL FRONT-DOOR CLOSET)
	(LINE 1)
	(STATION ENTRY)>

<ROUTINE ENTRY-F ("OPTIONAL" (RARG <>))
	 <COND ;(<==? .RARG ,M-ENTER>
		<COND (<AND <NOT <IN? ,PHONG ,ENTRY>>
			    <NOT ,WELCOMED>
			    <FSET? ,CORPSE ,INVISIBLE>>
		       <TELL
"The butler appears from a hallway to the east." CR>
		       <WELCOME>)>)
	       (<==? .RARG ,M-LOOK>
		<DDESC
"Here in the entry is a small Shinto shrine, with a hanging scroll and
an arrangement of flowers, as well as a coat closet and a platform for
storing shoes. You can see a hallway to the east. The front door, on the
west wall, is " ,FRONT-DOOR ".">)>>

<OBJECT FLOWER-ARRANGEMENT
	(IN ENTRY)
	(DESC "flower arrangement")
	(ADJECTIVE FLOWER)
	(SYNONYM ARRANGEMENT)
	(FLAGS NDESCBIT)
	(ACTION FLOWER-F)>

<ROUTINE FLOWER-F ()
 <COND (<VERB? PICK>
	<TELL "What? And spoil the arrangement?!" CR>)
       (<VERB? SMELL>
	<TELL
"Someone chose these flowers for looks, not aroma." CR>)>>

<OBJECT SCROLL
	(IN ENTRY)
	(DESC "scroll")
	(LDESC "A lovely calligraphed scroll hangs on the wall.")
	(ADJECTIVE LOVELY CALLIGRAPHED)
	(SYNONYM SCROLL SHRINE)
	(FLAGS NDESCBIT READBIT)
	(ACTION SCROLL-F)>

<ROUTINE SCROLL-F ()
	<COND (<VERB? EXAMINE READ>
	       <TELL
"The scroll is written with a fine brush. Freely translated, it reads:|
|
">
	       <PUT 0 8 <BOR <GET 0 8> 2>>
	       <TELL
"The WITNESS: An INTERLOGIC Mystery|
        from Infocom, Inc.|
          by Stu Galley|
       based on an idea by|
   Marc Blank and Dave Lebling|
 Copyright (c) 1983 Infocom, Inc.|
       All rights reserved.|
      WITNESS and INTERLOGIC|
  are trademarks of Infocom, Inc.|
" CR>
	       <PUT 0 8 <BAND <GET 0 8> -3>>
	       <RTRUE>)>>

<OBJECT SHOE-PLATFORM
	(IN ENTRY)
	(DESC "shoe platform")
	(ADJECTIVE SHOE)
	(SYNONYM PLATFORM)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT FURNITURE)
	(CAPACITY 10)
	(ACTION SHOE-PLATFORM-F)>

<ROUTINE SHOE-PLATFORM-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
	<TELL
"Several pairs of shoes are in a row, ready for inspection.">
	<COND (<AND <IN? ,MUDDY-SHOES ,SHOE-PLATFORM>
		    <NOT <FSET? ,MUDDY-SHOES ,INVISIBLE>>>
	       ;<FCLEAR ,MUDDY-SHOES ,INVISIBLE>
	       <TELL " One pair of boots would not pass.">)>
	<CRLF>)>>

<OBJECT OTHER-SHOES
	(IN SHOE-PLATFORM)
	(DESC "other shoes")
	(ADJECTIVE OTHER)
	(SYNONYM SHOE SHOES ;ROW)
	(FLAGS TRYTAKEBIT NDESCBIT AN)
	(ACTION OTHER-SHOES-F)>

<ROUTINE OTHER-SHOES-F ()
 <COND (<VERB? EXAMINE>
	<TELL
"They're just ordinary shoes, nothing to get excited about." CR>)
       (<VERB? TAKE>
	<TELL "That wouldn't do you any good." CR>)>>
]
<OBJECT FRONT-DOOR
	(ADJECTIVE FRONT ;MAIN)
	(SYNONYM DOOR LOCK)
	(DESC "front door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT LOCKED)
	(GENERIC LOCKED-F)
	(ACTION FRONT-DOOR-F)>

<ROUTINE FRONT-DOOR-F ("AUX" (VAL <>))
	<COND (<VERB? KNOCK>
	       <COND (<AND <==? ,PRSO ,FRONT-DOOR>
			   <NOT ,WELCOMED>
			   <FSET? ,CORPSE ,INVISIBLE>>
		      <COND (<==? ,HERE ,FRONT-PORCH> <WELCOME>)
			    (T <TELL "You can't reach the front door."CR>)>)
		     (<INHABITED? <DOOR-ROOM ,HERE ,FRONT-DOOR>>
		      <TELL "A muffled voice says, \"Come in!\"" CR>)
		     (T
		      <TELL "There is no answer at the door." CR>)>)
	      (<VERB? WALK-TO>
	       <COND (<EQUAL? ,HERE ,DRIVEWAY-ENTRANCE ,GARAGE>
		      <SET VAL T> <GOTO ,DRIVEWAY>)>
	       <COND (<EQUAL? ,HERE ,DRIVEWAY ,FRONT-YARD>
		      <SET VAL T> <GOTO ,FRONT-PORCH>)>
	       .VAL)>>

[
<ROOM STORAGE-CLOSET
	(IN ROOMS)
	(DESC "storage closet")
	(LDESC
"This is a little-used storage closet containing odds and ends of no interest
whatsoever. The exit is to the east.")
	(ADJECTIVE STORAGE)
	(SYNONYM CLOSET)
	(FLAGS RLANDBIT ONBIT)
	(EAST TO HALL-4 IF STORAGE-DOOR IS OPEN)
	(OUT  TO HALL-4 IF STORAGE-DOOR IS OPEN)
	(GLOBAL STORAGE-DOOR ;CLOSET)
	(SIZE 1)
	(LINE 2)
	(STATION HALL-4)>

<OBJECT STORAGE-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE STORAGE CLOSET)
	(DESC "storage door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>

<OBJECT LINENS
	(IN STORAGE-CLOSET)
	(DESC "linens")
	(SYNONYM LINENS SHEETS LINEN)
	(FLAGS NDESCBIT)
	(ACTION CLOSET-STUFF-F)>

<OBJECT TOWELS
	(IN STORAGE-CLOSET)
	(DESC "towel")
	(SYNONYM TOWEL TOWELS)
	(FLAGS NDESCBIT)
	(ACTION CLOSET-STUFF-F)>

<ROUTINE CLOSET-STUFF-F ()
		 <COND (<VERB? TAKE MOVE USE>
			<TELL "You have no need for them." CR>)
		       (<VERB? READ SEARCH EXAMINE>
			<TELL
	"You go through" THE-PRSO " and find nothing of interest." CR>)>>

]
<ROOM HALL-4
	(IN ROOMS)
	(DESC "hallway")
	(LDESC
"This is the south end of a hallway that runs the length of the house.
At the far end, to the north, you can see the living room; immediately
to the south is a door. Other doors on both sides lead to other rooms.")
	(FLAGS RLANDBIT ONBIT)
	(SOUTH TO GARAGE IF GARAGE-DOOR IS OPEN)
	(OUT   TO GARAGE IF GARAGE-DOOR IS OPEN)
	(EAST TO OFFICE IF OFFICE-DOOR IS OPEN)
	(NORTH TO HALL-3)
	(WEST TO STORAGE-CLOSET IF STORAGE-DOOR IS OPEN)
	(GLOBAL STORAGE-DOOR OFFICE-DOOR GARAGE-DOOR)
	(LINE 2)
	(STATION HALL-4)
	(CORRIDOR 16)>

<OBJECT OFFICE-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE OFFICE)
	(DESC "office door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT AN)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM OFFICE
	(IN ROOMS)
	(DESC "office")
	(SYNONYM OFFICE)
	(FLAGS RLANDBIT ONBIT AN)
	(ACTION OFFICE-F)
	(EAST TO OFFICE-PORCH IF OFFICE-BACK-DOOR IS OPEN)
	(OUT  TO OFFICE-PORCH IF OFFICE-BACK-DOOR IS OPEN)
	;(SOUTH TO W.C. IF W.C.-DOOR IS OPEN)
	;(IN    TO W.C. IF W.C.-DOOR IS OPEN)
	(WEST TO HALL-4 IF OFFICE-DOOR IS OPEN)
	(GLOBAL OFFICE-DOOR OFFICE-WINDOW ;PIECE-OF-WIRE ;PIECE-OF-PUTTY
		BROKEN-GLASS OFFICE-BACK-DOOR ;W.C.-DOOR TELEPHONE CLOCK)
	(LINE 2)
	(STATION OFFICE)>

<ROUTINE OFFICE-F ("OPTIONAL" (RARG <>))
	 ;<SETG WELCOMED T>
	 <COND (<AND <==? .RARG ,M-BEG>
		     ,LINDER-FOLLOWS-YOU
		     <NOT <DOBJ? CLOCK-WIRES LINDER>>
		     <VERB? WALK FOLLOW HIDE-BEHIND THROUGH>>
		<TELL
"Linder says with frustration, \"I wish you wouldn't try to go off while
we're trying to talk.\"" CR>
		<RTRUE>)
	       (<==? .RARG ,M-LOOK>
		<TELL
"This is obviously the office of Mr. Linder's company, Pacific Trade
Associates. ">
		<OFFICE-DESK-F ,M-OBJDESC>
		<TELL
"Behind it is a large ornately-carved chair, like a cruiser escorting a
battle ship">
		<COND (<IN? ,LINDER ,CARVED-CHAIR>
		       <TELL ", where Linder sits imperiously">)>
		<TELL
". A simple wooden chair, polished smooth by visitors,
flanks the desk on the other side. On the north wall is a lounge,
upholstered in green velvet and a bit lumpy, with a framed wood-block
picture hanging over it. On the outside wall, next to a door and window,
stands a grandfather clock, ticking relentlessly. A file cabinet stands
in the corner." CR>
		<COND (<FSET? ,OFFICE-DOOR ,OPENBIT>
		       <TELL
"The door to the interior hallway is open." CR>)>
		;<COND (<FSET? ,W.C.-DOOR ,OPENBIT>
		       <TELL
"The door to a small lavatory is open." CR>)>
		<COND (<FSET? ,OFFICE-BACK-DOOR ,OPENBIT>
		       <TELL
"The door leading outside is open." CR>)>
		<COND (<FSET? ,OFFICE-WINDOW ,OPENBIT>
		       <TELL
"The window facing the back yard is open." CR>)>
		<RTRUE>)>>

<OBJECT OFFICE-DESK
	(IN OFFICE)
	(ADJECTIVE LARGE MASSIVE OFFICE)
	(SYNONYM DESK)
	(DESC "desk")
	(DESCFCN OFFICE-DESK-F)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT FURNITURE)
	(ACTION OFFICE-DESK-F)
	(CAPACITY 25)>

<ROUTINE OFFICE-DESK-F ("OPTIONAL" (ARG <>))
	 <COND (<OR <==? .ARG ,M-OBJDESC>
		    <AND <NOT .ARG> <VERB? EXAMINE LOOK-INSIDE LOOK-ON>>>
		<TELL
"At the west end of the office, a massive desk of teak and mahogany
faces toward the window. It has no drawers, but the top is covered with
piles of letters, some newspapers, a telephone, and various souvenirs
from the Far East.">
		<COND (<==? ,MONICA-TIED-TO ,OFFICE-DESK>
		       <TELL
" Monica is fastened to the desk with a " D ,MONICA-TIED-WITH ".">)>
		<CRLF>
		<RTRUE>)
	       (<VERB? LOOK-UNDER>
		<TELL
"You can see dirt and grime, old chewing gum in various colors, and a pair of
black wires going from a button into the floor." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL "You can't. It doesn't have drawers." CR>)>>

<OBJECT OFFICE-DESK-STUFF
	(IN OFFICE-DESK)
	(SYNONYM PILES LETTER SOUVENIR STUFF)
	(DESC "stuff on the desk")
	(FLAGS NDESCBIT TRYTAKEBIT READBIT)
	(ACTION CLOSET-STUFF-F)>

<OBJECT NEWSPAPERS
	(IN OFFICE-DESK)
	(SYNONYM NEWSPAPERS ;PAPERS)
	(DESC "newspaper")
	(FLAGS NDESCBIT TRYTAKEBIT READBIT)
	(ACTION NEWSPAPERS-F)>

<ROUTINE NEWSPAPERS-F ()
 <COND (<VERB? TAKE MOVE USE>
	<TELL "You have no need for them." CR>)
       (<VERB? READ SEARCH EXAMINE>
	<TELL
"Today's L.A. Times has the usual sort of stories: secret records of the
police intelligence squad were seized in connection with an attempt to
assassinate private detective Harry Raymond; \"Two Officers Die in Battle
With Maniac\"; \"Slayer of Tijuana Girl Executed under Fugitive Law\"; and
\"Austria Near Hitler Yoke.\"" CR>)>>

<OBJECT CARVED-CHAIR
	(IN OFFICE)
	(DESC "carved chair")
	(ADJECTIVE CARVED OFFICE ORNATE ARM LARGE)
	(SYNONYM CHAIR THRONE)
	(FLAGS NDESCBIT TRYTAKEBIT SURFACEBIT CONTBIT OPENBIT
	       VEHBIT FURNITURE)
	(CAPACITY 30)
	(GENERIC GENERIC-CHAIR-F)
	(DESCFCN CARVED-CHAIR-F)
	(ACTION CARVED-CHAIR-F)>

<ROUTINE CARVED-CHAIR-F ("OPTIONAL" (ARG <>))
 <COND (<==? .ARG ,M-OBJDESC> <PRINT-CONT ,CARVED-CHAIR> <RTRUE>)
       (.ARG <RFALSE>)
       (<OR <VERB? EXAMINE>
	    <AND <VERB? SEARCH-OBJECT-FOR> ;<IOBJ? GLOBAL-HOLE>>>
	<COND ;(<OR <VERB? SEARCH-OBJECT-FOR>
		   <==? ,HOLE <FIRST? ,CARVED-CHAIR>>>
	       <FCLEAR ,HOLE ,INVISIBLE>
	       <FCLEAR ,GLOBAL-HOLE ,INVISIBLE>
	       <TELL
"The chair looks ancient, but it has a fresh hole in it, small and round."
CR>)
	      (T
	       <TELL
"The chair looks like teak, covered with carvings of vines and slithery
creatures that you wouldn't like to meet in a jungle." CR>
	       <RTRUE>)>)
       (<AND <FSET? ,CORPSE ,INVISIBLE> ;<IN? ,LINDER ,CARVED-CHAIR>
	     <VERB? CLIMB-ON SIT TAKE>
	     <==? 1 <GET ,P-PRSO 0>>	;"only one dir. object"
	     <==? ,PRSO ,CARVED-CHAIR>>
	<TELL "Linder glares at you. ">
	<COND (<IN? ,LINDER ,CARVED-CHAIR>
	       <TELL
"\"I meant that you should sit in the customer's chair, not my lap!\" ">)
	      (T <TELL
"\"That's my chair. You take the other one.\" ">)>
	<TELL "You are on your own feet again." CR>
	<RTRUE>)>>

;<OBJECT HOLE
	(IN CARVED-CHAIR)
	(DESC "hole")
	(ADJECTIVE DEEP ;BULLET)
	(SYNONYM HOLE HOLES)
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION HOLE-F)>

;<ROUTINE HOLE-F ();"?easy=not fm wdo, medium=if analyze, hard=?"
 <COND (<VERB? EXAMINE>
	<TELL
"The hole is new, from the look of the wooden splinters, and about the size
and shape of a bullet.">
	<COND (<==? ,P-ADVERB ,W?CAREFULLY> ;<0? ,DIFFICULTY>
	       <TELL
" From the angle of the hole, you can tell that the bullet came from the
direction of the clock.">)>
	<CRLF>)
       ;(<VERB? ANALYZE>
	<TELL
"From the look of it, the bullet did not come from the window." CR>)>>

;<OBJECT GLOBAL-HOLE
	(IN GLOBAL-OBJECTS)
	(DESC "hole")
	(SYNONYM HOLE HOLES)
	(FLAGS ;INVISIBLE)
	;(ACTION HOLE-F)>

<OBJECT WOODEN-CHAIR
	(IN OFFICE)
	(DESC "wooden chair")
	(ADJECTIVE SIMPLE WOODEN WOOD CUSTOMER)
	(SYNONYM CHAIR)
	(FLAGS NDESCBIT TRYTAKEBIT SURFACEBIT CONTBIT OPENBIT
	       VEHBIT FURNITURE)
	(CAPACITY 20)
	(GENERIC GENERIC-CHAIR-F)
	(ACTION WOODEN-CHAIR-F)>

<ROUTINE WOODEN-CHAIR-F ("OPTIONAL" (ARG <>))
 <COND (<AND <NOT .ARG>
	     <VERB? CLIMB-ON SIT TAKE>
	     <==? 1 <GET ,P-PRSO 0>>	;"only one dir. object"
	     <==? ,PRSO ,WOODEN-CHAIR>>
	<MOVE ,PLAYER ,WOODEN-CHAIR>
	<TELL "You are now sitting on the " D ,PRSO "." CR>
	<COND (<NOT ,LINDER-EXPLAINED> <I-LINDER-EXPLAIN>)>
	<RTRUE>)>>

<OBJECT GENERIC-CHAIR
	(IN GLOBAL-OBJECTS)
	(DESC "chair")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-CHAIR-F (OBJ)
 <COND (<AND <VERB? DISEMBARK> <NOT <IN? <LOC ,WINNER> ,ROOMS>>>
	<LOC ,WINNER>)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-CHAIR)
       (<NOT <OR <EQUAL? ,HERE ,MONICA-ROOM ,LINDER-ROOM ,LIVING-ROOM>
		 <EQUAL? ,HERE ,DINING-ROOM ,KITCHEN ,OFFICE>>>
	<SETG P-WON <>>
	<TELL "(You can't see any " "chair" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT FILE-CABINET
		(IN OFFICE)
		(DESC "file cabinet")
		(ADJECTIVE FILE OFFICE)
		(SYNONYM CABINET)
		(FLAGS NDESCBIT CONTBIT FURNITURE)
		(CAPACITY 33)>

<OBJECT PAPERS
	(IN FILE-CABINET)
	(DESC "lot of business papers")
	(FDESC "The cabinet is filled with a lot of business papers.")
	(ADJECTIVE BUSINESS OFFICE)
	(SYNONYM LOT PAPERS PAPER)
	(FLAGS TRYTAKEBIT READBIT ;BURNBIT ;NDESCBIT)
	(ACTION PAPERS-F)>

<ROUTINE PAPERS-F ()
 <COND (<VERB? ;BURN EXAMINE LOOK-INSIDE READ TAKE>
	<FSET ,PAPERS ,TOUCHBIT>
	<COND (<LOC ,LINDER> <PERFORM ,V?ASK-ABOUT ,LINDER ,PAPERS> <RTRUE>)
	      (T
	       <TELL "You look ">
	       <COND (<==? ,P-ADVERB ,W?CAREFULLY>
		      <TELL "more thoroughly through the files and still">)
		     (T <TELL "quickly through the files but">)>
	       <TELL
" find nothing suspicious, so you decide to leave them alone." CR>)>)>>

<OBJECT OFFICE-PICTURE
	(IN OFFICE)
	(DESC "picture")
	(ADJECTIVE FRAMED WOOD BLOCK OFFICE)
	(SYNONYM PICTURE)
	(FLAGS NDESCBIT)
	;(ACTION OFFICE-PICTURE-F)>

;<OBJECT GLOBAL-CLOCK
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE TALL CASE GRANDFATHER OFFICE)
	(SYNONYM CLOCK)
	(DESC "clock")
	(ACTION GLOBAL-CLOCK-F)>

;<ROUTINE GLOBAL-CLOCK-F ()
 <COND (<AND <VERB? ASK-ABOUT> <IOBJ? GLOBAL-CLOCK>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,CLOCK>
	<RTRUE>)>>

<OBJECT CLOCK
	(IN LOCAL-GLOBALS ;OFFICE)	;"So that SHOOT LOCK works on doors."
	(ADJECTIVE TALL ;CASE GRANDFATHER CLOCK ;OFFICE)
	(SYNONYM CLOCK CASE LOCK DOOR)
	(DESC "grandfather clock")
	(FLAGS FURNITURE NDESCBIT LOCKED CONTBIT)
	(GENERIC LOCKED-F)
	(SIZE 99)
	(CAPACITY 9)
	(ACTION CLOCK-F)>

<ROUTINE CLOCK-F ()
 <COND (<AND <NOT <EQUAL? ,HERE ,OFFICE>>
	     <NOT <VERB? ASK-ABOUT ASK-CONTEXT-ABOUT>>
	     <NOT <VERB? FIND TELL-ME WHAT>>>
	<SETG P-WON <>>
	<TELL "(You can't see any " "clock" " here!)" CR>)
       (<VERB? EXAMINE>
	<TELL
"This is a full-blown \"grandfather\" clock, seven feet tall, run by
weights and regulated by a pendulum, whose dial shows day, date, and
phase of the moon besides the time. According to the dial, today is ">
	<COND (<L? ,PRESENT-TIME 720> <TELL "Friday the 18">)
	      (T <TELL "Saturday the 19">)>
	<TELL "th, the moon is just past full, and the time is now ">
	<TIME-PRINT ,PRESENT-TIME>
	<COND (,SHOT-FIRED
	       <FCLEAR ,CLOCK-POWDER ,INVISIBLE>
	       ;<FCLEAR ,CLOCK-POWDER ,NDESCBIT>
	       <COND (<==? ,P-ADVERB ,W?CAREFULLY>
		      <TELL
" There is some kind of powder around the keyhole.">)
		     (T <TELL
" And you notice that the keyhole looks darker than normal.">)>)>
	<CRLF>)
       (<VERB? LISTEN>
	<TELL "The clock is ticking relentlessly." CR>)
       (<AND <VERB? LOOK-INSIDE OPEN SEARCH>
	     <NOT <FSET? ,CLOCK ,LOCKED>>>
	<COND (<AND <VERB? LOOK-INSIDE SEARCH> <NOT <FSET? ,CLOCK ,OPENBIT>>>
	       <TELL "You'll have to open it first." CR>
	       <RTRUE>)>
	<FSET ,CLOCK ,OPENBIT>
	<TELL "As you'd expect, the case holds a long pendulum.">
	<COND (<IN? ,INSIDE-GUN ,CLOCK>
	       <FCLEAR ,INSIDE-GUN ,INVISIBLE>
	       <TELL
" The surprise is a hand gun, pointing out into the room.">)>
	<TELL " You can also see some relays and things." CR>)
       (<VERB? LOOK-UNDER>
	<TELL
"All you see is a pair of green wires going from the case into
the floor." CR>)
       (<AND <VERB? LOCK> <==? ,PRSO ,CLOCK>>
	<COND (<IN? ,CLOCK-KEY ,WINNER>
	       <FSET ,CLOCK ,LOCKED>
	       <SETG USED-CLOCK-KEY T>
	       <TELL "The door of the clock is now locked." CR>)
	      (T <TELL "You don't have the right key." CR>)>
	<RTRUE>)
       (<AND <VERB? UNLOCK> <==? ,PRSO ,CLOCK>>
	<COND (<IN? ,CLOCK-KEY ,WINNER>
	       <FCLEAR ,CLOCK ,LOCKED>
	       <SETG USED-CLOCK-KEY T>
	       <TELL "The door of the clock is now unlocked." CR>)
	      (T <TELL "You don't have the right key." CR>)>)
       (<VERB? PUSH MOVE>
	<TELL "It seems to be bolted to the floor." CR>)>>

<OBJECT KEY-HOLE
	(IN OFFICE)
	(DESC "keyhole")
	;(ADJECTIVE KEY)
	(SYNONYM ;HOLE KEYHOLE ;HOLES)
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(CAPACITY 1)
	(ACTION KEY-HOLE-F)>

<ROUTINE KEY-HOLE-F ()
 <COND (<AND <EQUAL? ,WINNER ,PLAYER>
	     <VERB? BRUSH EXAMINE KISS LOOK-INSIDE PUT RUB RUB-OVER SMELL>>
	<SETG PLAYER-NEAR-SHOT ,PRESENT-TIME>)>
 <COND (<VERB? EXAMINE>
	<TELL
"It's an impressive keyhole, wrapped in a fine brass escutcheon.">
	<COND (,SHOT-FIRED
	       <FCLEAR ,CLOCK-POWDER ,INVISIBLE>
	       <TELL " There is some kind of powder around it.">)>
	<CRLF>)
       (<AND <VERB? LOOK-INSIDE> <NOT <FSET? ,CLOCK ,OPENBIT>>>
	<TELL "You can't see anything in there but darkness." CR>)
       (<AND <VERB? PUT> ,LINDER-FOLLOWS-YOU>
	<TELL
"Linder says, \"I wish you'd pay attention to me instead of that clock.\""
CR>)>>

<OBJECT POWDER		;"Need this for ANALYZE x FOR POWDER"
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE ;CLOCK GUN)
	(SYNONYM POWDER GUNPOWDER)
	(DESC "powder")
	;(FLAGS INVISIBLE)
	;(ACTION POWDER-F)>

;<ROUTINE POWDER-F ()
 <COND (<AND <VERB? ANALYZE> <==? <META-LOC ,WINNER> ,OFFICE>>
	<COND (<DOBJ? POWDER> <PERFORM ,V?ANALYZE ,CLOCK-POWDER ,PRSI>)
	      (<IOBJ? POWDER> <PERFORM ,V?ANALYZE ,PRSO ,CLOCK-POWDER>)>
	<RTRUE>)>>

<OBJECT CLOCK-POWDER
	(IN OFFICE)
	(ADJECTIVE CLOCK GUN)
	(SYNONYM SAMPLE POWDER)
	(DESC "sample of powder")
	(FLAGS NDESCBIT TAKEBIT INVISIBLE)
	(SIZE 1)
	(ACTION CLOCK-POWDER-F)>

<ROUTINE CLOCK-POWDER-F ()
 <COND (<VERB? ANALYZE>
	<FCLEAR ,CLOCK-POWDER ,NDESCBIT>
	<FCLEAR ,CLOCK-POWDER ,INVISIBLE>
	<DO-ANALYZE>)
       (<VERB? EXAMINE>
	<TELL "It looks like cheap gunpowder." CR>)
       (<VERB? SMELL>
	<TELL "It has a pungent smell, like cheap gunpowder." CR>)
       (<AND <==? 1 <GET ,P-PRSO 0>>	;"only one dir. object"
	     <VERB? TAKE>>
	<FCLEAR ,CLOCK-POWDER ,INVISIBLE>
	<FCLEAR ,CLOCK-POWDER ,NDESCBIT>
	<RFALSE>)>>

<OBJECT CLOCK-WIRES
	(IN OFFICE)
	(DESC "pair of green wires")
	(ADJECTIVE GREEN)
	(SYNONYM PAIR WIRES)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WIRE-F)
	(ACTION CLOCK-WIRES-F)>

<ROUTINE CLOCK-WIRES-F ()
 <COND (<VERB? FOLLOW>
	<TELL "The wires go into the floor and disappear." CR>)
       (<VERB? TAKE>
	<TELL "You can't." " They're stuck tight." CR>)>>

;<OBJECT OFFICE-CARPET
	(IN OFFICE)
	(SYNONYM CARPET RUG)
	(DESC "carpet")
	(FLAGS NDESCBIT)
	;(ACTION LIBRARY-CARPET-F)>

<OBJECT OFFICE-BUTTON
	(IN OFFICE)
	(ADJECTIVE BUTLER HIS OFFICE)
	(SYNONYM BUTTON)
	(DESC "butler's button")
	(FLAGS NDESCBIT)
	(ACTION OFFICE-BUTTON-F)>

<GLOBAL SHOT-FIRED <>>
<GLOBAL BUTTON-FIXED <>>
<GLOBAL PLAYER-PUSHED-BUTTON <>>

<ROUTINE OFFICE-BUTTON-F ()
	 <COND (<VERB? FIND>
		<TELL "It's on the edge of the desk." CR>)
	       (<VERB? PUSH RING>
		<COND (,BUTTON-FIXED
		       <PERFORM ,V?PUSH ,BUTTON>
		       <RTRUE>)
		      (,SHOT-FIRED
		       <SETG PLAYER-PUSHED-BUTTON T>
		       <TELL
"You hear a clicking sound from the direction of the clock." CR>)
		      (<==? <META-LOC ,LINDER> ,OFFICE>
		       <TELL
"Linder grabs your wrist and looks you hard in the eye.
Then a wide smile breaks out on his face as he lets go.
\"Sorry if I'm rough, but I don't want any interruptions right now.\"" CR>)
		      (T
		       <SETG PLAYER-PUSHED-BUTTON T>
		       <FIRE-SHOT>
		       <RTRUE>)>)>>

<OBJECT LOUNGE
	(IN OFFICE)
	(DESC "lounge")
	(ADJECTIVE GREEN VELVET LUMPY OFFICE)
	(SYNONYM LOUNGE)
	(CAPACITY 40)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT FURNITURE VEHBIT)>
]
;<OBJECT W.C.-DOOR
	(SYNONYM DOOR)
	(ADJECTIVE POWDER ROOM)
	(DESC "powder-room door")
	(IN LOCAL-GLOBALS)
	(FLAGS DOORBIT)
	;(ACTION HIDE-LOOK-DOOR-F)>

;<ROOM W.C.
	(IN ROOMS)
	(DESC "powder room")
	;(SYNONYM ROOM)
	;(ADJECTIVE POWDER)
	(FLAGS RLANDBIT ONBIT)
	;(ACTION LIBRARY-BALCONY-F)
	(NORTH TO OFFICE IF POWDER-ROOM-DOOR IS OPEN)
	(OUT   TO OFFICE IF POWDER-ROOM-DOOR IS OPEN)
	(GLOBAL POWDER-ROOM-DOOR)
	(LINE 2)
	(STATION OFFICE)>

<OBJECT GARAGE-DOOR
	(SYNONYM DOOR LOCK)
	(ADJECTIVE GARAGE)
	(DESC "garage door")
	(IN LOCAL-GLOBALS)
	(FLAGS LOCKED DOORBIT)
	(GENERIC LOCKED-F)
	;(ACTION BACK-DOOR-F)>
[
<ROOM GARAGE
	(IN ROOMS)
	(DESC "garage")
	(SYNONYM GARAGE)
	(FLAGS RLANDBIT ONBIT)
	(ACTION GARAGE-F)
	(NORTH TO HALL-4 IF GARAGE-DOOR IS OPEN)
	(WEST TO DRIVEWAY)
	(EAST TO WORKSHOP IF WORKSHOP-DOOR IS OPEN)
	(GLOBAL GARAGE-DOOR WORKSHOP-DOOR)
	(LINE 2)
	(STATION GARAGE)
	(CORRIDOR 8)>

<ROUTINE GARAGE-F ("OPTIONAL" (ARG <>))
 <COND (<==? .ARG ,M-LOOK>
	<TELL
"The garage, like a car port, has no door to keep the cars in.
Doors lead north and east.
The walls are decorated with spare tires and things. ">
	<COND (<FSET? ,MONICA-CAR ,INVISIBLE>
	       <COND (<FSET? ,MONICA-CAR ,TOUCHBIT>
		      <TELL "The red MG is gone.">)
		     (T <TELL
"Oil spots on the floor show that a car is often parked here.">)>)
	      (T
	       <COND (<FSET? ,MONICA-CAR ,TOUCHBIT>
		      <TELL "The red MG is parked here.">)
		     (T <TELL
"One car is a sporty red MG convertible.">)>)>
	<TELL " The other car is a dark blue Bentley 3.5-liter sedan."CR>)>>

<OBJECT LINDER-CAR
	(IN GARAGE)
	(DESC "blue sedan")
	;(FDESC "The other car is a dark blue Bentley 3.5-liter sedan.")
	;(DESCFCN LINDER-CAR-F)
	(ADJECTIVE DARK BLUE LINDER HIS)
	(SYNONYM CAR AUTO SEDAN BENTLEY)
	(FLAGS NDESCBIT ;FURNITURE ;VEHBIT)
	(GENERIC GENERIC-CAR-F)
	(ACTION CAR-F)>

<OBJECT MONICA-CAR
	(IN GARAGE)
	(DESC "red sport car")
	;(FDESC "One car is a sporty red MG convertible.")
	;(DESCFCN MONICA-CAR-F)
	(ADJECTIVE RED SPORT SPORTY MONICA HER)
	(SYNONYM CAR AUTO CONVERTIBLE MG)
	(FLAGS NDESCBIT ;FURNITURE)
	(GENERIC GENERIC-CAR-F)
	(ACTION CAR-F)>

<ROUTINE CAR-F ("OPTIONAL" (ARG <>))
 <COND (<AND <DOBJ? MONICA-CAR> <FSET? ,MONICA-CAR ,INVISIBLE>>
	<TELL "It's not here." CR>)
       (<AND ,FILM-SEEN <DOBJ? MONICA-CAR> <VERB? RUB>>
	<TELL "The hood is still warm from driving." CR>)
       (<VERB? LOOK-INSIDE>
	<TELL
"You can barely see a plush interior through the tinted glass, but nothing
else of interest." CR>)
       (<VERB? LOCK UNLOCK>
	<TELL "You don't have the right key." CR>)
       (<VERB? THROUGH> <TELL "The doors are locked." CR>)>>

<OBJECT CAR-WINDOW
	(IN GARAGE)
	(DESC "car window")
	(ADJECTIVE CAR)
	(SYNONYM WINDOW)
	(FLAGS NDESCBIT)
	(ACTION CAR-WINDOW-F)>

<ROUTINE CAR-WINDOW-F ()
 <COND (<NOT <EQUAL? ,HERE ,GARAGE>>
	<SETG P-WON <>>
	<TELL "(You can't see any " "window" " here!)" CR>)
       (<VERB? LOOK-INSIDE>
	<TELL
"You can barely see a plush interior through the tinted glass, but nothing
else of interest." CR>)
       (<VERB? MUNG>
	<TELL "Vandalism is for private ">
	<COND (<TANDY?> <TELL "eye">)
	      (T <TELL "dick">)>
	<TELL "s, not famous police detectives!" CR>)>>

<OBJECT GENERIC-CAR
	(IN GLOBAL-OBJECTS)
	(DESC "car")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-CAR-F (OBJ)
 <COND (<EQUAL? ,HERE ,GARAGE> <RFALSE>)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT FIND TELL-ME WHAT>
	,GENERIC-CAR)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "car" " here!)" CR>
	,NOT-HERE-OBJECT)>>
]
<OBJECT WORKSHOP-DOOR
	(SYNONYM DOOR LOCK)
	(ADJECTIVE WORKSHOP WORK SHOP)
	(DESC "workshop door")
	(IN LOCAL-GLOBALS)
	(FLAGS LOCKED DOORBIT)
	(GENERIC LOCKED-F)
	;(ACTION HIDE-LOOK-DOOR-F)>
[
<ROOM WORKSHOP
	(IN ROOMS)
	(DESC "workshop")
	(ADJECTIVE WORK)
	(SYNONYM SHOP WORKSHOP)
	(LDESC
"This room is a well-equipped workshop. Besides the usual sort of tools,
the place is full of mechanical and electrical parts and supplies:
switches, relays, spools of colored wire, and so on. One wall holds the
main electric board and a home-made junction box with more wires going
in and out than you can shake a stick at. The only door is the one you
came in.")
	(FLAGS RLANDBIT ONBIT)
	(WEST TO GARAGE IF WORKSHOP-DOOR IS OPEN)
	(GLOBAL WORKSHOP-DOOR)
	(LINE 2)
	(STATION GARAGE)>

<OBJECT WORKSHOP-WIRE
	(IN WORKSHOP)
	(DESC "other wire")
	(ADJECTIVE OTHER BROWN RED ORANGE YELLOW BLUE VIOLET GREY)
	(SYNONYM WIRE WIRES SPOOL SPOOLS)
	(FLAGS NDESCBIT AN ;DUPLICATE)
	(GENERIC GENERIC-WIRE-F)
	(ACTION WORKSHOP-WIRE-F)>

<ROUTINE WORKSHOP-WIRE-F ()
 <COND (<VERB? EXAMINE>
	<TELL "It looks just like ordinary wire." CR>)
       (<VERB? FIND>
	<TELL "You can find wire here in almost any color you like." CR>)
       (<VERB? FOLLOW>
	<TELL "It just goes around and around the supply spool." CR>)>>

<OBJECT SPOOL-OF-WIRE
	(IN WORKSHOP)
	(DESC "green wire spool")
	(ADJECTIVE GREEN WIRE)
	(SYNONYM WIRE SPOOL)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WIRE-F)
	(ACTION SPOOL-OF-WIRE-F)>

<ROUTINE SPOOL-OF-WIRE-F ()
 <COND (<AND <VERB? COMPARE>
	     <OR <IOBJ? PIECE-OF-WIRE> <DOBJ? PIECE-OF-WIRE>>>
	<COND (<==? ,P-ADVERB ,W?CAREFULLY>
	       <SETG WIRE-MATCHED T>
	       <TELL
"The piece of green wire and the green spool fit together
perfectly." CR>)
	      (T <TELL
"The piece of green wire and the green spool appear to be
similar." CR>)>)>>

<OBJECT GENERIC-GREEN-WIRE
	(IN GLOBAL-OBJECTS)
	(DESC "green wire")
	;(ADJECTIVE GREEN)
	(SYNONYM $GNRC)>

<OBJECT GENERIC-WIRE
	(IN GLOBAL-OBJECTS)
	(DESC "wire")
	(SYNONYM $GNRC)>

<ROUTINE GENERIC-WIRE-F (OBJ)
 <COND (<EQUAL? ,HERE ,WORKSHOP>
	<COND (<VERB? ;EXAMINE FIND ;FOLLOW> ,WORKSHOP-WIRE)>)
       (<IN? .OBJ ,GLOBAL-OBJECTS> <RFALSE>)
       (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT ASK-FOR ASK-CONTEXT-FOR
	       FIND TELL-ME WHAT
	       GIVE SGIVE SEARCH-OBJECT-FOR TAKE>
	<COND (<OR <EQUAL? .OBJ ,PIECE-OF-WIRE ,SPOOL-OF-WIRE>
		   <EQUAL? .OBJ ,CLOCK-WIRES ,GENERIC-GREEN-WIRE>>
	       ,GENERIC-GREEN-WIRE)
	      (T ,GENERIC-WIRE)>)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "wire" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT JUNCTION-BOX
	(IN WORKSHOP)
	(ADJECTIVE JUNCTION)
	(SYNONYM BOX)
	(DESC "junction box")
	(FLAGS NDESCBIT)
	(ACTION JUNCTION-BOX-F)>

<ROUTINE JUNCTION-BOX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There's a snarl of colored wires, relays, pilot lights, and stuff that only
an engineer could admire." CR>)>>

;<OBJECT TOOLS-1
	(IN WORKSHOP)
	(SYNONYM TOOLS SAW HAMMER ROPE)
	(DESC "collection of carpentry tools")
	(FLAGS NDESCBIT ;DUPLICATE)
	(ACTION TOOLS-F)>

<OBJECT SAW
	(IN WORKSHOP)
	(SYNONYM SAW)
	(DESC "saw")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

<OBJECT HAMMER
	(IN WORKSHOP)
	(SYNONYM HAMMER)
	(DESC "hammer")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

<OBJECT ROPE
	(IN WORKSHOP)
	(SYNONYM ROPE)
	(DESC "rope")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

;<OBJECT TOOLS-2
	(IN WORKSHOP)
	(SYNONYM SPADE HOE RAKE HOSE)
	(DESC "collection of garden tools")
	(FLAGS NDESCBIT ;DUPLICATE)
	(ACTION TOOLS-F)>

<OBJECT SPADE
	(IN WORKSHOP)
	(SYNONYM SPADE)
	(DESC "spade")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

<OBJECT HOE
	(IN WORKSHOP)
	(SYNONYM HOE)
	(DESC "hoe")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

<OBJECT RAKE
	(IN WORKSHOP)
	(SYNONYM RAKE)
	(DESC "rake")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

<OBJECT HOSE
	(IN WORKSHOP)
	(SYNONYM HOSE)
	(DESC "hose")
	(FLAGS NDESCBIT)
	(ACTION TOOLS-F)>

<ROUTINE TOOLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The tools are standard gardening and carpentry tools, in excellent
condition." CR>)
	       (<VERB? TAKE>
		<TELL
"You have no use for them, unless you are looking for
a new profession." CR>)>>

<OBJECT WORK-SHELVES
	(IN WORKSHOP)
	(SYNONYM SHELF SHELVES)
	(DESC "shelf")
	(FLAGS NDESCBIT OPENBIT CONTBIT SURFACEBIT)
	(CAPACITY 20)
	;(ACTION S-SHELVES-F)>
]

"Other stuff"

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(SYNONYM AIR WIND BREEZE)
	(FLAGS AN)
	(ACTION AIR-F)>

<ROUTINE AIR-F ()
	 <COND (<VERB? SMELL>
		<COND (<EQUAL? ,HERE ,FRONT-YARD>
		       <TELL
"The smell of herbs permeates everything." CR>)
		      (<EQUAL? ,HERE ,FRONT-PORCH>
		       <TELL
"A breeze carries the faint smell of herbs through the air." CR>)
		      (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
		       <TELL "The air is clear and fresh here." CR>)
		      (<FRESH-AIR? ,HERE> <RTRUE>)
		      (T <TELL "The air is rather musty here." CR>)>)>>

<ROUTINE FRESH-AIR? (RM "AUX" P L TBL O)
	 #DECL ((RM O) OBJECT (P L) FIX)
	 <SET P 0>
	 <REPEAT ()
		 <COND (<0? <SET P <NEXTP ,HERE .P>>>
			<RFALSE>)
		       (<NOT <L? .P ,LOW-DIRECTION>>
			<SET TBL <GETPT ,HERE .P>>
			<SET L <PTSIZE .TBL>>
			<COND (<AND <EQUAL? .L ,DEXIT>	;"Door EXIT"
				    <FSET? <SET O <GETB .TBL ,DEXITOBJ>>
					   ,OPENBIT>>
			       <TELL
"There is a pleasant breeze coming through the " D .O "." CR>
			       <RETURN>)>)>>>
[
<GLOBAL COR-1
	<PTABLE P?NORTH P?SOUTH
	       ROCK-GARDEN BACK-YARD OFFICE-PORCH OFFICE-PATH 0>>

<GLOBAL COR-2
	<PTABLE P?EAST P?WEST
	       OFFICE-PATH SIDE-YARD DRIVEWAY-ENTRANCE 0>>

<GLOBAL COR-4
	<PTABLE P?SOUTH P?NORTH
	       LIMBO DRIVEWAY-ENTRANCE DRIVEWAY FRONT-PORCH 0>>

<GLOBAL COR-8
	<PTABLE P?EAST P?WEST
	       GARAGE DRIVEWAY 0>>

<GLOBAL COR-16
	<PTABLE P?NORTH P?SOUTH
	       HALL-1 HALL-2 HALL-3 HALL-4 0>>

;<GLOBAL COR-32
	<PTABLE P?EAST P?WEST
		LIVING-ROOM DINING-ROOM 0>>
]
"Routines to do looking down corridors"

<ROUTINE CORRIDOR-LOOK ("OPTIONAL" (ITM <>) "AUX" C Z COR VAL (FOUND <>))
	 <COND (<SET C <GETP ,HERE ,P?CORRIDOR>>
		<REPEAT ()
			<COND (<NOT <L? <SET Z <- .C 16>> 0>>
			       <SET COR ,COR-16>)
			      (<NOT <L? <SET Z <- .C 8>> 0>>
			       <SET COR ,COR-8>)
			      (<NOT <L? <SET Z <- .C 4>> 0>>
			       <SET COR ,COR-4>)
			      (<NOT <L? <SET Z <- .C 2>> 0>>
			       <SET COR ,COR-2>)
			      (<NOT <L? <SET Z <- .C 1>> 0>>
			       <SET COR ,COR-1>)
			      (T <RETURN>)>
			<SET VAL <CORRIDOR-CHECK .COR .ITM>>
			<COND (<NOT .FOUND> <SET FOUND .VAL>)>
			<SET C .Z>>
		.FOUND)>>

<ROUTINE CORRIDOR-CHECK (COR ITM "AUX" (CNT 2) (PAST 0) (FOUND <>) RM OBJ)
 #DECL ((COR) <PRIMTYPE VECTOR> (CNT PAST) FIX)
 <REPEAT ()
  <COND (<==? <SET RM <GET .COR .CNT>> 0>
	 <RFALSE>)
	(<==? .RM ,HERE> <SET PAST 1>)
	(<SET OBJ <FIRST? .RM>>
	 <REPEAT ()
		 <COND (.ITM
			<COND (<==? .OBJ .ITM>
			       <SET FOUND <GET .COR .PAST>>
			       <RETURN>)>)
		       (<AND <FSET? .OBJ ,PERSON>
			     <NOT <IN-MOTION? .OBJ>>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (<AND <==? .OBJ ,STILES> ,DUFFY-WITH-STILES>
			       <SETG SEEN-DUFFY? T>
			       <TELL "Sgt. Duffy, with ">
			       <COND (,MET-STILES? <TELL "Stiles">)
				     (T		<TELL "someone">)>
			       <TELL " in tow,">)
			      (<NOT <FSET? .OBJ ,TOUCHBIT>>
			       <TELL "Someone">)
			      (T <TELL D .OBJ>)>
			<TELL " is ">
			<COND (<OUTSIDE? .RM>
			       <TELL "off">)
			      (T <TELL "down the hall">)>
			<TELL " to ">
			<DIR-PRINT <GET .COR .PAST>>
			<TELL "." CR>)>
		 <SET OBJ <NEXT? .OBJ>>
		 <COND (<NOT .OBJ> <RETURN>)>>
	 <COND (.FOUND <RETURN .FOUND>)>)>
  <SET CNT <+ .CNT 1>>>>

<ROUTINE COR-DIR (HERE THERE "AUX" COR RM (PAST 0) (CNT 2))
	 <SET COR <GET-COR <BAND <GETP .THERE ,P?CORRIDOR>
				 <GETP .HERE ,P?CORRIDOR>>>>
	 <REPEAT ()
		 <COND (<==? <SET RM <GET .COR .CNT>> .HERE>
			<SET PAST 1>
			<RETURN>)
		       (<==? .RM .THERE>
			<RETURN>)>
		 <SET CNT <+ .CNT 1>>>
	 <GET .COR .PAST>>

<ROUTINE GET-COR (NUM)
	 #DECL ((NUM) FIX)
	 <COND (<==? .NUM 1> ,COR-1)
	       (<==? .NUM 2> ,COR-2)
	       (<==? .NUM 4> ,COR-4)
	       (<==? .NUM 8> ,COR-8)
	       (T ,COR-16)
	       ;(<==? .NUM 32> ,COR-32)>>
