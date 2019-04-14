"PEOPLE for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

"Necessary Flags"

<GLOBAL LOAD-MAX 100>
<GLOBAL LOAD-ALLOWED 100>

<OBJECT HIM-HER
	(IN GLOBAL-OBJECTS)
	(SYNONYM HE SHE HIM HER)
	(DESC "him or her")
	(FLAGS NDESCBIT)>

<OBJECT YOU
	(IN GLOBAL-OBJECTS)
	(SYNONYM YOURSELF HIMSELF HERSELF)
	(DESC "himself or herself")
	(FLAGS NDESCBIT)
	(ACTION YOU-F)>

<ROUTINE YOU-F ()
 <COND (<AND <VERB? ASK-ABOUT> <IOBJ? YOU>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSO>
	<RTRUE>)
       (<AND <VERB? TELL-ME> <IOBJ? YOU>>
	<PERFORM ,V?TELL-ME ,PRSO ,WINNER>
	<RTRUE>)>>

<OBJECT OBJECT-PAIR
	(DESC "such things")
	(ACTION OBJECT-PAIR-F)>

<ROUTINE OBJECT-PAIR-F ("AUX" P1 P2)
 <COND (<L? 2 <GET ,P-PRSO ,P-MATCHLEN>>
	<COND (<VERB? ARREST>
	       <TELL
"You think it over. You realize that this arrest is pretty far-fetched.
It could only mean humiliation for you." CR>)
	      (<VERB? COMPARE>
	       <TELL
"That's too many things to compare all at once!" CR>)>
	<RTRUE>)
       (<AND <VERB? ARREST> <NOT <FSET? ,CORPSE ,INVISIBLE>>>
	<COND (<IN? <SET P1 <1 ,P-PRSO>> ,GLOBAL-OBJECTS>
	       <SET P1 <GET ,CHARACTER-TABLE <GETP .P1 ,P?CHARACTER>>>)>
	<COND (<IN? <SET P2 <2 ,P-PRSO>> ,GLOBAL-OBJECTS>
	       <SET P2 <GET ,CHARACTER-TABLE <GETP .P2 ,P?CHARACTER>>>)>
	<ARREST .P1 .P2>)
       (<VERB? COMPARE>
	<PERFORM ,PRSA <1 ,P-PRSO> <2 ,P-PRSO>>
	<RTRUE>)>>

"People"

"Constants used as table offsets for each character, including the player:"

<CONSTANT PLAYER-C 0>
<CONSTANT PHONG-C 1>
<CONSTANT LINDER-C 2>
<CONSTANT STILES-C 3>
<CONSTANT MONICA-C 4>
<CONSTANT CAT-C 5>
<CONSTANT CHARACTER-MAX 5>

<GLOBAL CHARACTER-TABLE
	<PTABLE PLAYER PHONG LINDER STILES MONICA CAT>> 

<GLOBAL GLOBAL-CHARACTER-TABLE
	<PTABLE PLAYER GLOBAL-PHONG GLOBAL-LINDER GLOBAL-STILES GLOBAL-MONICA
		GLOBAL-CAT>>

<OBJECT PLAYER
	(IN DRIVEWAY-GATE)
	(DESC "detective")
	(SYNONYM I ME MYSELF DETECTIVE)
	(ACTION PLAYER-F)
	(FLAGS NDESCBIT TRANSBIT)
	(CHARACTER 0)>

<GLOBAL PLAYER-HIDING <>>

<ROUTINE PLAYER-F ()
 <COND (<AND <VERB? SHOOT> <DOBJ? PLAYER>>
	<TELL
"What, and let down the Police Department track-and-field team?!" CR>)
       (<AND <NOT ,PLAYER-HIDING> <IN? <LOC ,PLAYER> ,ROOMS>>
	<RFALSE>)
       (<NOT ,PRSO>
	<RFALSE>)
       (<VERB? WALK>
	<TOO-BAD-SIT-HIDE>)
       (<AND ,PLAYER-HIDING
	     <VERB? $CALL TELL HELLO GOODBYE ASK-ABOUT ASK-FOR>>
	<TOO-BAD-SIT-HIDE>)
       (<NOT <STANDING-VERB?>>
	<RFALSE>)
       (<NOT <IN? ,PRSO ,WINNER>>
	<COND (<AND <VERB? EXAMINE>
		    <NOT <==? ,P-ADVERB ,W?CAREFULLY>>
		    <OR ;<FSET? ,PRSO ,PERSON>
			<DOBJ? CLOCK>
			<==? ,OFFICE <LOC ,PRSO>>>>
	       <TELL
"You'd do a much better job if you stood up, but let's see..." CR>
	       <RFALSE>)
	      (<AND <IN? ,PLAYER ,CARVED-CHAIR>
		    <VERB? FIND PUSH RING>
		    <DOBJ? BUTTON OFFICE-BUTTON>>
	       <RFALSE>)
	      (<AND <VERB? TAKE> <DOBJ? HINT>>
	       <RFALSE>)
	      (T
	       <TOO-BAD-SIT-HIDE>)>)
       (<NOT ,PRSI>			<RFALSE>)
       (<IN? ,PRSI ,WINNER>		<RFALSE>)
       (T
	<TOO-BAD-SIT-HIDE>)>>

<ROUTINE STANDING-VERB? ()
 <COND (<VERB? ATTACK BRUSH ;BURN CLOSE DRINK EAT ENTER EXAMINE
	       FINGERPRINT FOLLOW HANDCUFF HIDE-BEHIND
	       KICK KILL KISS KNOCK LOCK
	       LOOK-BEHIND LOOK-INSIDE LOOK-OUTSIDE LOOK-UNDER MAKE MOVE
	       MUNG OPEN PHONE PICK ;PLAY PUSH PUT PUT-UNDER
	       RAISE RAPE READ REVIVE RING RUB RUB-OVER
	       SEARCH SEARCH-OBJECT-FOR SIT SLAP SMELL
	       TAKE TAKEOUT THROUGH TIE-TO TIE-WITH
	       UNLOCK UNTIE USE WALK WALK-AROUND WALK-TO>
	T)>>

<ROUTINE TOO-BAD-SIT-HIDE ()
 <SETG P-CONT <>>
 <COND (<NOT <IN? <LOC ,PLAYER> ,ROOMS>>
	<COND (<VERB? SIT> <TELL "You're already sitting down." CR>)
	      (T <TELL
"You'd do a much better job if you stood up." CR>)>)
       (,PLAYER-HIDING
	<COND (<VERB? HIDE-BEHIND> <TELL "You're already hiding."CR>)
	      (T <TELL
"You can't do that while you're hiding." CR>)>)>>

<OBJECT PHONG
	(IN KITCHEN)
	(DESC "Mr. Phong")
	(ADJECTIVE MR MISTER HUI ASIAN ORIENTAL)
	(SYNONYM PHONG MAN)
	(ACTION PHONG-F)
	(DESCFCN PHONG-F)
	(XDESC "Asian man")
	(TEXT
"Phong's straight black hair and folded eyelids make him obviously
Asian, but no definite nationality. His open, almost gentle face holds a
quick smile and eyes that seem to miss nothing. He carries his stout
body lightly, but you can see great strength under his light shirt and
dark trousers. You guess his age at about fifty, but who knows how many
lifetimes of experience he carries?")
	(FLAGS PERSON ;OPENBIT)
	(CAPACITY 40)
	(CHARACTER 1)>

<OBJECT PHONG-SHOES
	(DESC "pair of Phong's shoes")
	(IN PHONG)
	(ADJECTIVE PHONG PHONGS ;PHONG\'S HIS)
	(SYNONYM PAIR SHOE SHOES)
	(FLAGS NDESCBIT)
	(ACTION RANDOM-SHOES-F)>

<OBJECT GLOBAL-PHONG
	(DESC "Mr. Phong")
	(IN GLOBAL-OBJECTS)
	(SYNONYM PHONG)
	(ADJECTIVE MR MISTER HUI)
	(FLAGS PERSON)
	(ACTION GLOBAL-PERSON)
	(CHARACTER 1)>

<GLOBAL PHONG-HAS-MOTIVE <>>
<GLOBAL PHONG-ADMITTED-HELPING? <>>

<ROUTINE PHONG-F ("OPTIONAL" (ARG <>) "AUX" OBJ (L <LOC ,PHONG>))
 <COND (<==? .ARG ,M-OBJDESC>
	<COND (<IN-MOTION? ,PHONG> <RTRUE>)
	      (<FSET? ,PHONG ,TOUCHBIT>
	       <COND (<AND <NOT <FSET? ,LINDER ,TOUCHBIT>>
			   <==? ,HERE <LOC ,LINDER>>>
		      <TELL CR
"\"Excuse me, sir,\" says Phong, \"but the detective has arrived.\"" CR CR>)
		     (<==? .L ,BUTLER-ROOM>
		      <TELL "Phong is lying on the bed, ">
		      <COND (<IN? ,RECURSIVE-BOOK ,PHONG>
			     <TELL "reading a book." CR>)
			    (T <TELL "meditating." CR>)>)
		     (<AND <==? .L ,KITCHEN> <L? ,PRESENT-TIME 710>>
		      <TELL "Phong is here, "
			    <GET ,KITCHEN-ACTIVITIES
				 <+ 1 </ <- ,PRESENT-TIME 480> 60>>> "." CR>)
		     (<AND <==? .L ,OFFICE> <IN? ,CORPSE ,OFFICE>
			   ,PHONG-SEEN-CORPSE?>
		      <TELL "Phong is gazing out the window." CR>)
		     (<==? .L ,ENTRY>
		      <TELL "Phong is waiting for you to do something." CR>)
		     (T <TELL "Phong is here, "
				<PICK-ONE ,PHONG-HERE> "." CR>)>)
	      (T
	       <FSET ,PHONG ,TOUCHBIT>
	       <TELL <GETP ,PHONG ,P?TEXT> CR>)>
	<RTRUE>)
       (<==? ,WINNER ,PHONG>
	<COND (<AND <VERB? FIND>
		    <DOBJ? PHONG-KEYS>>
	       <SETG WINNER ,PLAYER>
	       <PERFORM ,V?ASK-ABOUT ,PHONG ,PRSO>
	       <RTRUE>)
	      (<VERB? FIND THANKS> <RFALSE>)
	      (<VERB? SLAP>
	       <TELL "\"No, I must be careful about that.\"" CR>)
	      (<OR <AND <VERB? GIVE>
		       <DOBJ? PHONG-KEYS GENERIC-KEY GENERIC-GUN OUTSIDE-GUN>>
		   <AND <VERB? SGIVE>
		      <IOBJ? PHONG-KEYS GENERIC-KEY GENERIC-GUN OUTSIDE-GUN>>>
	       <TAKE-PHONG-KEYS>)
	      (<VERB? OPEN CLOSE LOCK UNLOCK>
	       <COND (<FSET? ,CORPSE ,INVISIBLE>
		      <TELL
"\"You'll have to ask Mr. Linder about that.\""CR>)
		     (<DOBJ? CLOCK ;GLOBAL-CLOCK>
		      <TELL "\"I don't have the key for the clock.\"" CR>)
		     (<AND <VERB? OPEN UNLOCK> <IN? ,PHONG-KEYS ,PHONG>>
		      <FCLEAR ,PRSO ,LOCKED>
		      <COND (<VERB? OPEN> <FSET ,PRSO ,OPENBIT>)>
		      <TELL "\"Okey.\"" CR>)
		     (<AND <VERB? CLOSE LOCK> <IN? ,PHONG-KEYS ,PHONG>>
		      <FCLEAR ,PRSO ,OPENBIT>
		      <COND (<VERB? LOCK> <FSET ,PRSO ,LOCKED>)>
		      <TELL "\"Okey.\"" CR>)>)
	      (<COM-CHECK ,PHONG> <RTRUE>)
	      (T <TELL <PICK-ONE ,WHY-ME> CR>)>)
       (<VERB? ACCUSE>
	<COND (<NOT ,PHONG-SEEN-CORPSE?>
	       <TELL
"\"What are you talking about?\" He looks frightened." CR>)
	      (<AND ,SIDE-FOOTPRINTS-MATCHED <FSET? ,GUN-RECEIPT ,TOUCHBIT>>
	       <SETG PHONG-ADMITTED-HELPING? T>
	       <DISCRETION ,PHONG ,MONICA>
	       <TELL
"\"It's true I helped set you up for deception with the guns. But only
because Mr. Linder asked me to! He said he wanted to frighten Stiles.
He wasn't supposed to be killed! Monica must have muffed it. Or else ...
could she ...?\" He looks confused and angry." CR>)
	      (,SIDE-FOOTPRINTS-MATCHED
	       <TELL
"\"I don't see why you're accusing me!" " Sure, I was in the yard, because "
"I thought I heard a
noise outside and went out to investigate."
" It's part of my job, you know.\""
CR>)
	      (<FSET? ,GUN-RECEIPT ,TOUCHBIT>
	       <DISCRETION ,PHONG ,MONICA>
	       <TELL
"\"I don't see why you're accusing me!" " You should ask Monica about those
guns.\"" CR>)
	      (T <TELL "\"You haven't a clue, and you know it!\"" CR>)>)
       (<OR <AND ,PRSI <SET OBJ ,PRSI><VERB? ASK-ABOUT CONFRONT><DOBJ? PHONG>>
	    <AND ,PRSO <IN? ,PRSO ,GLOBAL-OBJECTS> <SET OBJ ,PRSO>
		 <VERB? FIND WHAT>>>
	<COND (<NOT <GRAB-ATTENTION ,PHONG>> <RTRUE>)>
	<SAID-TO ,PHONG>
	<COND (<EQUAL? .OBJ ,BUTTON>
	       <TELL "\"That's my butler's button, of course.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-CAN-OF-WORMS>
	       <TELL
"\"I didn't think you had any interest in gardening! Those little babies
are the best thing for the clay soil around here. You can just order
them by mail and open them up when they arrive.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-GUN>
	       <TELL "\"I don't have one, if that's what you mean.\"" CR>)
	      (<EQUAL? .OBJ ,BLACK-WIRE>
	       <TELL
"\"Oh, Monica wired the house for butler's buttons.\"" CR>)
	      (<EQUAL? .OBJ ,WHITE-WIRE>
	       <TELL
"\"Oh, Monica wired the windows with burglar alarms.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-GREEN-WIRE ,GENERIC-WIRE>
	       <TELL
"\"There's wire all over the house. You'll have to ask Monica.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-KEY ,PHONG-KEYS>
	       <COND (<IN? ,PHONG-KEYS ,PHONG>
		      <TELL
"\"I have the keys for all the doors in the house.\"" CR>)
		     (T
		      <TELL
"\"Don't you remember? I gave you all the keys I have.\"" CR>)>)
	      (<EQUAL? .OBJ ,CLOCK-KEY>
	       <COND (<IN? ,CLOCK-KEY ,PLAYER>
		      <TELL
"\"That looks like the key to Mr. Linder's clock.\"" CR>)
		     (T <TELL
"\"There's only one key to Mr. Linder's clock. I think he keeps it in
the office somewhere.\"" CR>)>)
	      (<EQUAL? .OBJ ,GLOBAL-LINDER ,LINDER ,CORPSE>
	       <COND (<IN? ,LINDER ,HERE>
		      <TELL
"\"That man is a marvel. Always seems to have several deals going at
once. I don't know how he does it.\" Linder beams with self-pride." CR>)
		     (,PHONG-SEEN-CORPSE?
		      <SETG PHONG-HAS-MOTIVE ,CORPSE>
		      <DISCRETION ,PHONG ,MONICA>
		      <TELL
"\"Frankly, Detective, I can't say I" "'m sorry he's dead"
". He always promised me wealth here in America, but I've never seen it.
I could " "have managed" " the
Asian branch of his business if he'd let me. If I had any money, I'd quit
on the spot and return home.\"" CR>)
		     (T
		      <SETG PHONG-HAS-MOTIVE ,LINDER>
		      <DISCRETION ,PHONG ,MONICA>
		      <TELL
"\"Frankly, Detective, I can't say I" " like him much"
". He always promised me wealth here in America, but I've never seen it.
I could " "manage" " the
Asian branch of his business if he'd let me. If I had any money, I'd quit
on the spot and return home.\"" CR>)>)
	      (<EQUAL? .OBJ ,GLOBAL-MONICA ,MONICA>
	       <DISCRETION ,PHONG ,MONICA>
	       <TELL
"\"She's an intelligent girl. Mr. Linder is very proud of her, but I
think she acts too much like a man.">
	       <COND (,PHONG-SEEN-CORPSE?
		      <TELL " She really muffed it this time.">)>
	       <TELL "\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-AFFAIR ,GLOBAL-MRS-LINDER>
	       <DISCRETION ,PHONG ,LINDER>
	       <TELL
"\"If only Mr. Linder had been home more, he could have kept her in
line.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-PHONG ,PHONG>
	       ;<DISCRETION ,PHONG ,LINDER>
	       <SETG PHONG-HAS-MOTIVE ,PHONG>
	       <TELL
"\"Mr. Linder brought me here from Asia, to help manage his business and
run his house. I guess I do more running than managing. If I can help you,
just push the button anywhere in the house.\"" CR>)
	      (<AND ,SHOT-FIRED <EQUAL? .OBJ ,GLOBAL-SHOT>>
	       <TELL
"\"I was in the kitchen and heard a sound like a gunshot, so I ran to the
office and found you and Mr. Linder. You were closer to it than I was.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-STILES ,STILES>
	       <DISCRETION ,PHONG ,LINDER>
	       <TELL
"\"He used to come around here now and then, when Mr. Linder was away. I
never thought much about it until the fighting between Mr. and Mrs. got
bad, just before Mrs. Linder passed on.\" He pauses. \"I think Mr. Linder
has been calling him on the telephone a lot lately.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-SUICIDE>
	       <SETG MONICA-HAS-MOTIVE ,PHONG>
	       <DISCRETION ,PHONG ,LINDER ,MONICA>
	       <TELL
"\"Everyone was sad about that. Mr. Linder just threw himself into his
work, as usual. Monica was terribly depressed, didn't even come out of
her room for a long time. I doubt she'll ever get over it.\"" CR>)
	      (<EQUAL? .OBJ ,WILL>
	       <COND (,PHONG-SEEN-CORPSE?
		      ;<SETG PHONG-HAS-MOTIVE ,WILL>
		      <DISCRETION ,PHONG ,MONICA>
		      <TELL
"\"Mr. Linder probably kept it in his bank safe. I've never seen it.\"" CR>)
		     (T <TELL
"\"You'll have to ask Mr. Linder about that.\"" CR>)>)
	      (<EQUAL? .OBJ ,BROOM>
	       <TELL
"\"What can I tell you? That's a 'flathead broom,' invented by your
American Shakers, I believe.\"" CR>)
	      (<AND <EQUAL? .OBJ ,DOORBELL> ,PHONG-SEEN-CORPSE?>
	       <TELL
"He seems surprised. \"Uh, that was just some door-to-door salesman.\"" CR>)
	      (<EQUAL? .OBJ ,GUN-RECEIPT>
	       <DISCRETION ,PHONG ,MONICA>
	       <TELL
"\"Yes, I think Monica bought those, using some other name.\"" CR>)
	      (<EQUAL? .OBJ ,MATCHBOOK>
	       <TELL
"\"I've heard Mr. Linder mention that restaurant." " But I don't recognize
the phone number.\"" CR>)
	      (<EQUAL? .OBJ ,BRASS-LANTERN>
	       <TELL
"\"I've heard Mr. Linder mention that restaurant." "\"" CR>)
	      (<EQUAL? .OBJ ,MEDICAL-REPORT ,TUMOR>
	       <TELL
"Phong looks surprised but not alarmed. \"This is the first I've
heard of this.\"" CR>)
	      (<EQUAL? .OBJ ,MUDDY-SHOES>
	       <SETG SIDE-FOOTPRINTS-MATCHED T>
	       <TELL
"\"Those are my gardening boots. They're muddy because, while you were
in the office, " "I thought I heard a
noise outside and went out to investigate." "\"" CR>)
	      (<OR <EQUAL? .OBJ ,OFFICE-BUTTON ,CLOCK>
		   <EQUAL? .OBJ ,POWDER ,CLOCK-POWDER>>
	       <COND (,PLAYER-PUSHED-BUTTON
		      <SETG PHONG-ADMITTED-HELPING? T>
		      <DISCRETION ,PHONG ,MONICA>
		      <TELL
"\"I might as well tell you: Mr. Linder concocted this scheme to frighten
Stiles, and he got Monica and me to help him. But he was supposed to be
only wounded, not killed!\"" CR>
		      <RTRUE>)>
	       <COND (,PHONG-SEEN-CORPSE?
		      <TELL "Phong seems shaken, but all he says is, ">)>
	       <COND (<EQUAL? .OBJ ,OFFICE-BUTTON>
		      ;<OR ,BUTTON-FIXED <NOT ,SHOT-FIRED>>
		      <TELL
"\"That's my butler's button, of course.\"" CR>)
		     (<EQUAL? .OBJ ,CLOCK>
		      ;<OR ,BUTTON-FIXED <NOT ,SHOT-FIRED>>
		      <TELL
"\"Mr. Linder has a certain fondness for elaborate things like that.\"" CR>)
		     (T
		      <TELL
"\"If it's dust you're after, I plead guilty to plenty of it.\"" CR>)>)
	      (<EQUAL? .OBJ ,PIECE-OF-WIRE ,CLOCK-WIRES ,PIECE-OF-PUTTY>
	      <TELL "\"Oh, I guess that's part of the burglar alarm.\"" CR>)
	      (<EQUAL? .OBJ ,RECURSIVE-BOOK>
	       <TELL
"\"It's a mystery called 'Deadline.' Monica recommended it to me.\"" CR>)
	      (<EQUAL? .OBJ ,TELEGRAM>
	       <TELL
"\"Yes, that's the telegram Mr. Linder sent this morning.\"" CR>)
	      (<EQUAL? .OBJ ,THREAT-NOTE>
	       <COND (,PHONG-ADMITTED-HELPING?
		      <TELL
"\"Yes, now you know that Mr. Linder forged that note. Stiles didn't
send it to him.\"" CR>)
		     (T <TELL
"\"Yes, that's the note that Stiles sent to Mr. Linder.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-CAR ,FILE-CABINET>
	       <TELL
"\"That has nothing to do with why Mr. Linder asked you here.\"" CR>)
	      (T <TELL
"\"I'm sorry, Detective, but I can't help you.\"" CR>)>)>)
       (<AND <DOBJ? PHONG> <VERB? HELP>>
	<TELL
"Phong looks offended. \"I'm quite capable by myself, you know.\"" CR>)
       (<AND <DOBJ? PHONG> <VERB? RUB>>
	<PHONG-FIGHTS>)
       (<AND <DOBJ? PHONG> <VERB? ASK-FOR>>
	<FSET ,PHONG ,TOUCHBIT>
	<COND (<IOBJ? GENERIC-KEY PHONG-KEYS GENERIC-GUN OUTSIDE-GUN>
	       <PERFORM ,V?ASK-ABOUT ,PHONG ,PRSI>
	       <RTRUE>)
	      (T <RFALSE>)>)
       (<AND <DOBJ? PHONG> <VERB? SEARCH SEARCH-OBJECT-FOR>>
	<COND (<IN? ,OUTSIDE-GUN ,PHONG>
	       <PHONG-FIGHTS>)
	      (<AND <IN? ,PHONG-KEYS ,PHONG>
		    <OR <VERB? SEARCH>
			<AND <VERB? SEARCH-OBJECT-FOR>
			     <IOBJ? PHONG-KEYS GENERIC-KEY>>>>
	       <MOVE ,PHONG-KEYS ,PLAYER>
	       <FCLEAR ,PHONG-KEYS ,NDESCBIT>
	       <TELL
"You find a " D ,PHONG-KEYS " in Phong's pocket and take it." CR> ;"? better")
	      (T <RFALSE>)>)
       (<AND <DOBJ? PHONG> <VERB? SHOW>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSI>
	<RTRUE>)
       (<AND <VERB? TAKE>
	     <DOBJ? PHONG-KEYS GENERIC-KEY GENERIC-GUN OUTSIDE-GUN>
	     ;<IOBJ? PHONG>>
	<TAKE-PHONG-KEYS>)
       (<AND <VERB? TAKEOUT>	;"TAKE PHONG OUTSIDE"
	     <IOBJ? OFFICE-BACK-DOOR MONICA-BACK-DOOR LINDER-BACK-DOOR>>
	<PHONG-FIGHTS>)
       (<VERB? ARREST> <ARREST ,PHONG>)>>

<ROUTINE PHONG-FIGHTS ()
	<TELL
"Phong's smile disappears and his body shifts subtly toward a fighting
stance.  \"I don't think you really want to try that, Detective.\"" CR>>

<ROUTINE TAKE-PHONG-KEYS ()
 <COND (,PHONG-SEEN-CORPSE?
	<MOVE ,PHONG-KEYS ,PLAYER>
	<FCLEAR ,PHONG-KEYS ,NDESCBIT>
	<TELL
"\"Here, you may as well take them. I don't see how Mr. Linder can
object now.\"" CR>)
       (T <TELL
"\"I don't think Mr. Linder would like that.\"" CR>)>>

<GLOBAL PHONG-HERE
	<PLTABLE "tidying up" ;" as usual"
		"looking imperturbable">>

<GLOBAL KITCHEN-ACTIVITIES
	<PLTABLE "washing dishes"
		"opening a can of worms"
		"smoking a cigarette"	;"polishing the silver"
		"making pickles">>

<OBJECT LINDER
	(IN LIVING-ROOM)
	(DESC "Mr. Linder")
	(ADJECTIVE MISTER MR FREEMAN YOUR HER TALL)
	(SYNONYM LINDER FATHER DAD MAN)
	(FLAGS PERSON ;OPENBIT)
	(CAPACITY 40)
	(ACTION LINDER-F)
	(DESCFCN LINDER-F)
	(XDESC "tall man")
	(TEXT
"Linder stands at least six foot, with a powerful frame but quick actions,
like a cat. His eyeglasses sit on top of his head, where thin strands
of long black hair go here and there, mostly combed backward. His
wide-set hazel eyes size you up quickly from within their pouches in his
ruddy face. He wears a silk peach-colored Mandarin shirt and chocolate
trousers, impeccably tailored and laundered, but sweat gleams on his
high forehead, and he looks as though he hasn't slept much lately.")
	(CHARACTER 2)>

<OBJECT LINDER-SHOES
	(DESC "pair of Linder's shoes")
	(IN LINDER)
	(ADJECTIVE LINDER HIS)
	(SYNONYM PAIR SHOE SHOES)
	(FLAGS NDESCBIT)
	(ACTION RANDOM-SHOES-F)>

<OBJECT GLOBAL-LINDER
	(IN GLOBAL-OBJECTS)
	(DESC "Mr. Linder")
	(ADJECTIVE MISTER MR FREEMAN YOUR HER)
	(SYNONYM LINDER FATHER DAD)
	(FLAGS PERSON)
	(ACTION GLOBAL-PERSON)
	(CHARACTER 2)>

<ROUTINE LINDER-F ("OPTIONAL" (ARG <>) "AUX" OBJ (L <LOC ,LINDER>))
 <COND (<==? .ARG ,M-OBJDESC>
	<COND (<IN-MOTION? ,LINDER> <RTRUE>)
	      (<FSET? ,LINDER ,TOUCHBIT>
	       <COND (<AND <IN? ,LINDER ,HERE> <IN? ,HERE ,ROOMS>>
		      <TELL "Linder is pacing back and forth." CR>)
		     (T <TELL
"Linder is sitting on the " D <LOC ,LINDER> "." CR>)>)
	      (T
	       <FSET ,LINDER ,TOUCHBIT>
	       <TELL <GETP ,LINDER ,P?TEXT> CR>)>
	<RTRUE>)
       (<==? ,WINNER ,LINDER>
	<COND (<AND <VERB? FIND>
		    <DOBJ? GUN-RECEIPT>>
	       <SETG WINNER ,PLAYER>
	       <PERFORM ,V?ASK-ABOUT ,LINDER ,PRSO>
	       <RTRUE>)
	      (<VERB? FIND THANKS> <RFALSE>)
	      (<OR <AND <VERB? GIVE> <DOBJ? DRINK>>
		   <AND <VERB? SGIVE><IOBJ? DRINK>>>
	       <RFALSE>)
	      (<AND <VERB? PUSH> <DOBJ? OFFICE-BUTTON>>
	       <TELL "\"I don't need Phong yet.\"" CR>)
	      (<VERB? TIME>
	       <TELL "Linder looks at his wrist watch and says, \"I have ">
	       <TIME-PRINT ,PRESENT-TIME>
	       <TELL "\"" CR>)
	      (<COM-CHECK ,LINDER> <RTRUE>)
	      (T <TELL "\"Don't tell me what to do!\"" CR>)>)
       (<OR <AND ,PRSO <IN? ,PRSO ,GLOBAL-OBJECTS> <SET OBJ ,PRSO>
		 <VERB? FIND WHAT>>
	  <AND ,PRSI <SET OBJ ,PRSI><DOBJ? LINDER><VERB? CONFRONT ASK-ABOUT>>>
	<COND (<NOT <GRAB-ATTENTION ,LINDER>> <RTRUE>)>
	<SAID-TO ,LINDER>
	<COND (<EQUAL? .OBJ ,BUTTON>
	       <TELL "\"That's the butler's button, of course.\"" CR>)
	      (<EQUAL? .OBJ ,BLACK-WIRE>
	       <TELL
"\"Yes, Monica wired " "the whole house for butler's buttons."
" With all modesty, I think she's quite a mechanic.\"" CR>)
	      (<EQUAL? .OBJ ,WHITE-WIRE>
	       <TELL
"\"Yes, Monica wired " "all the windows for burglars."
" With all modesty, I think she's quite a mechanic.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-GREEN-WIRE ,GENERIC-WIRE>
	       <TELL
"\"That's Monica's territory. I don't interfere.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-CALL>
	       <TELL
"\"What phone call? I haven't talked with Stiles since my wife's death.
I'm really afraid he wants to do me in.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-KEY>
	       <TELL "\"Phong keeps the house keys for me.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-LINDER ,LINDER>
	       <TELL
"\"You've probably read about me in the papers. In fact they just published
something about me when I won that award. And I've heard lots about you.
That's why I asked you here.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-AFFAIR ,GLOBAL-MRS-LINDER ,GLOBAL-SUICIDE>
	       <TELL
"\"It's still too painful for me to talk about, I'm afraid.\"" CR>)
	      (<EQUAL? .OBJ ,MONEY>
	       <TELL
"\"Money?! I asked you here to prevent a crime. I hope you're not thinking
of some outlandish fee!\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-MONICA ,MONICA>
	       <TELL
"\"She's a loyal and intelligent girl. I'm very proud of her.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-PHONG ,PHONG>
	       <TELL
"\"He and I go back a long time. Met in Asia, you know. And since I
spend as much time there as here, he takes care of the house for me.
A fine fellow, and I trust him implicitly.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-STILES ,STILES ,DANGER>
	       <COND (<FSET? ,THREAT-NOTE ,TOUCHBIT>
		      <TELL
"\"All I know about Stiles is that he's a writer of some kind, and
sometimes he plays bit parts in films. I've never really met the man.\"" CR>)
		     (<==? ,HERE ,OFFICE>
		      <I-LINDER-EXPLAIN>
		      <RTRUE>)
		     (T <TELL
"\"I'll explain all that shortly, after I finish this drink.\"" CR>)>)
	      (<EQUAL? .OBJ ,PLAYER>
	       <TELL
"\"My friend Klutz, the Police Chief, recommended you to me.\"" CR>)
	      (<OR <EQUAL? .OBJ ,GENERIC-CAR ,GENERIC-GUN>
		   <EQUAL? .OBJ ,GLOBAL-PTA ,WILL>>
	       <TELL
"\"That has nothing to do with why I asked you here.\"" CR>)
	      (<EQUAL? .OBJ ,BROOM>
	       <TELL
"\"Oh, Phong must have left it there after cleaning up.\"" CR>)
	      (<EQUAL? .OBJ ,CARVED-CHAIR>
	       <TELL
"\"I found that in an obscure but wealthy estate in Asia during the war
and brought it home as booty. Sitting in it makes me feel like an
'Oriental Potentate.'\"" CR>)
	      (<EQUAL? .OBJ ,CAT>
	       <TELL
"\"She's Monica's cat. You'd do better to ask her.\"" CR>)
	      (<EQUAL? .OBJ ,CLOCK>
	       <TELL
"\"I've always admired elaborate machines, and that's the finest example
I could hope to own.\"" CR>)
	      (<EQUAL? .OBJ ,GUN-RECEIPT>
	       <TELL
"\"I didn't ask you here so you could search the house!\"" CR>)
	      (<EQUAL? .OBJ ,MATCHBOOK ,BRASS-LANTERN>
	       <DISCRETION ,LINDER ,PHONG>
	       <TELL
"\"I think Phong goes there sometimes. I've never been there myself.\"
He almost flinched before answering, but now he's as smooth as ever." CR>)
	      (<EQUAL? .OBJ ,MEDICAL-REPORT ,TUMOR>
	       <COND (,LINDER-SAW-MEDICAL-REPORT
		      <TELL
"\"I already told you that I haven't seen it before.\"" CR>)
		     (T <TELL
"Linder looks surprised and a bit alarmed. \"This is the first I've
heard of this. I don't know why my doctor didn't tell me about it.\"" CR>)>
	       <SETG LINDER-SAW-MEDICAL-REPORT T>)
	      (<EQUAL? .OBJ ,OFFICE-BUTTON>
	       <TELL "\"That's the butler's button, of course.\"" CR>)
	      (<EQUAL? .OBJ ,PAPERS ,FILE-CABINET>
	       <TELL
"\"I wish you wouldn't meddle in my files while we're trying to talk.\"" CR>)
	      (<EQUAL? .OBJ ,PIECE-OF-WIRE ,CLOCK-WIRES ,PIECE-OF-PUTTY>
	       <TELL "\"Oh, uh, that's part of the burglar alarm.\"" CR>)
	      (<EQUAL? .OBJ ,TELEGRAM>
	      <TELL "\"Yes, that's the telegram I sent this morning.\"" CR>)
	      (<EQUAL? .OBJ ,THREAT-NOTE>
	       <TELL "\"Yes, that's the note that Stiles sent to me.\"" CR>)
	      (T <TELL <PICK-ONE ,LINDER-ASKED> CR>)>)
       (<AND <DOBJ? LINDER> <VERB? RUB>>
	<TELL
"Linder looks bewildered, almost alarmed. \"Whatever do you have in mind?\""
CR>)
       (<AND <DOBJ? LINDER> <VERB? SHOW>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSI>
	<RTRUE>)
       (<AND <DOBJ? LINDER> <VERB? TURN-UP>>	;"SHUT UP"
	<TELL "Many have tried, but none has succeeded." CR>)
       (<AND <VERB? TAKEOUT>			;"TAKE LINDER OUTSIDE"
	     <IOBJ? OFFICE-BACK-DOOR MONICA-BACK-DOOR LINDER-BACK-DOOR>>
	<TELL "Many have tried, but none has succeeded." CR>)
       (<VERB? ARREST> <ARREST ,LINDER>)>>

<GLOBAL LINDER-ASKED
	<PLTABLE "\"I can't help you there.\""
		"\"That has nothing to do with why I asked you here.\"">>

<OBJECT STILES
        (DESC "Mr. Stiles")
	(ADJECTIVE MR RALPH)
	(SYNONYM STILES MAN VISITOR ;WRITER STRANGER)
	(FLAGS PERSON ;OPENBIT)
	(CAPACITY 40)
	(ACTION STILES-F)
	(DESCFCN STILES-F)
	(XDESC "visitor")
	(TEXT
"The young man looks you straight in the eye but says nothing. He looks like a
gigolo trying to imitate a university professor. His blond wavy hair
almost sparkles, like Pacific surf at night, but his recent panic has
left it dangling to one side. His hot blue eyes reveal his curiosity and
uncertainty about you.")
	(CHARACTER 3)>

<OBJECT GLOBAL-STILES
	(IN GLOBAL-OBJECTS)
	(DESC "Mr. Stiles")
	(ADJECTIVE MR RALPH)
	(SYNONYM STILES VISITOR WRITER STRANGER)
	(FLAGS PERSON)
	(ACTION GLOBAL-PERSON)
	(CHARACTER 3)>

<ROUTINE STILES-F ("OPTIONAL" (ARG <>) "AUX" OBJ (L <LOC ,STILES>))
 <COND (<==? .ARG ,M-OBJDESC>
	<COND (<EQUAL? .L ,OFFICE-PORCH ,OFFICE-PATH>
	       <COND (<IN-MOTION? ,STILES> <RTRUE>)
		     (<FSET? ,STILES ,TOUCHBIT>
		      <TELL"Stiles is waiting for you to say something."CR>)
		     (T <TELL "The visitor is in a hurry." CR>)>)
	      (<IN-MOTION? ,STILES>
	       <TELL
"Sgt. Duffy is leading Stiles by the handcuffs." CR>)
	      (,MET-STILES?
	       <COND (<L? ,PRESENT-TIME %<* 13 60>>
		      <TELL
"Stiles is fastened to the davenport, " "looking sullen." CR>)
		     (T 
		      <TELL
"Stiles is fastened to the davenport, "
"yawning and trying not to doze off." CR>)>)
	      (T
	       ;<FSET ,STILES ,TOUCHBIT>
	       <TELL
"Sgt. Duffy is holding a prisoner by the arm." CR>
	       <TELL <GETP ,STILES ,P?TEXT> CR>)>
	<RTRUE>)
       (<==? ,WINNER ,STILES>
	<COND (<AND ,TOO-LATE <VERB? FIND> <NOT <DOBJ? PLAYER>>>
	       <TELL "\"I wouldn't tell you even if I knew.\"" CR>)
	      (<AND ,TOO-LATE <VERB? INVENTORY>>
	       <TELL "\"I've never seen you before.\"" CR>)
	      (<VERB? FIND THANKS> <RFALSE>)
	      (<COM-CHECK ,STILES> <RTRUE>)
	      (T <TELL <PICK-ONE ,WHY-ME> CR>)>)
       (<OR <AND ,PRSI<SET OBJ ,PRSI><DOBJ? STILES><VERB? CONFRONT ASK-ABOUT>>
	    <AND ,PRSO <IN? ,PRSO ,GLOBAL-OBJECTS> <SET OBJ ,PRSO>
		 <VERB? FIND WHAT>>>
	<COND (<NOT <GRAB-ATTENTION ,STILES>> <RTRUE>)>
	<SAID-TO ,STILES>
	<COND (<EQUAL? .OBJ ,GLOBAL-CALL>
	       <TELL
"\"Linder phoned me today and almost commanded me to come here tonight
to talk about our deal. Last time, he at least was decent enough to buy
me lunch. He" " said he wanted to pay me a bundle to leave town.\"" CR>)
	      (<AND <NOT ,TOO-LATE> <EQUAL? .OBJ ,GLOBAL-DUFFY>>
	       <TELL
"\"Is that your man? When I came running out of the woods, he grabbed me
as if I was some kind of criminal. He wouldn't let me go! So here I am.\""CR>)
	      (<EQUAL? .OBJ ,GENERIC-GUN>
	       <TELL "\"Don't ask me. I never touch them.\"" CR>)
	      (<AND <NOT ,TOO-LATE> <EQUAL? .OBJ ,STILES-SHOES>>
	       <SETG BACK-FOOTPRINTS-MATCHED T>
	       <TELL
"\"What about them? They're muddy because I had to run through the yard and
woods to get away from the shooting.\"" CR>)
	      (<EQUAL? .OBJ ,TELEGRAM>
	       <TELL
"\"I don't get it. I think he's more dangerous than I am!\"" CR>)
	      (<EQUAL? .OBJ ,MONEY>
	       <TELL
"\"Yeah, Linder" " said he wanted to pay me a bundle to leave town.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-MONICA ,MONICA>
	       <DISCRETION ,STILES ,MONICA>
	       <TELL
"\"She's probably just another dizzy dame, but I don't really know her
well enough to say.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-AFFAIR ,GLOBAL-MRS-LINDER ,GLOBAL-SUICIDE>
	       <DISCRETION ,STILES ,MONICA>
	       <TELL
"\"Virginia was a special woman. Repressed for years. I think that, if
only ... Say, I don't have to answer your questions!\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-LINDER ,LINDER ,CORPSE>
		<TELL
"\"He's a smooth operator. I can think of many people who'd like to plug
him. Not me, of course. I still don't understand why he sounded so urgent
when he called me today and asked me to come here tonight.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-PHONG ,PHONG>
	       <DISCRETION ,STILES ,PHONG>
	       <TELL "\"He seems straight, but I don't really trust ">
	       <COND (<TANDY?> <TELL "his kind">)
		     (T <TELL "slanteyes">)>
	       <TELL ".\"" CR>)
	      (<AND ,SHOT-FIRED <EQUAL? .OBJ ,GLOBAL-SHOT>>
	       <TELL
"\"I was just walking up to Linder's office when there was this
explosion and the window fell apart. 'Holy jumping catfish!' I thought,
'Someone took a shot at me!' So I ran to the gate, but it was locked.
The only way out I could see was through the woods.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-STILES ,STILES>
	       <TELL
"\"There's not much to tell. I'm a writer, but that doesn't take you far
these days. So I do some film work on the side. Some day my agent will
wise up and find me a decent publisher.\"" CR>)
	      (<AND <NOT ,TOO-LATE> <EQUAL? .OBJ ,INSIDE-GUN ,OUTSIDE-GUN>>
	       <TELL
"\"I've never seen it before. Anyhow, I don't like guns.\"" CR>)
	      (<OR <EQUAL? .OBJ ,MATCHBOOK>
		   <AND <EQUAL? .OBJ ,INTNUM> <==? ,P-NUMBER 1729>>>
	       <TELL
"\"That's my phone number! Linder must have jotted it down the day
we had lunch at that restaurant,"
" when he first offered me money to leave town.\"" CR>)
	      (<EQUAL? .OBJ ,BRASS-LANTERN>
	       <TELL
"\"I think that's the name of the restaurant where Linder took me to lunch,"
" when he first offered me money to leave town.\"" CR>)
	      (<AND <NOT ,TOO-LATE> <EQUAL? .OBJ ,MEDICAL-REPORT ,TUMOR>>
	       <TELL
"\"So the old man was on the way out, eh? Wish I'd known that.\"
He pauses. \"I mean, I could have taken his money and blown town
until he kicked the bucket, then come back. Too late now.\"" CR>)
	      (<AND <NOT ,TOO-LATE> <EQUAL? .OBJ ,THREAT-NOTE>>
	       <TELL
"\"Holy smoke! That sort of looks like my writing, but I didn't write
it.\"" CR>)
	      (T
	       <TELL <PICK-ONE ,STILES-ASKED> CR>)>)
       (<VERB? LOOK-UP PHONE>
	<PERFORM ,PRSA ,MATCHBOOK>
	<RTRUE>)
       (<AND ,TOO-LATE
	     <OR <VERB? SEARCH>
		 <AND <DOBJ? MONEY> <VERB? GIVE TAKE>>
		 <AND <IOBJ? MONEY> <VERB? ASK-FOR SEARCH-OBJECT-FOR SGIVE>>>>
	<TELL
"When you try it, he whirls around in a fighting stance. \"Don't mess
around with me, buddy. I've handled thieves before.\"" CR>)
       (<AND <DOBJ? STILES> <VERB? SHOW>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSI>
	<RTRUE>)
       (<AND <DOBJ? STILES> <VERB? SLAP RUB>>
	<TELL
"Stiles" "'s eyes are full of hate, and " "he says something unprintable."CR>)
	(<AND <DOBJ? STILES> <VERB? TIE-TO TIE-WITH> <NOT ,TOO-LATE>>
	 <TELL "There's no need. Duffy's cuffs are secure enough." CR>)
	(<AND <DOBJ? STILES> <VERB? UNTIE> <NOT ,TOO-LATE>>
	<TELL "Your key won't fit the cuffs." CR>)
       (<AND <VERB? TAKEOUT>	;"TAKE STILES OUTSIDE"
	     <NOT ,TOO-LATE>
	     <IOBJ? OFFICE-BACK-DOOR MONICA-BACK-DOOR LINDER-BACK-DOOR>>
	<TELL "Your key won't fit the cuffs." CR>)
       (<VERB? ARREST> <ARREST ,STILES>)>>

<GLOBAL STILES-ASKED
	<PLTABLE "\"I couldn't help you if I wanted to.\""
		"\"That has nothing to do with me.\"">>

<OBJECT STILES-SHOES
	(DESC "pair of Stiles's shoes")
	(IN STILES)
	(ADJECTIVE STILES HIS)
	(SYNONYM PAIR SHOE SHOES)
	(FLAGS NDESCBIT)
	(ACTION STILES-SHOES-F)>

<ROUTINE STILES-SHOES-F ()
 <COND (<AND <VERB? COMPARE PUT>
	     <OR <DOBJ? SIDE-FOOTPRINTS SIDE-FOOTPRINTS-CAST>
		 <IOBJ? SIDE-FOOTPRINTS SIDE-FOOTPRINTS-CAST>>>
	<TELL
"The shoes don't seem to match " ;"the plaster cast of "
"the foot prints that you found in the " "side yard." CR>)
       (<AND <VERB? COMPARE PUT>
	     <OR <DOBJ? BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>
		 <IOBJ? BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>>>
	<COND (<OR <VERB? PUT> <==? ,P-ADVERB ,W?CAREFULLY>>
	       <SETG BACK-FOOTPRINTS-MATCHED T>
	       <TELL
"The shoes and the foot prints match each other perfectly." CR>)
	      (T
	       <TELL
"The shoes look similar to " ;"the plaster cast of "
"the foot prints that you found in the " "back yard." CR>)>)
       (T <RANDOM-SHOES-F>)>>

<OBJECT MONICA
	(IN LIVING-ROOM)
	(DESC "Monica")
	(ADJECTIVE YOUNG)
	(SYNONYM MONICA WOMAN)
	(FLAGS PERSON FEMALE ;OPENBIT)
	(CAPACITY 40)
	(ACTION MONICA-F)
	(DESCFCN MONICA-F)
	(XDESC "young woman")
	(TEXT 
"She is a woman in her mid-twenties. Her grey eyes flash, emphasizing
her dark waved hair and light but effective make-up. She wears a navy
Rayon blouse, tan slacks, and tan pumps with Cuban heels. She acts as
though you were a masher who just gave her a whistle.")
	(CHARACTER 4)>

<OBJECT MONICA-SHOES
	(DESC "pair of Monica's shoes")
	(IN MONICA)
	(ADJECTIVE MONICA HER)
	(SYNONYM PAIR SHOE SHOES)
	(FLAGS NDESCBIT)
	(ACTION RANDOM-SHOES-F)>

<OBJECT GLOBAL-MONICA
	(IN GLOBAL-OBJECTS)
	(DESC "Monica")
	(SYNONYM MONICA)
	(FLAGS PERSON FEMALE)
	(ACTION GLOBAL-PERSON)
	(CHARACTER 4)>

<GLOBAL MONICA-QUESTIONS 0>
<GLOBAL MONICA-HAS-MOTIVE <>>
<GLOBAL MONICA-CLAMS-UP <>>
<GLOBAL MONICA-TIED-TO <>>
<GLOBAL MONICA-TIED-WITH <>>
<GLOBAL MONICA-ADMITTED-HELPING? <>>
<GLOBAL SHE-CLAMS-UP
" She seems to remember who you are, then clams up.">

<ROUTINE MONICA-F ("OPTIONAL" (ARG <>) "AUX" OBJ (L <LOC ,MONICA>) X)
 <COND (<==? .ARG ,M-OBJDESC>
	<COND (<IN-MOTION? ,MONICA> <RTRUE>)
	      (<FSET? ,MONICA ,TOUCHBIT>
	       <COND (,MONICA-TIED-TO <TELL
"Monica is fastened to the " D ,MONICA-TIED-TO
		" with the " D ,MONICA-TIED-WITH "." CR>)
		     (<==? .L ,MONICA-ROOM>
		    <TELL "Monica is lying on her bed, softly sobbing." CR>)
		     (<==? .L ,TOILET-ROOM>
		    <TELL "Monica is leaning over the toilet, gasping." CR>)
		     (T
		      <TELL "Monica is here, biting her nails." CR>)>)
	      (T
	       <FSET ,MONICA ,TOUCHBIT>
	       <TELL "Monica ">
	       <COND (<==? <LOC ,MONICA> <LOC ,LINDER>>
		      <TELL "stops talking and ">)>
	       <TELL "looks at you sharply. "
		     <GETP ,MONICA ,P?TEXT>
		     CR>)>
	<RTRUE>)
       (<==? ,WINNER ,MONICA>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (<AND <VERB? FIND> <DOBJ? CLOCK-KEY>>
	       <SETG WINNER ,PLAYER>
	       <PERFORM ,V?ASK-ABOUT ,MONICA ,PRSO>
	       <RTRUE>)
	      (<VERB? FIND THANKS> <RFALSE>)
	      (<OR <AND <VERB? GIVE>
			<DOBJ? CLOCK-KEY GENERIC-KEY GENERIC-GUN INSIDE-GUN>>
		   <AND <VERB? SGIVE>
			<IOBJ? CLOCK-KEY GENERIC-KEY GENERIC-GUN INSIDE-GUN>>>
	       <TELL "\"Why should I?\"" CR>)	;"? better"
	      (<COM-CHECK ,MONICA> <RTRUE>)
	      (T <TELL <PICK-ONE ,WHY-ME> CR>)>)
       (<VERB? ACCUSE>
	<SETG MONICA-CLAMS-UP T>
	<COND (<NOT ,MONICA-SEEN-CORPSE?>
	       <TELL
"\"What murder? What are you talking about?\" Her cheeks quiver like jelly."
CR>)
	      (<NOT <OR ,SEEN-MONICA-AT-CLOCK ,MONICA-ADMITTED-HELPING?>>
	       <TELL
"\"You were there when it happened. Isn't it obvious that Stiles did it?\""
CR>)
	      (<NOT ,MONICA-SAW-MEDICAL-REPORT>
	       <FCLEAR ,MEDICAL-REPORT ,INVISIBLE>
	       <FCLEAR ,TUMOR ,INVISIBLE>
	       <SETG MONICA-SAW-MEDICAL-REPORT T>
	       <SETG MONICA-ADMITTED-HELPING? T>
	       <TELL
"\"It's true I helped set up the gun mechanism. But Dad was already
dying! You can find the medical report on the desk ">
	       <COND (<IN? ,MONICA ,MONICA-ROOM> <TELL "here ">)>
	       <TELL
"in my room. He was ... dying ...\" She breaks down in tears." CR>)
	      (<NOT ,MONICA-SAW-CORONER-REPORT>
	       <TELL
"\"I've told you already: he was dying!\" Tears dribble down her cheeks." CR>)
	      (T
	       <TELL
"\"I don't understand! I believed that medical report, and I don't know
why the doctor lied to me about the tumor. You think I wanted to murder
my own father? I thought he was dying already!\" Her eyes are pleading
with you now, begging you to believe her." CR>)>)
       (<OR <AND ,PRSI<SET OBJ ,PRSI><DOBJ? MONICA><VERB? CONFRONT ASK-ABOUT>>
	    <AND ,PRSO <IN? ,PRSO ,GLOBAL-OBJECTS> <SET OBJ ,PRSO>
		 <VERB? FIND WHAT>>>
	<COND (<NOT <GRAB-ATTENTION ,MONICA>> <RTRUE>)>
	<SAID-TO ,MONICA>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (<OR <EQUAL? .OBJ ,MONEY ,GLOBAL-PTA>
		   <EQUAL? .OBJ ,GLOBAL-TERRY ,GENERIC-CAR>>
	       <TELL
"\"That has nothing to do with why Dad asked you here.\"" CR>)
	      (<EQUAL? .OBJ ,BUTTON>
	       <SETG MONICA-CLAMS-UP T>
	       <TELL
"\"That's the butler's button, you cheesehead.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-GUN>
	       <SETG MONICA-CLAMS-UP T>
	       <TELL "\"I have nothing to say to you about that.\"" CR>)
	      (<EQUAL? .OBJ ,BLACK-WIRE>
	       <TELL
"\"That bell system is just one of the features I've put in this house.
Beyond your imagination, probably.\"" CR>)
	      (<EQUAL? .OBJ ,WHITE-WIRE>
	       <TELL
"\"That alarm system is another of the features I've put in this house.
You probably know the kind of low-life that would try to break in
here.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-GREEN-WIRE ,GENERIC-WIRE>
	       <SETG MONICA-CLAMS-UP T>
	       <TELL "\"You want wire? You can find all kinds ">
	       <COND (<EQUAL? ,HERE ,WORKSHOP> <TELL "here ">)>
	       <TELL "in the workshop.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-MONICA ,MONICA>
	       <TELL "\"I have no secrets. Anyone can see what I am.\"" CR>)
	      (<EQUAL? .OBJ ,GENERIC-KEY ,PHONG-KEYS>
	       <TELL "\"Phong keeps the house keys. Ask him.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-LINDER ,LINDER ,CORPSE>
	       <COND (,MONICA-CLAMS-UP
		      <TELL "\"What can I say? He">
		      <COND (,MONICA-SEEN-CORPSE?
			     <TELL " wa">)
			    (T <TELL "'">)>
		      <TELL  "s my father, a hard-working, clever man.\"" CR>
		      <RTRUE>)>
	       <SETG MONICA-CLAMS-UP T>
	       <COND (,MONICA-SEEN-CORPSE?
		      <SETG MONICA-HAS-MOTIVE ,CORPSE>
		      <TELL
"She rambles a bit, as if dreaming. \"To be honest, I feel relieved ...
that he's met his Maker. Now I won't feel as if I'm under his thumb when
he's home. He really treated all of us like ... his property, even
Mother. I guess I'm an orphan now, but ... \""
,SHE-CLAMS-UP
;"\"What can I say? He was my father, and he had his faults, but he loved
me in his own way. And now he's dead! They're both ... dead!\" She
practically shouts the last word." CR>)
		     (T
		      <SETG MONICA-HAS-MOTIVE ,LINDER>
		      <DISCRETION ,MONICA ,LINDER>
		      <TELL
"\"Oh, I can tell you lots about him. Do you want to know if he was a
good husband? A good father? Anything but a selfish ...\""
,SHE-CLAMS-UP CR>)>)
	      (<EQUAL? .OBJ ,GLOBAL-AFFAIR ,GLOBAL-MRS-LINDER>
	       <SETG MONICA-HAS-MOTIVE ,GLOBAL-MRS-LINDER>
	       <DISCRETION ,MONICA ,LINDER>
	       <COND (,MONICA-CLAMS-UP
		      <TELL "\"That's between Mother and me.\"" CR>)
		     (T
		      <SETG MONICA-CLAMS-UP T>
		      <TELL
"\"She was the most noble woman I've ever known. Did her best to be a
'good wife' even though she was alone so much. No one understood her as
I did, certainly not Father. Sometimes I feel I could just ...\"
She slams a clenched fist into her palm."
,SHE-CLAMS-UP CR>)>)
	      (<EQUAL? .OBJ ,GLOBAL-MURDER ,DANGER>
	       <COND (<NOT ,MONICA-SEEN-CORPSE?>
		      <TELL
"\"What do you think this is, a cheap whodunit?\"" CR>)
		     (<NOT ,MONICA-ADMITTED-HELPING?>
		      <TELL "\"Isn't it obvious? That ">
		      <COND (<TANDY?> <TELL "idiot">)
			    (T <TELL "bastard">)>
		      <TELL " Stiles squibbed him off!\"" CR>)
		     (T
		      <SETG WINNER ,PLAYER>
		      <PERFORM ,V?ACCUSE ,MONICA ,GLOBAL-MURDER>
		      <RTRUE>)>)
	      (<EQUAL? .OBJ ,GLOBAL-PHONG ,PHONG>
	       <DISCRETION ,MONICA ,PHONG>
	       <TELL
"\"He's a right gee, no matter what some people say about his ">
	       <COND (<TANDY?> <TELL "kind">)
		     (T <TELL "race">)>
	       <TELL ".\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-STILES ,STILES>
	       <COND (,MONICA-ADMITTED-HELPING?
		      <SETG MONICA-CLAMS-UP T>
		      <TELL "\"That poor ">
		      <COND (<TANDY?> <TELL "idiot">)
			    (T <TELL "bastard">)>
		      <TELL
". First he fell in love with Mother, a married woman;
then he actually trusted her husband. I don't know what he uses for brains.\""
CR>)
		     (,MONICA-SEEN-CORPSE?
		      <TELL "\"That ">
		      <COND (<TANDY?> <TELL "idiot">)
			    (T <TELL "bastard">)>
		      <TELL
" who killed Dad? I'd spit in his face if it was worth the trouble.\"" CR>)
		     (T
		      <DISCRETION ,MONICA ,STILES>
		      <TELL
"\"Oh, that lover boy thinks he's a smooth apple, all right. If you ask me,
he's just a harmless grifter.\"" CR>)>)
	      (<EQUAL? .OBJ ,PLAYER>
	       <TELL "\"I don't know anything about you, but I ">
	       <COND (,MONICA-SEEN-CORPSE? <TELL "had hoped you could">)
		     (T <TELL "hope you can">)>
	       <TELL " help Dad.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-SUICIDE>
	       <TELL "\"I don't want to talk about it.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-TERRY>
	       <TELL "\"Terry's a good friend of mine, that's all.\"" CR>)
	      (<EQUAL? .OBJ ,WILL>
	       <COND (,MONICA-SEEN-CORPSE?
		      <SETG PHONG-HAS-MOTIVE ,WILL>
		      <DISCRETION ,MONICA ,PHONG>
		      <TELL
"\"Dad kept it in his bank safe. I'll bet Phong would like to see it.\"" CR>)
		     (T <TELL
"\"You'll have to ask Dad about that.\"" CR>)>)
	      (<EQUAL? .OBJ ,FILE-CABINET>
	       <TELL
"\"That has nothing to do with why Dad asked you here.\"" CR>)
	      (<EQUAL? .OBJ ,CAT>
	       <TELL
"\"She's my cat. I named her Asta, because she's at least as smart as
the dog in 'The Thin Man.'\"" CR>)
	      (<EQUAL? .OBJ ,CLOCK-KEY>
	       <COND (<IN? ,CLOCK-KEY ,MONICA> 
		      <SETG MONICA-CLAMS-UP T>
		      <TELL "\"I don't know where Dad keeps it.\"" CR>)
		     (T <TELL
"\"That's the only key for the clock. So what?\"" CR>)>)
	      ;(<EQUAL? .OBJ ,GENERIC-KEY>
	       <TELL "\"I don't know where Dad keeps it.\"" CR>)
	      (<EQUAL? .OBJ ,GUN-RECEIPT>
	       <TELL
"\"What about it? It's no crime to get a little heat for
self-protection.\"" CR>
	       ;<TELL "\"I thought I told Phong to destroy that!\"" CR>)
	      (<EQUAL? .OBJ ,INSIDE-GUN>	;"? more!"
	       <COND (<FSET? ,INSIDE-GUN ,TOUCHBIT>
		      <TELL
"Monica has the wild look of a trapped animal. \"I can't understand why
that heater was inside the clock.\"" CR>)
		     (T <TELL
"\"I don't know what you're talking about.\"" CR>)>)
	      (<EQUAL? .OBJ ,MEDICAL-REPORT ,TUMOR>
	       <COND (,MONICA-SEEN-CORPSE?
		      <COND (,MONICA-ADMITTED-HELPING?
			     <SETG WINNER ,PLAYER>
			     <PERFORM ,V?ACCUSE ,MONICA ,GLOBAL-MURDER>
			     <RTRUE>)
			    (,MONICA-SAW-MEDICAL-REPORT
			     <TELL
"\"I already told you: Dad was about to kick the bucket anyway.\""
CR>)
			    (T
			     <FCLEAR ,MEDICAL-REPORT ,INVISIBLE>
			     <FCLEAR ,TUMOR ,INVISIBLE>
			     <TELL "\"Dad gave "
				     <COND (<EQUAL? .OBJ ,MEDICAL-REPORT>
					    "it to me ")
					   (T "me a medical report ")>
"so I could try to understand what was wrong and
what his chances were. Now I guess Stiles has ended Dad's pain.\"" CR>)>)
		     (T <DISCRETION ,MONICA ,LINDER>
		      <COND (,MONICA-SAW-MEDICAL-REPORT
			     <TELL
"\"I already told you: Dad's about to kick the bucket.\"" CR>)
			    (T <TELL
"\"How did you find that? Dad gave it to me so I could try to understand
what's wrong and what his chances are. They don't look good.\" She looks
alarmed." CR>)>)>
	       <SETG MONICA-SAW-MEDICAL-REPORT T>
	       <RTRUE>)
	      (<AND <EQUAL? .OBJ ,PIECE-OF-WIRE ,CLOCK-WIRES ,PIECE-OF-PUTTY>
		    <NOT ,MONICA-ADMITTED-HELPING?>>
	       <SETG MONICA-CLAMS-UP T>
	       <TELL
"\"Oh, uh, that's part of a timed lock I set up for the office.\"" CR>)
	      (<OR <EQUAL? .OBJ ,OFFICE-BUTTON ,CLOCK>
		   <EQUAL? .OBJ ,POWDER ,CLOCK-POWDER>
		   <AND <EQUAL? .OBJ ,PIECE-OF-WIRE ,CLOCK-WIRES
				     ,PIECE-OF-PUTTY>
			,MONICA-ADMITTED-HELPING?>>
	       <COND (<AND ,MONICA-SEEN-CORPSE? ,PLAYER-PUSHED-BUTTON>
		      <SETG MONICA-ADMITTED-HELPING? T>
		      <SETG MONICA-CLAMS-UP T>
		      <TELL
"\"You seem to have discovered Dad's little plot to frighten Stiles.
Sure, I helped set it up for him. But I don't know what went wrong.
He wasn't supposed to die!\" Her lower lip is quivering." CR>)
		     (<EQUAL? .OBJ ,OFFICE-BUTTON>
		      <TELL
"\"That's the butler's button, you cheesehead.\"" CR>)
		     (T
		      <TELL
"\"Phong really ought to do a better job of cleaning around here.\"" CR>)>)
	      (<EQUAL? .OBJ ,OUTSIDE-GUN>
	       <COND (,MONICA-ADMITTED-HELPING?
		      <SETG MONICA-CLAMS-UP T>
		      <TELL
"\"That gat you found? Phong planted it so it would look as if Stiles
used it.\"" CR>)
		     (,MONICA-SEEN-CORPSE?
		      <DISCRETION ,MONICA ,STILES>
		      <TELL
"\"That gat you found? It must belong to Stiles.\"" CR>)
		     (T <TELL
"\"I've never seen it before. It looks as if you don't take good care of
it.\"" CR>)>)
	      (<EQUAL? .OBJ ,RECURSIVE-BOOK>
	       <TELL
"\"It's a swell mystery called 'Deadline.' I haven't figured it out yet.\""
CR>)
	      (<EQUAL? .OBJ ,TELEGRAM>
	       <TELL
"\"That must be the telegram Dad sent this morning.\"" CR>)
	      (<EQUAL? .OBJ ,STUB>
	       <TELL
"\"That looks like my ticket stub. I didn't know I dropped it.\"" CR>)
	      (<EQUAL? .OBJ ,GLOBAL-FILM>
	       <COND (,FILM-SEEN
		      <TELL
"\"It was called 'Dead End'. I don't think this Bogart guy is pretty
enough to make it big.\"" CR>)
		     (T
		      <TELL
"\"I think we'll see 'Dead End'. Terry wants to check out this guy named
Bogart.\"" CR>)>)
	      (T
	       <TELL "\"I don't know anything about it, shamus.">
	       <SETG MONICA-QUESTIONS <+ 1 ,MONICA-QUESTIONS>>
	       <COND (<L? 6 ,MONICA-QUESTIONS>
		      <TELL
		       " And I'm really getting tired of your questions.">)>
	       <TELL "\"" CR>)>)
       (<AND <DOBJ? MONICA> <VERB? GOODBYE>>
	<FSET ,MONICA ,TOUCHBIT>
	<TELL "\"If I never see you again, it's jake with me.\"" CR>)
       (<AND <DOBJ? MONICA> <VERB? RUB>>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (<NOT ,MONICA-TIED-TO> <MONICA-PUSHES>)
	      (T <TELL
"Monica writhes away from your touch and manages to kick you in the
shin." CR>)>)
       (<AND <DOBJ? MONICA> <VERB? ASK-FOR>>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (,MONICA-TIED-TO
	       <TELL"\"How can I give you anything when I'm tied up?\"" CR>)
	      (<IOBJ? CLOCK-KEY GENERIC-KEY PHONG-KEYS GENERIC-GUN INSIDE-GUN>
	       <PERFORM ,V?ASK-ABOUT ,MONICA ,PRSI>
	       <RTRUE>)
	      (T <RFALSE>)>)
       (<OR <AND <DOBJ? MONICA> <SET OBJ ,PRSI>
		 <VERB? SEARCH SEARCH-OBJECT-FOR>>
	    <AND <IOBJ? MONICA> <SET OBJ ,PRSO>
		 <VERB? TAKE>>>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (<NOT ,MONICA-TIED-TO> <MONICA-PUSHES>)
	      (<AND <IN? ,CLOCK-KEY ,MONICA>
		    <OR <VERB? SEARCH> <EQUAL? .OBJ ,GENERIC-KEY ,CLOCK-KEY>>>
	       <MOVE ,CLOCK-KEY ,PLAYER>
	       <FCLEAR ,CLOCK-KEY ,INVISIBLE>
	       <FSET ,CLOCK-KEY ,TOUCHBIT>
	       <TELL
"You find a single key in Monica's pocket and take it." CR> ;"? better")
	      (<AND <IN? ,INSIDE-GUN ,MONICA>
		    <OR <VERB? SEARCH><EQUAL? .OBJ ,GENERIC-GUN ,INSIDE-GUN>>>
	       <SETG SEEN-MONICA-AT-CLOCK T>
	       <MOVE ,INSIDE-GUN ,PLAYER>
	       <FCLEAR ,INSIDE-GUN ,INVISIBLE>
	       <FSET ,INSIDE-GUN ,TOUCHBIT>
	       <TELL
"You find a hand gun in Monica's pocket and take it." CR> ;"? better")
	      (T <RFALSE>)>)
       (<AND <DOBJ? MONICA> <VERB? SHOW>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSI>
	<RTRUE>)
       (<AND <DOBJ? MONICA> <VERB? SLAP> <IN? ,MONICA ,MONICA-ROOM>>
	<FSET ,MONICA ,TOUCHBIT>
	<TELL
"Monica screams, \"Leave me alone! I'll get over it! Please!\"" CR>)
       (<AND <VERB? SLAP> ,MONICA-TIED-TO>
	<FSET ,MONICA ,TOUCHBIT>
	<TELL
"Monica's eyes are full of hate, and she says something unprintable."
CR>)
       (<AND <DOBJ? MONICA> <VERB? TIE-TO>>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (,MONICA-TIED-TO
	       <TELL
"She's already fastened to the " D ,MONICA-TIED-TO "." CR>
	       <RTRUE>)
	      (<AND ,CLOCK-FIXED
		    <FSET? ,PRSI ,FURNITURE>
		    <IN? ,HANDCUFFS ,PLAYER>>
	       <SETG MONICA-CLAMS-UP T>
	       <SETG MONICA-TIED-TO ,PRSI>
	       <SETG MONICA-TIED-WITH ,HANDCUFFS>
	       <TELL "(with your handcuffs)" CR>)
	      (T <MONICA-PUSHES> <RTRUE>)>
	<COND (,MONICA-TIED-WITH
	       <MOVE ,MONICA-TIED-WITH ,PRSI>
	       <FCLEAR ,MONICA-TIED-WITH ,TAKEBIT>
	       <FSET ,MONICA-TIED-WITH ,NDESCBIT>
	       <PUT <GET ,GOAL-TABLES ,MONICA-C> ,GOAL-ENABLE <>>
	       <PUT ,MOVEMENT-GOALS
		    ,MONICA-C
		    <REST <GET ,MOVEMENT-GOALS ,MONICA-C> ,MG-LENGTH>>
	       <TELL
"She puts up a struggle, but you manage to do it." CR>)
	      (T <TELL "There's nothing to tie her " "with!" CR>)>)
	(<AND <DOBJ? MONICA> <VERB? TIE-WITH>>
	<FSET ,MONICA ,TOUCHBIT>
	<COND (,MONICA-TIED-WITH
	       <TELL
"She's already fastened with the " D ,MONICA-TIED-WITH "." CR>
	       <RTRUE>)
	      (<AND ,CLOCK-FIXED <IOBJ? HANDCUFFS> ;<FSET? ,PRSI ,TOOLBIT>>
	       <SETG MONICA-TIED-TO
		     <COND (<SET X <FIND-FLAG ,HERE ,FURNITURE>>
			    <TELL "(to the " D .X ")" CR>
			    .X)>>)
	      (T <MONICA-PUSHES> <RTRUE>)>
	<COND (,MONICA-TIED-TO
	       <SETG MONICA-CLAMS-UP T>
	       <SETG MONICA-TIED-WITH ,PRSI>
	       <MOVE ,PRSI ,MONICA-TIED-TO>
	       <FCLEAR ,PRSI ,TAKEBIT>
	       <FSET ,PRSI ,NDESCBIT>
	       <PUT <GET ,GOAL-TABLES ,MONICA-C> ,GOAL-ENABLE <>>
	       <PUT <GET ,GOAL-TABLES ,MONICA-C> ,ATTENTION-SPAN 999>
	       <TELL
"She puts up a struggle, but you manage to do it." CR>)
	      (T <TELL "There's nothing to "
			 <COND (<IOBJ? HANDCUFFS> "handcuff ")
			       (T "tie ")>
			 "her to!" CR>)>)
	(<VERB? UNTIE>
	 <COND (<NOT ,MONICA-TIED-TO>
		<TELL "She's not even tied up!" CR>)
	       (<AND ,PRSI <NOT <==? ,PRSI ,MONICA-TIED-TO>>>
		<TELL "She's not fastened to the " D ,PRSI "!" CR>)
	       (T
		<MOVE ,MONICA-TIED-WITH ,PLAYER>
		<TELL
"Monica rubs her wrists as you take the " D ,MONICA-TIED-WITH ".">
		<COND (<NOT <OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER>>
		       <TELL
" Her eyes dart from door to door, then she bolts for the hallway. But,
within seconds, Sgt. Duffy brings her back.">)>
		<RELEASE-MONICA>
		<TELL " She refuses to look at you." CR>)>)
	(<AND <VERB? TAKEOUT>	;"TAKE MONICA OUTSIDE"
	      <IOBJ? OFFICE-BACK-DOOR MONICA-BACK-DOOR LINDER-BACK-DOOR>>
	 <COND (,MONICA-TIED-TO
		<TELL
"You can't take her and the " D ,MONICA-TIED-TO " both!" CR>)
	       (T <MONICA-PUSHES>)>)
	(<VERB? ARREST> <ARREST ,MONICA>)>>

<ROUTINE MONICA-PUSHES ()
	<TELL
"Monica pushes you away with surprising strength. \"I don't know what
game you're playing, Detective, but count me out. If you think I'm just
a dumb twi">
	<COND (<NOT <TANDY?>> <TELL "s">)>
	<TELL "t, think again.\" Her eyes burn like polished gems." CR>
	<RTRUE>>

<ROUTINE RELEASE-MONICA ()
	<SETG MONICA-TIED-TO <>>
	<SETG MONICA-TIED-WITH <>>
	<FSET ,MONICA-TIED-WITH ,TAKEBIT>
	<FCLEAR ,MONICA-TIED-WITH ,NDESCBIT>>

<OBJECT CAT
	(IN OFFICE)
	(DESC "cat")
	(FDESC "A cat is sleeping in the corner.")
	(SYNONYM CAT FELINE BEAST ASTA)
	(FLAGS FEMALE)
	(ACTION CAT-F)
	(TEXT "The cat is a brown tabby, more bulgy than sleek.")
	(CHARACTER 5)>

<ROUTINE CAT-F ()
 <COND (<VERB? KICK>
	<TELL
"Like a fly, the cat springs up just in time, then goes to a different
corner to settle down." CR>)
       (<VERB? RUB HELLO>
	<TELL "The cat purrs a little louder and curls one paw." CR>)>>

<OBJECT GLOBAL-CAT
	(IN GLOBAL-OBJECTS)
	(DESC "cat")
	(SYNONYM CAT FELINE BEAST ASTA)
	(FLAGS FEMALE)
	(CHARACTER 5)>

<ROUTINE GLOBAL-PERSON ()
	 <COND (<VERB? WHAT FIND WAIT-FOR FOLLOW $CALL PHONE>
		<RFALSE>)
	       (<AND <VERB? ASK-ABOUT TELL-ME>
		     ,PRSO
		     <OR <AND <FSET? ,PRSO ,PERSON>
			      <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>>
			 <EQUAL? ,PRSO ,GLOBAL-DUFFY>>>
		<RFALSE>)
	       (<VERB? TELL>
		<TELL "You can't speak to someone who isn't here." CR>
		<SETG P-CONT <>>
		<RTRUE>)
	       (<VERB? ARREST>
		<COND (<DOBJ? GLOBAL-LINDER> <ARREST ,GLOBAL-LINDER>)
		      (T <ARREST <GET ,CHARACTER-TABLE
				      <GETP ,PRSO ,P?CHARACTER>>>)>)
	       (T
		<COND (<OR <VERB? ASK-ABOUT TELL-ME>
			   <NOT ,NOW-PRSI>>
		       <TELL D ,PRSO>)
		      (T <TELL D ,PRSI>)>
		<COND (<AND <VERB? $CALL TELL HELLO GOODBYE ASK-ABOUT ASK-FOR>
			    <NOT <==?
				   <BAND
				     <GETP
				       <LOC <GET ,CHARACTER-TABLE
						 <GETP ,PRSO ,P?CHARACTER>>>
				       ,P?CORRIDOR>
				     <GETP ,HERE ,P?CORRIDOR>> 0>>>
		       <TELL " can't hear you." CR>)
		      (T <TELL " isn't here!" CR>)>
		<SETG P-CONT <>>
		<RTRUE>)>>
	
<OBJECT GLOBAL-TERRY
	(IN GLOBAL-OBJECTS)
	(DESC "Terry")
	(SYNONYM TERRY)
	(FLAGS FEMALE)>

<OBJECT GLOBAL-MRS-LINDER
	(IN GLOBAL-OBJECTS)
	(DESC "late Mrs. Linder")
	(ADJECTIVE MRS LATE YOUR HER)
	(SYNONYM LINDER MOTHER WIFE VIRGINIA)
	(FLAGS FEMALE)
	(ACTION GLOBAL-MRS-LINDER-F)>

<ROUTINE GLOBAL-MRS-LINDER-F ()
	 <COND (<VERB? FOLLOW>
		<TELL "You will eventually, shamus, you will." CR>)
	       (<VERB? $CALL PHONE>
		<TELL "You're not with her yet." CR>)>>

<OBJECT GLOBAL-DUFFY
	(IN GLOBAL-OBJECTS)
	(ADJECTIVE SERGEANT SGT)
	(SYNONYM DUFFY POLICE)
	(DESC "Sergeant Duffy")
	(ACTION GLOBAL-DUFFY-F)>

<OBJECT HINT
	(DESC "hint")
	(IN GLOBAL-OBJECTS)
	(SYNONYM HINT HELP)
	(ACTION HINT-F)>

<ROUTINE HINT-F ()
 <COND (<OR <AND <VERB? ASK-FOR> <NOT <DOBJ? GLOBAL-DUFFY>>>
	    <AND <VERB? TAKE>	 <NOT <IOBJ? GLOBAL-DUFFY>>>>
	<TELL "You'll have to be more specific." CR>)>>

<ROUTINE GLOBAL-DUFFY-F ()
 <COND (<AND <VERB? PHONE> <DOBJ? GLOBAL-DUFFY> <PHONE-IN? ,HERE>>
	<COND (,SEEN-DUFFY?
	       <TELL
"Duffy must be around here somewhere. There's no point in trying to
phone him." CR>)
	      (T <TELL
"The night clerk at the station says he'll give Duffy your message." CR>)>)
       (<NOT ,SEEN-DUFFY?>
	<TELL
"Sergeant Duffy is probably at the station, working late as usual." CR>
	<RFATAL>)
       (<AND <VERB? WAIT-FOR> <DOBJ? GLOBAL-DUFFY>>
	<COND (<OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER <NOT ,MET-DUFFY?>>
	       <V-WAIT 10000 ,PRSO>)
	      (T <TELL
"You'd wait quite a while, since Sergeant Duffy is always
nearby but never approaches you without a good reason." CR>)>)
       (<OR ,FINGERPRINT-OBJ ,DUFFY-AT-CORONER>
	<DO-FINGERPRINT>
	<RFATAL>)
       (<AND <VERB? ARREST SHOOT> <DOBJ? GLOBAL-DUFFY>>
	<TELL "Oh, come on now! Not trusty " D ,PRSO "!" CR>)
       (<AND <VERB? FIND> <DOBJ? GLOBAL-DUFFY>>
	<TELL
"Like a lurking grue in the dark places of the earth, Sergeant Duffy is
never far from the scene of a crime. If you witness a crime, you can be
sure he'll show up soon. Then, if you ANALYZE something, he
will appear in an instant to take it to the lab. When the results are
available, he will rush them back to you. If you ARREST someone, he
will be there with the handcuffs. You can't find a more dedicated civil
servant." CR>)
       (<AND <VERB? FOLLOW> <DOBJ? GLOBAL-DUFFY>>
	<COND (,DUFFY-WITH-STILES <PERFORM ,PRSA ,STILES ,PRSI> <RTRUE>)
	      (T <TELL "Duffy is too quick to follow." CR>)>)
       (<NOT ,MET-DUFFY?>
	<COND (<NOT <I-MEET-DUFFY?>>
	       <TELL "It looks as though Duffy didn't hear you." CR>)>
	<RTRUE>)
       (<AND <VERB? $CALL> <DOBJ? GLOBAL-DUFFY>>
	<RFALSE>)
       (<==? ,WINNER ,GLOBAL-DUFFY>
	<COND (<VERB? ANALYZE SANALYZE MAKE>
	       <SETG WINNER ,PLAYER>
	       <PERFORM ,PRSA ,PRSO ,PRSI>
	       <RTRUE>)
	      (<VERB? ARREST>
	       <SETG WINNER ,PLAYER>
	       <PERFORM ,V?ARREST ,PRSO>
	       <RTRUE>)
	      (<VERB? FIND THANKS> <RFALSE>)
	      (<OR <AND <VERB? GIVE> <DOBJ? HINT> <IOBJ? PLAYER>>
		   <AND<VERB? SGIVE> <IOBJ? HINT> <DOBJ? PLAYER>>>
	       <DUFFY-HINT>)
	      (<VERB? TAKE>
	       <TELL "Duffy">
	       <COND (<NOT ,DUFFY-WITH-STILES>
		      <TELL " appears for an instant but">)>
	       <TELL " politely declines your offer." CR>)
	      (<AND <VERB? PHONE> <DOBJ? CORONER>>
	       <COND (,DUFFY-WITH-STILES
		      <TELL "\"I will, as soon as I case the joint.\"" CR>)
		     (T <TELL
"\"Oh, I called the coroner as soon as I saw the body. They'll be here
as soon as they have time.\"" CR>)>)
	      (<AND <DOBJ? STILES> <VERB? UNTIE>>
	       <TELL "\"What?? I won't release a suspect!\"" CR>)
	      (<COM-CHECK ,GLOBAL-DUFFY> <RTRUE>)
	      (T <TELL
"\"With all respect, I think you should do that yourself.\"" CR>)>)
       (<AND <VERB? ASK-ABOUT> <DOBJ? GLOBAL-DUFFY>>
	<COND (<NOT ,DUFFY-WITH-STILES>
	       <TELL "Duffy appears for a moment. ">)>
	<TELL "\"">
	<COND (<AND <IOBJ? CORONER> <L? ,PRESENT-TIME 720>>
	       <TELL
"Oh, I called the coroner as soon as I saw the body. They'll be here
as soon as they have time.">)
	      (<IOBJ? AUTOPSY CORONER>
	       <COND (<OR ,DUFFY-AT-CORONER <L? ,PRESENT-TIME 720>>
		      <TELL
"Oh, I called the coroner as soon as I saw the body. They'll be here
as soon as they have time.">)
		     (T
		      <TELL "I thought I told you already. The coroner ">
		      <COND (,DUFFY-SAW-MEDICAL-REPORT
			     <TELL
"found no evidence of the alleged stomach tumor. In fact, he
could find no organic disease that would either explain the
death or support the theory that Linder wanted to die. He ">)>
		      <TELL
"concluded that Linder died of a single small-caliber bullet through the
heart. And here's something peculiar: there were no
traceable rifle marks on the bullet.">)>)
	      (<IOBJ? GLOBAL-DUFFY>
	       <TELL
"Come off it, Detective. We've worked together before. You sure you
didn't stop at a bar tonight?">)
	      (<IOBJ? TUB-ROOM BATHTUB>
	       <TELL
"Ah, that's where the late Mrs. Linder did herself in. A messy
business, Detective.">)
	      (<IOBJ? GLOBAL-SUICIDE>
	       <TELL "She shot herself in the bathtub.">)
	      (<IOBJ? GUN-RECEIPT>
	       <TELL
"Oh, I know that place, Fritzi's. Untidy, but clean.">)
	      (<IOBJ? MEDICAL-REPORT>
	       <SETG DUFFY-SAW-MEDICAL-REPORT T>
	       <TELL"Fascinating! It could have been a suicide, then.">)
	      (<IOBJ? RECURSIVE-BOOK>
	       <TELL
"Ah, Connecticut! I have relations there, you know. In fact, one young
one wants to be a detective some day.">)
	      (T <TELL "I wish I could help you, Detective.">)>
	<TELL "\"">
	<COND (<NOT ,DUFFY-WITH-STILES>
	       <TELL " He scurries off again.">)>
	<CRLF>)
       (<AND <VERB? ASK-FOR> <IOBJ? HINT>>
	<DUFFY-HINT>)
       (<OR <AND <VERB? GIVE> <IOBJ? GLOBAL-DUFFY>>
	    <AND<VERB? SGIVE> <DOBJ? GLOBAL-DUFFY>>>
	<TELL "Duffy">
	<COND (<NOT ,DUFFY-WITH-STILES>
	       <TELL " appears for an instant but">)>
	<TELL " politely declines your offer." CR>)
       (<VERB? GOODBYE>
	<TELL
"\"You can't leave yet, Detective. Think of your reputation!\"" CR>)
       (<VERB? HELLO>
	<COND (,DUFFY-WITH-STILES
	       <TELL "\"Hello again, Detective.\"" CR>)
	      (T <TELL
"Duffy peeks around a corner, tips his hat to you, and disappears
again." CR>)>)
       (<AND <DOBJ? GLOBAL-DUFFY> <VERB? SHOW>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSI>
	<RTRUE>)
       (<AND <VERB? TAKE> <DOBJ? HINT> <IOBJ? GLOBAL-DUFFY>>
	<DUFFY-HINT>)>>

"People Functions"

<GLOBAL WHY-ME
	<PLTABLE "\"You can do that yourself.\""
		"\"Do it yourself!\""
		"\"Why not do it yourself?\"">>

;<GLOBAL HO-HUMS
	<PLTABLE " is standing here.">	;"? MORE?">

;<ROUTINE CARRY-CHECK (PERSON)
	 <COND (<FIRST? .PERSON>
		<PRINT-CONT .PERSON T 0>)>
	 T>

<ROUTINE COM-CHECK (PER)
 	 <COND (<VERB? EXAMINE>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?SHOW .PER ,PRSO>
		<RTRUE>)
	       (<AND <VERB? FOLLOW> <DOBJ? PLAYER>>
		<TELL "\"I would rather not.\"" CR>)
	       (<AND <VERB? GIVE> <IOBJ? PLAYER>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?TAKE ,PRSO .PER>
		<RTRUE>)
	       (<AND <VERB? SGIVE> <DOBJ? PLAYER>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?TAKE ,PRSI .PER>
		<RTRUE>)
	       (<AND <VERB? GOODBYE>
		     <OR <NOT ,PRSO> <==? ,PRSO .PER>>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?GOODBYE ,WINNER>
		<RTRUE>)
	       (<AND <VERB? HELLO>
		     <OR <NOT ,PRSO> <==? ,PRSO .PER>>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?HELLO .PER>
		<RTRUE>)
	       (<VERB? HELP>
		<COND (<OR <DOBJ? PLAYER> <NOT ,PRSO>>
		       <PERFORM ,V?GIVE ,HINT ,PLAYER>
		       <RTRUE>)
		      (<FSET? ,PRSO ,PERSON>
		       <TELL "\"I don't need your help.\"" CR>)
		      (T <RFALSE>)>)
	       (<VERB? INVENTORY>
		<TELL "\"" "You're the detective!" "\"" CR>)
	       (<AND <VERB? SHOW> <DOBJ? PLAYER>>
		<TELL "\"I'm sure you can find it, Detective.\"" CR>)
	       (<AND <VERB? TELL-ME> <DOBJ? PLAYER>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?ASK-ABOUT .PER ,PRSI>
		<RTRUE>)
	       (<OR <VERB? WAIT>
		    <AND <VERB? WAIT-FOR> <DOBJ? PLAYER>>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,V?$CALL .PER>
		<RTRUE>)
	       (<VERB? WHAT>
		<SETG WINNER ,PLAYER>
	        <PERFORM ,V?ASK-ABOUT .PER ,PRSO>
		<RTRUE>)>>

<ROUTINE DESCRIBE-PERSON (PERSON "OPTIONAL" (STR <>))
	 <TELL D .PERSON " is "
	       <COND (<NOT .STR> "here")
		     (T .STR)>
	       "." CR>>

<ROUTINE DISCRETION (P1 P2 "OPTIONAL" (P3 <>))
	 <COND (<AND <==? ,HERE <META-LOC .P2>>
		     .P3 <==? ,HERE <META-LOC .P3>>>
	        <TELL D .P1 " looks briefly toward " D .P2 " and " D .P3
" and then speaks in a whisper." CR>)
	       (<==? ,HERE <META-LOC .P2>>
	        <TELL D .P1 " looks briefly toward " D .P2
" and then speaks in a whisper." CR>)
	       (<AND .P3 <==? ,HERE <META-LOC .P3>>>
	        <TELL D .P1 " looks briefly toward " D .P3
" and then speaks in a whisper." CR>)>>

;<ROUTINE FOLLOWED? (PERSON "AUX" (L <LOC .PERSON>))
	 <COND (<==? .L ,HERE> <RTRUE>)
	       (<NOT <==? <BAND <GETP .L ,P?CORRIDOR>
				<GETP ,HERE ,P?CORRIDOR>> 0>>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE INHABITED? (RM) <NOT <0? <POPULATION .RM>>>>

<ROUTINE POPULATION (RM "OPTIONAL" (PR <>) "AUX" (CNT 0) OBJ)
	 #DECL ((RM) OBJECT (CNT) FIX)
 <COND (<NOT <SET OBJ <FIRST? .RM>>> <RETURN .CNT>)>
 <REPEAT ()
	 <COND (<AND <FSET? .OBJ ,PERSON> <NOT <FSET? .OBJ ,INVISIBLE>>>
		<SET CNT <+ .CNT 1>>
		<COND (.PR <DESCRIBE-PERSON .OBJ "there">)>)
	       (<FSET? .OBJ ,CONTBIT>
		<SET CNT <+ .CNT <POPULATION .OBJ .PR>>>)>
	 <SET OBJ <NEXT? .OBJ>>
	 <COND (<NOT .OBJ> <RETURN .CNT>)>>>

<ROUTINE RANDOM-SHOES-F ("AUX" OBJ)
 <COND (<OR <AND <SET OBJ ,PRSO> <VERB? GIVE TAKE>>
	    <AND <SET OBJ ,PRSI> <VERB? ASK-FOR SEARCH-OBJECT-FOR SGIVE>>>
	<COND (<EQUAL? .OBJ ,PHONG-SHOES> <PHONG-FIGHTS>)
	      (<EQUAL? .OBJ ,MONICA-SHOES>
	       <COND (<NOT ,MONICA-TIED-TO> <MONICA-PUSHES>)
		     (T <TELL
"Monica writhes away from your touch and manages to kick you in the
shin." CR>)>)
	      (<EQUAL? .OBJ ,STILES-SHOES>
	       <TELL
"\"Please don't take them! I'm cold enough as it is!\"" CR>)
	      (<EQUAL? .OBJ ,LINDER-SHOES>
	       <COND (<LOC ,LINDER>
		      <TELL
"\"I'm beginning to wonder if I got a decent detective or not!\"" CR>)
		     (<TANDY?> <TELL "You can't be that desperate!" CR>)
		     (T <TELL
"Necrophilia went out with raccoon coats!" CR>)>)>)
       (<AND <VERB? COMPARE PUT>
	     <OR <DOBJ? SIDE-FOOTPRINTS SIDE-FOOTPRINTS-CAST
			BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>
		 <IOBJ? SIDE-FOOTPRINTS SIDE-FOOTPRINTS-CAST
			BACK-FOOTPRINTS BACK-FOOTPRINTS-CAST>>>
	<TELL
"The shoes don't seem to match " ;"the plaster cast of "
"the foot prints that you found in the " "yard." CR>)
       (<VERB? EXAMINE>
	<COND (<DOBJ? PHONG-SHOES LINDER-SHOES>
	       <TELL
"They're straw slippers with thongs, clean and obviously comfortable." CR>)
	      (<DOBJ? STILES-SHOES>
	       <TELL
"They're pointed wing tips with sensational welt features, but a bit shabby
and more than a bit muddy." CR>)
	      (<DOBJ? MONICA-SHOES>
	       <TELL
"They're tan pumps with Cuban heels, clean and stylish." CR>)>)>>
