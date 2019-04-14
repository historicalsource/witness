"MAIN for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>

<CONSTANT M-HANDLED 1>   

<CONSTANT M-NOT-HANDLED <>>   

<CONSTANT M-BEG 1>  

<CONSTANT M-END 6> 

<CONSTANT M-ENTER 2>

<CONSTANT M-LOOK 3> 

<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<ROUTINE GO ()
	 <PUTB ,P-LEXV 0 59>
	 <SETG LIT T>
	 <SETG SCORE 20>
	 <SETG WINNER ,PLAYER>
	 <SETG HERE ,DRIVEWAY-ENTRANCE>
	 <THIS-IS-IT ,FRONT-DOOR>
	 <THIS-IS-S-HE ,PHONG>
	 <SETG DIFFICULTY ,DIFFICULTY-MAX>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<QUEUE-MAIN-EVENTS>
		<START-MOVEMENT>
	 	<INTRO>
		<V-VERSION>
		<CRLF>)>
	 <MOVE ,PLAYER ,HERE>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>    


<ROUTINE MAIN-LOOP ("AUX" TRASH)
	<REPEAT ()
	     <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP) 
   #DECL ((CNT OCNT ICNT NUM) FIX (V) <OR 'T FIX FALSE> (OBJ)<OR FALSE OBJECT>
	  (OBJ1) OBJECT (TBL) TABLE (PTBL) <OR FALSE ATOM>)
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<NOT <==? ,QCONTEXT-ROOM ,HERE>>
	    <SETG QCONTEXT <>>)>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET NUM
		 <COND (<0? <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<==? ,PRSA ,V?WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (T
			  <TELL "(There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (,P-OFLAG
				 <PRINTB <GET .TMP 0>>)
				(T
				 <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
			  <TELL "!)" CR>
			  <SET V <>>)>)
		  (<AND .PTBL <G? .NUM 1> <VERB? ARREST COMPARE>>
		   <SET V <PERFORM ,PRSA ,OBJECT-PAIR>>)
		  (T
		   <SET TMP 0>
		   <REPEAT ()
		    <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			   <COND (<G? .TMP 0>
				  <TELL "The other object">
				  <COND (<NOT <EQUAL? .TMP 1>>
					 <TELL "s">)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? .TMP 1>>
					 <TELL "are">)
					(T <TELL "is">)>
				  <TELL "n't here." CR>)>
			   <RETURN>)
			  (T
			   <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
				 (T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			   <COND (<G? .NUM 1>
				  <COND (<==? .OBJ1 ,NOT-HERE-OBJECT>
					 <SET TMP <+ .TMP 1>>
					 <AGAIN>)
					(<==? .OBJ1 ,PLAYER> <AGAIN>)
					;(<FSET? .OBJ1 ,DUPLICATE> <AGAIN>)
					(T
					 <COND (<EQUAL? .OBJ1 ,IT>
						<PRINTD ,P-IT-OBJECT>)
					       (T <PRINTD .OBJ1>)>
					 <TELL ": ">)>)>
			   <SET V <QCONTEXT-CHECK <COND (.PTBL .OBJ1)
							(T .OBJ)>>>
			   <SET V
				<PERFORM ,PRSA ;"? SETG PRSx to these?"
					 <COND (.PTBL .OBJ1) (T .OBJ)>
					 <COND (.PTBL .OBJ)(T .OBJ1)>>>
			   <COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	    <COND (<==? .V ,M-FATAL> <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE TIME SAVE
			  SPACE UNSPACE SCRIPT UNSCRIPT $VERIFY
			  QUIT RESTART $WHERE DEBUG $TANDY
			  ;"DIAGNOSE INVENTORY SCORE" VERSION> T)
		  (T <SET V <CLOCKER>>)>)>>

<ROUTINE QCONTEXT-CHECK (PRSO "AUX" OTHER (WHO <>) (N 0))
	 <COND (<OR <VERB? ;FIND HELP WHAT>
		    <AND <VERB? SHOW TELL-ME> <==? .PRSO ,PLAYER>>> ;"? more?"
		<SET OTHER <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<NOT .OTHER> <RETURN>)
			      (<FSET? .OTHER ,PERSON>
			       <SET N <+ 1 .N>>
			       <SET WHO .OTHER>)>
			<SET OTHER <NEXT? .OTHER>>>
		<COND (<AND <==? 1 .N> <NOT ,QCONTEXT>>
		       <SAID-TO .WHO>)>
		<COND (<AND ,QCONTEXT
			    <IN? ,QCONTEXT ,HERE>
			    <==? ,QCONTEXT-ROOM ,HERE>
			    <==? ,WINNER ,PLAYER>> ;"? more?"
		       <SETG WINNER ,QCONTEXT>
		       <TELL "(said to " D ,QCONTEXT ")" CR>)>)>>

<ROUTINE SAID-TO (WHO)
 <SETG WINNER .WHO>
 <SETG QCONTEXT .WHO>
 <SETG QCONTEXT-ROOM ,HERE>>

"<GLOBAL L-PRSA <>>  
 
<GLOBAL L-PRSO <>>  
 
<GLOBAL L-PRSI <>>"  

<ROUTINE FAKE-ORPHAN ("AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <TELL "(Be specific: what object do you want to ">
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<==? .TMP 0> <TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <TELL "?)" CR>>

<GLOBAL NOW-PRSI <>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V)ANY)
	<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? PREDGEN> '<TELL N .A>)
		      (T '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL "/" D .O>)>
	       <COND (.I <TELL "/" D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<NOT <EQUAL? .A ,V?WALK>>
	       <COND (<AND <EQUAL? ,IT .I .O>
			   <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
		      <COND (<NOT .I> <FAKE-ORPHAN>)
			    (T
			    <TELL "(The " D ,P-IT-OBJECT " isn't here!)" CR>)>
		      <RFATAL>)
		     (<AND <EQUAL? ,HIM-HER .I .O>
			   <NOT <EQUAL? <META-LOC ,P-HIM-HER> ,HERE>>>
		      <SETG P-HIM-HER <GET ,GLOBAL-CHARACTER-TABLE
					  <GETP ,P-HIM-HER ,P?CHARACTER>>>)>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)
	      (<==? .O ,HIM-HER> <SET O ,P-HIM-HER>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)
	      (<==? .I ,HIM-HER> <SET I ,P-HIM-HER>)>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <COND (<FSET? ,PRSO ,PERSON>
		      <SETG P-HIM-HER ,PRSO>
		      <SETG P-HIM-HER-LOC ,HERE>)
		     (T
		      <SETG P-IT-OBJECT ,PRSO>
		      <SETG P-IT-LOC ,HERE>)>)>
	<SETG PRSI .I>
	;<COND (<NOT <==? .A ,V?AGAIN>>
	       <SETG L-PRSA .A>
	       <COND (<==? .A ,V?WALK> <SETG L-PRSO <>>)
		     (T <SETG L-PRSO .O>)>
	       <SETG L-PRSI .I>)>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>> .V)
	      (<AND <SET O ,PRSO> <SET I ,PRSI> <NULL-F>>
	       <TELL "[in case last clause changed PRSx]">)
	      (<SET V <DD-APPLY "Actor" ,WINNER <GETP ,WINNER ,P?ACTION>>> .V)
	      (<SET V <D-APPLY "Room (M-BEG)"
			       <GETP <LOC ,WINNER> ,P?ACTION>
			       ,M-BEG>> .V)
	      (<SET V <D-APPLY "Preaction"
			       <GET ,PREACTIONS .A>>> .V)
	      (<AND .I
		    <SETG NOW-PRSI T>
		    <SET V <D-APPLY "PRSI" <GETP .I ,P?ACTION>>>>
	       .V)
	      (<AND <NOT <SETG NOW-PRSI <>>>
		    .O
		    <NOT <==? .A ,V?WALK>>
		    <LOC .O>
		    <GETP <LOC .O> ,P?CONTFCN>
		    <SET V <DD-APPLY "Container" <LOC .O>
				    <GETP <LOC .O> ,P?CONTFCN>>>>
	       .V)
	      (<AND .O
		    <NOT <==? .A ,V?WALK>>
		    <SET V <D-APPLY "PRSO"
				    <GETP .O ,P?ACTION>>>>
	       .V)
	      (<SET V <D-APPLY <>
			       <GET ,ACTIONS .A>>> .V)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       <COND (<==? <LOC ,WINNER> ,PRSO>	;"was not in compiled PERFORM"
		      <SETG PRSO <>>)>
	       <SET V <D-APPLY "Room (M-END)"
			       <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE DD-APPLY (STR OBJ FCN "OPTIONAL" (FOO <>))
	<COND (,DEBUG <TELL "[" D .OBJ "=]">)>
	<D-APPLY .STR .FCN .FOO>>

<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "[Action:]" CR>)
			    (T <TELL "[" .STR ": ">)>)>
	       <SET RES
		    <COND (.FOO <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,DEBUG .STR>
		      <COND (<==? .RES ,M-FATAL>
			     <TELL "Fatal]" CR>)
			    (<NOT .RES>
			     <TELL "Not handled]" CR>)
			    (T <TELL "Handled]" CR>)>)>
	       .RES)>>
