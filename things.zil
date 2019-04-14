"THINGS for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

<OBJECT GLOBAL-OBJECTS
	(FLAGS AN CONTBIT DOORBIT DRINKBIT ;DUPLICATE FEMALE FOODBIT FURNITURE
		INVISIBLE LIGHTBIT LOCKED NDESCBIT ON-NOT-IN ONBIT OPENBIT
		PERSON READBIT RLANDBIT RMUNGBIT SEARCHBIT SURFACEBIT TAKEBIT
	TOOLBIT TOUCHBIT TRANSBIT TRYTAKEBIT VEHBIT WEAPONBIT WINDOWBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZKJLK)	;"This synonym is necessary - God knows">

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo" ;"Place holder (MUST BE 6 CHARACTERS!!!!!)")
	(ACTION NULL-F ;"Place holder")>

<ROUTINE RANDOM-PSEUDO ()
	 <TELL "You can't do anything useful with that." CR>>

<OBJECT NOT-HERE-OBJECT
	(DESC "such thing")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	;"Protocol: return T if case was handled and msg TELLed,
			  <> if PRSO/PRSI ready to use"
	<COND ;"This COND is game independent (except the TELL)"
	       (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "(Those things aren't here!)" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<VERB? ASK-CONTEXT-ABOUT ASK-CONTEXT-FOR CLIMB-UP
			      EXAMINE FIND FOLLOW
			      LOOK-INSIDE LOOK-OUTSIDE SEARCH WHAT
			      $WHERE GIVE MAKE THROUGH WALK-TO>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<VERB? ASK-ABOUT ASK-FOR
			      SEARCH-OBJECT-FOR SGIVE TELL-ME>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <SETG P-WON <>>
	 <TELL "(You can't see any">
	 <NOT-HERE-PRINT>
	 <TELL " here!)" CR>
	 <RTRUE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	;"Protocol: return T if case was handled and msg TELLed,
	    ,NOT-HERE-OBJECT if 'can't see' msg TELLed,
			  <> if PRSO/PRSI ready to use"
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	<COND (,DEBUG
	       <TELL "[Moby-found " N .M-F " objects" "]" CR>)>
	<COND (<==? 1 .M-F>
	       <COND (,DEBUG <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO? <SETG PRSO ,P-MOBY-FOUND>)
		     (T <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <L? 1 .M-F>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET .TBL 1>> ,P?GENERIC>
				    .OBJ>>>
	;"Protocol: returns .OBJ if that's the one to use,
		,NOT-HERE-OBJECT if case was handled and msg TELLed,
			      <> if WHICH-PRINT should be called"
	       <COND (,DEBUG <TELL "[Generic: " D .OBJ "]" CR>)>
	       <COND (<==? .OBJ ,NOT-HERE-OBJECT> <RTRUE>)
		     (.PRSO? <SETG PRSO .OBJ>)
		     (T <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (<OR <AND <NOT .PRSO?>
			<VERB? ASK-ABOUT ASK-FOR TELL-ME>>
		   <AND .PRSO?
			<VERB? ASK-CONTEXT-ABOUT ASK-CONTEXT-FOR>>
		   <AND <NOT <==? ,WINNER ,PLAYER>>
			<VERB? FIND WHAT GIVE SGIVE>>>
	       <COND (<VERB? ASK-ABOUT ASK-FOR> <TELL D ,PRSO>)
		     (T <TELL D <COND (<AND ,QCONTEXT
					    <==? ,HERE ,QCONTEXT-ROOM>
					    <==? ,HERE <META-LOC ,QCONTEXT>>>
				       ,QCONTEXT)
				      (<NOT <==? ,WINNER ,PLAYER>>
				       ,WINNER)
				      (T <FIND-FLAG ,HERE ,PERSON>)>>)>
	       <TELL
" looks confused. \"I don't know anything about any">
	       <NOT-HERE-PRINT>
	       <TELL "!\"" CR>
	       <RTRUE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT ()
 <COND (<OR ,P-OFLAG ,P-MERGED>
	<COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM <TELL " "> <PRINTB ,P-XNAM>)>)
       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

;<ROUTINE NO-TOUCH ()
	 <TELL
"Only clods fool around with these things for no good reason." CR>>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM THEY)
	(DESC "it")
	(FLAGS NDESCBIT AN)
	(ACTION IT-F)>

<ROUTINE IT-F ()
 <COND (<OR <AND <IOBJ? IT>
		 <VERB? ASK-ABOUT ASK-FOR SEARCH-OBJECT-FOR TELL-ME>>
	    <AND <DOBJ? IT>
		 <VERB? ASK-CONTEXT-ABOUT ASK-CONTEXT-FOR FIND WHAT>>>
	<TELL "\"I'm not sure what you're talking about.\"" CR>)>>

<ROUTINE THE? (NOUN)
	<COND (<OR <EQUAL? .NOUN ,MONICA-ROOM ,LINDER-ROOM ,LIMBO>
		   <EQUAL? .NOUN ,PHONG ,LINDER ,STILES>
		   <EQUAL? .NOUN ,GLOBAL-PHONG ,GLOBAL-LINDER ,GLOBAL-STILES>
		   <EQUAL? .NOUN ,MONICA ,GLOBAL-MONICA ,GLOBAL-TERRY>
		   <EQUAL? .NOUN ,IT ,YOU ,HIM-HER>
		   <EQUAL? .NOUN ,LINDER-WINDOW ,GLOBAL-DUFFY>>
	       <RTRUE>)
	      (T <TELL " the">)>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <SETG P-IT-LOC ,HERE>>

<OBJECT RECURSIVE-BOOK
	(IN BUTLER-TABLE)
	(DESC "mystery book")
	(ADJECTIVE MYSTERY IMPORTANT)
	(SYNONYM BOOK)
	(FDESC "A book is sitting on the bed-side table.")
	(FLAGS TAKEBIT READBIT CONTBIT)
	(CAPACITY 4)
	(ACTION RECURSIVE-BOOK-F)>

<ROUTINE RECURSIVE-BOOK-F ()
	 <COND (<AND <VERB? ASK-FOR> <DOBJ? PHONG>>
		<FCLEAR ,PRSI ,NDESCBIT>
		<RFALSE>)
	       (<AND <VERB? GIVE TAKE> <IN? ,RECURSIVE-BOOK ,PHONG>>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RFALSE>)
	       (<AND <VERB? DROP> <IN? ,PHONG ,BUTLER-ROOM>>
		<MOVE ,RECURSIVE-BOOK ,PHONG>
		<TELL "Phong picks up the book and starts to read." CR>)
	       (<VERB? EXAMINE>
		<TELL
"This is a mystery story called 'Deadline,' just now published as a book."
CR>)
	       (<VERB? SEARCH READ OPEN LOOK-INSIDE>
		<FSET ,RECURSIVE-BOOK ,OPENBIT>
		<TELL
"The book is a novel-length version of 'Deadline,' a whodunit set in the
future in Connecticut. You start to read it, and it seems oddly
familiar, as if you might live through it yourself some day.">
		<COND (<IN? ,GUN-RECEIPT ,RECURSIVE-BOOK>
		       <FCLEAR ,GUN-RECEIPT ,INVISIBLE>
		       <TELL
" A receipt of some kind is being used as a bookmark.">)>
		<CRLF>)>>

<OBJECT GUN-RECEIPT
	(IN RECURSIVE-BOOK)
	(ADJECTIVE GUN)
	(SYNONYM RECEIPT PAPER TICKET BOOKMARK)
	(DESC "gun receipt")
	(FLAGS TAKEBIT READBIT INVISIBLE)
	(SIZE 1)
	(ACTION GUN-RECEIPT-F)>

<ROUTINE GUN-RECEIPT-F ()
	<COND (<VERB? EXAMINE READ>
	       <PUT 0 8 <BOR <GET 0 8> 2>>
	       <TELL
"\"            FRITZI'S|
   fine merchandise - quick loans|
        Cabeza Plana, Calif.|
                        Number: 69105|
                        Date: 12/1/37|
Sold to: Nemo Newbourne|
Address: 137 E. Second Street|
|
Two handguns - - - - - - - - - $ 8.00|
|
[PAID]\"" CR>
	       <PUT 0 8 <BAND <GET 0 8> -3>>
	       <RTRUE>)>>

<OBJECT TELEGRAM
	(IN PLAYER)
	(DESC "telegram")
	(SYNONYM TELEGRAM)
	(FLAGS TAKEBIT READBIT)
	(SIZE 1)
	(TEXT "(You'll find the telegram in your game package.)")>

<OBJECT MATCHBOOK
	(IN PLAYER)
	(DESC "match book")
	(ADJECTIVE MATCH)
	(SYNONYM MATCHBOOK BOOK MATCHES ;HANDWR ;NUMBER)
	(FLAGS TAKEBIT READBIT)
	(ACTION MATCHBOOK-F)
	(SIZE 1)
	(TEXT "(You'll find the match book in your game package.)")>

<ROUTINE MATCHBOOK-F ()
 <COND (<VERB? LAMP-ON SLAP>
	<TELL "The matches don't seem to work." CR>)
       (<VERB? LOOK-INSIDE OPEN>
	<TELL
"(You'll find the match book in your game package.)"
;"The book is full of matches, and there is a phone number written on the
inside flap." CR>)
       (<AND <VERB? LOOK-UP> <PHONE-IN? ,HERE>>
	<TELL
"The listing for Stiles in the phone book is the same as the number
written in the match book." CR>)>>

<OBJECT PISTOL
	(IN PLAYER)
	(DESC "snub-nosed Colt")
	(ADJECTIVE SNUB-NOSED)
	(SYNONYM COLT PISTOL GUN ROSCOE)
	(GENERIC GENERIC-GUN-F)
	(FLAGS TAKEBIT WEAPONBIT)>

<OBJECT HANDCUFFS
	(IN PLAYER)
	(DESC "pair of handcuffs")
	(ADJECTIVE HAND)
	(SYNONYM PAIR CUFFS HANDCUFF NIPPERS)
	(FLAGS TAKEBIT TOOLBIT)
	(ACTION HANDCUFFS-F)>

<ROUTINE HANDCUFFS-F ()
 <COND (<AND <VERB? TAKE> <DOBJ? HANDCUFFS>>
	<COND (<AND <==? ,HANDCUFFS ,MONICA-TIED-WITH>
		    <OR <NOT ,PRSI> <==? ,PRSI ,MONICA>>>
	       <PERFORM ,V?UNTIE ,MONICA>
	       <RTRUE>)
	      (T <RFALSE>)>)>>

<OBJECT HOUSE
	(IN LOCAL-GLOBALS)
	(DESC "house")
	(SYNONYM HOUSE ;WALL)
	(ADJECTIVE LINDER)
	;(GENERIC WALL-F)
	(ACTION HOUSE-F)>

<ROUTINE HOUSE-F ()
	 <COND (<VERB? FIND>
		<TELL "It's right here. Some detective you are." CR>)
	       (<AND <VERB? WALK-TO>
		     <EQUAL? ,HERE ,DRIVEWAY-ENTRANCE ,DRIVEWAY>>
		<PERFORM ,V?WALK ,P?NORTH>
		<RTRUE>)
	       (<VERB? THROUGH>
		<COND (<AND <EQUAL? ,HERE ,FRONT-YARD>
			    <FSET? ,DINING-DOOR ,OPENBIT>>
		       <GOTO ,DINING-ROOM>)
		      (<AND <EQUAL? ,HERE ,FRONT-PORCH>
		            <FSET? ,FRONT-DOOR ,OPENBIT>>
		       <GOTO ,ENTRY>)
		      (<AND <EQUAL? ,HERE ,OFFICE-PORCH>
		            <FSET? ,OFFICE-BACK-DOOR ,OPENBIT>>
		       <GOTO ,OFFICE>)
		      (<AND <EQUAL? ,HERE ,BACK-YARD>
		            <FSET? ,MONICA-BACK-DOOR ,OPENBIT>>
		       <GOTO ,MONICA-ROOM>)
		      (<AND <EQUAL? ,HERE ,ROCK-GARDEN>
		            <FSET? ,LINDER-BACK-DOOR ,OPENBIT>>
		       <GOTO ,LINDER-ROOM>)
		      (T
		       <TELL "You might try the front door." CR>)>)
	       (<VERB? EXAMINE>
		<TELL	;"? more detail?"
"The house looks like a mixture of
a California bungalow and East Asian influences." CR>)>>

<OBJECT FENCE
	(IN LOCAL-GLOBALS)
	(DESC "fence")
	(SYNONYM FENCE)
	(ACTION FENCE-F)>

<ROUTINE FENCE-F ()
	 <COND (<VERB? CLIMB-FOO CLIMB-ON CLIMB-UP>
		<TELL
"You can't leave the property yet. It would mean your job." CR>)
	       (<VERB? LOOK-BEHIND LOOK-INSIDE LOOK-OUTSIDE>
		<TELL "It's too dark to see anything." CR>)
	       (<VERB? FIND>
		<TELL "It's right here. Some detective you are." CR>)
	       (<VERB? EXAMINE>
		<TELL
"This is a Japanese-style \"shadow fence\" made of wooden slats, opaque
from most angles but designed to let breezes through." CR>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(DESC "ground")
	(ADJECTIVE MUDDY)
	(SYNONYM GROUND DIRT MUD ;SOIL AREA)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<AND <DOBJ? GROUND>
		     <VERB? ASK-CONTEXT-ABOUT ASK-CONTEXT-FOR FIND WHAT>>
		<RFALSE>)
	       (<AND <IOBJ? GROUND>
		     <VERB? ASK-ABOUT ASK-FOR SEARCH-OBJECT-FOR TELL-ME>>
		<RFALSE>)
	       (<NOT <==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>>
		<SETG P-WON <>>
		<TELL "(You can't see any" PRSO " here!)" CR>)
	       (<AND <VERB? PUT> <IOBJ? GROUND>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE SEARCH>
		<TELL "You don't find anything new there." CR>)>>

<OBJECT FLOOR
	(IN GLOBAL-OBJECTS)
	(DESC "floor")
	(SYNONYM FLOOR AREA)
	(ACTION FLOOR-F)>

<ROUTINE FLOOR-F ()
	 <COND (<AND <DOBJ? FLOOR>
		     <VERB? ASK-CONTEXT-ABOUT ASK-CONTEXT-FOR FIND WHAT>>
		<RFALSE>)
	       (<AND <IOBJ? FLOOR>
		     <VERB? ASK-ABOUT ASK-FOR SEARCH-OBJECT-FOR TELL-ME>>
		<RFALSE>)
	       (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
		<SETG P-WON <>>
		<TELL "(You can't see any" PRSO " here!)" CR>)
	       (<AND <VERB? PUT> <IOBJ? FLOOR>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE SEARCH>
		<TELL "You don't find anything new there." CR>)>>

<OBJECT BRASS-LANTERN
	(IN GLOBAL-OBJECTS)
	(DESC "Brass Lantern")
	(ADJECTIVE BRASS)
	(SYNONYM LANTERN RESTAURANT)>

<OBJECT MUSIC
	(IN GLOBAL-OBJECTS)
	(DESC "music")
	(SYNONYM MUSIC PROGRAM)
	(ACTION MUSIC-F)>

<ROUTINE MUSIC-F ()
	 <COND (<VERB? LISTEN>
		<COND (,RADIO-ON
		       <TELL
"You're too far away to make out what it is." CR>)
		      (T <TELL
"You'd enjoy it more if you turned on the radio." CR>)>)>>

	<OBJECT SCOTCH
		(IN LIQUOR-CABINET)
		(DESC "bottle of Scotch")
		(FDESC
"A half-filled bottle of Teacher's \"Highland Cream\" Scotch Whisky is
in the cabinet.")
		(ADJECTIVE SCOTCH TEACHER)
		(SYNONYM BOTTLE SCOTCH WHISKY WHISKEY)
		(FLAGS TAKEBIT CONTBIT)
		(ACTION LIQUOR-F)>

	<OBJECT BOURBON
		(IN LIQUOR-CABINET)
		(DESC "bottle of Bourbon")
		(FDESC
"A nearly-empty bottle of \"Jack Daniels\" Bourbon Whisky is in the
cabinet.")
		(ADJECTIVE BOURBON JACK DANIEL)
		(SYNONYM BOTTLE BOURBON WHISKY WHISKEY)
		(FLAGS TAKEBIT CONTBIT)
		(ACTION LIQUOR-F)>

<OBJECT DRINK
	(IN GLOBAL-OBJECTS)
	(DESC "drink")
	(SYNONYM DRINK COCKTAIL BELT)
	;(FLAGS TAKEBIT)
	(ACTION LIQUOR-F)>

<ROUTINE SEEKING-DRINK? ()
 <COND (<VERB? GIVE>
	<COND (<AND <IOBJ? PLAYER> <NOT <==? ,WINNER ,PLAYER>>>
	       <RTRUE>)>)
       (<VERB? SGIVE>
	<COND (<AND <DOBJ? PLAYER> <NOT <==? ,WINNER ,PLAYER>>>
	       <RTRUE>)>)
       (<VERB? ASK-FOR>
	<COND (<FSET? ,PRSO ,PERSON>
	       <RTRUE>)>)
       (<VERB? TAKE>
	<COND (<FIND-FLAG ,HERE ,PERSON>
	       <RTRUE>)
	      (<AND ,PRSI <FSET? ,PRSI ,PERSON>>
	       <RTRUE>)>)>>

<GLOBAL DRUNK-FLAG <>>
<ROUTINE LIQUOR-F ()
 <COND (<AND ,LINDER-FOLLOWS-YOU
	     <VERB? EXAMINE>>
	<TELL
"Linder is drinking something that looks like whisky, straight up." CR>)
       (<SEEKING-DRINK?>
	<COND (,DRUNK-FLAG <NO-DRINK> <RTRUE>)>
	<SETG DRUNK-FLAG T>
	<COND (<EQUAL? ,MONICA ,WINNER ,PRSO ,PRSI>
	       <TELL
"\"So you want to dip your beak? Go ahead.\"" CR>)
	      (T
	       <MOVE ,DRINK ,PLAYER>
	       <FSET ,DRINK ,TAKEBIT>
	       <TELL
"\"I think we both need one.\"  And so you both have one." CR>)>)
       (<OR <VERB? DRINK>
	    <AND <VERB? OPEN> <DOBJ? SCOTCH BOURBON>>>
	<COND (,DRUNK-FLAG <NO-DRINK> <RTRUE>)
	      (T
	       <SETG DRUNK-FLAG T>
	       <MOVE ,DRINK ,PLAYER>
	       <FSET ,DRINK ,TAKEBIT>
	       <TELL
"You take a belt of the stuff and roll it on your tongue before
swallowing. It's good whisky." CR>)>)>>

<ROUTINE NO-DRINK ()
	<TELL
"You could drink this stuff all night, but you have work to do." CR>>

<OBJECT CIGARETTE
	(IN GLOBAL-OBJECTS)
	(DESC "cigarette")
	(SYNONYM CIGARETTE SMOKE WEED CAMEL)
	(FLAGS LIGHTBIT)
	(SIZE 1)
	(ACTION CIGARETTE-F)>

<ROUTINE CIGARETTE-F ()
 <COND (<VERB? FIND SEARCH SEARCH-OBJECT-FOR>
	<TELL
"Like any hard-boiled police detective, you must have a pack on you
somewhere." CR>)
       (<VERB? EXAMINE>
	<COND (<EQUAL? ,HERE ,KITCHEN>
	       <TELL "Phong's cigarettes are Lucky Strikes." CR>)
	      (T <TELL "All you can see is an ashtray full of butts." CR>)>)
       (<VERB? SMOKE>
	<TELL
"You light up a Camel, take a deep drag, and watch the smoke drift
through the air. A few more puffs, and you're ready to go to work
again." CR>)
       (<OR <AND <VERB? GIVE TURN> <IOBJ? PLAYER> <NOT <==? ,WINNER ,PLAYER>>>
	    <AND <VERB? SGIVE>     <DOBJ? PLAYER> <NOT <==? ,WINNER ,PLAYER>>>
	    <AND <VERB? ASK-FOR> <FSET? ,PRSO ,PERSON>>
	    <AND <VERB? TAKE>
		 <OR <FIND-FLAG ,HERE ,PERSON ,WINNER> ;<NOT ,PRSI>
		     <FSET? ,PRSI ,PERSON>>>>
	<TELL
"\"I think we both need one.\" And so you both have one." CR>)>>

<OBJECT THREAT-NOTE
	(DESC "threatening note")
	(IN OFFICE-DESK)
	(ADJECTIVE HAND WRITTEN HAND-WRITTEN STILES THREAT)
	(SYNONYM NOTE ;LETTER ;HANDWR)
	(FLAGS TAKEBIT READBIT INVISIBLE)
	(SIZE 1)
	(TEXT
"The note is written in a spidery hand on fine rag paper. It says:|
\"Linder --|
Since Virginia died, I've lost too much sleep because of you and
your harrassments. The time has come to put this matter to rest
once and for all. I'll be seeing you sooner than you imagine.|
              -- Stiles\"")>

<OBJECT BROKEN-GLASS
	(IN LOCAL-GLOBALS)
	(DESC "pile of broken glass")
	(ADJECTIVE BROKEN)
	(SYNONYM PILE GLASS FRAGMENT SHARD)
	(FLAGS INVISIBLE TRYTAKEBIT NDESCBIT)
	(ACTION BROKEN-GLASS-F)>

<ROUTINE BROKEN-GLASS-F ()
 <COND (<VERB? TAKE>
	<TELL "You'd probably cut yourself on the sharp edges." CR>)>>

<OBJECT BROOM
	(IN STORAGE-CLOSET)
	(DESC "broom")
	(LDESC "A broom is standing in the corner.")
	(SYNONYM BROOM)
	(FLAGS TAKEBIT)
	;(ACTION BROKEN-GLASS-F)>

<OBJECT INSIDE-GUN
	(IN CLOCK)
	(DESC "hidden handgun")
	(ADJECTIVE NEW CLOCK HIDDEN HAND)
	(SYNONYM GUN HANDGUN PISTOL HEATER)
	(FLAGS TAKEBIT WEAPONBIT INVISIBLE)
	;(SIZE 2)
	(GENERIC GENERIC-GUN-F)
	(ACTION INSIDE-GUN-F)>

<OBJECT OUTSIDE-GUN
	(IN PHONG)
	(DESC "muddy handgun")
	(ADJECTIVE OLD MUDDY HAND)
	(SYNONYM GUN HANDGUN PISTOL HEATER)
	(FLAGS TAKEBIT WEAPONBIT INVISIBLE)
	;(SIZE 2)
	(GENERIC GENERIC-GUN-F)
	(ACTION OUTSIDE-GUN-F)>

<GLOBAL GUNS-MATCHED <>>
<ROUTINE INSIDE-GUN-F ()
 <COND (<AND <VERB? COMPARE>
	     <OR <DOBJ? OUTSIDE-GUN> <IOBJ? OUTSIDE-GUN>>>
	<COND (<==? ,P-ADVERB ,W?CAREFULLY>
	       <SETG GUNS-MATCHED T>
	       <TELL
"The two guns are virtually identical,"
" except that one has a very short barrel." CR>)
	      (T
	       <TELL
"The two guns appear to be very similar,"
" except that one has a very short barrel." CR>)>)
       (<VERB? EXAMINE ;ANALYZE ;FINGERPRINT>
	<TELL
"Y" "ou can see it's just a cheap low-quality handgun."
" The barrel is very short, as if someone sawed it off." CR>)
       (<VERB? OPEN>
	<TELL
"You open the gun, find no spare bullets inside, and close it again." CR>)
       (<VERB? SMELL>
	<TELL "It smells as though it's recently been fired." CR>)>>

<ROUTINE OUTSIDE-GUN-F ()
 <COND (<VERB? EXAMINE ;ANALYZE ;FINGERPRINT>
	<TELL
"The gun is muddy from the ground, but y"
"ou can see it's just a cheap low-quality handgun." CR>)
       (<VERB? OPEN>
	<TELL
"You open the gun, find no spare bullets inside, and close it again." CR>)
       (<VERB? SMELL>
	<TELL "It smells as though it's recently been fired." CR>)>>

<ROUTINE GENERIC-GUN-F (OBJ)
 <COND (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT ASK-FOR ASK-CONTEXT-FOR
	       FIND TELL-ME WHAT
	       GIVE SGIVE SEARCH-OBJECT-FOR TAKE>
	,GENERIC-GUN)
       (<EQUAL? <LOC ,PISTOL> ,PLAYER ,HERE> <RFALSE>)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "gun" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT GENERIC-GUN
	(IN GLOBAL-OBJECTS)
	(DESC "handgun")
	(SYNONYM $GNRC)>

<OBJECT GLOBAL-SHOT
	(IN GLOBAL-OBJECTS)
	(DESC "shot")
	(ADJECTIVE GUN)
	(SYNONYM SHOT GUNSHOT SHOOTING EXPLOSION)
	(FLAGS INVISIBLE)>

<GLOBAL LINDER-SAW-MEDICAL-REPORT <>>
<GLOBAL MONICA-SAW-MEDICAL-REPORT <>>
<GLOBAL DUFFY-SAW-MEDICAL-REPORT <>>
<OBJECT MEDICAL-REPORT
	(IN MONICA-ROOM)
	(DESC "medical report")
	(ADJECTIVE MEDICAL)
	(SYNONYM REPORT PAPER)
	(FLAGS TAKEBIT READBIT INVISIBLE)
	(SIZE 1)
	(TEXT
"After sifting through the medical officialese, you realize that the
report says that Linder has an advanced stomach tumor, and
that his death will come slowly and painfully.")>

<OBJECT AUTOPSY
	(IN GLOBAL-OBJECTS)
	(DESC "autopsy")
	(SYNONYM AUTOPSY)
	(FLAGS AN)>

<GLOBAL MONICA-SAW-CORONER-REPORT <>>

<OBJECT CLOCK-KEY
	(IN MONICA)
	(ADJECTIVE CLOCK)
	(SYNONYM KEY)
	(DESC "clock key")
	(FLAGS TAKEBIT ;NDESCBIT TOOLBIT INVISIBLE)
	(GENERIC GENERIC-KEY-F)
	(SIZE 1)>

<OBJECT PHONG-KEYS
	(IN PHONG)
	(ADJECTIVE ;PHONG HOUSE)
	(SYNONYM KEY KEYS SET)
	(DESC "set of house keys")
	(FLAGS TAKEBIT NDESCBIT TOOLBIT)
	(GENERIC GENERIC-KEY-F)
	(ACTION PHONG-KEYS-F)>

<ROUTINE PHONG-KEYS-F ()
 <COND (<OR <AND <VERB? GIVE> <IOBJ? PLAYER> <==? ,WINNER ,PHONG>>
	    <AND <VERB? TAKE> <IN? ,PHONG-KEYS ,PHONG>>>
	<COND (,PHONG-SEEN-CORPSE?
	       <MOVE ,PHONG-KEYS ,PLAYER>
	       <FCLEAR ,PHONG-KEYS ,NDESCBIT>
	       <TELL
"\"Here, you may as well take them. I don't see how Mr. Linder can
object now.\"" CR>)
	      (T <TELL
"\"I don't think Mr. Linder would like that.\"" CR>)>)>>

<ROUTINE GENERIC-KEY-F (OBJ)
 <COND (<VERB? ASK-ABOUT ASK-CONTEXT-ABOUT ASK-FOR ASK-CONTEXT-FOR
	       FIND TELL-ME WHAT
	       GIVE SGIVE SEARCH-OBJECT-FOR TAKE>
	,GENERIC-KEY)
       (<EQUAL? <LOC ,PHONG-KEYS> ,PLAYER ,HERE> <RFALSE>)
       (T
	<SETG P-WON <>>
	<TELL "(You can't see any " "key" " here!)" CR>
	,NOT-HERE-OBJECT)>>

<OBJECT GENERIC-KEY
	(IN GLOBAL-OBJECTS)
	(SYNONYM $GNRC)
	(DESC "key")>

<OBJECT HANDWRITING
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDWRITING WRITING)
	(DESC "handwriting")
	(ACTION HANDWRITING-F)>

<ROUTINE HANDWRITING-F ()
 <COND (<AND <VERB? ANALYZE> <DOBJ? HANDWRITING> <NOT ,PRSI>
	     <EQUAL? ,PLAYER <LOC ,MATCHBOOK> <LOC ,THREAT-NOTE>>>
	<TELL "You didn't say what to analyze the handwriting on." CR>)>>

<OBJECT GLOBAL-FINGERPRINTS
	(IN GLOBAL-OBJECTS)
	(SYNONYM FINGERPRINT)
	(DESC "fingerprints")
	(ACTION GLOBAL-FINGERPRINTS-F)>

<ROUTINE GLOBAL-FINGERPRINTS-F ()
	 <COND (<AND <VERB? TAKE> <==? ,PRSO ,GLOBAL-FINGERPRINTS>>
		<COND (<NOT ,PRSI>
		       <TELL
"You didn't say what to take the fingerprints from." CR>)
		      (T
		       <PERFORM ,V?FINGERPRINT ,PRSI>
		       <RTRUE>)>)>>

"Global objects"

<OBJECT GLOBAL-MURDER
	(IN GLOBAL-OBJECTS)
	(DESC "murder")
	(SYNONYM MURDER KILLING CRIME)>

<OBJECT GLOBAL-SUICIDE
	(IN GLOBAL-OBJECTS)
	(DESC "suicide")
	(ADJECTIVE LATE MRS LINDER MOTHER VIRGINIA HER)
	(SYNONYM SUICIDE)
	(ACTION GLOBAL-SUICIDE-F)>

<ROUTINE GLOBAL-SUICIDE-F ("AUX" STR)
	 <COND (<AND <VERB? FIND> <NOT <EQUAL? ,WINNER ,PLAYER>>>
		<TELL "\"She shot herself in the bathtub.\"" CR>)>>

<OBJECT RANDOM-CRIME
	(IN GLOBAL-OBJECTS)
	(DESC "other crime")
	(FLAGS AN)
	(ADJECTIVE OTHER MERCY)
	(SYNONYM CRIME KILLING CONSPIRACY EUTHANASIA)>

<OBJECT GLOBAL-PTA
	(IN GLOBAL-OBJECTS)
	(DESC "Pacific Trade Associates")
	(ADJECTIVE PACIFIC TRADE)
	(SYNONYM ASSOCIATES COMPANY PTA BUSINESS)>

<OBJECT DANGER
	(IN GLOBAL-OBJECTS)
	(DESC "danger")
	(SYNONYM DANGER THREAT WRONG PROBLEM)>

<OBJECT GLOBAL-WEATHER
	(IN GLOBAL-OBJECTS)
	(DESC "weather")
	(SYNONYM WEATHER CLIMATE)>

<OBJECT TELEPHONE
	(IN LOCAL-GLOBALS)
	(DESC "telephone")
	(SYNONYM TELEPHONE PHONE RECEIVER)
	(FLAGS TRYTAKEBIT)
	(ACTION TELEPHONE-F)>

<ROUTINE TELEPHONE-F ()
 <COND (<VERB? PHONE>
	<TELL
"You should type what number to call, for example \"DIAL HYACINTH
1031.\"" CR>)
       (<VERB? REPLY> <TELL "Don't bother unless it rings." CR>)
       (<VERB? RAISE TAKE>
	<TELL "You lift the receiver and get a dial tone. Well done!" CR>)>>

<OBJECT CORONER
	(IN GLOBAL-OBJECTS)
	(DESC "coroner")
	(SYNONYM CORONER DOCTOR AMBULANCE MORGUE ;POLICE)
	(ACTION CORONER-F)>

<ROUTINE CORONER-F ()
 <COND (<AND <VERB? PHONE> <PHONE-IN? ,HERE>>
	<COND (<PROB 69>
	       <TELL
"You dial the number and wait a long time for someone to answer.
Finally you hear a voice: \"We're awful busy here. Call back in ten
minutes.\" He hangs up before you can say a word." CR>)
	      (T <TELL "You dial the number and get a busy signal." CR>)>)>>

<OBJECT BUTTON
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE BUTLER)
	(SYNONYM BUTTON)
	(DESC "butler's button")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<ROUTINE BUTTON-F ()
 <COND (<==? ,HERE ,FRONT-PORCH>
	<COND (<IOBJ? BUTTON> <PERFORM ,PRSA ,PRSO ,DOORBELL> <RTRUE>)
	      (<DOBJ? BUTTON> <PERFORM ,PRSA ,DOORBELL ,PRSI> <RTRUE>)>
	<RFALSE>)
       (<OUTSIDE? ,HERE>
	<TELL "There's no button here." CR>)
       (<VERB? PUSH RING>
	<COND (<IN? ,PHONG ,HERE>
	       <TELL
"Phong looks annoyed. \"You needn't ring for me. I'm right here.\"" CR>)
	      (T
	       <YOU-RANG>
	       <TELL "You barely hear a bell ring in the distance." CR>)>)>>

<ROUTINE YOU-RANG ()
	 <COND (<NOT <GET <GET ,GOAL-TABLES ,PHONG-C> ,GOAL-S>>
		<SETG PHONG-CALLED T>
		<SETG PHONG-OLD-LOC <LOC ,PHONG>>
		<ESTABLISH-GOAL ,PHONG ,HERE>)>>

<OBJECT BLACK-WIRE
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE BLACK)
	(SYNONYM WIRE WIRES)
	(DESC "black wire")
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WIRE-F)
	(ACTION BLACK-WIRE-F)>

<ROUTINE BLACK-WIRE-F ()
 <COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
	<TELL "There's no wire here." CR>)
       (<AND <DOBJ? WHITE-WIRE>
	     <NOT <EQUAL? ,HERE ,WORKSHOP>>
	     <NOT <WINDOW-IN? ,HERE>>>
	<TELL "There's no white wire here." CR>)
       (<VERB? EXAMINE>
	<COND (<DOBJ? BLACK-WIRE>
	       <COND (<EQUAL? ,HERE ,WORKSHOP>
		      <TELL
"You can see several kinds of " "black" " wire on spools, not to mention the
snarl in the junction box." CR>)
		     (T <TELL
"A pair of black wires goes from the butler's button into the floor." CR>)>)
	      (<EQUAL? ,HERE ,WORKSHOP>
	       <TELL
"You can see several kinds of " "white" " wire on spools, not to mention the
snarl in the junction box." CR>)
	      (T <TELL
"A pair of white wires goes from some sort of electric switch on the "
<COND (<EQUAL? ,HERE ,ENTRY ,GARAGE> "door") (T "sash")>
" into the frame." CR>)>)
       (<VERB? FOLLOW>
	<COND (<DOBJ? BLACK-WIRE>
	       <TELL "The wire goes into the floor and disappears." CR>)
	      (<EQUAL? ,HERE ,WORKSHOP>
	       <TELL "It just goes around and around the spools." CR>)
	      (T
	       <TELL "The wire goes into the wall and disappears." CR>)>)
       (<VERB? TAKE>
	<TELL "You don't really want to do that." CR>)>>

<OBJECT WHITE-WIRE
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE WHITE)
	(SYNONYM WIRE WIRES)
	(DESC "white wire")
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WIRE-F)
	(ACTION BLACK-WIRE-F)>

<OBJECT GLOBAL-AFFAIR
	(IN GLOBAL-OBJECTS)
	(DESC "love affair")
	(ADJECTIVE LOVE VIRGINIA STILES)
	(SYNONYM AFFAIR)>

<OBJECT MUDDY-SHOES
	(IN SHOE-PLATFORM)
	(DESC "pair of muddy boots")
	(ADJECTIVE MUDDY DIRTY ADOBE GARDEN)
	(SYNONYM BOOT BOOTS PAIR MUD)
	(FLAGS TAKEBIT NDESCBIT INVISIBLE)
	(ACTION MUDDY-SHOES-F)>

<ROUTINE MUDDY-SHOES-F ()
 <COND (<AND <VERB? COMPARE PUT>
	     <OR <DOBJ? BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>
		 <IOBJ? BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>>>
	<TELL
"The boots don't seem to match " ;"the plaster cast of "
"the foot prints that you found in the " "back yard." CR>)
       (<AND <VERB? COMPARE PUT>
	     <OR <DOBJ? SIDE-FOOTPRINTS SIDE-FOOTPRINTS-CAST>
		 <IOBJ? SIDE-FOOTPRINTS SIDE-FOOTPRINTS-CAST>>>
	<COND (<OR <VERB? PUT> <==? ,P-ADVERB ,W?CAREFULLY>>
	       <SETG SIDE-FOOTPRINTS-MATCHED T>
	       <TELL
"The boots and the foot prints match each other perfectly." CR>)
	      (T
	       <TELL
"The boots appear to be similar to " ;"the plaster cast of "
"the foot prints that you found in the " "side yard." CR>)>)
       (<VERB? EXAMINE>
	<TELL
"They're just ordinary gardening boots, with some fresh adobe mud around the
bottom." CR>)
       (<VERB? TAKE>
	<FCLEAR ,MUDDY-SHOES ,NDESCBIT>
	<RFALSE>)>>

<OBJECT CHAIR
	(IN LOCAL-GLOBALS)
	(DESC "chair")
	(SYNONYM CHAIR CHAIRS)
	(FLAGS NDESCBIT FURNITURE)>

<OBJECT LAMP
	(IN LOCAL-GLOBALS)
	(DESC "lamp")
	(SYNONYM LAMP)
	(FLAGS NDESCBIT FURNITURE ONBIT)>

<OBJECT BED
	(IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT FURNITURE VEHBIT)
	(CAPACITY 30)
	(ACTION BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG 100))
	 <COND (<NOT <==? .RARG 100>> <RFALSE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE LOOK-ON>
		     <==? ,HERE ,MONICA-ROOM>
		     <IN? ,MONICA ,MONICA-ROOM>>
		<TELL "Monica is lying on her bed, softly sobbing." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"If you wanted to find the bogey man, you're out of luck." CR>)>>

<OBJECT GLOBAL-CALL
	(IN GLOBAL-OBJECTS)
	(DESC "telephone call")
	(ADJECTIVE TELEPHONE PHONE)
	(SYNONYM CALL ;CONVERSATION LEFT RIGHT)
	(ACTION GLOBAL-CALL-F)>

<ROUTINE GLOBAL-CALL-F ()
 <COND (<VERB? TURN WALK>
	<TELL "(Use compass directions to move around here.)" CR>)>>

<OBJECT MONEY
	(IN GLOBAL-OBJECTS)
	(SYNONYM MONEY LOOT PAYOFF BRIBE)
	(DESC "money")
	;(ACTION MONEY-F)>

<OBJECT WILL
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE LINDER HIS)
	(SYNONYM WILL TESTAMENT)
	(DESC "Linder's will")>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")
	;(ACTION INTNUM-F)>

<OBJECT TUMOR
	(IN GLOBAL-OBJECTS)
	(DESC "tumor")
	(FLAGS INVISIBLE)
	(ADJECTIVE ADVANCED STOMACH)
	(SYNONYM TUMOR TUMOUR CANCER CARCINOMA)>

<OBJECT CORPSE
	(IN OFFICE ;CARVED-CHAIR)
	(DESC "body of Mr. Linder")
	(ADJECTIVE MR BLOODY)
	(SYNONYM BODY LINDER CORPSE WOUND ;STIFF)
	(FLAGS INVISIBLE TAKEBIT ;NDESCBIT)
	(SIZE 101)
	(DESCFCN CORPSE-F)
	(ACTION CORPSE-F)>

<ROUTINE CORPSE-F ("OPTIONAL" (ARG <>)
		   "AUX" (T <- ,PRESENT-TIME ,MURDER-TIME>))
 <COND (<==? .ARG ,M-OBJDESC>
	<TELL
"The body of Mr. Linder is still crumpled in a heap on the floor." CR>
	<RTRUE>)
       (<AND <VERB? ANALYZE> <DOBJ? CORPSE>>
	<COND (<IOBJ? TUMOR> <SETG DUFFY-SAW-MEDICAL-REPORT T>)>
	<TELL "Only the coroner can do that." CR>)
       (<AND <VERB? ARREST> <DOBJ? CORPSE>> <ARREST ,GLOBAL-LINDER>)
       (<AND <VERB? ASK-ABOUT ASK-FOR TELL PHONE $CALL> <DOBJ? CORPSE>>
	<TELL "Talking to corpses will get you nowhere." CR>
	,M-FATAL)
       (<AND <VERB? TAKEOUT>	;"TAKE CORPSE OUTSIDE"
	     <IOBJ? OFFICE-BACK-DOOR MONICA-BACK-DOOR LINDER-BACK-DOOR>>
	<TELL "You can't move" THE-PRSO "." CR>)
       (<VERB? TIE-TO TIE-WITH>
	<TELL "Don't tell me you think the body's going to run away!" CR>)
       (<VERB? EXAMINE RUB>
	<COND (<L? .T 10>
	       <TELL
"The blood is still spreading on Linder's shirt." CR>)
	      (<L? .T 60>
	       <TELL
"The blood on Linder's shirt has clotted and turned dark." CR>)
	      (<L? .T 180>
	       <TELL
"Linder's body is getting stiff." CR>)
	      (T <TELL
"The corpse is pretty stiff now." CR>)>)>>

<OBJECT TODAY
	(IN GLOBAL-OBJECTS)
	(DESC "today")
	(SYNONYM TODAY DATE DAY)
	(ACTION TODAY-F)>

<OBJECT GLOBAL-WARRANT
	(IN GLOBAL-OBJECTS)
	(DESC "search warrant")
	(ADJECTIVE SEARCH)
	(SYNONYM WARRANT)
	(ACTION GLOBAL-WARRANT-F)>

<ROUTINE GLOBAL-WARRANT-F ()
	 <COND (<VERB? TAKE FIND>
		<TELL
"Knowing the courts, it would probably take days to get one." CR>)>>

<OBJECT STUB
	(DESC "ticket stub")
	(ADJECTIVE TICKET)
	(SYNONYM TICKET STUB)
	(FLAGS TAKEBIT READBIT)
	(FDESC "Lying on the ground is what appears to be a ticket stub.")
	(ACTION STUB-F)>

<ROUTINE STUB-F ()
	<COND (<VERB? EXAMINE READ>
	       <PUT 0 8 <BOR <GET 0 8> 2>>
	       <TELL
"|
   #570716|
|
BIJOU THEATRE|
|
  ADMIT ONE|
|
   25 CENTS|
|
-^-^-^-^-^-^-|
" CR>
	       <PUT 0 8 <BAND <GET 0 8> -3>>
	       <RTRUE>)>>

<OBJECT GLOBAL-WATER
	(IN GLOBAL-OBJECTS)
	(DESC "water")
	(SYNONYM WATER)>

<OBJECT MIRROR
	(IN LOCAL-GLOBALS)
	(DESC "mirror")
	(SYNONYM MIRROR)
	(FLAGS NDESCBIT)
	(ACTION MIRROR-F)>

<ROUTINE MIRROR-F ()
	 <COND (<VERB? MUNG>
		<TELL
"According to superstition, it's bad luck to break mirrors." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"A harried and weary police detective looks back at you, with a
look that seems to say, \"Look what the cat dragged in.\"" CR>)>>

<OBJECT CLOSET
	(IN LOCAL-GLOBALS)
	(DESC "closet")
	(SYNONYM CLOSET)
	(FLAGS NDESCBIT CONTBIT ;OPENBIT FURNITURE)
	(ACTION CLOSET-F)>

<ROUTINE CLOSET-F ()
 <COND (<AND <NOT <EQUAL? ,HERE ,MONICA-ROOM ,LINDER-ROOM ,BUTLER-ROOM>>
	     <NOT <EQUAL? ,HERE ,ENTRY>>>
	<SETG P-WON <>>
	<TELL "(You can't see any " "closet" " here!)" CR>)
       (<VERB? EXAMINE LOOK-INSIDE SEARCH OPEN>
	<TELL
"You open the closet and find a bunch of stylish clothes, but nothing
in your size." CR>)
       (<VERB? THROUGH>
	<TELL "The closet's too crowded to get in." CR>)>>

<OBJECT CABINET
	(IN LOCAL-GLOBALS)
	(DESC "cabinet")
	(SYNONYM CABINET)
	;(ACTION CUPBOARD-F)>

<OBJECT GLOBAL-CAN-OF-WORMS
	(IN GLOBAL-OBJECTS)
	(DESC "can of worms")
	(SYNONYM CAN WORM WORMS)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION GLOBAL-CAN-OF-WORMS-F)>

<ROUTINE GLOBAL-CAN-OF-WORMS-F ()
	 <COND (<EQUAL? ,PHONG ,PRSO ,WINNER> <RFALSE>)
	       (<VERB? FIND>
		<TELL "In a sense, they're all around you!" CR>)
	       (<VERB? WHAT>
		<TELL "That would be telling!" CR>)
	       (<EQUAL? ,HERE ,KITCHEN>
		<TELL "This case is tangled enough already." CR>)>>

<OBJECT RANDOM-MEAL
	(DESC "meal")
	(IN GLOBAL-OBJECTS)
	(SYNONYM MEAL DINNER BREAKFAST SNACK)
	(ACTION RANDOM-MEAL-F)>

<ROUTINE RANDOM-MEAL-F ()
	 <COND (<VERB? ASK-ABOUT ASK-FOR EAT FIND>
		<TELL
"The blue-plate special at the diner was enough for you." CR>)
	       (T ;<VERB? EXAMINE>
		<TELL "What a strange notion!" CR>)>>

<OBJECT GLOBAL-HOUSE
	(IN GLOBAL-OBJECTS)
	(DESC "house")
	(SYNONYM HOUSE)
	(ACTION GLOBAL-HOUSE-F)>

<ROUTINE GLOBAL-HOUSE-F ()
	 <COND (<VERB? WALK-AROUND>
		<TELL
"(Use compass directions to move around here.)" CR>)>>

<OBJECT GLOBAL-FILM
	(IN GLOBAL-OBJECTS)
	(DESC "film")
	(SYNONYM FILM MOVIE SHOW)
	;(ACTION FILM-F)>

<GLOBAL FILM-SEEN <>>
