"VERBS for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

;<GLOBAL COPR-NOTICE
" a transcript of interaction with WITNESS.|
WITNESS is a registered trademark of Infocom, Inc.|
Copyright (c) 1983 Infocom, Inc.  All rights reserved.">

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" " a transcript of interaction with ">
	<V-VERSION>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" " a transcript of interaction with ">
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE V-$VERIFY ()
	 <TELL "Verifying disk..." CR>
	 <COND (<VERIFY> <TELL "The disk is correct." CR>)
	       (T <TELL CR "** Disk Failure **" CR>)>>

"
<ROUTINE V-$WHEN ('AUX' (CNT 0) O L NUM RM)
 <REPEAT ()
  <COND (<G? <SET CNT <+ .CNT 1>> ,CHARACTER-MAX>
	 <RETURN>)
	(<SET O <GET ,CHARACTER-TABLE .CNT>>
	 <SET L <GET ,MOVEMENT-GOALS .CNT>>
	 <REPEAT ()
	  <COND (<0? <SET NUM <GET .L ,MG-TIME>>> <RETURN>)
		(<SET RM <GET .L 3>>
		 <TELL D .O ' will go in ' N .NUM ' minutes to'>
		 <THE? .RM>
		 <TELL ' ' D .RM '.' CR>
		 <SET L <REST .L ,MG-LENGTH>>)>>)>>>
"

<ROUTINE V-$TANDY ("AUX" X MSG)
	<COND (<NOT ,DEBUG>
	       <SET MSG <PICK-ONE ,UNKNOWN-MSGS>>
	       <TELL <GET .MSG 0> "$ta" <GET .MSG 1> CR>
	       <RTRUE>)>
	<SET X <GETB 0 1>>
	<COND (<==? <BAND .X 8> 0>
	       <PUTB 0 1 <BOR .X 8>>
	       <TELL "[on]" CR>)
	      (T
	       <PUTB 0 1 <BAND .X -9>>
	       <TELL "[off]" CR>)>>

<ROUTINE V-$WHERE ("AUX" (CNT 0) O L MSG)
 <COND (<NOT ,DEBUG>
	<SET MSG <PICK-ONE ,UNKNOWN-MSGS>>
	<TELL <GET .MSG 0> "$whr" <GET .MSG 1> CR>)
       (,PRSI <MOVE ,PRSI ,PRSO>)
       (,PRSO <GOTO ,PRSO>)
       (T
	 <REPEAT ()
		 <COND (<SET O <GET ,CHARACTER-TABLE .CNT>>
			<SET L <LOC .O>>
			<TELL D .O " is ">
			<COND (.L <TELL "in"> <THE? .L> <TELL " " D .L "."CR>)
			      (T  <TELL "nowhere." CR>)>)>
		 <COND (<G? <SET CNT <+ .CNT 1>> ,CHARACTER-MAX>
			<RETURN>)>>)>>

<GLOBAL DEBUG <>>
<ROUTINE V-DEBUG ("AUX" MSG)
	 <COND (<SETG DEBUG <NOT ,DEBUG>>
		<TELL "Find them bugs, boss!" CR>)
	       (T <TELL "No bugs left, eh?" CR>)>>

""

"ZORK game commands"

<CONSTANT DIFFICULTY-MAX 2>
<GLOBAL DIFFICULTY 0>

"
<ROUTINE V-EASIER ()
 <COND (<0? ,DIFFICULTY>
	<TELL 'If this were any easier, there'd be no mystery!' CR>)
       (T <SETG DIFFICULTY <- ,DIFFICULTY 1>>
	<TELL 'O.K., let's see if you can handle it now.' CR>)>
 <COND (<0? ,DIFFICULTY>
	<COND (<IN? ,BROOM ,STORAGE-CLOSET> <MOVE ,BROOM ,OFFICE>)>
	<MOVE ,BROKEN-GLASS ,OFFICE-PORCH>)
       (<1? ,DIFFICULTY> <MOVE ,BROKEN-GLASS ,LOCAL-GLOBALS>)
       (<RTRUE>)>>

<ROUTINE V-HARDER ()
 <COND (<==? ,DIFFICULTY ,DIFFICULTY-MAX>
	<TELL 'If this were any harder, you'd never solve it!' CR>)
       (T <SETG DIFFICULTY <+ ,DIFFICULTY 1>>
	<TELL 'O.K., let's see how you handle it now.' CR>)>
 <COND (<NOT <0? ,DIFFICULTY>>
	<COND (<IN? ,BROOM ,OFFICE> <MOVE ,BROOM ,STORAGE-CLOSET>)>)
       (<1? ,DIFFICULTY> <MOVE ,BROKEN-GLASS ,LOCAL-GLOBALS>)
       (<==? ,DIFFICULTY ,DIFFICULTY-MAX> <MOVE ,BROKEN-GLASS ,OFFICE>)
       (<RTRUE>)>>
"

"SUBTITLE SETTINGS FOR VARIOUS LEVELS OF DESCRIPTION"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <SETG P-SPACE 1>
	 <TELL "(O.K., you will get " "brief" " descriptions.)" CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <SETG P-SPACE 0>
	 <TELL
"(O.K., you will get " "super-brief descriptions. Remember that objects and
people won't be described, only the name of the place you are entering.)" CR>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <SETG P-SPACE 1>
	 <TELL "(O.K., you will get " "verbose" " descriptions.)" CR>>

<GLOBAL P-SPACE 1>

<ROUTINE V-SPACE ()
	 <SETG P-SPACE 1>
	 <TELL
"(O.K., you will now see a space before each input line.)" CR>>

<ROUTINE V-UNSPACE ()
	 <SETG P-SPACE 0>
	 <TELL
"(O.K., you will not see a space before each input line.)" CR>>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<ROUTINE V-TIME ()
	 <TELL "It's now ">
	 <TIME-PRINT ,PRESENT-TIME>
	 <CRLF>>

<ROUTINE TIME-PRINT (NUM "AUX" HR (AM <>))
	 #DECL ((NUM HR) FIX (AM) <OR FALSE ATOM>)
	 <COND (<G? <SET HR </ .NUM 60>> 12>
		<SET HR <- .HR 12>>
		<SET AM T>)
	       (<==? .HR 12> <SET AM T>)>
	 <PRINTN .HR>
	 <TELL ":">
	 <COND (<L? <SET HR <MOD .NUM 60>> 10>
		<TELL "0">)>
	 <TELL N .HR " ">
	 <TELL <COND (.AM "a.m.") (T "p.m.")>>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 #DECL ((ASK?) <OR ATOM <PRIMTYPE LIST>> (SCOR) FIX)
	 <COND (<OR <AND .ASK?
			 <TELL
"(If you want to continue from this point at another time, you must
\"SUSPEND\" first.) Do you want to " "stop your investigation now?">
			 <YES?>>
		    <NOT .ASK?>>
		<COND (,TOO-LATE <TOO-LATE-F>)>
		<QUIT>)
	       (ELSE <TELL "O.K." CR>)>>

<ROUTINE V-RESTART ()
	 <TELL
"Do you wish to restart your investigation?">
	 <COND (<YES?>
		<RESTART>
		<TELL "Your original" " status couldn't be restored."
" Consult your instruction manual" ;"Nat'l Detective Gazette" " if necessary."
CR>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "O.K." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Your previous" " status couldn't be restored."
" Consult your instruction manual" ;"Nat'l Detective Gazette"
" or Reference Card" " if necessary."
CR>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF> <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "O.K." CR>)
	       (T
		<TELL "Your story couldn't be suspended."
" Consult your instruction manual" ;"Nat'l Detective Gazette"
" or Reference Card" " if necessary."
CR>)>>

<ROUTINE TANDY? () <NOT <==? <BAND <GETB 0 1> 8> 0>>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"The WITNESS
Infocom interactive fiction - a mystery story|
Copyright (c) 1983 by Infocom, Inc.  All rights reserved.|
">
	 ;<COND (<TANDY?>
		<TELL "Licensed to Tandy Corporation." CR>)>
	 <TELL "The WITNESS is a registered trademark of Infocom, Inc.|
Release number ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE YES? ()
	 <PRINTI " (Answer YES or NO.) >">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<0? <GETB ,P-LEXV ,P-LEXWORDS>>
		<RFALSE>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

""

"SUBTITLE - GENERALLY USEFUL ROUTINES & CONSTANTS"

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)>
	 <COND (<FSET? .OBJ ,PERSON> <THIS-IS-S-HE .OBJ>)
	       (T <THIS-IS-IT .OBJ>)>
	 <COND (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<COND (<FSET? .OBJ ,PERSON>
		       <TELL D .OBJ " is here.">)
		      (T
		       <TELL "There's "
			     <COND (<FSET? .OBJ ,AN> "an ")
				   (T "a ")>
			     D .OBJ " here.">)>)
	       (ELSE
		<TELL <GET ,INDENTS .LEVEL>>
		<COND (<FSET? .OBJ ,PERSON>
		       <TELL D .OBJ>)
		      (T
		       <TELL <COND (<FSET? .OBJ ,AN> "an ")
				   (T "a ")>
			     D .OBJ>)>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside"> <THE? .AV> <TELL " " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
 <COND (,LIT
	<COND (<FIRST? ,HERE>
	       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
       (ELSE
	<TELL "You can't see anything in the dark." CR>)>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? (F? <>) STR L)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>
		<SET F? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<COND (,P-PROMPT
		       <TELL "You are now "
			     <COND (<FSET? ,HERE ,ON-NOT-IN> "on")
				   (T "in")>>
		       <THE? ,HERE>
		       <TELL " " D ,HERE "." CR>)
		      (T
		       <TELL "(" D ,HERE ")" CR>)>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET L ,PLAYER-HIDING>
		<COND (.L
		       <TELL "(You are hiding behind">
		       <THE? .L>
		       <TELL " " D .L ".)" CR>)
		      (<FSET? <SET L <LOC ,WINNER>> ,VEHBIT>
		       <TELL "(You are ">
		       <COND (<FSET? .L ,SURFACEBIT>
			      <TELL "sitting o">)
			     (T <TELL "standing i">)>
		       <TELL "n">
		       <THE? .L>
		       <TELL " " D .L ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?FDESC>>>
		       <TELL .STR CR>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<NOT <==? ,HERE .L>>
		       <APPLY <GETP .L ,P?ACTION> ,M-LOOK>)>)>
	 <COND (<GETP ,HERE ,P?CORRIDOR> <CORRIDOR-LOOK>)>
	 T>

"Lengths:"
<CONSTANT UEXIT 1> "Uncondl EXIT:(dir TO rm)		 = rm"
<CONSTANT NEXIT 2> "Non EXIT:	(dir string)		 = str-ing"
<CONSTANT FEXIT 3> "Fcnl EXIT:  (dir PER rtn)		 = rou-tine, 0"
<CONSTANT CEXIT 4> "Condl EXIT:	(dir TO rm IF f)	 = rm, f, str-ing"
<CONSTANT DEXIT 5> "Door EXIT: (dir TO rm IF dr IS OPEN) = rm, dr, str-ing, 0"

<CONSTANT REXIT 0>
<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>	"GETB"
<CONSTANT CEXITSTR 1>	"GET"
<CONSTANT DEXITOBJ 1>	"GETB"
<CONSTANT DEXITSTR 1>	"GET"

<GLOBAL FINGERPRINT-OBJ <>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<==? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on">
		       <THE? .OBJ>
		       <TELL " " D .OBJ " can be seen:" CR>)
		      (<FSET? .OBJ ,PERSON>
		       <TELL D .OBJ " is holding:" CR>)
		      (ELSE
		       <TELL "The " D .OBJ
			     " contains:" CR>)>)>>

<ROUTINE GONE-CRAZY ()
	 <TELL
"You vaguely hear screaming and yelling through a haze of confusion and
the tugs of your conscience asking \"How could you have done it?\"
Before you can answer, you hear police sirens come near. Sergeant Duffy
and two others enter and grab you by the arms. They take you to a
waiting car, where, forlorn and disgusted, you think about being sent up
for life. \"Maybe,\" you think, \"I shouldn't have done that.\"" CR>
	 <CASE-OVER>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" F WT)
	 #DECL ((RM) OBJECT)
	<WHERE-UPDATE ,PLAYER>
	<MOVE ,PLAYER .RM>
	<SETG HERE .RM>
	<SETG LIT T>
	<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	<COND (.V? <V-FIRST-LOOK>)>>

<ROUTINE HACK-HACK (STR)
 <COND (<IN? ,PRSO ,GLOBAL-OBJECTS>
	<SETG P-WON <>>
	<TELL "(You can't see any" PRSO " here.)" CR>)
       (T
	<TELL .STR THE-PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<PLTABLE
	 " doesn't help."
	 " has no effect.">>

<ROUTINE HELD? (OBJ)
	 <REPEAT ()
		 <COND (<NOT <LOC .OBJ>> <RFALSE>)
		       (<EQUAL? <LOC .OBJ> ,ROOMS ,GLOBAL-OBJECTS> <RFALSE>)
		       (<IN? .OBJ ,WINNER> <RTRUE>)
		       (T <SET OBJ <LOC .OBJ>>)>>>

<ROUTINE IDROP ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL D ,PRSO " wouldn't enjoy that." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying" THE-PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "Too bad, but" THE-PRSO " is closed."CR>
		<RFALSE>)
	       (T <MOVE ,PRSO ,HERE ;<LOC ,WINNER>> <RTRUE>)>>

<GLOBAL INDENTS
	<PTABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

<GLOBAL FUMBLE-NUMBER 7>
<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL "You can't take" THE-PRSO "." CR>)>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load's too heavy">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			  <TELL ", especially in light of your condition.">)
			     (ELSE <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<SET OBJ <FIRST? ,WINNER>>
		<SET OBJ <NEXT? .OBJ>>
		<TELL "Too bad, but">
		<THE? .OBJ>
		<TELL " " D .OBJ
		      " slips from your arms while you are taking"
		      THE-PRSO
		      ", and both tumble to the ">
		<COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
		       <TELL "ground">)
		      (T <TELL "floor">)>
		<TELL "." CR>
		<MOVE .OBJ ,HERE>	;<PERFORM ,V?DROP .OBJ>
		<MOVE ,PRSO ,HERE>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<FCLEAR ,PRSO ,INVISIBLE>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<SET CNT <+ .CNT 1>>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

<ROUTINE NOT-HERE (OBJ)
	 <SETG P-WON <>>
	 <TELL "(You can't see">
	 <THE? .OBJ>
	 <TELL " " D .OBJ " here.)" CR>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV (STR <>) (PV? <>) (INV? <>))
	#DECL ((OBJ) OBJECT (LEVEL) FIX)
 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
	T)
       (ELSE <SET AV <>>)>
 <SET 1ST? T>
 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
	<SET INV? T>)
       (ELSE
	<REPEAT ()
	 <COND (<NOT .Y> <RETURN <NOT .1ST?>>)
	       (<==? .Y .AV> <SET PV? T>)
	       (<==? .Y ,WINNER>)
	       (<AND %<COND (<GASSIGNED? PREDGEN>'<NOT <FSET? .Y ,INVISIBLE>>)
			    (T '<OR <NOT <FSET? .Y ,INVISIBLE>>
				    <AND ,DEBUG <TELL "[invisible] ">>>)>
		     <NOT <FSET? .Y ,TOUCHBIT>>
		     <OR ;<APPLY <GETP .Y ,P?DESCFCN> ,M-OBJDESC>
			 <SET STR <GETP .Y ,P?FDESC>>>>
		<COND (<OR <NOT <FSET? .Y ,NDESCBIT>>
			   <AND ,DEBUG <TELL "[ndescbit] ">>>
		       <SET 1ST? <>>
		       <SET LEVEL 0>
		       <COND (.STR
			      <TELL .STR CR>
			      <SET STR <>>
			      <COND (<FSET? .Y ,PERSON> <THIS-IS-S-HE .Y>)
				    (T <THIS-IS-IT .Y>)>)>)>
		<COND (<AND <SEE-INSIDE? .Y>
			    <NOT <GETP <LOC .Y> ,P?DESCFCN>>
			    <FIRST? .Y>>
		       <PRINT-CONT .Y .V? 0>)>)>
	 <SET Y <NEXT? .Y>>>)>
 <SET Y <FIRST? .OBJ>>
 <REPEAT ()
	 <COND (<NOT .Y>
		<COND (<AND .PV? .AV <FIRST? .AV>>
		       <PRINT-CONT .AV .V? .LEVEL>)>
		<RETURN <NOT .1ST?>>)
	       (<EQUAL? .Y .AV ,PLAYER>)
	       (<AND %<COND (<GASSIGNED? PREDGEN>'<NOT <FSET? .Y ,INVISIBLE>>)
			    (T '<OR <NOT <FSET? .Y ,INVISIBLE>>
				    <AND ,DEBUG <TELL "[invisible] ">>>)>
		     <OR .INV?
			 <FSET? .Y ,TOUCHBIT>
			 <NOT <GETP .Y ,P?FDESC>>>>
		<COND (<OR <NOT <FSET? .Y ,NDESCBIT>>
			   <AND ,DEBUG <TELL "[ndescbit] ">>>
		       <COND (.1ST?
			      <COND (<FIRSTER .OBJ .LEVEL>
				     <COND (<L? .LEVEL 0> <SET LEVEL 0>)>)>
			      <SET LEVEL <+ 1 .LEVEL>>
			      <SET 1ST? <>>)>
		       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
		      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
		       <PRINT-CONT .Y .V? .LEVEL>)>)>
	 <SET Y <NEXT? .Y>>>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T))
	 #DECL ((OBJ) OBJECT (F N) <OR FALSE OBJECT>)
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<COND (<FSET? .F ,PERSON>
			       <TELL D .F>)
			      (T
			       <TELL <COND (<FSET? .F ,AN> "an ")
					   (T "a ")>
				     D .F>)>
			<COND (<FSET? .F ,PERSON> <THIS-IS-S-HE .F>)
			      (T <THIS-IS-IT .F>)>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>>

<GLOBAL QCONTEXT <>>
<GLOBAL QCONTEXT-ROOM <>>

<ROUTINE ROOM-CHECK ()
	 <COND (<IN? ,PRSO ,ROOMS>
		<COND (<EQUAL? ,PRSO ,HERE ,GLOBAL-HERE>
		       <PERFORM ,PRSA ,GLOBAL-ROOM ,PRSI>
		       <RTRUE>)
		      ;(<DOBJ? DRIVEWAY> <RFALSE>)
		      (T
		       <TELL "You aren't in that place!" CR>
		       <RTRUE>)>)
	       (<OR <DOBJ? PSEUDO-OBJECT>
		    <EQUAL? <META-LOC ,PRSO>
			    ,HERE ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>>
		<RFALSE>)
	       (T
		<SETG P-WON <>>
		<TELL "(You can't see any ">
		<COND (<==? ,PRSO ,CAR-WINDOW> <TELL "window">)
		      (T <TELL D ,PRSO>)>
		<TELL " here!)" CR>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

"WEIGHT:  Get sum of SIZEs of supplied object, recursing to the nth level."

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 #DECL ((OBJ) OBJECT (CONT) <OR FALSE OBJECT> (WT) FIX)
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<SET WT <+ .WT <WEIGHT .CONT>>>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

<GLOBAL WHO-CARES
	<PLTABLE " doesn't appear interested"
		" doesn't care"
		" lets out a loud yawn"
		" seems to be getting impatient">>

<GLOBAL YUKS
	<PLTABLE "That's ridiculous!"
		"That's wacky!"
		"Nuts!"
		"What a fruitcake!"
		"What a screwball!"
		"You're off your rocker!"
		"You're crazy in the head!"
		"You can't be serious!">>
""
"SUBTITLE REAL VERBS"

<ROUTINE PRE-ACCUSE ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,GLOBAL-MURDER>)>
	 <COND (<FSET? ,CORPSE ,INVISIBLE>
		<TELL "Nothing's dead here but your head!" CR>)
	       (<AND <DOBJ? GLOBAL-LINDER CORPSE> <IOBJ? GLOBAL-SUICIDE>>
		<TELL
"Duffy appears for a moment. "
"\"So you believe that Linder's death was suicide? I'm not convinced.
But if you'll "
"just \"arrest Mr. Linder,\" we can go on from there.\" He disappears again."
CR>
		<RTRUE>)
	       (<AND <DOBJ? GLOBAL-MRS-LINDER> <IOBJ? GLOBAL-SUICIDE>>
		<TELL "Everybody knows that!" CR>
		<RTRUE>)
	       (<NOT <==? ,PRSI ,GLOBAL-MURDER>>
		<TELL "What an accusation!" CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL "What a detective! \"Quick, Sergeant! Arrest that "
		      D ,PRSO "!\"" CR>)>>

<ROUTINE V-ACCUSE ()
	 <TELL D ,PRSO " shrugs off your accusation." CR>>

<ROUTINE PRE-SANALYZE ()
	<PERFORM ,V?ANALYZE ,PRSI ,PRSO>
	<RTRUE>>

<ROUTINE V-SANALYZE ()
	 <TELL "[Foo!! This is a bug!!]" CR>>

<ROUTINE PRE-ANALYZE ()
 <COND (<IOBJ? GLOBAL-FINGERPRINTS> <RFALSE>)
       (<NOT ,MET-DUFFY?>
	<TELL
"You haven't met Sergeant Duffy yet tonight."
" You'll need his help to do that." CR>
	<RTRUE>)
       (,DUFFY-WITH-STILES
	<TELL
"You'd better wait until Duffy takes care of his prisoner." CR>)>>

<ROUTINE V-ANALYZE ()
	 <COND (<==? ,PRSI ,GLOBAL-FINGERPRINTS>
		<PERFORM ,V?FINGERPRINT ,PRSO>
		<RTRUE>)
	       (<OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER <FSET? ,PRSO ,TAKEBIT>>
		<DO-ANALYZE>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<TELL
"Duffy appears in an instant. \"Well, I might be able to analyze"
THE-PRSO ",
but you don't even have it with you!\"  With that, he discreetly leaves." CR>)
	       (T
		<TELL
"Sergeant Duffy appears with a puzzled look on his face." " \"With all
respect, I don't think I can take THAT to the laboratory! I'll
be nearby if you need me.\"" " He leaves, shaking his head slowly." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be waiting for your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-REPLY ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "No one's knocking at" THE-PRSO "." CR>)
	       (T <TELL "Too bad, but" THE-PRSO " doesn't care." CR>)>>

<ROUTINE PRE-ARREST ()
	 <COND (<FSET? ,CORPSE ,INVISIBLE>
		<TELL "For what? You have no evidence of a crime yet." CR>)
	       (<NOT ,MET-DUFFY?>
		<TELL
"You haven't met Sergeant Duffy yet tonight."
" You'll need his help to do that." CR>)
	       (<OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER>
		<TELL
"Sergeant Duffy isn't around right now. You'll have to wait for him to
help you make the arrest." CR>)
	       (<AND <NOT <DOBJ? CORPSE GLOBAL-LINDER OBJECT-PAIR>>
		     <IOBJ? GLOBAL-SUICIDE RANDOM-CRIME>>
		<TELL
"Your Chief would probably want you to be sure there's no bigger fish
here, like an honest-to-Pete murderer." CR>)
	       (<DOBJ? GLOBAL-DUFFY> <RFALSE>)
	       (<OR <AND <NOT <FSET? ,PRSO ,PERSON>>
			 <NOT <DOBJ? CORPSE GLOBAL-LINDER OBJECT-PAIR>>>
		    <AND ,PRSI <NOT <IOBJ? GLOBAL-MURDER>>>>
		<TELL "What a detective! \"Quick, Sergeant! Arrest that "
			D ,PRSO>
		<COND (,PRSI <TELL " for " D ,PRSI>)>
		<TELL " before "
			<COND (<FSET? ,PRSO ,FEMALE> "she")
			      (<OR <DOBJ? GLOBAL-DUFFY> <FSET? ,PRSO ,PERSON>>
			       "he")
			      (T "it")>
			" gets away!\"" CR>)>>

<ROUTINE V-ARREST ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL 
"You realize that you don't have enough evidence to convict " D ,PRSO
", so you decide to continue the investigation." CR>)
	       (T
		<TELL
"Sergeant Duffy enters, strokes his chin, and in a puzzled voice says,
\"With all respect, I think we'd be laughed out of the station if we
tried to charge" THE-PRSO " with murder!\" He leaves quietly." CR>)>> 

<ROUTINE V-ASK-ABOUT ()
	 <COND (<==? ,PRSO ,PLAYER>
		<TELL
"It's been a long week, but talking to yourself won't end it any sooner." CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL "Hey, Duffy! Look at your boss talking to "
			<COND (<FSET? ,PRSO ,AN> "an ")
			      (T "a ")>
			D ,PRSO "!" CR>)
	       (T
		<FSET ,PRSO ,TOUCHBIT>
		<TELL D ,PRSO " doesn't seem to know about that." CR>)>>

<ROUTINE PRE-ASK-CONTEXT-ABOUT ("AUX" P)
 <COND (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>>
	<PERFORM ,V?ASK-ABOUT ,QCONTEXT ,PRSO>
	<RTRUE>)
       (<SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>
	<PERFORM ,V?ASK-ABOUT .P ,PRSO>
	<RTRUE>)>>

<ROUTINE V-ASK-CONTEXT-ABOUT ()
	<TELL "You aren't talking to anyone!" CR>>

<ROUTINE V-ASK-FOR ()
	 <COND (<AND <FSET? ,PRSO ,PERSON> <NOT <==? ,PRSO ,PLAYER>>>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL D ,PRSO>
		<COND (<IN? ,PRSI ,PRSO>
		       <TELL " hands you" THE-PRSI "." CR>
		       <MOVE ,PRSI ,WINNER>)
		      (T <TELL " doesn't have that." CR>)>)
	       (T <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE PRE-ASK-CONTEXT-FOR ("AUX" P)
 <COND (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>>
	<PERFORM ,V?ASK-FOR ,QCONTEXT ,PRSO>
	<RTRUE>)
       (<SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>
	<PERFORM ,V?ASK-FOR .P ,PRSO>
	<RTRUE>)>>

<ROUTINE V-ASK-CONTEXT-FOR ()
	<TELL "You aren't talking to anyone!" CR>>

<ROUTINE V-ATTACK () <IKILL "attack">>

<ROUTINE V-BRUSH ()
 <COND (<DOBJ? OUTSIDE-GUN MUDDY-SHOES>
	<TELL "You shouldn't try to clean a piece of evidence." CR>)
       (T <TELL
"\"Cleanliness is next to Godliness,\" but in this case it seems to be
next to Impossible." CR>)>>

<ROUTINE V-CALL-LOSE ()
	 <TELL "(You must use a verb!)" CR>>

<ROUTINE V-$CALL ("AUX" PER (MOT <>))
	 <COND (<FSET? ,PRSO ,PERSON>
		<SET PER <GET ,CHARACTER-TABLE <GETP ,PRSO ,P?CHARACTER>>>
		<COND (<IN-MOTION? .PER> <SET MOT T>)>
		<COND (<OR <==? <META-LOC .PER> ,HERE> <CORRIDOR-LOOK .PER>>
		       <FSET .PER ,TOUCHBIT>
		       <TELL D .PER>
		       <COND (<GRAB-ATTENTION .PER>
			      <COND (.MOT
				   <TELL " stops and turns toward you." CR>)
			      	    (T <TELL " is listening." CR>)>)
			     (T
			      <TELL " ignores you." CR>)>)
		      (T
		       <SETG P-WON <>>
		       <TELL "(You don't see " D .PER " here.)" CR>)>)
	       (T <V-CALL-LOSE>)>>

<ROUTINE V-PHONE ("AUX" PER)
	 <COND (<AND <FSET? ,PRSO ,PERSON>
		     <SET PER <GET ,CHARACTER-TABLE<GETP ,PRSO ,P?CHARACTER>>>
		     <OR <==? <META-LOC .PER> ,HERE> <CORRIDOR-LOOK .PER>>>
		<PERFORM ,V?$CALL ,PRSO>
		<RTRUE>)
	       (<AND ,PRSI <NOT <==? ,PRSI ,TELEPHONE>>>
		<TELL
"Too bad, but" THE-PRSI " isn't wired for phoning." CR>)
	       (<NOT <PHONE-IN? ,HERE>>
		<TELL "There's no phone here." CR>)
	       (<AND <DOBJ? INTNUM> <==? ,P-NUMBER 0>>
		<TELL
"You dial the operator, who doesn't go for any of your cute lines, but
does connect you with the police station. "
"The night clerk at the station says he'll give Duffy your message." CR>)
	       (<OR <DOBJ? BRASS-LANTERN>
		    <AND <DOBJ? INTNUM> <==? ,P-NUMBER 1308>>>
		<TELL
"You dial the number. A voice with a thick Oriental accent answers and says,
\"Sorry, Brass Lantern off tonight. Private party. Thank you.\" Then the line
goes dead." CR>)
	       (<OR <DOBJ? STILES GLOBAL-STILES MATCHBOOK>
		    <AND <DOBJ? INTNUM> <==? ,P-NUMBER 1729>>>
		<TELL
"You dial the number. It rings several times with no answer." CR>)
	       (<DOBJ? INTNUM>
		<TELL "There's no point in calling that number." CR>)
	       (<DOBJ? GLOBAL-TERRY>
		<TELL "You don't know the number." CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL "Too bad, but" THE-PRSO " has no phone." CR>)
	       (<IN? ,PRSO ,HERE>
		<TELL D ,PRSO " is right here!" CR>)
	       (T <TELL "There's no sense in phoning " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<AND <FSET? ,PRSO ,FURNITURE> <FSET? ,PRSO ,VEHBIT>>
		<MOVE ,PLAYER ,PRSO>
		<TELL
"You are now sitting on" THE-PRSO "." CR>)
	       (<FSET? ,PRSO ,FURNITURE>
		<TELL "This isn't the kind of thing to sit on!" CR>)
	       (T
		<TELL
"You can't climb onto" THE-PRSO "." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X)
	 #DECL ((DIR) FIX (OBJ) <OR ATOM FALSE> (X) TABLE)
	 <COND (<GETPT ,HERE .DIR>
		<PERFORM ,V?WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL "You can't go that way." CR>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>>
			    <- </ <PTSIZE .X> 2> 1>>>
		<TELL "Climbing the walls is no help." CR>)
	       (ELSE <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<AND <FSET? ,PRSO ,FURNITURE> <FSET? ,PRSO ,VEHBIT>>
		<V-CLIMB-ON>
		<RTRUE>)
	       (T <V-CLIMB-UP ,P?DOWN>)>>

<ROUTINE V-CLIMB-FOO () <V-CLIMB-UP ,P?UP T>>

<ROUTINE V-CLOSE ()
	 <COND (<NOT <OR <FSET? ,PRSO ,CONTBIT>
			 <FSET? ,PRSO ,DOORBIT>
			 <FSET? ,PRSO ,WINDOWBIT>>>
		<TELL
"You'd have to be more clever to do that to" THE-PRSO "." CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,WINDOWBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FSET? ,PRSO ,RMUNGBIT>
			      <TELL
"It won't stay closed. The latch is broken." CR>)
			     (T
			      <FCLEAR ,PRSO ,OPENBIT>
			      <TELL
"Okeh," THE-PRSO " is now closed." CR>)>)
		      (T <TELL "It's already closed." CR>)>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL "It's already closed." CR>)>)
	       (ELSE
		<TELL "You can't close" THE-PRSO "." CR>)>>

<ROUTINE PRE-COMPARE ()
 <COND (<AND <NOT ,PRSI>
	     <==? 1 <GET ,P-PRSO 0>>>
	<TELL "Oops! Try typing \"COMPARE IT TO (something).\"" CR>
	<RTRUE>)
       (<==? 2 <GET ,P-PRSO 0>>
	<PUT ,P-PRSO 0 1>
	<PERFORM ,PRSA <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
	<RTRUE>)>>

<ROUTINE V-COMPARE ()
 <COND (<==? ,PRSO ,PRSI> <TELL "They're the same thing!" CR>)
       (T <TELL "They're not a bit alike." CR>)>>

<ROUTINE V-CONFRONT ()
	 <COND (<==? ,PRSO ,PLAYER>
		<TELL "You aren't talking to anyone!" CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL
"That ought to put a scare into" THE-PRSO "." CR>)
	       (T
		<TELL D ,PRSO <PICK-ONE ,WHO-CARES> "." CR>)>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,PERSON>
		       <TELL
"Insults like that won't help you solve the case." CR>)
		      (T
		       <TELL <PICK-ONE ,YUKS> CR>)>)
	       (T
		<TELL <PICK-ONE ,OFFENDED> CR>)>>

<GLOBAL OFFENDED
	<PLTABLE "You ought to be ashamed of yourself!"
		"Hey, save that talk for the locker room!"
		"Step outside and say that!"
		"And so's your grandmother!">>

<ROUTINE V-MUNG ()
	 <COND (<AND <FSET? ,PRSO ,DOORBIT> <NOT ,PRSI>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"You'd fly through the open door if you tried." CR>)
		      (<FSET? ,PRSO ,LOCKED>
		       <TELL "Oof! All you get is a sore shoulder." CR>)
		      (T <TELL "Why don't you just open it instead?" CR>)>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<HACK-HACK "Trying to destroy">)
	       (<NOT ,PRSI>
		<TELL "Trying to destroy " D ,PRSO
		      " with your bare hands is suicidal." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to destroy " D ,PRSO " with "
			<COND (<FSET? ,PRSI ,AN> "an ") (T "a ")>
			D ,PRSI " is quite self-destructive." CR>)
	       (T <TELL "You can't." CR>)>>

<ROUTINE V-DRINK ()
	 <V-EAT>>

;<ROUTINE PRE-DROP ()
	 <COND (<==? ,PRSO <META-LOC ,WINNER>>
		<PERFORM ,V?WALK ,P?OUT>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Okeh," THE-PRSO " is now on the ">
		<COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
		       <TELL "ground">)
		      (T <TELL "floor">)>
		<TELL "." CR>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 #DECL ((NOBJ) <OR OBJECT FALSE> (EAT? DRINK?) <OR ATOM FALSE>)
	 <COND (<AND <SET EAT? <FSET? ,PRSO ,FOODBIT>> <IN? ,PRSO ,WINNER>>
		<COND (<VERB? DRINK>
		       <TELL
			"Seems that you've had too much to drink already!"CR>)
		      (ELSE
		       <TELL "Mmm. That really hit the spot." CR>
		       <REMOVE ,PRSO>)>
		<CRLF>)
	       (<SET DRINK? <FSET? ,PRSO ,DRINKBIT>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <AND <SET NOBJ <LOC ,PRSO>>
				<IN? .NOBJ ,WINNER>
				<FSET? .NOBJ ,OPENBIT>>>
		       <TELL "Mmm. That really hit the spot." CR>
		       <REMOVE ,PRSO>)
		      (T <TELL "You can't get to it." CR>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL
"The blue-plate special at the diner was enough for you." CR>)>>

<ROUTINE V-ENTER ()
	<PERFORM ,V?WALK ,P?IN>
	<RTRUE>>

;<ROUTINE PRE-THROUGH ()		;"WALK WITH => FOLLOW"
 <COND (<FSET? ,PRSO ,PERSON> <PERFORM ,V?FOLLOW ,PRSO> <RTRUE>)>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" RM ;M DIR ;PT ;PTS)
	#DECL ((OBJ) <OR OBJECT FALSE> (M) <PRIMTYPE VECTOR>)
	<COND (<IN? ,PRSO ,ROOMS>
	       <COND (<SET DIR <DIR-FROM ,HERE ,PRSO>>
		      <PERFORM ,V?WALK .DIR>
		      <RTRUE>)
		     (<==? ,PRSO <META-LOC ,PLAYER>>
		      <TELL "You're already there!" CR>)
		     (T <TELL
"You can't go from here to there, at least not directly." CR>)>)
	      (<AND <FSET? ,PRSO ,DOORBIT> <FSET? ,PRSO ,OPENBIT>>
	       <COND (<SET RM <DOOR-ROOM ,HERE ,PRSO>>
		      <GOTO .RM>)
		     (T <TELL
"Sorry, but the \"" D ,PRSO "\" must be somewhere else." CR>)>)
	      (<DOBJ? SIDE-FOOTPRINTS BACK-FOOTPRINTS>
		<TELL "You could mess up valuable evidence that way." CR>
		<RTRUE>)
	      (<AND <NOT .OBJ> <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       <TELL "You hit your head against" THE-PRSO
		     " as you try it." CR>)
	      (.OBJ <TELL "You can't do that!" CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "You must think you're a contortionist!" CR>)
	      (ELSE <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE PRE-EXAMINE ("AUX" VAL)
	 <COND (<ROOM-CHECK> <RTRUE>)
	       (<==? ,P-ADVERB ,W?CAREFULLY>
		<COND (<NOT <SET VAL <INT-WAIT 3>>>
		       <TELL
"You never got to finish looking over" THE-PRSO "." CR>)
		      (<==? .VAL ,M-FATAL> <RTRUE>)>)>>

<ROUTINE V-EXAMINE ("AUX" TXT)
	 <COND (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<NOT-HERE ,PRSO>
		<RTRUE>)
	       (<SET TXT <GETP ,PRSO ,P?TEXT>>
		<TELL .TXT CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    ;<FSET? ,PRSO ,DOORBIT>
		    ;<FSET? ,PRSO ,WINDOWBIT>>
		<V-LOOK-INSIDE>)
	       (ELSE
		<TELL
"There's nothing special about" THE-PRSO "." CR>)>>

;<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TBL)
	 #DECL ((OBJ1 OBJ2) OBJECT (TBL) <OR FALSE TABLE>)
	 <COND (<SET TBL <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TBL <- <PTSIZE .TBL> 1>>)>>

<GLOBAL PRON-HIM "him">
<GLOBAL PRON-HE "he">
<GLOBAL PRON-HER "her">
<GLOBAL PRON-SHE "she">

<ROUTINE PRE-FIND ("AUX" PRON PRON1 CHR NUM)
	 <SET PRON ,PRON-HIM>
	 <SET PRON1 ,PRON-HE>
	 <COND (<IN? ,PRSO ,ROOMS>
		<COND (<==? ,PRSO ,HERE>
		       <TELL "You're already here!" CR>)
		      (<FSET? ,PRSO ,TOUCHBIT>
		       <TELL "You should know - you've been there!" CR>)
		      (T <TELL "You're the detective!" CR>)>)
	       (<FSET? ,PRSO ,PERSON>
		<SET NUM <GET <GET ,WHERE-TABLES <GETP ,WINNER ,P?CHARACTER>>
			      <SET CHR <GETP ,PRSO ,P?CHARACTER>>>>
		<COND (<IN? ,PRSO ,GLOBAL-OBJECTS>
		       <SETG PRSO <GET ,CHARACTER-TABLE .CHR>>)>
		<COND (<FSET? ,PRSO ,FEMALE>
		       <SET PRON ,PRON-HER>
		       <SET PRON1 ,PRON-SHE>)
		      (<AND <EQUAL? .CHR ,LINDER-C>
			    <NOT <LOC ,LINDER>>>
		       <COND (<==? ,WINNER ,PLAYER>
			      <TELL "What do you mean? He's dead!" CR>
			      <RTRUE>)
			     (<OR <AND <==? ,WINNER ,PHONG>
				       ,PHONG-SEEN-CORPSE?>
				  <AND <==? ,WINNER ,MONICA>
				       ,MONICA-SEEN-CORPSE?>>
			      <TELL "\"" "What do you mean? He's dead!"
				      "\"" CR>
			      <RTRUE>)
			     (T <RFALSE>)>)>
		<COND (<AND <NOT <==? ,WINNER ,PLAYER>>
			    <NOT <GRAB-ATTENTION ,WINNER>>>
		       <RTRUE>)>
		<COND (<==? <META-LOC ,WINNER> <META-LOC ,PRSO>>
		       <COND (<==? ,WINNER ,PLAYER>
			      <TELL
		"It sounds as though you need your vision checked." CR>)
			     (T
			      <TELL "\"Ahem...\"" CR>)>)
		      (<0? .NUM>
		       <COND (<==? ,WINNER ,PLAYER>
			      <TELL
"You haven't seen " .PRON " yet." CR>)
			     (T
			      <TELL
"\"I haven't seen " .PRON " tonight.\"" CR>)>)
		      (T
		       <SET NUM <- ,PRESENT-TIME .NUM>>
		       <COND (<==? ,WINNER ,PLAYER>
			      <TELL
"You last saw " .PRON " ">)
			     (T
			      <TELL
"\"I last saw " .PRON " ">)>
		       <COND (<G? .NUM 120>
			      <TELL "a few hours">)
			     (<G? .NUM 80>
			      <TELL "an hour or two">)
			     (<G? .NUM 45>
			      <TELL "about an hour">)
			     (<G? .NUM 20>
			      <TELL "about half an hour">)
			     (<G? .NUM 10>
			      <TELL "about 15 minutes">)
			     (<G? .NUM 5>
			      <TELL "less than 10 minutes">)
			     (T
			      <TELL "just a few minutes">)>
		       <COND (<NOT <==? ,WINNER ,PLAYER>>
			      <TELL " ago. I don't know where ">
			      <TELL .PRON1 " is now.\"" CR>)
			     (T <TELL " ago." CR>)>)>
		<RTRUE>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<==? ,PRSO ,PLAYER>
		<COND (<NOT <==? ,PLAYER ,WINNER>> <TELL "\"">)>
		<TELL "You're right here, ">
		<COND (<FSET? .L ,SURFACEBIT> <TELL "on">)
		      (T <TELL "in">)>
		<THE? .L>
		<TELL " " D .L ".">
		<COND (<NOT <==? ,PLAYER ,WINNER>> <TELL "\"">)>
		<CRLF>)
	       (<NOT <==? ,PLAYER ,WINNER>>
		<TELL "\"" "You're the detective!" "\"" CR>)
	       (<OR <EQUAL? .L ,GLOBAL-OBJECTS> <NOT <FSET? ,PRSO ,TOUCHBIT>>>
		<TELL "You're the detective!" CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <==? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,PERSON>
		<TELL D .L " has it." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL "It's on">
		<THE? .L>
		<TELL " " D .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in">
		<THE? .L>
		<TELL " " D .L "." CR>)
	       (ELSE
		<TELL "You're the detective!" CR>)>>

<ROUTINE V-FINGERPRINT ()
 <COND (<FSET? ,PRSO ,PERSON>
	<TELL "You can't find prints on a person!" CR>)
       (T <TELL
"You don't find any good prints on" THE-PRSO "." CR>)>>

<ROUTINE V-FOLLOW ("AUX" CN CHR COR PCOR L)
	 <COND (<==? ,PRSO ,PLAYER>
		<TELL "It's not clear who you're talking to." CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL
"How tragic to see a formerly great detective stalking "
<COND (<FSET? ,PRSO ,AN> "an ") (T "a ")>
D ,PRSO "!" CR>)
	       (<==? ,HERE
		     <SET L <META-LOC
			     <SET CHR <GET ,CHARACTER-TABLE
				       <SET CN <GETP ,PRSO ,P?CHARACTER>>>>>>>
		<TELL "You're in the same place as ">
		<COND (<FSET? .CHR ,TOUCHBIT> <TELL D ,PRSO "!" CR>)
		      (T <TELL "the " <GETP .CHR ,P?XDESC> "!" CR>)>)
	       (<OR <NOT .L> <==? .L ,LIMBO>>
		<COND (<FSET? .CHR ,TOUCHBIT> <TELL D ,PRSO>)
		      (T <TELL "The " <GETP .CHR ,P?XDESC>>)>
		<TELL " has left the grounds." CR>)
	       (<==? <GET <GET ,WHERE-TABLES 0> .CN> ,PRESENT-TIME>
		<COND (<OR <AND <OUTSIDE? .L> <OUTSIDE? ,HERE>>
			   <AND <NOT <OUTSIDE? .L>> <NOT <OUTSIDE? ,HERE>>>>
		       <GOTO .L>)
		      (T
		       <TELL "You seem to have lost track of ">
		       <COND (<FSET? .CHR ,TOUCHBIT> <TELL D ,PRSO "." CR>)
			     (T <TELL "the " <GETP .CHR ,P?XDESC> "." CR>)>)>)
	       (<AND <SET COR <GETP ,HERE ,P?CORRIDOR>>
		     <SET PCOR <GETP .L ,P?CORRIDOR>>
		     <NOT <==? <BAND .COR .PCOR> 0>>>
		<SETG PRSO <COR-DIR ,HERE .L>>
		<V-WALK>)
	       (T
		<TELL "You seem to have lost track of ">
		<COND (<FSET? .CHR ,TOUCHBIT> <TELL D ,PRSO "." CR>)
		      (T <TELL "the " <GETP .CHR ,P?XDESC> "." CR>)>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<EQUAL? ,PRSO ,OFFICE-BACK-DOOR> <RFALSE>)
	       (<AND <NOT <HELD? ,PRSO>> <NOT <EQUAL? ,PRSI ,PLAYER>>>
		<TELL 
"That's easy for you to say, since you don't even have it." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,PERSON>>
		<TELL "You can't give ">
		<COND (<OR <FSET? ,PRSO ,PERSON> <DOBJ? GLOBAL-DUFFY>> T)
		      (<FSET? ,PRSO ,AN> <TELL "an ">)
		      (T <TELL "a ">)>
		<TELL D ,PRSO " to "
			<COND (<FSET? ,PRSI ,AN> "an ") (T "a ")>
			D ,PRSI "!" CR>)
	       (T <TELL D ,PRSI " refuses your offer." CR>)
	       ;(<IDROP>
		<TELL D ,PRSI " takes" THE-PRSO
			" and then puts it down." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	<RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "[Foo!! This is a bug!!]" CR>>

<ROUTINE V-GOODBYE () <V-HELLO <>>>

<ROUTINE V-HANDCUFF ()
	<COND (<IN? ,HANDCUFFS ,PLAYER>
	       <PERFORM ,V?TIE-WITH ,PRSO ,HANDCUFFS>
	       <RTRUE>)
	      (T <TELL "You don't have the " D ,HANDCUFFS "." CR>)>>

<ROUTINE V-HELLO ("OPTIONAL" (HELL T) "AUX" P)
 <COND (<SET P <OR ,PRSO ,QCONTEXT <FIND-FLAG ,HERE ,PERSON ,WINNER>>>
	<COND (<FSET? .P ,PERSON>
	       <COND (.HELL
		      <FSET .P ,TOUCHBIT>
		      <TELL D .P " nods at you." CR>)
		     (ELSE <TELL
"\"Don't tell me you're leaving already!\"" CR>)>)
	      (ELSE
	       <TELL "Only nuts say \""
		     <COND (.HELL "Hello") (T "Good-bye")>
		     "\" to "
		     <COND (<FSET? .P ,AN> "an ") (T "a ")>
		     D .P "." CR>)>)
       (T <TELL "It's not clear who you're talking to." CR>)>>

<ROUTINE V-HELP ()
 <COND (<ZERO? ,PRSO>
	<TELL
"(You'll find plenty of help in your instruction manual."
;"Nat'l Detective Gazette" CR
"If you really need help, you can order an InvisiClues Hint Booklet
and a complete map by using the order form that came in your package.)" CR>)
       (<DOBJ? PLAYER> <PERFORM ,V?GIVE ,HINT ,PLAYER> <RTRUE>)
       (T <TELL "You'll have to be more specific." CR>)>>

<ROUTINE V-HIDE ()
	 <COND (<EQUAL? ,HERE ,OFFICE>
		<TELL "You could hide behind the lounge." CR>)
	       (T <TELL "There's no good hiding place here." CR>)>>

<ROUTINE V-HIDE-BEHIND ()
 <COND (<FIND-FLAG ,HERE ,PERSON ,WINNER>
	<TELL "You can't hide when people are watching you!" CR>)
       (<DOBJ? LOUNGE>
	<SETG PLAYER-HIDING ,PRSO>
	<TELL "Okeh, you're now crouching down behind the lounge." CR>)
       (T <TELL "There's no room to hide behind" THE-PRSO "."CR>)>>

<ROUTINE V-KICK ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "\"I get no ">
		<VERB-PRINT>
		<TELL " from shampoo...\" -- Cole Flathead" CR>)
	       (T <HACK-HACK "Kicking">)>>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 <COND (<NOT ,PRSO> <TELL "There's nothing here to " .STR "." CR>)
	       (<AND <NOT ,PRSI> <FSET? ,PRSO ,WEAPONBIT>>
		<TELL "You didn't say what to " .STR " at." CR>)
	       (<DOBJ? FRONT-DOOR GARAGE-DOOR WORKSHOP-DOOR>
		<TELL "There must be an easier way to do what you want."CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    ;<FSET? ,PRSO ,WINDOWBIT>>
		<FSET ,PRSO ,RMUNGBIT>
		<TELL "Hey, this isn't a " .STR "-em-up Western!"
			" You just broke the lock beyond repair." CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL
"Sure, you probably need to sharpen your eye, but "
<COND (<FSET? ,PRSO ,AN> "an ") (T "a ")>
D ,PRSO " is a lousy target." CR>)
	       (<NOT ,PRSI>
		<COND (<PROB 50>
		       <TELL
"You think it over. It's not worth the trouble." CR>)
		      (T <TELL
"With your expert ability, you " .STR PRSO " in no time." CR>
		       <GONE-CRAZY>)>)
	       (<EQUAL? ,PRSI ,PISTOL ,INSIDE-GUN ,OUTSIDE-GUN>
		<COND (<PROB 50>
		       <TELL
"You think it over. It's not worth the trouble." CR>)
		      (T <TELL
"A shot rings out and" PRSO " crumples to the ground, dead. Good shot." CR>
		       <GONE-CRAZY>)>)
	       (<PROB 50>
		<TELL
"You think it over. It's not worth the trouble." CR>)
	       (T
		<TELL
"With a lethal blow of" THE-PRSI "," PRSO " falls dead." CR>
		<GONE-CRAZY>)>>

<ROUTINE V-KISS ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL
"Section 204D, Paragraph 7.6 of the California Police Code of
Conduct specifically prohibits kissing potential suspects or witnesses." CR>)
	       (T <TELL "What a (ahem!) strange idea!" CR>)>>

<ROUTINE V-KNOCK ()
 <COND (<OR <FSET? ,PRSO ,DOORBIT>
	    <FSET? ,PRSO ,WINDOWBIT>>
	<COND (<INHABITED?
		<COND (<FSET? ,PRSO ,DOORBIT> <DOOR-ROOM ,HERE ,PRSO>)
		      (T <WINDOW-ROOM ,HERE ,PRSO>)>>
	       <TELL "Someone">
	       <COND (,TOO-LATE <TELL " shouts \"Go away!\"" CR>)
		     (T <TELL " shouts \"Go to the front door!\"" CR>)>)
	      (T <TELL "There's no answer." CR>)>)
       (ELSE
	<TELL "Why knock on ">
	<COND (<OR <FSET? ,PRSO ,PERSON> <DOBJ? GLOBAL-DUFFY>> T)
	      (<FSET? ,PRSO ,AN> <TELL "an ">)
	      (T <TELL "a ">)>
	<TELL D ,PRSO "?" CR>)>>

<ROUTINE V-LEAN ()
	 <TELL "You can't do that!" CR>>

<ROUTINE V-STAND ("AUX" P)
	 <COND (,PLAYER-HIDING
		<TELL "You are no longer hiding behind">
		<THE? ,PLAYER-HIDING>
		<TELL " " D ,PLAYER-HIDING "." CR>
		<SETG PLAYER-HIDING <>>
		<COND (<INHABITED? ,HERE>
		       <SET P <FIND-FLAG ,HERE ,PERSON>>
		       <TELL D .P " looks startled to find you here." CR>)>
		<RTRUE>)
	       (<OR <FSET? <LOC ,WINNER> ,SURFACEBIT>
		    <FSET? <LOC ,WINNER> ,FURNITURE>>
		<MOVE ,WINNER ,HERE>
		<SETG PLAYER-HIDING <>>
		<TELL "You are on your own feet again." CR>)
	       (T
		<TELL "You're already standing up!" CR>)>>

<ROUTINE V-LEAVE () <PERFORM ,V?WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
 <COND (<CAN-HEAR-RECORD?>
	<TELL "Through the door you can hear a " "record" " playing." CR>)
       (<CAN-HEAR-RADIO?>
	<TELL "Through the door you can hear a " "radio" " playing." CR>)
       (T <TELL "Too bad, but" THE-PRSO " makes no sound." CR>)>>

<ROUTINE V-LOCK ()
	 <COND (<NOT <OR <FSET? ,PRSO ,CONTBIT> <FSET? ,PRSO ,DOORBIT>>>
		<TELL
"You'd have to be more clever to do that to" THE-PRSO "." CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    ;<FSET? ,PRSO ,WINDOWBIT>
		    <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "You'll have to close it first." CR>)
		      (<FSET? ,PRSO ,LOCKED>
		       <TELL "It's already locked." CR>)
		      (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL "You can't lock it. The lock is broken." CR>)
		      (T
		       <FSET ,PRSO ,LOCKED>
		       <TELL
"Okeh," THE-PRSO " is now locked." CR>)>)
	       (T <TELL "You can't lock" THE-PRSO "." CR>)>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There's nothing behind ">
	 <COND (<FSET? ,PRSO ,PERSON>
		;"? looks at you as though you were a lower form of life."
		<TELL D ,PRSO>)
	       (T <TELL "the" PRSO>)>
	 <TELL "." CR>>

<ROUTINE V-LOOK-DOWN ()
 <COND (<==? ,PRSO ,ROOMS>
	<COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
	       <TELL "There's " <GROUND-SURFACE> " there, mostly." CR>)
	      (T
	       <TELL "Nothing's interesting about the floor." CR>)>)
       (T <TELL "It has been a long week, hasn't it?" CR>)>>

<ROUTINE PRE-LOOK-INSIDE () <ROOM-CHECK>>

<ROUTINE V-LOOK-INSIDE ("OPTIONAL" (DIR ,P?IN) "AUX" RM)
	 <COND (<DOBJ? GLOBAL-ROOM>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<FSET? ,PRSO ,RLANDBIT>
		<ROOM-PEEK ,PRSO>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<SET RM <DOOR-ROOM ,HERE ,PRSO>>
			      <ROOM-PEEK .RM>)
			     (T <TELL
"The " D ,PRSO " is open, but you can't tell what's beyond it." CR>)>)
		      (ELSE <TELL
"Too bad, but" THE-PRSO " is closed." CR>)>)
	       (<FSET? ,PRSO ,WINDOWBIT>
		<COND (<SET RM <WINDOW-ROOM ,HERE ,PRSO>>
		       <ROOM-PEEK .RM>)
		      (T <TELL
"You can't tell what's beyond" THE-PRSO "." CR>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO> <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (<FSET? ,PRSO ,SURFACEBIT>
			      <TELL
"There's nothing on" THE-PRSO "." CR>)
			     (T
			      <TELL
"Too bad, but" THE-PRSO " is empty." CR>)>)
		      (ELSE <TELL
"Too bad, but" THE-PRSO " is closed." CR>)>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "You forgot to bring your X-ray glasses." CR>)
	       (<==? .DIR ,P?IN>
		<TELL "You can't look inside" THE-PRSO "." CR>)
	       (<==? .DIR ,P?OUT>
		<TELL "You can't look outside" THE-PRSO "." CR>)>>

<ROUTINE ROOM-PEEK (RM "AUX" OHERE)
	 <SET OHERE ,HERE>
	 <COND (<SEE-INTO? .RM>
		<SETG HERE .RM>
		<TELL "You take a quick peek into">
		<THE? .RM>
		<TELL " " D .RM ":" CR>
		<COND (<NOT <DESCRIBE-OBJECTS T>>
		       <TELL "You can't see anything interesting." CR>)>
		<SETG HERE .OHERE>)>>

<ROUTINE SEE-INTO? (THERE "AUX" P L TBL O)
	 #DECL ((THERE O) OBJECT (P L) FIX)
	 <SET P 0>
	 <REPEAT ()
		 <COND (<0? <SET P <NEXTP ,HERE .P>>>
			<TELL "You can't seem to find that room." CR>
			<RFALSE>)
		       (<EQUAL? .P ,P?IN ,P?OUT> T)
		       (<NOT <L? .P ,LOW-DIRECTION>>
			<SET TBL <GETPT ,HERE .P>>
			<SET L <PTSIZE .TBL>>
			<COND (<AND <==? .L ,UEXIT>
				    <==? <GETB .TBL ,REXIT> .THERE>>
			       <RTRUE>)
			      (<AND <==? .L ,DEXIT>
				    <==? <GETB .TBL ,REXIT> .THERE>>
			       <COND (<FSET? <GETB .TBL ,DEXITOBJ> ,OPENBIT>
				      <RTRUE>)
				     (T
				      <TELL
"The door to that room is closed." CR>
				      <RFALSE>)>)
			      (<AND <==? .L ,CEXIT>
				    <==? <GETB .TBL ,REXIT> .THERE>>
			       <COND (<VALUE <GETB .TBL ,CEXITFLAG>>
				      <RTRUE>)
				     (T
				      <TELL
"You can't seem to find that room." CR>
				      <RFALSE>)>)>)>>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<V-LOOK-INSIDE>)
	       (T <TELL "There's no good surface on" THE-PRSO "." CR>)>>

<ROUTINE V-LOOK-OUTSIDE () <V-LOOK-INSIDE ,P?OUT>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<FSET? ,PRSO ,FURNITURE>
		<TELL
"You twist your head to look under" THE-PRSO " but find nothing."CR>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "Nope. Nothing hiding under " D ,PRSO "." CR>)
	       (<EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS ,GLOBAL-OBJECTS>
		<TELL "There's nothing there but dust." CR>)
	       (T
		<TELL "That's not a bit useful." CR>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<COND (<TANDY?> <TELL <PICK-ONE ,YUKS> CR>)
		      (T <TELL "What a pervert!" CR>)>)
	       (<NOT <==? ,PRSO ,ROOMS>>
		<TELL "It has been a long week, hasn't it?" CR>
		<RTRUE>)
	       (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
		<TELL ,SKY-DESC CR>)
	       (T
		<TELL
"You can see the ceiling. It's not Union Station, but it's
nicely painted." CR>)>>

<ROUTINE V-MAKE ()
	<TELL
"\"Eat, drink, and make merry, for tomorrow we shall die!\"" CR>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Juggling isn't one of your talents." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL
"Moving" THE-PRSO " reveals nothing." CR>)
	       (T <TELL "You can't move" THE-PRSO "." CR>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<NOT <OR <FSET? ,PRSO ,CONTBIT>
			 <FSET? ,PRSO ,DOORBIT>
			 <FSET? ,PRSO ,WINDOWBIT>>>
		<TELL
"You'd have to be more clever to do that to" THE-PRSO "." CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,WINDOWBIT>
		    <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "It's already open." CR>)
		      (<FSET? ,PRSO ,LOCKED>
		       <TELL "You'll have to unlock it first." CR>)
		      (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL
"You can't open it. The latch is broken." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<OR <FSET? ,PRSO ,DOORBIT>
				  <FSET? ,PRSO ,WINDOWBIT>>
			      <TELL
"Okeh," THE-PRSO " is now open." CR>)
			     (<OR <NOT <FIRST? ,PRSO>><FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "You open" THE-PRSO "."CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "You open" THE-PRSO
				    " and see ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (T <TELL "You can't open" THE-PRSO "." CR>)>>

<ROUTINE V-PICK () <TELL "You can't pick that." CR>>

<ROUTINE V-PLAY ()
	 <TELL
"(Speaking of playing, you ought to try Infocom's other products.)" CR>>

<ROUTINE V-PUSH () <HACK-HACK "Pushing">>

<ROUTINE V-PUT-UNDER ()
         <TELL "There's not enough room." CR>>

<ROUTINE PRE-PUT ()
	 <COND (<DOBJ? HANDCUFFS>
		<PERFORM ,V?TIE-WITH ,PRSI ,HANDCUFFS>
		<RTRUE>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "That would be a mistake." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>> T)
	       (<IOBJ? SIDE-FOOTPRINTS BACK-FOOTPRINTS>
		<TELL "You could mess up valuable evidence that way." CR>
		<RTRUE>)
	       (T
		<TELL "You can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "Too bad, but" THE-PRSI " isn't open." CR>)
	       (<==? ,PRSI ,PRSO>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL
  "Too bad, but" THE-PRSO
" is already in" THE-PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Okeh." CR>)>>

<ROUTINE V-RAISE () <HACK-HACK "Playing in this way with">>

<ROUTINE V-RAPE ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<COND (<PROB 75>
		       <TELL
"Section 29A of the United States Criminal Code, whose provisions
come to your unhealthy mind, forbids it." CR>)
		      (T <GONE-CRAZY>)>)
	       (T <TELL "What a (ahem!) strange idea!" CR>)>>

<GLOBAL LIT <>>

<ROUTINE PRE-READ ("AUX" VAL)
	 <COND (<NOT ,LIT> <TELL "It's impossible to read in the dark." CR>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<NOT-HERE ,PRSO>)
	       (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TRANSBIT>>
		     <NOT <==? ,PRSI ,INTNUM>>>	;"? INTNUM?"
		<TELL
"You must have a swell method of looking through" THE-PRSI "." CR>)
	       (<==? ,P-ADVERB ,W?CAREFULLY>
		<COND (<NOT <SET VAL <INT-WAIT 3>>>
		       <TELL
"You never got to finish reading" THE-PRSO "." CR>)
		      (<==? .VAL ,M-FATAL> <RTRUE>)>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "You can't read" THE-PRSO "." CR>)
	       (ELSE <TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-REVIVE ()
 <COND (<FSET? ,PRSO ,PERSON>
	<TELL D ,PRSO " doesn't need reviving." CR>)
       (T <HACK-HACK "Trying to revive">)>>

<ROUTINE V-RING () <TELL "\"DING-DONG!\"" CR>>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with">>

<ROUTINE PRE-RUB-OVER ()
	 <PERFORM ,V?RUB ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-RUB-OVER ()
	 <TELL "You really can't expect that to help." CR>>

<ROUTINE V-SAY ("AUX" V)
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <TELL
"To talk to someone, try 'SAY TO someone \"something\"'." CR>>

<ROUTINE PRE-SEARCH () <ROOM-CHECK>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL D ,PRSO
		      " grudgingly allows you to search.  You find nothing
whatsoever of interest." CR>)
	       (<AND <FSET? ,PRSO ,CONTBIT> <NOT <FSET? ,PRSO ,OPENBIT>>>
		<TELL "You'll have to open it first." CR>)
	       (T <TELL "You find nothing unusual." CR>)>>

<ROUTINE PRE-SEARCH-OBJECT-FOR ("AUX" OBJ)
 <COND (<ROOM-CHECK> <RTRUE>)
       (<AND <IN? ,PRSI ,PLAYER>
	     <GETP ,PRSI ,P?GENERIC>
	     <SET OBJ <APPLY <GETP ,PRSI ,P?GENERIC> ,PRSI>>>
	<SETG PRSI .OBJ>)>
 <COND (<DOBJ? GLOBAL-ROOM GLOBAL-HERE>
	<SETG PRSO ,HERE>)>
 <RFALSE>>

<ROUTINE V-SEARCH-OBJECT-FOR ()
	 <COND (<AND <IOBJ? MONEY> <FSET? ,PRSO ,PERSON>>
		<SAID-TO ,PRSO>
		<TELL
"You can find only pocket change. \"I could have told you that.\"" CR>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL D ,PRSO
		      " resignedly allows you to perform the search." CR>
		<COND (<IN? ,PRSI ,PRSO>
		       <TELL
"Indeed, " D ,PRSO " has" THE-PRSI "." CR>)
		      (<IN? ,PRSI ,GLOBAL-OBJECTS>
		       <TELL D ,PRSO " doesn't have ">
		       <COND (<OR <FSET? ,PRSI ,PERSON>
				  <IOBJ? GLOBAL-DUFFY>> T)
			     (<FSET? ,PRSI ,AN> <TELL "an ">)
			     (T <TELL "a ">)>
		       <TELL D ,PRSI "." CR>)
		      (T <TELL D ,PRSO " doesn't have"
			       THE-PRSI "." CR>)>)
	       (<AND <FSET? ,PRSO ,CONTBIT> <NOT <FSET? ,PRSO ,OPENBIT>>>
		<TELL "You'll have to open" THE-PRSO " first." CR>)
	       (<IN? ,PRSI ,PRSO>
		<TELL "How observant you are! There "
			<COND (<FSET? ,PRSI ,FEMALE> "she")
			      (<FSET? ,PRSI ,PERSON> "he")
			      (T "it")>
			" is!" CR>)
	       (T <TELL "You don't find" THE-PRSI " there." CR>)>>

<ROUTINE V-SHOOT ()
 <COND (<NOT <FIND-FLAG ,WINNER ,WEAPONBIT>>
	<TELL "You don't have anything to shoot with." CR>)
       (T <IKILL "shoot">)>>

<ROUTINE PRE-SSHOOT ()
	 <PERFORM ,V?SHOOT ,PRSI ,PRSO>
	<RTRUE>>

<ROUTINE V-SSHOOT ()
	 <TELL "[Foo!! This is a bug!!]" CR>>

<ROUTINE V-SHOW ()
	 <COND (<==? ,PRSO ,PLAYER>
		<TELL "Do you often talk to yourself?" CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL "Don't wait for" THE-PRSO " to applaud." CR>)
	       (T
		<TELL D ,PRSO <PICK-ONE ,WHO-CARES> "." CR>)>>

<ROUTINE PRE-SSHOW ()
	 <SETG P-MERGED T>
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW () <RTRUE>>

<ROUTINE V-SIT ()
	 <COND (<AND <FSET? ,PRSO ,FURNITURE> <FSET? ,PRSO ,VEHBIT>>
		<MOVE ,PLAYER ,PRSO>
		<SETG PLAYER-HIDING <>>
		<TELL
"You are now sitting on" THE-PRSO "." CR>)
	       (T
		<TELL "That isn't something to sit on!" CR>)>>

<ROUTINE V-SLAP ()
 <COND (<FSET? ,PRSO ,PERSON>
	<TELL D ,PRSO " slaps you right back. Wow, is your face red!" CR>)
       (T <TELL
"You should see Phong. He breaks boards with the edge of his hand!" CR>)>>

<ROUTINE V-SMELL ()
 <COND (<FSET? ,PRSO ,PERSON>
	<COND (<FSET? ,PRSO ,FEMALE> <TELL "She">)
	      (T <TELL "He">)>
	<TELL " smells just like " D ,PRSO "." CR>)
       (T <TELL "It" " smells just like "
		  <COND (<FSET? ,PRSO ,AN> "an ") (T "a ")>
		  D ,PRSO "." CR>)>>

<ROUTINE V-SMOKE ()
	 <COND ;(<FSET? ,PRSO ,BURNBIT>
		<TELL "You must think you're a jazz musician." CR>)
	       (T <TELL "You can't burn" THE-PRSO "." CR>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<DOBJ? WHITE-WIRE BLACK-WIRE GLOBAL-FINGERPRINTS HINT DRINK
		       CIGARETTE GLOBAL-CAN-OF-WORMS HANDCUFFS GLOBAL-WARRANT>
		<RFALSE>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS> <NOT-HERE ,PRSO>)
	       (<IN? ,PRSO ,WINNER> <TELL "You already have it." CR>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach that." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<IOBJ? OFFICE-BACK-DOOR
			      MONICA-BACK-DOOR LINDER-BACK-DOOR>
		       <RFALSE>)
		      (<NOT <==? ,PRSI <LOC ,PRSO>>>
		       <COND (<NOT <FSET? ,PRSO ,PERSON>>
			      <COND (<NOT <FSET? ,PRSI ,PERSON>>
				     <TELL "It's not in that!" CR>)
				    (<FSET? ,PRSI ,FEMALE>
				     <TELL "She doesn't have it!" CR>)
				    (T <TELL "He doesn't have it!" CR>)>)
			     (<FSET? ,PRSO ,FEMALE>
			      <COND (<NOT <FSET? ,PRSI ,PERSON>>
				     <TELL "She's not in that!" CR>)
				    (<FSET? ,PRSI ,FEMALE>
				     <TELL "She doesn't have her!" CR>)
				    (T <TELL "He doesn't have her!" CR>)>)
			     (T
			      <COND (<NOT <FSET? ,PRSI ,PERSON>>
				     <TELL "He's not in that!" CR>)
				    (<FSET? ,PRSI ,FEMALE>
				     <TELL "She doesn't have him!" CR>)
				    (T <TELL "He doesn't have him!" CR>)>)>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<==? ,PRSO <LOC ,WINNER>>
		<TELL "You're in it, nitwit!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<==? <ITAKE> T>
		<TELL
"You are now carrying" THE-PRSO "." CR>)>>

<ROUTINE PRE-TAKEOUT ()
 <COND (<IOBJ? OFFICE-BACK-DOOR MONICA-BACK-DOOR LINDER-BACK-DOOR>
	<COND (<OR <DOBJ? CORPSE> <FSET? ,PRSO ,PERSON>>
	       <RFALSE>)	;"TAKE person OUTSIDE"
	      (T <TELL
"(If you want to go outside, simply type \"OUT.\")" CR>)>)
       (T <TELL
"(Sorry, but English is my second language. Please rephrase that.)" CR>)>>

<ROUTINE V-TAKEOUT ()
	 <TELL "[Foo!! This is a bug!!]" CR>>

<ROUTINE V-DISEMBARK ()
	 <COND (<==? <LOC ,PRSO> ,WINNER>
		<TELL
"You don't need to take out" THE-PRSO " to use it." CR>)
	       (<NOT <==? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (T
		<TELL "You are on your own feet again." CR>
		<MOVE ,WINNER ,HERE>)>>

;<ROUTINE V-HOLD-UP ()
	 <TELL "That doesn't seem to help at all." CR>>

<ROUTINE V-TELL ()
	 <COND (<==? ,PRSO ,PLAYER>
		<TELL
"Talking to yourself is a sign of impending looniness." CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)
	       (<OR <FSET? ,PRSO ,PERSON>
		    <AND ,MET-DUFFY? <==? ,PRSO ,GLOBAL-DUFFY>>>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>)
		      (T
		       <FSET ,PRSO ,TOUCHBIT>
		       <TELL D ,PRSO " is listening." CR>)>
		<SETG QCONTEXT ,PRSO>
		<SETG QCONTEXT-ROOM ,HERE>)
	       (T
		<TELL "You can't talk to" THE-PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE PRE-TELL-ME ("AUX" P)
 <COND (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>
	     <DOBJ? PLAYER>>
	<PERFORM ,V?ASK-ABOUT ,QCONTEXT ,PRSI>
	<RTRUE>)
       (<AND <DOBJ? PLAYER>
	     <SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>>
	<PERFORM ,V?ASK-ABOUT .P ,PRSI>
	<RTRUE>)>>

<ROUTINE V-TELL-ME ()
 <COND (<DOBJ? PLAYER>
	<TELL "You aren't talking to anyone!" CR>)
       (T <TELL D ,PRSO <PICK-ONE ,WHO-CARES> "." CR>)>>

<ROUTINE PRE-TELL-ME-ABOUT ("AUX" P)
 <COND (<AND ,QCONTEXT
	     <==? ,HERE ,QCONTEXT-ROOM>
	     <==? ,HERE <META-LOC ,QCONTEXT>>>
	<PERFORM ,V?ASK-ABOUT ,QCONTEXT ,PRSO>
	<RTRUE>)
       (<SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>
	<PERFORM ,V?ASK-ABOUT .P ,PRSO>
	<RTRUE>)>>

<ROUTINE V-TELL-ME-ABOUT ()
	<TELL "You aren't talking to anyone!" CR>>

<ROUTINE V-THANKS ("AUX" P)
	 <COND (<OR <AND ,PRSO <FSET? ,PRSO ,PERSON>>
		    <AND ,QCONTEXT
			 <==? ,HERE ,QCONTEXT-ROOM>
			 <==? ,HERE <META-LOC ,QCONTEXT>>>
		    <SET P <FIND-FLAG ,HERE ,PERSON ,WINNER>>>
		<TELL D <OR ,PRSO ,QCONTEXT .P>
			" acknowledges your thanks."CR>)
	       (T <TELL "You're more than welcome." CR>)>>

<ROUTINE V-THROW () <COND (<IDROP> <TELL "Thrown." CR>)>>

<ROUTINE V-THROW-AT ()
	 <COND (<NOT <IDROP>> <RTRUE>)
	       (<FSET? ,PRSI ,PERSON>
		<TELL D ,PRSI
		      ", puzzled by your unusual methods, ducks as"
		      THE-PRSO " flies by." CR>)
	       (T <TELL "Maybe you aren't feeling well." CR>)>>

<ROUTINE V-THROW-THROUGH ()
	 <COND (<NOT <FSET? ,PRSO ,PERSON>>
		<TELL "Let's not resort to violence, please." CR>)
	       (T <V-THROW>)>>

<ROUTINE PRE-TIE-TO ()
	 <COND (<OR <NOT <FSET? ,PRSO ,PERSON>>
		    <NOT <FSET? ,PRSI ,FURNITURE>>>
		<TELL "That won't do any good." CR>)>>

<ROUTINE V-TIE-TO ()
	<TELL "You can't tie" PRSO " to that." CR>>

<ROUTINE PRE-TIE-WITH ()
	 <COND (<OR <NOT <FSET? ,PRSO ,PERSON>>
		    <NOT <FSET? ,PRSI ,TOOLBIT>>>
		<TELL "That won't do any good." CR>)>>

<ROUTINE V-TIE-WITH ()
	<COND (<FSET? ,PRSO ,PERSON>
	       <TELL
"\"If you don't formally arrest me first, I'll sue!\"" CR>)
	      (T <TELL "You can't "
			 <COND (<IOBJ? HANDCUFFS> "handcuff ")
			       (T "tie " ;V)>
			 PRSO " with that." CR>)>>

<ROUTINE V-TURN () <TELL "This has no effect." CR>>

<ROUTINE V-LAMP-ON ()
	 <COND (<DOBJ? SINK GLOBAL-WATER>
		<TELL
"You turn the handle and lo! The water starts to run. Impressed
with yourself, you turn the handle again, and the water stops
running! You try it again, just to make sure. Bravo!" CR>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (T <TELL "You can't turn on" THE-PRSO "." CR>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "Your vulgar ways would turn anyone off." CR>)
	       (T <TELL "You can't turn off" THE-PRSO "." CR>)>>

<ROUTINE V-TURN-UP ()
	 <TELL "That's silly." CR>>

<ROUTINE V-TURN-DOWN ()
	 <TELL "That's silly." CR>>

<ROUTINE PRE-UNLOCK ()
 <COND (<DOBJ? CLOCK>
	<COND (<IN? ,CLOCK-KEY ,WINNER> <RFALSE>)
	      (T <TELL "You don't have the right key." CR>)>)
       (,LINDER-FOLLOWS-YOU
	<TELL
"Linder says, \"Don't leave yet. We're just getting started.\"" CR>)
       (<OUTSIDE? ,HERE>
	<COND (<IN? ,PHONG-KEYS ,WINNER> <RFALSE>)
	      (T <TELL "You don't have the right key." CR>)>)>>

<ROUTINE V-UNLOCK ()
	 <COND (<NOT <OR <FSET? ,PRSO ,CONTBIT> <FSET? ,PRSO ,DOORBIT>>>
		<TELL
"You'd have to be more clever to do that to" THE-PRSO "." CR>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "You'll have to close it first." CR>)
		      (<NOT <FSET? ,PRSO ,LOCKED>>
		       <TELL "It's already unlocked." CR>)
		      (<FSET? ,PRSO ,RMUNGBIT>
		       <TELL "You can't unlock it. The lock is broken." CR>)
		      (T
		       <FCLEAR ,PRSO ,LOCKED>
		       <TELL
"Okeh," THE-PRSO " is now unlocked." CR>)>)
	       (T <TELL "You can't unlock" THE-PRSO"."CR>)>>

<ROUTINE V-UNTIE ()
	 <TELL "You can't tie it, so you can't untie it!" CR>>

<ROUTINE V-USE ()
	 <TELL "You should be more specific about what you want to do." CR>>

"V-WAIT has three modes, depending on the arguments:
1) If only one argument is given, it will wait for that many moves.
2) If a second argument is given, it will wait the least of the first
   argument number of moves and the time at which the second argument
   (an object) is in the room with the player.
3) If the third argument is given, the second should be FALSE.  It will
   wait <first argument> number of moves (or at least try to).  The
   third argument means that an 'internal wait' is happening (e.g. for
   a 'careful' search)."

<GLOBAL WHO-WAIT 0>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 10) (WHO <>) (INT <>) "AUX" VAL HR(RESULT T))
	 #DECL ((NUM) FIX)
	 <SET HR ,HERE>
	 <SETG WHO-WAIT 0>
	 <COND (<NOT .INT> <TELL "Time passes..." CR>)>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<SET VAL <CLOCKER>>
			<COND (<OR <==? .VAL ,M-FATAL>
				   <NOT <==? .HR ,HERE>>>
			       <SET RESULT ,M-FATAL>
			       <RETURN>)
			      (<AND <==? .WHO ,GLOBAL-DUFFY>
				    ,MET-DUFFY?
				    <NOT ,FINGERPRINT-OBJ>
				    <NOT ,DUFFY-AT-CORONER>>
			       <RETURN>)
			      (<AND .WHO <IN? .WHO ,HERE>>
			       <FSET .WHO ,TOUCHBIT>
			       <TELL D .WHO
", for whom you are waiting, has arrived." CR>
			       <RETURN>)
			      (T
			       <SETG WHO-WAIT <+ ,WHO-WAIT 1>>
			       <COND (<NOT <==? <BAND <GETB 0 1> 16> 0>>
				      <TELL "(">
				      <TIME-PRINT ,PRESENT-TIME>
				      <TELL ") ">)>
			       <COND (.INT <TELL
"Do you want to continue what you were doing?">)
				     (T <TELL
"Do you want to keep waiting?">)>
			       <COND (<NOT <YES?>> <RETURN>)
				     (T <USL>)>)>)
		       (<AND <==? .WHO ,GLOBAL-DUFFY>
			     <NOT ,FINGERPRINT-OBJ>
			     <NOT ,DUFFY-AT-CORONER>>
			<RETURN>)
		       (<AND .WHO <IN? .WHO ,HERE>>
			<TELL D .WHO
", for whom you are waiting, has arrived." CR>
			<RETURN>)
		       (<AND .WHO <G? <SETG WHO-WAIT <+ ,WHO-WAIT 1>> 30>>
			<TELL D .WHO
" still hasn't arrived.  Do you want to keep waiting?">
			<COND (<NOT <YES?>> <RETURN>)>
			<SETG WHO-WAIT 0>
			<USL>)
		       (T <USL>)>>
	 <SETG CLOCK-WAIT T>
	 <COND (<NOT .INT> <V-TIME>)>
	 .RESULT>

<ROUTINE INT-WAIT (N "AUX" TIM REQ VAL)
	 <SET TIM ,PRESENT-TIME>
	 <COND (<==? ,M-FATAL <V-WAIT <SET REQ <RANDOM <* .N 2>>> <> T>>
		<RFATAL>)
	       (<NOT <L? <- ,PRESENT-TIME .TIM> .REQ>>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE V-WAIT-FOR ("AUX" WHO)
	 <COND (<==? ,PRSO ,INTNUM>
		<COND (<G? ,P-NUMBER ,PRESENT-TIME> <V-WAIT-UNTIL> <RTRUE>)
		      (<G? ,P-NUMBER 180>
		       <TELL "That's too long to wait." CR>)
		      (T <V-WAIT ,P-NUMBER>)>)
	       (<==? ,PRSO ,GLOBAL-HERE> <V-WAIT> <RTRUE>)
	       (<==? ,PRSO ,MIDNIGHT> <V-WAIT-UNTIL> <RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<SET WHO <GET ,CHARACTER-TABLE
			      <GETP ,PRSO ,P?CHARACTER>>>
		<COND (<IN? .WHO ,HERE>
		       <TELL "That person's already here!" CR>)
		      (T <V-WAIT 10000 .WHO>)>)
	       (<DOBJ? PLAYER> <TELL "You're already here!" CR>)
	       (T <TELL "Not a good idea. You might wait all night." CR>)>>

<ROUTINE V-WAIT-UNTIL ()	;"?? time?"
	 <COND (<==? ,PRSO ,MIDNIGHT>
		<SETG P-NUMBER 720>
		<SETG PRSO ,INTNUM>)
	       (<L? ,P-NUMBER 8>
		<SETG P-NUMBER <* <+ ,P-NUMBER 12> 60>>)
	       (<L? ,P-NUMBER 13>
		<SETG P-NUMBER <* ,P-NUMBER 60>>)>
	 <COND (<==? ,PRSO ,INTNUM>
		<COND (<G? ,P-NUMBER ,PRESENT-TIME>
		       <V-WAIT <- ,P-NUMBER ,PRESENT-TIME>>)
		      (T <TELL
"You are clearly ahead of your time." CR>)>)
	       (T <TELL "It has been a long week, hasn't it?" CR>)>>

<ROUTINE V-ALARM ()
	 <COND (<==? ,PRSO ,CAT>
		<TELL
"The cat yawns, licks its lips, and settles down again." CR>)
	       (<==? ,PRSO ,MONICA>
		<TELL "You wouldn't like that." CR>)	;"?"
	       (<FSET? ,PRSO ,PERSON>
		<TELL "He's wide awake, or haven't you noticed?" CR>)
	       (ELSE
		<TELL
"Too bad, but" THE-PRSO " isn't asleep." CR>)>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 #DECL ((PT) <OR FALSE TABLE> (PTS) FIX
		(OBJ) OBJECT (RM) <OR FALSE OBJECT>)
	 <COND (<==? ,PRSO ,GLOBAL-CALL>
		<PERFORM ,V?TURN ,PRSO>
		<RTRUE>)
	       (<NOT ,PRSO> <TELL "You can't go that way." CR>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <SET RM <GETB .PT ,REXIT>>
		       <GOTO .RM>)
		      (<==? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<==? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<==? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<==? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<AND <FSET? .OBJ ,INVISIBLE>
				   <NOT <AND ,DEBUG
					     <TELL "[invisible] ">>>>
			      <TELL "You can't go that way." CR>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "Too bad, but">
			      <THE? .OBJ>
			      <TELL " " D .OBJ " is closed." CR>
			      <SETG P-IT-LOC ,HERE>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)>)>)
	       (<==? ,PRSO ,P?IN>
		<TELL "(What compass direction do you want to go in?)" CR>
		<RFATAL>)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "(Use compass directions to move around here.)" CR>>

<ROUTINE V-WALK-TO ()
 <COND (<OR <EQUAL? <META-LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>
	    <FSET? ,PRSO ,DOORBIT>
	    <FSET? ,PRSO ,WINDOWBIT>>
	<TELL "You don't need to walk around within a "
		<COND (<OUTSIDE? ,HERE> "part of the yard.")
		      (<NOT <0? <BAND 16 <GETP ,HERE ,P?CORRIDOR>>>>
		       "part of the hall.")
		      (T "room.")>
		CR>)
       (<IN? <META-LOC ,PRSO> ,ROOMS>
	<SETG PRSO <META-LOC ,PRSO>>
	<V-THROUGH>)
       (T
	<TELL
"You can't go from here to there, at least not directly." CR>)>>

<ROUTINE V-RUN-OVER ()
	 <TELL "That doesn't make much sense." CR>>

<ROUTINE V-WHAT ()
	 <COND (<OR <AND ,QCONTEXT
			 <==? ,HERE ,QCONTEXT-ROOM>
			 <==? ,HERE <META-LOC ,QCONTEXT>>
			 <FSET? ,QCONTEXT ,PERSON>>
		    <FIND-FLAG ,HERE ,PERSON ,WINNER>>
		<TELL "\"Isn't it obvious?\"" CR>)
	       (<FSET? ,PRSO ,PERSON>
		<TELL "Try asking that person." CR>)
	       (T <TELL "Are you talking to yourself again?" CR>)>>

<ROUTINE V-YN ()
	 <COND (<AND ,QCONTEXT
		     <==? ,HERE ,QCONTEXT-ROOM>
		     <==? ,HERE <META-LOC ,QCONTEXT>>>
		<TELL D ,QCONTEXT " ignores you completely." CR>)
	       (T <TELL "That deserves to be ignored." CR>)>>

