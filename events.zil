"EVENTS for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

"Ideas:	insurance policy - fraud?
	nosy neighbor?
	fingerprint two-color picture"

<ROUTINE INTRO ()
	 <TELL 
"Somewhere near Los Angeles. A cold Friday evening in February 1938. In
this climate, cold is anywhere below about fifty degrees. Storm clouds
are swimming across the sky, their bottoms glowing faintly from the city
lights in the distance. A search light pans slowly under the clouds,
heralding another film premiere. The air seems expectant, waiting for
the rain to begin, like a cat waiting for the ineffable moment to
ambush.|" CR "The taxi has just dropped you off at the entrance to the
Linders' driveway. The driver didn't seem to like venturing into this
maze of twisty streets any more than you did. But the house windows are
full of light, and radio music drifts toward you. Your favorite pistol,
a snub-nosed Colt .32, is snug in its holster. You just picked up a
match book off the curb. It might come in handy. Good thing you looked
up the police file on Mrs. Linder's death. Her suicide note and the
newspaper story told you all you know about the family. The long week is
finished, except for this appointment. But why does an ominous feeling
grip you?|" CR>>

<ROUTINE TIMES-UP ()
	 <TELL 
"Police Chief Klutz walks up to you, from out of nowhere. \"I'm
sorry, Detective, but you can't spend any more time here. We need you at
the Coliseum for the all-day Police Department track-and-field meet. I
hope you had a restful night!\" He
escorts you to a waiting police car, and you go off into the sunrise." CR>
	 <COND (,TOO-LATE <TOO-LATE-F>)>
	 <QUIT>>

<OBJECT MIDNIGHT
	(IN GLOBAL-OBJECTS)
	(DESC "midnight")
	(SYNONYM MIDNIGHT)>

<OBJECT SMALL-INTEGER
	(IN GLOBAL-OBJECTS)
	(SYNONYM TWO THREE FOUR FIVE)
	(ACTION INTEGER-F)>

<OBJECT MEDIUM-INTEGER
	(IN GLOBAL-OBJECTS)
	(SYNONYM TEN FIFTEEN TWENTY THIRTY)
	(ACTION INTEGER-F)>

<ROUTINE INTEGER-F ()
	<TELL "(Use figures for numbers, for example \"10.\")" CR>>

<ROUTINE QUEUE-MAIN-EVENTS ()
	<ENABLE <QUEUE I-LINDER-TO-OFFICE 52>>
	<ENABLE <QUEUE I-LINDER-RETIRES 290>>
	<ENABLE <QUEUE I-PHONG-RETIRES 320>>
	<ENABLE <QUEUE I-STILES-ARRIVE 60>>
	<ENABLE <QUEUE I-PROMPT-1 1>>
	<ENABLE <QUEUE I-PROMPT-2 10>>
	<ENABLE <QUEUE I-WEATHER 6>>
	<ENABLE <QUEUE I-CHIMES 30>>>

"SCORE INDICATES HOURS / MOVES = MINUTES"

<GLOBAL SCORE 20>
<GLOBAL MOVES 0>

<GLOBAL SKY-DESC "There's dark, cloudy sky above you.">
<GLOBAL PRESENT-TIME	480>		"8 PM"
<GLOBAL CLOUDS-GONE	525>
<GLOBAL MOONRISE	612>	"from L.A. Times of 1938-02-18"
<GLOBAL SUNRISE		1117>  "sun crosses horizon at Pasadena on 1938-02-19"

<GLOBAL I-WEATHER-NUM 0>
<GLOBAL GROUND-MUDDY <>>
<ROUTINE I-WEATHER ("AUX" (OUT? <==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>))
 <SETG I-WEATHER-NUM <+ 1 ,I-WEATHER-NUM>>
 <COND (<==? 1 ,I-WEATHER-NUM>
	<TELL "Suddenly, a clap of thunder rolls across the hills">
	<COND (.OUT? <TELL " nearby">)
	      (T <TELL " outside">)>
	<TELL "." CR>
	<ENABLE <QUEUE I-WEATHER 3>>)
       (<==? 2 ,I-WEATHER-NUM>
	<TELL "Without warning, lightning flashes">
	<COND (.OUT? <TELL " above">)
	      (T <TELL " outside">)>
	<TELL ", and a few seconds later thunder rattles the house." CR>
	<ENABLE <QUEUE I-WEATHER 3>>)
       (<==? 3 ,I-WEATHER-NUM>
	<TELL "Rain begins to fall">
	<COND (<NOT .OUT?> <TELL " outside">)>
	<TELL " in a sprinkle." CR>
	<ENABLE <QUEUE I-WEATHER 2>>)
       (<==? 4 ,I-WEATHER-NUM>
	<SETG GROUND-MUDDY T>
	<TELL "The rain">
	<COND (<NOT .OUT?> <TELL " outside">)>
	<TELL " is falling heavily now." CR>
	<ENABLE <QUEUE I-WEATHER 9>>)
       (<==? 5 ,I-WEATHER-NUM>
	<TELL "The rain">
	<COND (<NOT .OUT?> <TELL " outside">)>
	<TELL " begins to taper off." CR>
	<ENABLE <QUEUE I-WEATHER 5>>)
       (<==? 6 ,I-WEATHER-NUM>
	<TELL "The rain storm">
	<COND (<NOT .OUT?> <TELL " outside">)>
	<TELL " has passed now." CR>
	<ENABLE <QUEUE I-WEATHER <- ,CLOUDS-GONE ,PRESENT-TIME>>>)
       (<==? 7 ,I-WEATHER-NUM>
	<SETG SKY-DESC "The sky is clear now, with stars shining coldly.">
	<ENABLE <QUEUE I-WEATHER <- ,MOONRISE ,PRESENT-TIME>>>)
       (<==? 8 ,I-WEATHER-NUM>
	<SETG SKY-DESC "The moon, just past full, lights up the whole yard.">
	<ENABLE <QUEUE I-WEATHER <- ,SUNRISE ,PRESENT-TIME 15>>>)
       (<==? 9 ,I-WEATHER-NUM>
	<TELL "Suddenly it dawns on you that the sky is getting light">
	<COND (<NOT .OUT?> <TELL " outside">)>
	<TELL "." CR>
	<SETG SKY-DESC "The morning sunshine lights up the whole yard.">
	<ENABLE <QUEUE I-WEATHER 25>>)
       (<==? 10 ,I-WEATHER-NUM>
	<TELL "The sun has appeared over the hills">
	<COND (<NOT .OUT?> <TELL " outside">)>
	<TELL "." CR>)>
 <RFALSE>>

<ROUTINE I-CHIMES ("AUX" HALF-HR HR)
 <ENABLE <QUEUE I-CHIMES 30>>
 <SET HALF-HR </ ,PRESENT-TIME 30>>
 <SET HR </ .HALF-HR 2>>
 <COND (<EQUAL? ,HERE ,OFFICE>
	<COND (<==? .HALF-HR <* 2 .HR>>
	       <COND (<L? 12 .HR> <SET HR <- .HR 12>>)>
	       <TELL "The clock chimes ">
	       <COND (<==? 1 .HR> <TELL "once">)
		     (<==? 2 .HR> <TELL "twice">)
		     (T <TELL N .HR " times">)>
	       <TELL " to mark the hour." CR>)
	      (T
	       <TELL "The clock chimes once to mark the half hour." CR>)>)>
 <RFALSE>>

<ROUTINE I-STILES-ARRIVE ()
	<MOVE ,STILES ,OFFICE-PATH>
	<FSET ,BACK-GATE ,LOCKED>
	<ESTABLISH-GOAL ,STILES ,OFFICE-PORCH>
	<COND (<EQUAL? ,HERE ,OFFICE-PATH>
	       <TELL
"Someone enters through the back gate and rushes past you." CR>)
	      (<AND <GETP ,HERE ,P?CORRIDOR>
		    <NOT <0? <BAND <GETP ,HERE ,P?CORRIDOR> 3>>>>
	       <TELL
"Someone enters the property through the back gate." CR>)>>

<GLOBAL DUFFY-WITH-STILES <>>
<ROUTINE I-DUFFY-ARRIVE ()
	<COND (,WELCOMED
	       <ENABLE <QUEUE I-MEET-DUFFY? -1>>
	       <SETG DUFFY-WITH-STILES T>
	       <FCLEAR ,STILES ,INVISIBLE>
	       <ESTABLISH-GOAL ,STILES ,FRONT-PORCH>)
	      (T
	       <SETG SEEN-DUFFY? T>
	       <SETG MET-DUFFY? T>
	       <TELL
"Suddenly, your assistant, Sgt. Duffy, appears from out of nowhere.
\"Hello, Detective!"
" I thought I should come here on the streetcar, in case you needed help. "
"I'll be nearby if you want me.\" He disappears just as quickly." CR>)>
	<RFALSE>>

<GLOBAL MET-STILES? <>>
<GLOBAL MET-DUFFY? <>>
<GLOBAL SEEN-DUFFY? <>>

<ROUTINE DUFFY-GREETING ()
	<SETG MET-STILES? T>
	<SETG SEEN-DUFFY? T>
	<SETG MET-DUFFY? T>
	<FSET ,STILES ,TOUCHBIT>
	<TELL " \"Detective, I'm glad you're safe!">
	<COND (,PLAYER-HIDING
	       <TELL " Don't worry, I won't tell anyone you're hiding.">)>
	<TELL
" I thought I should come here on the streetcar, in case you needed help. "
"I'm familiar with the house, since I was here to help investigate
Mrs. Linder's death.
Just as I walked up tonight, I heard a shot! The next thing I knew, this man,
who calls himself Stiles, burst out of the woods behind the house.
Naturally, I put the nippers on him and brought him along.">>

<ROUTINE I-MEET-DUFFY? ("OPTIONAL" (ARG <>) "AUX" (L <LOC ,STILES>))
 <COND (<AND ,WELCOMED
	     <NOT ,MET-DUFFY?>
	     <OR <==? .L ,HERE>	;"? or sees you thru door"
		 <NOT <0? <BAND <GETP .L ,P?CORRIDOR>
				<GETP ,HERE ,P?CORRIDOR>>>>>>
	<TELL "Your assistant, Sgt. Duffy, sees you.">
	<DUFFY-GREETING>
	<TELL
" I'll just stow him in the living room and stand by to help you.\"" CR>
	<ESTABLISH-GOAL ,STILES ,LIVING-ROOM>
	<DISABLE <INT I-MEET-DUFFY?>>
	<RTRUE>)>>

"Object functions"

<GLOBAL ANALYSIS-GOAL <>>

<ROUTINE DO-FINGERPRINT ("OPTIONAL" (AN <>))
	 <COND (,DUFFY-AT-CORONER
		<TELL
"Don't you remember? Duffy went in the ambulance to the Coroner's office. "
"You'll have to wait for him to return." CR>
		<RTRUE>)
	       (,FINGERPRINT-OBJ
		<TELL
"Sergeant Duffy ran off to the lab on an errand for you. "
"You'll have to wait for him to return." CR>
		<RTRUE>)>
	 <COND (<NOT ,MET-DUFFY?>
		<TELL
"You haven't met Sergeant Duffy yet tonight."
" You'll need his help to do that." CR>
		<RTRUE>)>
	 <COND (<NOT .AN>
		<TELL
"You look at the " D ,PRSO " closely. It appears to have good
fingerprints on it, so you call for Sergeant Duffy." CR>)>
	 <COND (<AND .AN ,PRSI>
		<SETG ANALYSIS-GOAL ,PRSI>)
	       (T <SETG ANALYSIS-GOAL <>>)>
	 <SETG FINGERPRINT-OBJ ,PRSO>
	 <SETG ANALYSIS-OBJ .AN>
	 <ENABLE <QUEUE I-FINGERPRINT <+ 15 <RANDOM 15>>>>
	 <FSET ,PRSO ,TOUCHBIT>
	 <REMOVE ,PRSO>
	 <TELL
"Sergeant Duffy, quiet as a mouse, walks up and takes the
" D ,PRSO " from you. \"I'll return soon with the results,\" he
says, and leaves as silently as he came." CR>>

<GLOBAL ANALYSIS-OBJ <>>

<ROUTINE DO-ANALYZE ()
 <COND (<EQUAL? ,PRSO ,PRSI>
	<TELL
"Sergeant Duffy appears with a puzzled look on his face."
" \"I don't see how you expect the lab to analyze something for itself!\""
" He leaves, shaking his head slowly." CR>
	<RTRUE>)>
 <DO-FINGERPRINT T>>

<ROUTINE I-FINGERPRINT ()
	 <TELL "Suddenly, Sergeant Duffy ">
	 <COND (<PROB 30>
		<TELL
"appears, holding the " D ,FINGERPRINT-OBJ
" carefully in his hands. His quiet efficiency is impressive. ">)
	       (<PROB 50>
		<TELL
"seems to arrive from nowhere, holding the " D ,FINGERPRINT-OBJ
" in his hands. ">)
	       (T
		<TELL
"returns with the " D ,FINGERPRINT-OBJ ". For a moment you muse on his almost
magical appearances. ">)>
	 <COND (,ANALYSIS-GOAL
		<COND (<AND <EQUAL? ,FINGERPRINT-OBJ ,INSIDE-GUN ,OUTSIDE-GUN>
			    <EQUAL? ,ANALYSIS-GOAL ,POWDER ,CLOCK-POWDER>>
		       <TELL
"\"The gun has recently been fired, and it contains traces of cheap
gun powder">
		       <COND (,POWDER-ANALYZED
			      <TELL
", the same kind of powder that you found on the clock">)>
		       <TELL ".">)
		      (<AND <EQUAL? ,FINGERPRINT-OBJ ,MATCHBOOK ,THREAT-NOTE>
			    <EQUAL? ,ANALYSIS-GOAL ,HANDWRITING>>
		       <TELL
"\"The ink is ordinary Waterman blue-black. The lab can't tell much else
without a certified handwriting sample on file.">)
		      (<NOT <EQUAL? ,FINGERPRINT-OBJ ,ANALYSIS-GOAL>>
		       <TELL "\"The " D ,FINGERPRINT-OBJ
			     " doesn't contain any ">
		       <ANALYSIS-PRINT ,ANALYSIS-GOAL>)>)
	       (<OR <EQUAL? ,FINGERPRINT-OBJ ,PIECE-OF-WIRE ,SPOOL-OF-WIRE>
		    <EQUAL? ,FINGERPRINT-OBJ ,WHITE-WIRE ,BLACK-WIRE>>
		<TELL "\"The wire is ordinary 16-gauge bell wire.">)
	       (<EQUAL? ,FINGERPRINT-OBJ ,PIECE-OF-PUTTY>
		<TELL
"\"The putty contained traces of the explosive cordite.">)
	       (<EQUAL? ,FINGERPRINT-OBJ ,INSIDE-GUN ,OUTSIDE-GUN>
		       <TELL
"\"The gun has recently been fired, and it contains traces of cheap
gun powder">
		       ;<COND (,POWDER-ANALYZED
			      <TELL
", the same kind of powder that you found on the clock">)>
		       <TELL ".">
		       <COND (<EQUAL? ,FINGERPRINT-OBJ ,INSIDE-GUN>
			      <TELL
" And the barrel has indeed been sawed off.">)>)
	       (<==? ,FINGERPRINT-OBJ ,CLOCK-POWDER>
		<SETG POWDER-ANALYZED T>
		<TELL
"\"The powder is gun powder, as I suspected. I put it in a cellophane
envelope for you.">)
	       (<EQUAL? ,FINGERPRINT-OBJ ,MATCHBOOK ,THREAT-NOTE>
		<TELL
"\"The ink is ordinary Waterman blue-black. The lab can't tell much else
without a certified handwriting sample on file.">)
	       (<EQUAL? ,FINGERPRINT-OBJ ,STUB>
		<TELL
"\"I took the ticket stub to the movie theater, where they told me
that it looked authentic to them, and the serial number proves that it
was bought tonight.">)
	       (<EQUAL? ,FINGERPRINT-OBJ ,MEDICAL-REPORT>
		<SETG DUFFY-SAW-MEDICAL-REPORT T>
		<TELL
"\"I tried to call the doctor, but there's no listing in the phone book.
The lab people couldn't see anything unusual about the report.">)
	       (T
		<TELL
"\"I'm sorry,\" he begins, \"but the lab found nothing interesting.">)>
	 <TELL "\"
With that, he leaves, handing you the " D ,FINGERPRINT-OBJ
" as he whisks away." CR>
	 <MOVE ,FINGERPRINT-OBJ ,PLAYER>
	 <SETG FINGERPRINT-OBJ <>>
	 <RTRUE>>

<ROUTINE ANALYSIS-PRINT (OBJ)
	 <TELL D .OBJ ".">>

<ROUTINE TODAY-F ()
	 <COND (<VERB? WHAT>
		<COND (<L? ,PRESENT-TIME 720>
		       <TELL "Today is Friday, February 18, 1938." CR>)
		      (T
		      <TELL "Today is Saturday, February 19, 1938." CR>)>)>>

<GLOBAL WELCOMED <>>
<GLOBAL TOO-LATE-KNOCKED 0>

<ROUTINE WELCOME ()
 <COND (<==? 2 ,TOO-LATE-KNOCKED>
	<TELL
"No one answers the door, but a police car races in the driveway and
stops. Two officers jump out, grab you roughly, and haul you off as a
trespasser." CR>
	<TOO-LATE-F>
	<QUIT>)>
 <COND (,RADIO-ON
	<TELL "Someone turns off the radio. ">
	<SETG RADIO-ON <>>)>
 <TELL "You hear footsteps inside the house. Then the door swings open." CR>
 <COND (<1? ,TOO-LATE-KNOCKED>
	<SETG TOO-LATE-KNOCKED 2>
	<TELL
"The butler isn't smiling now. \"I told you Mr. Linder will be in touch.
Please leave before I call the police!\" He slams the door in your face." CR>)
       (,TOO-LATE
	<SETG TOO-LATE-KNOCKED 1>
	;<FSET ,PHONG ,TOUCHBIT>
	<TELL
"\"Good evening,\" says a smiling face, \"I am Phong. I'm sorry, but
you're too late arriving here. Mr. Linder has other business now. But he
thanks you for coming and says he'll be in touch. Good night!\" He
closes the door in your face." CR>)
       (T
	<COND (<==? ,HERE ,FRONT-PORCH>
		<MOVE ,PHONG ,ENTRY>
		<TELL
"\"Good evening,\" says a smiling face, \"I am Phong. Please come in.\"
He leads you into the house and closes the door behind you.|" CR>
		<FCLEAR ,FRONT-DOOR ,OPENBIT>
		<GOTO ,ENTRY>)
	       (T
		<TELL
"\"I've been told that detectives are sneaky, but this is too much!\"" CR>)>
	<ENABLE <QUEUE I-GOTO-LIVING-ROOM 2>>)>>

<ROUTINE I-GOTO-LIVING-ROOM ()
	 <TELL "Phong says, \"I believe ">
	 <COND (<IN? ,MONICA ,LIVING-ROOM> <TELL "the Linders are">)
	       (T <TELL "Mr. Linder is">)>
	 <TELL " in the living room. Please follow me.\"">
	 <COND (<0? <BAND 16 <GETP ,HERE ,P?CORRIDOR>>>
		<FSET ,HALL-3 ,TOUCHBIT>
		<TELL " He leads you into a hallway and turns left. "
			  <GETP ,HALL-3 ,P?LDESC>>)
	       (T <TELL " He leads you north along the hallway. ">)>
	 <COND (<IN? ,MONICA ,LIVING-ROOM>
		<TELL
" As you get near the living room, you hear voices talking, half-loud
and fast.">)>
	 <CRLF> <CRLF>
	 <MOVE ,PHONG ,LIVING-ROOM>
	 <GOTO ,LIVING-ROOM>
	 <COND (<FIX-PHONG-MOVEMENT>
		<ENABLE <QUEUE I-PHONG 1>>
		<SETG WELCOMED T>)>
	 <I-LINDER-WELCOME>>

<ROUTINE I-LINDER-WELCOME ()
	<TELL CR
"Linder turns to you and says, \"Detective, am I glad to see you! ">
	<COND (,TOO-LATE
	       <TELL
"I was afraid you'd met with an accident. I'm afraid I don't have time
for you now, since I have another appointment. But thank you for
coming. I'll be in touch. Phong, please show the Detective out.\"">
	       <SAID-TO ,LINDER>
	       <ESTABLISH-GOAL ,LINDER ,OFFICE>
	       <DISABLE <INT I-LINDER-TO-OFFICE>>
	       <ENABLE <QUEUE I-PHONG-EJECTS 3>>)
	      (T
	       <ESTABLISH-GOAL ,PHONG ,KITCHEN>
	       <SETG OHERE ,HERE>
	       <SETG LINDER-FOLLOWS-YOU T>
	       <ENABLE <QUEUE I-LINDER-FOLLOWS-YOU -1>>
	       <COND (<IN? ,MONICA ,HERE>
		      <TELL "This is my daughter, Monica, and of course ">)
		     (T <TELL "I see ">)>
	       <TELL
"you've met Phong already.\" He looks at a wrist watch with a gleaming
silver bracelet. \"I see you're">
	       <SAID-TO ,LINDER>
	       <COND (<L? ,PRESENT-TIME 490>
		      <TELL " right on time.">
		      <ENABLE <QUEUE I-LINDER-TO-OFFICE 10>>)
		     (<L? ,PRESENT-TIME 500>
		      <TELL " a little late.">
		      <ENABLE <QUEUE I-LINDER-TO-OFFICE 5>>)
		     (T
		      <TELL " rather late.">
		      <ENABLE <QUEUE I-LINDER-TO-OFFICE 1>>)>
	       <TELL " I'll be with you as soon as I finish my drink.\"">)>
	<CRLF>>

<ROUTINE I-PHONG-EJECTS ()
 <FCLEAR ,FRONT-DOOR ,OPENBIT>
 <FSET ,FRONT-DOOR ,LOCKED>
 <TELL
"Phong grabs you by the arm and guides you to the front door. It's
obvious that you have no choice. \"Thank you for coming, Detective. Good
night!\" He closes the door in your face." CR>
 <SETG TOO-LATE-KNOCKED 1>
 <GOTO ,FRONT-PORCH>
 <RTRUE>>

<GLOBAL OHERE <>>

<GLOBAL LINDER-FOLLOWS-YOU <>>

<ROUTINE I-LINDER-FOLLOWS-YOU ()
 <COND (<NOT <==? ,OHERE ,HERE>>
	<WHERE-UPDATE ,LINDER>
	<MOVE ,LINDER ,HERE>
	<TELL "Linder follows you ">
	<COND (<AND <OR <EQUAL? ,OHERE ,HALL-1 ,HALL-2>
			<EQUAL? ,OHERE ,HALL-3 ,HALL-4>>
		    <OR <EQUAL?  ,HERE ,HALL-1 ,HALL-2>
			<EQUAL?  ,HERE ,HALL-3 ,HALL-4>>>
	       <TELL "along">)
	      (T
	       <TELL "into">)>
	<THE? ,HERE>
	<TELL " " D ,HERE ".">
	<COND (<AND <PROB 50> <WINDOW-IN? ,HERE>>
	       <TELL " He looks out the window and checks the lock.">)>
	<CRLF>
	<SETG OHERE ,HERE>)>>

<ROUTINE I-LINDER-TO-OFFICE ("AUX" (VAL <>))
	 <DISABLE <INT I-LINDER-FOLLOWS-YOU>>
	 <COND (<OR <EQUAL? ,HERE ,WORKSHOP> <OUTSIDE? ,HERE>>
		<MOVE ,LINDER ,CARVED-CHAIR>
		<SETG TOO-LATE T>
		<COND (<EQUAL? ,HERE ,BACK-YARD ,OFFICE-PORCH ,OFFICE-PATH>
		       <TELL "The lights go on in Linder's office." CR>)>
		<RFALSE>)
	       (<NOT <EQUAL? ,OFFICE ,HERE <LOC ,PLAYER>>>
		<SET VAL ,M-FATAL>
		<TELL
"Linder gulps down the rest of his drink. \"Well, Detective,\" he says,
\"I'm anxious to get on with our business. Let's you and I go to my
office so we can talk undisturbed.\" ">
		<COND (<FSET? <LOC ,PLAYER> ,FURNITURE>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?STAND>)>
		<COND (<EQUAL? ,HERE ,HALL-4>
		       <TELL
"He takes you by the arm, opens a door to the east and leads you through it."
CR>)
		      (T <TELL
"He takes you by the arm and leads you through the hallway. Just south
of the entry, he opens a door to the east and leads you through it." CR>)>
		<FSET ,OFFICE-DOOR ,OPENBIT>
		<GOTO ,OFFICE>
		<WHERE-UPDATE ,LINDER>
		<SAID-TO ,LINDER>)>
	 <ENABLE <QUEUE I-LINDER-IN-OFFICE 1>>
	 <FSET ,LINDER ,NDESCBIT>
	 <MOVE ,LINDER ,CARVED-CHAIR>
	 <TELL "Linder sits down in the carved chair." CR>
	 .VAL>

<GLOBAL LINDER-ASKED-YOU-TO-SIT 0>
<ROUTINE I-LINDER-IN-OFFICE ()
	<COND (,LINDER-EXPLAINED <>)
	      (<IN? <LOC ,PLAYER> ,ROOMS>
	       <ENABLE <QUEUE I-LINDER-IN-OFFICE 5>>
	       <SAID-TO ,LINDER>
	       <COND (<0? ,LINDER-ASKED-YOU-TO-SIT>
		      <TELL
"\"I" "f you'll just take a chair, I'll explain what this is all about.\""
CR>)
		     (T <TELL "Linder says, \"I repeat: i"
"f you'll just take a chair, I'll explain what this is all about.\""
CR>)>
	       <SETG LINDER-ASKED-YOU-TO-SIT <+ 1 ,LINDER-ASKED-YOU-TO-SIT>>)
	      (T <ENABLE <QUEUE I-LINDER-EXPLAIN 1>>)>>

<GLOBAL LINDER-EXPLAINED <>>
<ROUTINE I-LINDER-EXPLAIN ()
 <COND (<NOT ,LINDER-EXPLAINED>
	<SETG LINDER-EXPLAINED T>
	<TELL
"Linder begins his story. \"My late wife, may she rest in peace, got
involved with a young man named Stiles. Naturally I tried to stop this
affair, but without much success. Since my wife passed away, this Stiles
fellow has gone off the deep end, I'm afraid, and blamed me for her
death. I tried my best to ignore him, but he seems to have lost his
senses. This morning I received this note and decided to ask your
help.\" He hands the note to you." CR>
	<SAID-TO ,LINDER>
	<THIS-IS-IT ,THREAT-NOTE>
	<MOVE ,THREAT-NOTE ,PLAYER>
	<FSET ,THREAT-NOTE ,TOUCHBIT>
	<FCLEAR ,THREAT-NOTE ,INVISIBLE>)>>

<GLOBAL PLAYER-NEAR-SHOT <>>
<ROUTINE FIRE-SHOT ()
	<TELL " Suddenly there is a flash of light and an explosion, and ">
	<COND (<AND ,PLAYER-NEAR-SHOT
		    <G? 2 <- ,PRESENT-TIME ,PLAYER-NEAR-SHOT>>>
	       <TELL
"everything goes black. What a lousy way to step off, poking around like
a two-bit shamus!" CR>
	       <QUIT>)
	      (<AND <PROB 50>
		    <NOT ,PLAYER-HIDING>
		    <NOT <EQUAL? <LOC ,PLAYER> ,WOODEN-CHAIR ,LOUNGE>>>
	       <TELL
"mortal pain radiates from your heart. As blood fills your lungs and a
scream fills your brain, you feel sure of only one thing: you should
have taken a chair when Linder asked you to." CR>
	       <QUIT>)>
	<TELL "the window falls into dozens of shiny shards.">
	<TELL " The cat bolts and disappears somewhere.">
	<REMOVE ,CAT>
	<SETG SHOT-FIRED T>
	<FCLEAR ,PIECE-OF-WIRE ,TRYTAKEBIT>
	<FSET	,PIECE-OF-WIRE ,TAKEBIT>
	<FCLEAR ,PIECE-OF-PUTTY ,TRYTAKEBIT>
	<FSET	,PIECE-OF-PUTTY ,TAKEBIT>
	<FCLEAR ,GLOBAL-SHOT ,INVISIBLE>
	<FSET ,OFFICE-WINDOW ,RMUNGBIT>
	<FCLEAR ,BROKEN-GLASS ,INVISIBLE>
	;<COND (<0? ,DIFFICULTY> <MOVE ,BROKEN-GLASS ,OFFICE-PORCH>)
	      (<==? ,DIFFICULTY ,DIFFICULTY-MAX>
	       <MOVE ,BROKEN-GLASS ,OFFICE>)>>

<ROUTINE I-PHONG-RETIRES ()
 <WHERE-UPDATE ,PHONG>
 <MOVE ,PHONG ,BUTLER-ROOM>
 <COND (<==? <GETP ,HERE ,P?LINE> ,OUTSIDE-LINE-C>
	<TELL "The lights go out, one by one, all over the house." CR>)>>

<ROUTINE I-LINDER-RETIRES ()
 <WHERE-UPDATE ,LINDER>
 <MOVE ,LINDER ,LINDER-ROOM>
 <COND (<EQUAL? ,HERE ,ROCK-GARDEN ,BACK-YARD ,OFFICE-PORCH>
	<TELL
"The lights go off in Linder's office and then in the bedroom at the
other end of the house." CR>)>>

"Here is the code for goal motivation for the various characters.
Each character has a tendency to move from one place to another
at certain times. They all converge on the living room at about
noon."

"Goal tables for the 6 characters (including PLAYER), offset
by the preceding constants, which, for a given character,
is the P?CHARACTER property of the object."

<GLOBAL GOAL-TABLES
	<TABLE <TABLE <> <> <> <> 1 <> <> I-FOLLOW 4 4>
	       <TABLE <> <> <> <> 1 <> <> I-PHONG 3 3>
	       <TABLE <> <> <> <> 1 <> <> I-LINDER 4 4>
	       <TABLE <> <> <> <> 1 <> <> I-STILES 9 9>
	       <TABLE <> <> <> <> 1 <> <> I-MONICA 2 2>
	       <TABLE <> <> <> <> 1 <> <> I-CAT 1 1>>>

<GLOBAL ATTENTION-TABLE <TABLE 0 0 0 0 0 0 0 0>>

"Offsets into GOAL-TABLEs"

<CONSTANT GOAL-F 0>
<CONSTANT GOAL-S 1>
<CONSTANT GOAL-I 2>
<CONSTANT GOAL-LDIR 3>
<CONSTANT GOAL-ENABLE 4>
<CONSTANT GOAL-PRIORITY 5>
<CONSTANT GOAL-QUEUED 6>
<CONSTANT GOAL-FUNCTION 7>
<CONSTANT ATTENTION-SPAN 8>
<CONSTANT ATTENTION 9>

"Goal-function constants, similar to M-xxx in MAIN"

<CONSTANT G-REACHED 1>
<CONSTANT G-ENROUTE 2>

"Here's how the movement goals are done:  For each player is
a table which consists of triplets, a number of minutes until
the next movement (an clock interrupt number), a number of
minutes allowed variation (for a bit of randomness), and a
room toward which to start. All movement is controlled by
the GOAL-ENABLE flag in the GOAL-TABLE for a character."

"Time starts at 8AM. Characters are at that point in their
starting positions, as reflected in DUNGEON."

<GLOBAL MOVEMENT-GOALS <TABLE
	;"PLAYER"
	<TABLE 0 0 0>
	;"PHONG"
	<TABLE 0
	       50  1 OFFICE-PATH	;"8:50-9 PM"
	       ;"Stiles arr. => Phong to front door, rings bell, then office."
	       70 10 KITCHEN		;"10-12 PM"
	      120 10 BUTLER-ROOM	;"12 PM ON"
	       0>
	;"LINDER"
	<TABLE 0
	       0
	       0>
	;"STILES"
	<TABLE 0 0
	       ;"60 5 OFFICE-PATH		;arrives about 9:00
	       135 20 LIVING-ROOM"
	       0>
	;"MONICA"
	<TABLE 0
	       30  2 OFFICE		;"8:30"
	      ;"5  0 GARAGE		;8:35 to movie: goal set in I-MONICA"
	    ;"145 10 GARAGE		;11:00: ditto"
	      ;"2  1 WORKSHOP		;to fix junction box: I-MONICA-RETURN"
	      161  1 OFFICE	;"? not used!"
	     ;"15  5 TOILET-ROOM	;to vomit: I-MONICA"
	       15  5 MONICA-ROOM	;"to rest"
	       30 10 OFFICE		;"12:00 to hide evidence"
	       60 10 MONICA-ROOM	;"1:00 retires"
	       0>
	;"CAT"
	<TABLE 0 0 0>>>

<GLOBAL TOO-LATE <>>
<ROUTINE FIX-PHONG-MOVEMENT ("AUX" MG ELAPSED OT)
 <SET MG <GET ,MOVEMENT-GOALS ,PHONG-C>>
 <SET ELAPSED <- ,PRESENT-TIME 480>>
 <REPEAT ()
	 <COND (<0? <SET OT <GET .MG ,MG-TIME>>>
		<RTRUE>)>
	 <COND (<G? 1 <SET OT <- .OT .ELAPSED>>>
		<SETG TOO-LATE T>
		<RFALSE>)>
	 <PUT .MG ,MG-TIME .OT>
	 <SET MG <REST .MG ,MG-LENGTH>>>>

<ROUTINE IN-MOTION? (PERSON "AUX" GT)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (<AND <GET .GT ,GOAL-ENABLE>
		     <GET .GT ,GOAL-S>
		     <NOT <==? <LOC .PERSON> <GET .GT ,GOAL-F>>>>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE START-MOVEMENT ()
	 <ENABLE <QUEUE I-MONICA 1>>
	 <ENABLE <QUEUE I-FOLLOW -1>>
	 <ENABLE <QUEUE I-ATTENTION -1>>>

"This routine does the interrupt-driven goal establishment
for the various characters, using the MOVEMENT-GOALS table."

<CONSTANT MG-ROOM 0>
<CONSTANT MG-TIME 1>
<CONSTANT MG-VARIATION 2>
<CONSTANT MG-LENGTH <* 3 2>>
<CONSTANT MG-NEXT 4>

<ROUTINE IMOVEMENT (PERSON INT "AUX" TB VAR DIS TIM ID RM GT)
	 #DECL ((PERSON) OBJECT (TB) <PRIMTYPE VECTOR> (ID VAR DIS TIM) FIX)
	 <SET TB <GET ,MOVEMENT-GOALS <SET ID <GETP .PERSON ,P?CHARACTER>>>>
	 <SET GT <GET ,GOAL-TABLES .ID>>
	 <COND (<NOT <==? 0 <SET RM <GET .TB ,MG-ROOM>>>>
		<COND (<GET .GT ,GOAL-PRIORITY>
		       <PUT .GT ,GOAL-QUEUED .RM>)
		      (T
		       <ESTABLISH-GOAL .PERSON .RM>)>)>
	 <COND (<NOT <==? 0 <SET TIM <GET .TB ,MG-TIME>>>>
		<SET VAR <GET .TB ,MG-VARIATION>>
		<SET DIS <RANDOM <* .VAR 2>>>
	        <QUEUE .INT <+ .TIM <- .DIS .VAR>>>
		<PUT ,MOVEMENT-GOALS .ID <REST .TB ,MG-LENGTH>>
		<COND (<NOT <==? 0 <GET .TB ,MG-NEXT>>>
		       <PUT .TB
			    ,MG-NEXT
			    <+ <GET .TB ,MG-NEXT> <- .VAR .DIS>>>)>)>
	 <RFALSE>>

<ROUTINE I-FOLLOW ("AUX" (FLG <>) (CNT 0) GT VAL)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> ,CHARACTER-MAX>
			<RETURN>)
		       (<AND <GET <SET GT <GET ,GOAL-TABLES .CNT>> ,GOAL-S>
			     <OR <GET .GT ,GOAL-ENABLE>
				 <0? <GET .GT ,ATTENTION>>>>
			<PUT .GT ,GOAL-ENABLE T>
			<COND (<SET VAL
				    <FOLLOW-GOAL <GET ,CHARACTER-TABLE .CNT>>>
			       <COND (<NOT <==? .FLG ,M-FATAL>>
				      <SET FLG .VAL>)>)>)>>
	 .FLG>

<ROUTINE I-ATTENTION ("AUX" (FLG <>) (CNT 0) ATT)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> ,CHARACTER-MAX> <RETURN>)
	       	       (<==? <SET ATT <- <GET ,ATTENTION-TABLE .CNT> 1>> 1>
			<COND (<IN? <GET ,CHARACTER-TABLE .CNT> ,HERE>
			       <COND (<AND <==? .CNT ,MONICA-C>
					   ,MONICA-DASHED-OUT-DOOR>
				      <SETG MONICA-DASHED-OUT-DOOR <>>)
				     (T
				      <TELL D <GET ,CHARACTER-TABLE .CNT>
					      " is acting impatient." CR>)>
			       <SET FLG T>)>)
		       (<==? .ATT 0>
			<PUT <GET ,GOAL-TABLES .CNT> ,GOAL-ENABLE T>)>
		 <PUT ,ATTENTION-TABLE .CNT .ATT>>
	 .FLG>

<ROUTINE GRAB-ATTENTION (PERSON "AUX" (CHR<GETP .PERSON ,P?CHARACTER>) GT ATT)
	 #DECL ((PERSON) OBJECT (ATT) FIX)
	 <SET GT <GET ,GOAL-TABLES .CHR>>
	 <COND (<GET .GT ,GOAL-S>
		<PUT ,ATTENTION-TABLE .CHR <SET ATT<GET .GT ,ATTENTION-SPAN>>>
		<COND (<==? .ATT 0>
		       <PUT .GT ,GOAL-ENABLE T>
		       <RFALSE>)
		      (<GET .GT ,GOAL-ENABLE>
		       <PUT .GT ,GOAL-ENABLE <>>)>)>
	 <SETG QCONTEXT .PERSON>
	 <SETG QCONTEXT-ROOM ,HERE>
	 <RTRUE>>

"Movement etc."

<CONSTANT OUTSIDE-LINE-C 4>
<GLOBAL OUTSIDE-LINE
	<PTABLE	0	FRONT-YARD	P?SOUTH
		P?NORTH	FRONT-PORCH	P?SOUTH
		P?NORTH	DRIVEWAY	P?SOUTH
		P?NORTH	DRIVEWAY-ENTRANCE	P?EAST
		P?WEST	SIDE-YARD	P?EAST
		P?WEST	OFFICE-PATH	P?NORTH
		P?SOUTH	OFFICE-PORCH	P?NORTH
		P?SOUTH	BACK-YARD	P?NORTH
		P?SOUTH	ROCK-GARDEN	0>>

<CONSTANT INSIDE-LINE-C 1>
<GLOBAL INSIDE-LINE
	<PTABLE	0	LINDER-ROOM	P?WEST
		P?EAST	LIVING-ROOM	P?SOUTH
		P?NORTH	HALL-1		P?SOUTH
		P?NORTH	HALL-2		P?SOUTH
		P?NORTH	HALL-3		P?WEST
		P?EAST	ENTRY		0>>

<CONSTANT MONICA-LINE-C 3>
<GLOBAL MONICA-LINE
	<PTABLE	0	BATHROOM	P?SOUTH
		P?NORTH	MONICA-ROOM	0>>

<CONSTANT OFFICE-LINE-C 2>
<GLOBAL OFFICE-LINE
	<PTABLE	0	OFFICE		P?WEST
		P?EAST	HALL-4		P?SOUTH
		P?NORTH	GARAGE		P?EAST
		P?WEST	WORKSHOP	0>>

<ROUTINE UNPRIORITIZE (PERSON "AUX" GT)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <PUT .GT ,GOAL-PRIORITY <>>
	 <COND (<GET .GT ,GOAL-QUEUED>
		<ESTABLISH-GOAL .PERSON <GET .GT ,GOAL-QUEUED>>
		<PUT .GT ,GOAL-QUEUED <>>)>>

<ROUTINE ESTABLISH-GOAL (PERSON GOAL "OPTIONAL" (PRIORITY <>)
			 	     "AUX" (HERE <LOC .PERSON>) HL GL GT)
	 #DECL ((PERSON GOAL HERE) OBJECT (HL GL) FIX
		(PRIORITY) <OR FALSE ATOM>)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (.PRIORITY
		<PUT .GT ,GOAL-ENABLE T>
		<PUT .GT ,GOAL-PRIORITY T>
		<PUT .GT ,GOAL-QUEUED .HERE>)>
	 <COND (<==? <SET HL <GETP .HERE ,P?LINE>>
		     <SET GL <GETP .GOAL ,P?LINE>>>
		<PUT .GT ,GOAL-I <>>)
	       (<==? .HL ,OUTSIDE-LINE-C>
		<PUT .GT ,GOAL-I ,FRONT-PORCH>)
	       (<==? .HL ,OFFICE-LINE-C>
		<PUT .GT ,GOAL-I ,HALL-4>)
	       (<==? .HL ,MONICA-LINE-C>
		<PUT .GT ,GOAL-I ,MONICA-ROOM>)
	       (<==? .GL ,OUTSIDE-LINE-C>
		<PUT .GT ,GOAL-I ,ENTRY>)
	       (<==? .GL ,MONICA-LINE-C>
		<PUT .GT ,GOAL-I ,HALL-2>)
	       (T
		<PUT .GT ,GOAL-I ,HALL-3>)>
	 <PUT .GT
	      ,GOAL-S
	      %<COND (<GASSIGNED? PREDGEN> '<GETP .GOAL ,P?STATION>)
		     (T			  ',<GETP .GOAL ,P?STATION>)>>
	 <PUT .GT ,GOAL-F .GOAL>
	 <LOC .PERSON>>

<ROUTINE FOLLOW-GOAL (PERSON "AUX" (HERE <LOC .PERSON>) LINE LN RM GT GOAL FLG
		      		   (GOAL-FLAG <>) (IGOAL <>) LOC (CNT 1) DIR)
	 #DECL ((PERSON HERE LOC RM) OBJECT (LN CNT) FIX
		(GOAL-FLAG IGOAL) <OR ATOM FALSE>)
	 <SET GT <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>>
	 <COND (<==? .HERE <GET .GT ,GOAL-F>>
		<PUT .GT ,GOAL-S <>>
		<RETURN <>>)
	       (<NOT <GET .GT ,GOAL-ENABLE>> <RFALSE>)>
	 <COND (<NOT <==? .HERE
			  <SET LOC %<COND (<GASSIGNED? PREDGEN>
					    '<GETP .HERE ,P?STATION>)
		      			  (T
					   ',<GETP .HERE ,P?STATION>)>>>>
		<SET FLG <MOVE-PERSON .PERSON .LOC>>
		<RETURN .FLG>)>
	 <COND (<SET GOAL <GET .GT ,GOAL-I>>
		<SET IGOAL T>)
	       (T <SET GOAL <GET .GT ,GOAL-S>>)>
	 <COND (<NOT .GOAL> <RFALSE>)
	       (<==? .HERE .GOAL>
		<COND (.IGOAL
		       <RETURN <TRANSFER .PERSON .GOAL <GET .GT ,GOAL-F>>>)
		      (<NOT <==? .HERE <GET .GT ,GOAL-F>>>
		       <SET FLG <MOVE-PERSON .PERSON <GET .GT ,GOAL-F>>>
		       <PUT .GT ,GOAL-S <>>
		       <RETURN .FLG>)
		      (T
		       <PUT .GT ,GOAL-S <>>
		       <RETURN <>>)>)>
	 <SET LN <GETP .GOAL ,P?LINE>>
	 <SET LINE
	      <COND (<==? .LN ,OUTSIDE-LINE-C> ,OUTSIDE-LINE)
		    (<==? .LN ,INSIDE-LINE-C>  ,INSIDE-LINE)
		    (<==? .LN ,OFFICE-LINE-C>  ,OFFICE-LINE)
		    (<==? .LN ,MONICA-LINE-C>  ,MONICA-LINE)>>
	 <REPEAT ()
		 <COND (<==? <SET RM <GET .LINE .CNT>> .HERE>
		        <COND (.GOAL-FLAG
			       <SET LOC <GET .LINE <- .CNT 3>>>)
			      (T
			       <SET LOC <GET .LINE <+ .CNT 3>>>)>
			<RETURN <MOVE-PERSON .PERSON .LOC>>)
		       (<==? .RM .GOAL>
			<SET GOAL-FLAG T>)>
		 <SET CNT <+ .CNT 3>>>>

<ROUTINE GOAL-REACHED (PERSON)
	 #DECL ((PERSON) OBJECT)
	 <APPLY <GET <GET ,GOAL-TABLES <GETP .PERSON ,P?CHARACTER>>
		     ,GOAL-FUNCTION>
		,G-REACHED>>

<ROUTINE MOVE-PERSON (PERSON WHERE "AUX" DIR GT OL COR PCOR CHR
		      			 (FLG <>) DR (VAL <>)
			(STI <COND (,MET-STILES? "Stiles") (T "someone")>))
	 #DECL ((PERSON WHERE) OBJECT)
	 <SET GT <GET ,GOAL-TABLES <SET CHR <GETP .PERSON ,P?CHARACTER>>>>
	 <SET OL <LOC .PERSON>>
	 <SET DIR <DIR-FROM .OL .WHERE>>
	 <COND (<==? <PTSIZE <SET DR <GETPT .OL .DIR>>> ,DEXIT>
		<SET DR <GETB .DR ,DEXITOBJ>>
		<COND (<NOT <FSET? .DR ,OPENBIT>>
		       <COND (<NOT <FSET? .DR ,LOCKED>> <FSET .DR ,OPENBIT>)>)
		      (T <SET DR <>>)>)
	       (T <SET DR <>>)>
	 <PUT .GT ,GOAL-LDIR .DIR>
	 <COND (<AND <==? .OL ,HERE> <NOT <FSET? .PERSON ,INVISIBLE>>>
		<SET FLG T>
		<THIS-IS-S-HE .PERSON>
		<COND (<AND <==? .PERSON ,STILES> ,DUFFY-WITH-STILES>
		       <SETG SEEN-DUFFY? T>
		       <TELL "Sgt. Duffy">)
		      (<NOT <FSET? .PERSON ,TOUCHBIT>> <TELL "Someone">)
		      (T <TELL D .PERSON>)>
		<COND (<==? .DIR ,P?OUT>
		       <COND (<AND <==? .PERSON ,STILES> ,DUFFY-WITH-STILES>
			      <TELL " leads " .STI " out of the room." CR>)
			     (T <TELL " leaves the room." CR>)>)
		      (<==? .DIR ,P?IN>
		       <COND (<AND .DR <NOT <==? .PERSON ,STILES>>>
			      <TELL " opens the " D .DR " and">)>
		       <COND (<AND <==? .PERSON ,STILES> ,DUFFY-WITH-STILES>
			      <TELL " leads " .STI " into another room">)
			     (T <TELL " goes into another room">)>
		       <COND (<AND .DR
				   <FSET? .DR ,LOCKED>
				   <NOT <==? .PERSON ,STILES>>>
			      ;<FCLEAR .DR ,OPENBIT>
			      <TELL ", locking the door again">)>
		       <TELL "." CR>)
		      (T
		       <COND (<AND .DR <NOT <==? .PERSON ,STILES>>>
			      <TELL " opens the " D .DR " and">)>
		       <COND (<AND <==? .PERSON ,STILES> ,DUFFY-WITH-STILES>
			      <TELL " leads " .STI " off to ">)
			     (T <TELL " heads off to ">)>
		       <DIR-PRINT .DIR>
		       <COND (<AND .DR
				   <FSET? .DR ,LOCKED>
				   <NOT <==? .PERSON ,STILES>>>
			      ;<FCLEAR .DR ,OPENBIT>
			      <TELL ", locking the door again">)>
		       <TELL "." CR>)>)
	       (<AND <==? .WHERE ,HERE> <NOT <FSET? .PERSON ,INVISIBLE>>>
		<SET FLG T>
		<THIS-IS-S-HE .PERSON>
		<COND (<NOT <==? ,HERE <GET .GT ,GOAL-F>>>
		       <COND (<AND <==? .PERSON ,STILES> ,DUFFY-WITH-STILES>
			      <SETG SEEN-DUFFY? T>
			      <TELL "Sgt. Duffy">
			      <TELL " leads " .STI " past you." CR>)
			     (<NOT <FSET? .PERSON ,TOUCHBIT>>
			      <TELL "Someone walks past you." CR>)
			     (T <TELL D .PERSON " walks past you." CR>)>)>)
	       (<AND <SET COR <GETP ,HERE ,P?CORRIDOR>>
		     <NOT <FSET? .PERSON ,INVISIBLE>>>
		<COND (<AND <SET PCOR <GETP .OL ,P?CORRIDOR>>
			    <NOT <==? <BAND .COR .PCOR> 0>>>
		       <SET FLG T>
		       <THIS-IS-S-HE .PERSON>
		       <COND (<NOT <GETP .WHERE ,P?CORRIDOR>>
			      <COND (<AND <==? .PERSON ,STILES>
					  ,DUFFY-WITH-STILES>
				     <SETG SEEN-DUFFY? T>
				     <TELL "Sgt. Duffy">)
				    (<NOT <FSET? .PERSON ,TOUCHBIT>>
				     <TELL "Someone">)
				    (T <TELL D .PERSON>)>
			      <TELL ", off to ">
			      <DIR-PRINT <COR-DIR ,HERE .OL>>
			      <TELL ",">
			      <COND (<AND .DR <NOT <==? .PERSON ,STILES>>>
				     <TELL " opens a door and">)>
			      <COND (<AND <==? .PERSON ,STILES>
					  ,DUFFY-WITH-STILES>
				     <TELL " leads " .STI>)
				    (<OUTSIDE? ,HERE>
				     <TELL " leaves your view">)
				    (T
				     <TELL " ducks into a room">)>
			      <TELL " to ">
			      <DIR-PRINT <DIR-FROM .OL .WHERE>>
			      <COND (<AND .DR
					  <FSET? .DR ,LOCKED>
					  <NOT <==? .PERSON ,STILES>>>
				     ;<FCLEAR .DR ,OPENBIT>
				     <TELL ", locking the door again">)>
			      <TELL "." CR>)
			     (<0? <BAND .COR <GETP .WHERE ,P?CORRIDOR>>>
			      <COND (<AND <==? .PERSON ,STILES>
					  ,DUFFY-WITH-STILES>
				     <SETG SEEN-DUFFY? T>
				     <TELL "Sgt. Duffy, with " .STI" in tow">)
				    (<NOT <FSET? .PERSON ,TOUCHBIT>>
				     <TELL "Someone">)
				    (T <TELL D .PERSON>)>
			      <TELL ", off to ">
			      <DIR-PRINT <COR-DIR ,HERE .OL>>
			      <TELL ", disappears from sight to ">
			      <DIR-PRINT <SET PCOR <DIR-FROM .OL .WHERE>>>
			      <TELL "." CR>)
			     (T
			      <COND (<AND <==? .PERSON ,STILES>
					  ,DUFFY-WITH-STILES>
				     <SETG SEEN-DUFFY? T>
				     <TELL"Sgt. Duffy, with " .STI" in tow,">)
				    (<NOT <FSET? .PERSON ,TOUCHBIT>>
				     <TELL "Someone">)
				    (T <TELL D .PERSON>)>
			      <TELL " is to ">
			      <DIR-PRINT <COR-DIR ,HERE .WHERE>>
			      <TELL ", heading toward ">
			      <DIR-PRINT <DIR-FROM .OL .WHERE>>
			      <TELL "." CR>)>)
		      (<AND <SET PCOR <GETP .WHERE ,P?CORRIDOR>>
			    <NOT <==? <BAND .COR .PCOR> 0>>>
		       <SET FLG T>
		       <THIS-IS-S-HE .PERSON>
		       <TELL "To ">
		       <DIR-PRINT <COR-DIR ,HERE .WHERE>>
		       <COND (<AND <==? .PERSON ,STILES> ,DUFFY-WITH-STILES>
			      <SETG SEEN-DUFFY? T>
			      <TELL " Sgt. Duffy, with " .STI " in tow,">)
			     (<NOT <FSET? .PERSON ,TOUCHBIT>>
			      <TELL " someone">)
			     (T <TELL " " D .PERSON>)>
		       <COND (<OUTSIDE? .WHERE>
			      <TELL " comes into view from ">)
			     (T <TELL " enters the hallway from ">)>
		       <COND (<==? .OL ,LIMBO> <TELL "the south">)
			     (T <DIR-PRINT <DIR-FROM .WHERE .OL>>)>
		       <TELL "." CR>)>)>
	 <WHERE-UPDATE .PERSON .FLG>
	 <MOVE .PERSON .WHERE>
	 <COND (<==? <GET .GT ,GOAL-F> .WHERE>
		<COND (<AND <NOT <SET VAL <GOAL-REACHED .PERSON>>>
			    <==? ,HERE .WHERE>
			    <NOT <FSET? .PERSON ,INVISIBLE>>>
		       <THIS-IS-S-HE .PERSON>
		       <TELL D .PERSON>
		       <COND (<OUTSIDE? ,HERE>
			      <TELL " stops here." CR>)
		             (T <TELL " steps into the room." CR>)>)>)>
	<COND (<EQUAL? .PERSON ,STILES> <I-MEET-DUFFY?>)>
	<COND (,DEBUG
	       <TELL "[" D .PERSON " just went into">
	       <THE? .WHERE>
	       <TELL " " D .WHERE ".]" CR>)>
	 <COND (<==? .VAL ,M-FATAL> .VAL)
	       (T .FLG)>>

<ROUTINE DIR-FROM (HERE THERE "AUX" (P 0) L TBL O)
	 #DECL ((HERE THERE O) OBJECT (P L) FIX)
 <REPEAT ()
	 <COND (<0? <SET P <NEXTP .HERE .P>>>
		<RFALSE>)
	       (<EQUAL? .P ,P?IN ,P?OUT> T)
	       (<NOT <L? .P ,LOW-DIRECTION>>
		<SET TBL <GETPT .HERE .P>>
		<SET L <PTSIZE .TBL>>
		<COND (<AND <EQUAL? .L ,DEXIT ,UEXIT ,CEXIT>
			    <==? <GETB .TBL ,REXIT> .THERE>>
		       <RETURN .P>)>)>>>

<ROUTINE TRANSFER (PERSON IGOAL FGOAL "AUX" V (FLG <>))
	 #DECL ((PERSON IGOAL FGOAL) OBJECT)
 <SET V <COND (<==? .IGOAL ,FRONT-PORCH>
	       ;<FSET ,FRONT-DOOR ,OPENBIT>
	       <MOVE-PERSON .PERSON ,ENTRY>)
	      (<==? .IGOAL ,ENTRY>
	       ;<FSET ,FRONT-DOOR ,OPENBIT>
	       <MOVE-PERSON .PERSON ,FRONT-PORCH>)
	      (<==? .IGOAL ,MONICA-ROOM>
	       <FSET ,MONICA-DOOR ,OPENBIT>
	       <MOVE-PERSON .PERSON ,HALL-2>)
	      (<==? .IGOAL ,HALL-2>
	       <FSET ,MONICA-DOOR ,OPENBIT>
	       <MOVE-PERSON .PERSON ,MONICA-ROOM>)
	      (<==? .IGOAL ,HALL-4>
	       <MOVE-PERSON .PERSON ,HALL-3>)
	      (T
	       <MOVE-PERSON .PERSON ,HALL-4>)>>
 <ESTABLISH-GOAL .PERSON .FGOAL>
 .V>

<ROUTINE WHERE-UPDATE (PERSON "OPTIONAL" (FLG <>) "AUX" WT NC (CNT 0))
	 <SET NC <GETP .PERSON ,P?CHARACTER>>
	 <SET WT <GET ,WHERE-TABLES .NC>>
	 <REPEAT ()
		 <COND (<G? .CNT ,CHARACTER-MAX> <RETURN>)
		       (<==? .CNT .NC>)
		       (<OR <AND <0? .CNT> .FLG>
			    <IN? <GET ,CHARACTER-TABLE .CNT> <LOC .PERSON>>>
			<PUT .WT .CNT ,PRESENT-TIME>
			<PUT <GET ,WHERE-TABLES .CNT> .NC ,PRESENT-TIME>)>
		 <SET CNT <+ .CNT 1>>>>

<GLOBAL WHERE-TABLES
        <TABLE <TABLE 0 0 0 0 0 0>
	       <TABLE 0 0 0 0 0 0>
	       <TABLE 0 0 0 0 0 0>
	       <TABLE 0 0 0 0 0 0>
	       <TABLE 0 0 0 0 0 0>
	       <TABLE 0 0 0 0 0 0>>>

"People functions"

<GLOBAL PHONG-SEEN-CORPSE? <>>
<GLOBAL PHONG-CALLED <>>
<GLOBAL PHONG-OLD-LOC <>>

<ROUTINE I-PHONG-UNCALLED ()
 <COND (<NOT <GET <GET ,GOAL-TABLES ,PHONG-C> ,GOAL-S>>
	<ESTABLISH-GOAL ,PHONG ,PHONG-OLD-LOC>
	<COND (<==? <LOC ,PHONG> ,HERE>
	       <SAID-TO ,PHONG>
	       <TELL "Inscrutably, Phong turns to leave.">
	       <COND (<OR <NOT ,PLAYER-HIDING>
			  <FIND-FLAG ,HERE ,PERSON ,PHONG>>
		      <TELL " \"If you need me again, just ring.\"">)>
	       <CRLF>)>)>>

<ROUTINE I-PHONG ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,PHONG>) MPB)
 <SET MPB ,MONICA-PUSHED-BUTTON>
 <COND (<NOT .GARG> <IMOVEMENT ,PHONG I-PHONG>)
       (<==? .GARG ,G-REACHED>
	<COND (,PHONG-CALLED
	       <SETG PHONG-CALLED <>>
	       <SETG MONICA-PUSHED-BUTTON <>>
	       <ENABLE <QUEUE I-PHONG-UNCALLED 3>>
	       <COND (<==? .L ,HERE>
		      <COND (<AND ,PLAYER-HIDING
				  <NOT <FIND-FLAG ,HERE ,PERSON ,PHONG>>>
			     <TELL
"Suddenly Phong appears and " "looks around to see who pushed the button." CR>
			     <RTRUE>)
			    (T
			     <SAID-TO ,PHONG>
			     <TELL
"Suddenly Phong appears and " "says, \"You rang?\"" CR>
			     <COND (.MPB
				    <TELL
"Monica says, \"Yes, Phong, I was testing a new twist on the household
wiring that I thought of during the film.">
				    <COND (,MONICA-TIED-TO
					   <TELL
" Can't you talk this copper into letting me loose?\" Phong opens his eyes
wide for a moment but says nothing." CR>)
					  (T <TELL "\"" CR>)>)>)>
		      <RTRUE>)>)
	      (<==? .L ,OFFICE>
	       <COND (<OR ,PHONG-SEEN-CORPSE? <FSET? ,CORPSE ,INVISIBLE>>
		      <COND (<==? ,HERE ,OFFICE>
			     <SAID-TO ,PHONG>
			     <TELL
"Suddenly Phong enters the office. \"I believe you called for me,
Detective.\"" CR>)>)
		     (T
		      <SETG PHONG-SEEN-CORPSE? T>
		      <COND (<==? ,HERE ,OFFICE>
			     <TELL
"Suddenly Phong enters the office. When he sees that Linder has cashed
in his chips, he turns away for a minute and bows his head." CR>)>)>)
	      (<==? .L ,OFFICE-PATH>
	       <ENABLE <QUEUE I-STILES-ARRIVE 4>>
	       <MOVE ,OUTSIDE-GUN ,OFFICE-PATH>
	       <FCLEAR ,OUTSIDE-GUN ,INVISIBLE>
	       <FCLEAR ,SIDE-FOOTPRINTS ,INVISIBLE>
	       <ESTABLISH-GOAL ,PHONG ,FRONT-PORCH>)
	      (<==? .L ,FRONT-PORCH>
	       <COND (<EQUAL? ,HERE ,FRONT-PORCH>	;"? Can this happen?"
		      <TELL
"The butler comes up to you, looking agitated." CR>)
		     (T <TELL "You hear the door bell ring." CR>)>
	       <MOVE ,PHONG ,ENTRY>
	       <FCLEAR ,MUDDY-SHOES ,INVISIBLE>
	       <ESTABLISH-GOAL ,PHONG ,OFFICE>)
	      (<==? .L ,ENTRY>
	       <COND (<==? ,HERE ,ENTRY>
		     <TELL "Phong arrives and lets Sergeant Duffy in." CR>)>
	       <ESTABLISH-GOAL ,PHONG ,LIVING-ROOM>
	       <ESTABLISH-GOAL ,STILES ,LIVING-ROOM>)
	      (<==? .L ,LIVING-ROOM>
	       <ESTABLISH-GOAL ,PHONG ,KITCHEN>)
	      (<==? .L ,BUTLER-ROOM>
	       <COND (<AND <EQUAL? <META-LOC ,RECURSIVE-BOOK> ,BUTLER-ROOM>
			   <NOT <IN? ,RECURSIVE-BOOK ,PLAYER>>>
		      ;<FSET ,RECURSIVE-BOOK ,NDESCBIT>
		      <MOVE ,RECURSIVE-BOOK ,PHONG>)>
	       <COND (<IN? ,PLAYER ,BUTLER-ROOM>
		      <TELL
"Suddenly Phong comes in, lies down, and starts reading a book." CR>)>
	       <RTRUE>)>)>>

<GLOBAL MURDER-TIME <>>
<ROUTINE I-STILES ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,STILES>))
 <COND (<NOT .GARG> <IMOVEMENT ,STILES I-STILES>)
       (<==? .GARG ,G-REACHED>
	<COND (<==? .L ,OFFICE-PORCH>
	       <COND (,WELCOMED
		      <COND (<==? ,HERE ,OFFICE>
			     <TELL CR
"Linder looks toward the window and says, \"I don't think Phong has
answered the door bell yet.\" He reaches toward the butler's button
and at the same instant shouts \"Stiles!\" You turn around and dimly see
a figure outside.">
			     <FIRE-SHOT>
			     <TELL
" The figure outside turns and runs before you can see the face. When
you turn back around, you see Linder slumping down in his chair, with a
bloody stain spreading across his silk shirt. He teeters on the edge of
the seat, then falls onto the floor, quite dead." CR>
			     <REMOVE ,LINDER>
			     <SETG QCONTEXT <>>
			     <SETG LINDER-FOLLOWS-YOU <>>
			     <ROB ,LINDER ,CORPSE>
			     <FCLEAR ,CORPSE ,INVISIBLE>
			     <SETG LINDER-FOLLOWS-YOU <>>
			     <DISABLE <INT I-LINDER-IN-OFFICE>>
			     <DISABLE <INT I-PHONG-RETIRES>>
			     <DISABLE <INT I-LINDER-RETIRES>>
			     <ENABLE <QUEUE I-AMBULANCE 150>>
			     <MOVE ,STILES ,LIMBO>
			     <FSET ,STILES ,INVISIBLE>
			     <PUT <GET ,GOAL-TABLES ,STILES-C> ,GOAL-S <>>
			     <FCLEAR ,BACK-FOOTPRINTS ,INVISIBLE>
			     <ENABLE <QUEUE I-DUFFY-ARRIVE 3>>
			     <SETG MURDER-TIME ,PRESENT-TIME>
			     <RFATAL>)>)
		     (T
		      <FCLEAR ,BACK-GATE ,LOCKED>
		      <SETG TOO-LATE T>
		      <ESTABLISH-GOAL ,STILES ,OFFICE-PATH>
		      <ENABLE <QUEUE I-DUFFY-ARRIVE 5>>
		      <COND (<EQUAL? ,HERE ,BACK-YARD ,ROCK-GARDEN>
			     <COND (<FSET? ,STILES ,TOUCHBIT> <TELL "Stiles">)
				   (T <TELL "The visitor">)>
			     <TELL
" comes up to Linder's office entrance. A tall man opens the
office door and steps out. They speak briefly, then the tall man counts out
some money and sends ">
			     <COND (<FSET? ,STILES ,TOUCHBIT> <TELL "Stiles">)
				   (T <TELL "the person">)>
			     <TELL " away." CR>)
			    (<EQUAL? ,HERE ,OFFICE-PORCH>
			     <COND (<FSET? ,STILES ,TOUCHBIT> <TELL "Stiles">)
				   (T <TELL "The visitor">)>
			     <TELL
" pushes you out of the way and"
" knocks on the door of Linder's office. A tall man opens it, speaks to
him briefly, hands him some money, and sends him away." CR>)
			    (<EQUAL? ,HERE ,OFFICE-PATH>
			     <COND (<FSET? ,STILES ,TOUCHBIT> <TELL "Stiles">)
				   (T <TELL "The visitor">)>
			     <TELL
" knocks on the door of Linder's office. A tall man opens it, speaks to
him briefly, hands him some money, and sends him away." CR>)>)>)
	      (<==? .L ,OFFICE-PATH>
	       <REMOVE ,STILES>
	       <PUT <GET ,GOAL-TABLES ,STILES-C> ,GOAL-S <>>
	       <COND (<NOT <0? <BAND <GETP ,HERE ,P?CORRIDOR> 3>>>
		      <COND (<FSET? ,STILES ,TOUCHBIT> <TELL "Stiles">)
			    (T <TELL "The visitor">)>
		      <TELL " disappears out the back gate." CR>)>)
	      (<==? .L ,FRONT-PORCH>
	       <COND (<EQUAL? ,HERE ,FRONT-PORCH>
		      <I-MEET-DUFFY?>)
		     (T <TELL "You hear the door bell ring." CR>)>
	       <ESTABLISH-GOAL ,PHONG ,ENTRY>)
	      (<==? .L ,LIVING-ROOM>
	       <SETG DUFFY-WITH-STILES <>>
	       <COND (<==? ,HERE ,LIVING-ROOM>
		      <COND (,MET-DUFFY?
			     <TELL
"Duffy brings a prisoner into the room and fastens him to the
davenport.">
			     <TELL
" He goes quickly to work, disappearing down the hall." CR>)
			    (T <TELL
"Suddenly " "Duffy brings a prisoner into the room and fastens him to the
davenport." " Then he notices you.">
			     <DUFFY-GREETING>
			     <TELL
"\"" " He goes quickly to work, disappearing down the hall." CR>)>)
		     (<NOT ,MET-DUFFY?>
		      <TELL "Suddenly your assistant, Sgt. Duffy, ">
		      <COND (,SEEN-DUFFY? <TELL "runs up to you.">)
			    (T <TELL "appears from out of nowhere.">)>
		      <DUFFY-GREETING>
		      <TELL
" I've stowed him in the living room. I'll stand by to help you.\"
He scurries off to go about his work." CR>)
		     (<OR <EQUAL? ,HERE ,HALL-1 ,HALL-2>
			  <EQUAL? ,HERE ,HALL-3 ,HALL-4>>
		      <TELL
"Duffy goes quickly to work, disappearing down the hall." CR>)>)>)>>

<ROUTINE ROB (WHAT THIEF "OPTIONAL" (PROB <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHAT>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
			     <OR <NOT .PROB> <PROB .PROB>>>
			<MOVE .X .THIEF>
			;<FSET .X ,TOUCHBIT>
			<SET ROBBED? T>)>
		 <SET X .N>>>

<GLOBAL MONICA-SEEN-CORPSE? <>>
<GLOBAL CLOCK-FIXED <>>
<GLOBAL MONICA-PUSHED-BUTTON <>>

<ROUTINE I-MONICA ("OPTIONAL" (GARG <>) "AUX" (L <LOC ,MONICA>) HR)
 <COND (<NOT .GARG> <IMOVEMENT ,MONICA I-MONICA>)
       (<==? .GARG ,G-REACHED>
	<COND (<AND <==? .L ,OFFICE> <L? ,PRESENT-TIME 540>>
	       <ESTABLISH-GOAL ,MONICA ,GARAGE>
	       <COND (<OR <EQUAL? ,OFFICE ,HERE <LOC ,PLAYER>>
			  <AND <EQUAL? ,HERE ,OFFICE-PORCH>
			       <VERB? LOOK-INSIDE>>>
		      <COND (<EQUAL? ,OFFICE ,HERE <LOC ,PLAYER>>
			     <TELL "Monica">)
			    (<EQUAL? ,HERE ,OFFICE-PORCH>
			     <TELL "A young woman">)>
		      <TELL
" bursts into the office, wearing a felt hat and wool coat, and
struggling to get her driving gloves on. ">
		      <COND (<EQUAL? ,OFFICE ,HERE <LOC ,PLAYER>>
			     <ENABLE <QUEUE I-MONICA-GOES 5>>
			     <THIS-IS-S-HE ,MONICA>
			     <TELL
"She glances icily in your direction and then back to her father. \"I'm
off to the pictures with Terry, Dad. Good-bye.\" She hugs him briefly
but firmly, burying her head in his shoulder. He pushes her away and
says, \"You're leaving now?! I thought you'd be talking to the detective
here. What about the threat on my life?\" He has the hurt look of an
orphan pup. She answers, \"You don't need me here. I need to get away
now and then. I'm not like Mother, you know.\" Tears well up in her eyes
but she brushes them away before they drop. She turns to leave." CR>)
			    (<EQUAL? ,HERE ,OFFICE-PORCH>
			     <TELL
"She glances quickly around the room, then turns to leave." CR>)>)>)
	      (<AND <==? .L ,GARAGE> <L? ,PRESENT-TIME 540>>
	       <UNPRIORITIZE ,MONICA>
	       <SETG FILM-SEEN T>
	       <FSET ,GARAGE-DOOR ,LOCKED>
	       <FCLEAR ,GARAGE-DOOR ,OPENBIT>
	       <MOVE ,MONICA ,LIMBO>
	       <FSET ,MONICA ,INVISIBLE>
	       <PUT <GET ,GOAL-TABLES ,MONICA-C> ,GOAL-S <>>
	       <PUT <GET ,GOAL-TABLES ,MONICA-C> ,GOAL-ENABLE <>>
	       <FSET ,MONICA-CAR ,INVISIBLE>
	       <ENABLE <QUEUE I-MONICA-RETURN
			      <- <- 670 ,PRESENT-TIME> <RANDOM 20>>>>
	       <COND (<OR <EQUAL? ,HERE ,GARAGE ,DRIVEWAY>
			  <EQUAL? ,HERE ,DRIVEWAY-ENTRANCE ,WORKSHOP>>
		      <TELL "Someone">
		      <TELL
" jumps into her car, starts it up, and races out the driveway,
leaving a wake of peastone behind her." CR>)
		     (<==? ,OUTSIDE-LINE-C <GETP ,HERE ,P?LINE>>
		      <TELL
"Without warning, a car roars to life and speeds out of the driveway." CR>)
		     (T <TELL
"Outside somewhere, a car roars to life and speeds away." CR>)>)
	      (<==? .L ,WORKSHOP>
	       <SETG BUTTON-FIXED T>
	       <ESTABLISH-GOAL ,MONICA ,OFFICE>
	       <COND (<EQUAL? ,HERE ,WORKSHOP>
		      <SAID-TO ,MONICA>
		      <THIS-IS-S-HE ,MONICA>
		      <SETG SEEN-MONICA-AT-J-BOX T>
		      <TELL
"Suddenly Monica rushes in, goes to the junction box, and fiddles with
the wires for a minute. Then she turns, sees you, gasps and grabs her
throat. \"My">
		      <COND (<NOT <TANDY?>> <TELL " God">)>
		      <TELL
", you gave me a start!\" Her face is ashen." CR>)>)
	      (<AND <==? .L ,OFFICE> <NOT ,MONICA-SEEN-CORPSE?>>
	       <ESTABLISH-GOAL ,MONICA ,TOILET-ROOM>
	       <COND (<OR ,TOO-LATE <NOT <FSET? ,CORPSE ,INVISIBLE>>>
		      <SETG MONICA-SEEN-CORPSE? T>)>
	       <COND (<EQUAL? ,HERE ,OFFICE ,OFFICE-PORCH>
		      <THIS-IS-S-HE ,MONICA>
		      <COND (<FSET? ,MONICA ,TOUCHBIT> <TELL "Monica">)
			    (T <TELL "Someone">)>
		      <TELL " walks gingerly into the office, ">
		      <COND (<NOT <FSET? ,CORPSE ,INVISIBLE>>
			     <TELL
"opens her eyes wide in horror, and then puts her hand over her mouth
and">)
			    (T <TELL "looks around quickly, and then">)>
		      <TELL " rushes toward the door." CR>)>)
	      (<==? .L ,TOILET-ROOM>
	       <COND (<EQUAL? ,HERE ,TOILET-ROOM>
		      <SAID-TO ,MONICA>
		      <THIS-IS-S-HE ,MONICA>
		      <TELL
"Monica rushes in. \"Stand aside, flatfoot, I'm going to be sick.\" She
leans over the toilet and gives in to an attack of dry heaves." CR>)
		     (<OR <EQUAL? ,HERE ,BATHROOM ,TUB-ROOM>
			  <EQUAL? ,HERE ,LINDER-ROOM ,MONICA-ROOM>>
		      <FCLEAR ,TOILET-DOOR ,OPENBIT>
		      <TELL
"The door to the toilet room slams shut. You hear sounds of dry heaving
inside." CR>)>)
	      (<AND <==? .L ,MONICA-ROOM> <NOT ,CLOCK-FIXED>>
	       <COND (<EQUAL? ,HERE ,MONICA-ROOM>
		      <SAID-TO ,MONICA>
		      <THIS-IS-S-HE ,MONICA>
		      <TELL
"Monica comes in, sits down on her bed, and buries her face in her hands.
\"Leave me alone for a while. I'm really not well.\" She begins to sob." CR>)
		     (<OR <EQUAL? ,HERE ,BATHROOM>
			  <EQUAL? ,HERE ,HALL-1 ,HALL-2 ,HALL-3>>
		      <FCLEAR ,MONICA-DOOR ,OPENBIT>
		      <FCLEAR ,MONICA-BATH-DOOR ,OPENBIT>
		      <FCLEAR ,MONICA-BACK-DOOR ,OPENBIT>
		      <TELL "Monica slams shut her bedroom doors." CR>)>)
	      (<==? .L ,OFFICE>
	       <COND (<AND <EQUAL? ,HERE ,OFFICE> <NOT ,PLAYER-HIDING>>
		      <PUT ,MOVEMENT-GOALS
			   ,MONICA-C
			   <BACK <GET ,MOVEMENT-GOALS ,MONICA-C> ,MG-LENGTH>>
		      <ESTABLISH-GOAL ,MONICA ,MONICA-ROOM>
		      <THIS-IS-S-HE ,MONICA>
		      <TELL
"Monica comes into the office quietly and, seeing you, steps over to the
desk and shuffles some papers. Then she sighs, rubs her eyes, and turns
to leave without saying a word." CR>)
		     (T
		      <MOVE ,INSIDE-GUN ,MONICA>
		      <FSET ,CLOCK ,LOCKED>	;"?"
		      <FCLEAR ,CLOCK ,OPENBIT>
		      <SETG CLOCK-FIXED T>
		      <SETG MONICA-PUSHED-BUTTON T>
		      <SET HR ,HERE>
		      <SETG HERE ,OFFICE>
		      <YOU-RANG>
		      <SETG HERE .HR>
		      <COND (<OR <AND <EQUAL? ,HERE ,OFFICE-PORCH>
				      <VERB? LOOK-INSIDE>>
				 <AND ,PLAYER-HIDING
				      <EQUAL? ,HERE ,OFFICE>>>
			     <FCLEAR ,CLOCK-KEY ,INVISIBLE>
			     <SETG SEEN-MONICA-AT-CLOCK T>
			     <COND (<FSET? ,MONICA ,TOUCHBIT> <TELL "Monica">)
				   (T <TELL "Someone">)>
			     <THIS-IS-S-HE ,MONICA>
			     <TELL
" quietly sticks her head in the door, looks quickly around the
room, and then steps over to the desk. She pushes the butler's button and
seems to listen for the bell. She takes another look around, then
crosses the room to the clock. Looking well rehearsed, she produces a key,
opens the door of the case, takes something out and puts it in the
pocket of her slacks, and then shuts and locks the case." CR>)
			    (T <TELL CR
"You barely hear a bell ring in the distance." CR>)>)>)
	      (<==? .L ,MONICA-ROOM>	;<AND  ,CLOCK-FIXED>
	       <COND (<EQUAL? ,HERE ,ROCK-GARDEN ,BACK-YARD ,OFFICE-PORCH>
		      <TELL "The lights go out in the middle bedroom." CR>)
		     (<EQUAL? ,HERE ,MONICA-ROOM>
		      <THIS-IS-S-HE ,MONICA>
		      <SAID-TO ,MONICA>
		      <TELL
"Monica comes in and sits down at her dressing table. Her eyes are red
from crying. \"Go peddle your cookies somewhere else. I'm going to have
some Ovaltine and go to bed.\"" CR>)
		     (<OR <EQUAL? ,HERE ,BATHROOM>
			  <EQUAL? ,HERE ,HALL-1 ,HALL-2 ,HALL-3>>
		      <FCLEAR ,MONICA-DOOR ,OPENBIT>
		      <FCLEAR ,MONICA-BATH-DOOR ,OPENBIT>
		      <FCLEAR ,MONICA-BACK-DOOR ,OPENBIT>
		     <TELL "Monica slams shut her bedroom doors." CR>)>)>)>>

<GLOBAL MONICA-DASHED-OUT-DOOR <>>
<ROUTINE I-MONICA-GOES ()
 <COND (<IN? ,MONICA ,OFFICE>
	<ESTABLISH-GOAL ,MONICA ,GARAGE T>
	<SETG MONICA-DASHED-OUT-DOOR T>
	<TELL
"Monica looks more nervous. \"I really must go now, or I'll be
late for the film.\" She hugs her father again and dashes out the door."
CR>)>>

<ROUTINE I-MONICA-RETURN ()
 <FCLEAR ,MONICA ,INVISIBLE>
 <MOVE ,MONICA ,GARAGE>
 <MOVE ,STUB ,GARAGE>
 <FCLEAR ,MONICA-CAR ,INVISIBLE>
 <ESTABLISH-GOAL ,MONICA ,WORKSHOP>
 <PUT <GET ,GOAL-TABLES ,MONICA-C> ,GOAL-ENABLE T>
 <COND (<EQUAL? ,HERE ,GARAGE ,DRIVEWAY ,DRIVEWAY-ENTRANCE>
	<COND (<FSET? ,MONICA ,TOUCHBIT> <TELL "Monica">)
	      (T <TELL "Someone">)>
	<TELL
" drives into the garage, stops her car, jumps out, and slams the door." CR>)
       (T <TELL
"Suddenly you hear a car drive into the garage and stop. Its door
slams." CR>)>>

<GLOBAL DUFFY-AT-CORONER <>>

<ROUTINE I-AMBULANCE ()
	<REMOVE ,CORPSE>
	<COND (,PLAYER-HIDING
	       <TELL
"Out of the blue, " "two" " of the coroner's men run"
" in to the office with a stretcher and carry Linder's body out.">)
	      (T
	       <COND (<EQUAL? ,HERE ,OFFICE ,OFFICE-PORCH ,OFFICE-PATH>
		      <TELL
"Out of the blue, " "two" " of the coroner's men run"
" in to the office with a stretcher and carry Linder's body out. "
"One of them shouts to you, \"">)
		     (T <TELL
"Out of the blue, " "one" " of the coroner's men run"
"s up to you and says, \"We just removed the body. ">)>
	       <TELL
"Haven't time to chat. Busy night at the morgue! Carry on, Detective.\"">)>
	<COND (<AND <NOT ,FINGERPRINT-OBJ> <NOT ,DUFFY-AT-CORONER>>
	       <SETG DUFFY-AT-CORONER T>
	       <ENABLE <QUEUE I-DUFFY-RETURNS 69>>
	       <TELL
" Then Duffy appears, saying, \"I'm glad they finally showed up! When I
called, they seemed very busy. I think I should go along and make sure
they give this autopsy top priority.">
	       <COND (,PLAYER-HIDING
		      <TELL
" Don't worry, I won't tell anyone you're hiding.">)>
	       <TELL " See you later!\"">)>
	<TELL " They head for the street." CR>>

<ROUTINE I-DUFFY-RETURNS ()
	<SETG DUFFY-AT-CORONER <>>
	<TELL
"Without warning, Duffy comes running up to you and says, \"I just got
back from the morgue. The coroner ">
	<COND (,DUFFY-SAW-MEDICAL-REPORT
	       <COND (<==? <META-LOC ,MONICA> ,HERE>
		      <SETG MONICA-SAW-CORONER-REPORT T>)>
	       <TELL
"found no evidence of the alleged stomach tumor. In fact, he
could find no organic disease that would either explain the
death or support the theory that Linder wanted to die. He ">)>
	<TELL
"concluded that Linder died of a single small-caliber bullet through the
heart. And here's something peculiar: there were no
traceable rifle marks on the bullet." "\"" CR>>

"Evidence: hints and conclusions"

<GLOBAL DUFFY-HINT-NUM 0>
<GLOBAL NO-WIRE-HINT T>
<ROUTINE DUFFY-HINT ()
	<COND (<NOT ,MET-DUFFY?>
	       <TELL "You'd better wait until Duffy " "sees you." CR>
	       <RTRUE>)
	      (,DUFFY-WITH-STILES
	       <TELL "You'd better wait until Duffy "
		       "stows his prisoner." CR>
	       <RTRUE>)>
	<TELL "Duffy appears and says, ">
	<COND (<FSET? ,CORPSE ,INVISIBLE>
	       <TELL
"\"If I were you, I'd wait until some crime occurred.\"" CR>
	       <RTRUE>)>
	<SETG DUFFY-HINT-NUM <+ 1 ,DUFFY-HINT-NUM>>
	<TELL
"\"I don't know if it means anything, Detective, but I noticed ">
	<COND (<NOT <FSET? ,PIECE-OF-WIRE ,TOUCHBIT>>
	       <TELL
"a piece of green wire on the broken office window.\"" CR>)
	      (,NO-WIRE-HINT
	       <SETG NO-WIRE-HINT <>>
	       <TELL "a green spool in the workshop.\"" CR>)
	      ;(<FSET? ,HOLE ,INVISIBLE>
	       <TELL "a hole of some kind in Linder's office chair.\"" CR>)
	      (<AND <NOT ,BUTTON-FIXED> <NOT ,PLAYER-PUSHED-BUTTON>>
	       <TELL
"that the butler's button in the office wasn't working right.\"" CR>)
	      (<NOT ,POWDER-ANALYZED>
	       <TELL "something funny about the clock in the office.\"" CR>)
	      (<NOT <FSET? ,GUN-RECEIPT ,TOUCHBIT>>
	       <TELL "a very interesting book in Phong's room.\"" CR>)
	      (<NOT <FSET? ,MEDICAL-REPORT ,TOUCHBIT>>
	       <TELL "some kind of medical report in Monica's room.\"" CR>)
	      (<NOT ,MONICA-HAS-MOTIVE>
	       <TELL
"Monica's reaction when I asked her about her mother.\"" CR>)
	      ;(<NOT ,SIDE-FOOTPRINTS-MATCHED>
	       <TELL
"lots of foot prints in the mud outside. Of course, I was careful not to
confuse them with my own.\"" CR>)
	      (<NOT ,SEEN-MONICA-AT-J-BOX>
	       <TELL
"that Monica went in the workshop right when she got home.\"" CR>)
	      (T <TELL "that I've run out of ideas on this case.\"" CR>)>>

<GLOBAL WIRE-MATCHED <>>
<GLOBAL POWDER-ANALYZED <>>
<GLOBAL SIDE-FOOTPRINTS-MATCHED <>>
<GLOBAL BACK-FOOTPRINTS-MATCHED <>>
<GLOBAL SEEN-MONICA-AT-CLOCK <>>
<GLOBAL SEEN-MONICA-AT-J-BOX <>>
<GLOBAL USED-CLOCK-KEY <>>
"Other clues: INSIDE-GUN, GUN-RECEIPT, OFFICE-BUTTON, BROKEN-GLASS,
HOLE, and MEDICAL-REPORT."

<ROUTINE ARREST (PERSON "OPTIONAL" (HELPER <>) "AUX" FLG)
 <COND (.HELPER
	<COND (<AND <OR <NOT <EQUAL? .PERSON ,MONICA>>
			<NOT <EQUAL? .HELPER ,PHONG>>>
		    <OR <NOT <EQUAL? .HELPER ,MONICA>>
			<NOT <EQUAL? .PERSON ,PHONG>>>>
	       <TELL
"You think it over. You realize that this arrest is pretty far-fetched.
It could only mean humiliation for you." CR>
	       <RTRUE>)
	      (T <SET PERSON ,MONICA> <SET HELPER ,PHONG>)>)>
 <COND (<AND <==? .PERSON ,MONICA> <IN? ,MONICA ,LIMBO>>
	<TELL "Duffy appears with a solemn look.">
	<TELL
" He says, \"I can't find Monica around here anywhere. I guess you'll
have to wait for her to return.\" He disappears again." CR>
	<RTRUE>)>
 <TELL
"(If you want to continue from this point at another time, you must
\"SUSPEND\" first.) Do you want to "
"make an arrest and " "stop your investigation now?">
 <COND (<NOT <YES?>> <RTRUE>)>
 ;<COND (<NOT ,PRSI> <SETG PRSI ,GLOBAL-MURDER>)>
 <COND (<==? .PERSON ,GLOBAL-LINDER ,CORPSE>
	<TELL
"Duffy appears, to escort you from the grounds. "
"\"So you believe that Linder's death was suicide? I'm not convinced.
But if you'll "
"file a deposition, we can see what the D.A. and coroner think.\"|" CR>)
       (T
	<COND (.HELPER
	       <COND (<AND <EQUAL? ,HERE <META-LOC ,MONICA>>
			   <IN? .HELPER ,HERE>>
		      <TELL "Duffy appears with a solemn look.">
		      <COND (,MONICA-TIED-TO
			     <TELL " He unfastens Monica from the "
				     D ,MONICA-TIED-TO ".">)>
		      <TELL
" He puts nippers on the wrists of both " D .PERSON " and " D .HELPER
", who stand stiff and quiet.">)
		     (<EQUAL? ,HERE <META-LOC ,MONICA>>
		      <TELL "Duffy appears with " D .HELPER " in tow.">
		      <COND (,MONICA-TIED-TO
			     <TELL " He unfastens Monica from the "
				     D ,MONICA-TIED-TO ".">)>
		      <TELL
" He puts nippers on the wrists of " D .PERSON
", who stands stiff and quiet.">)
		     (<IN? .HELPER ,HERE>
		      <TELL "Duffy appears with " D .PERSON " in tow.">
		      <TELL
" He puts nippers on the wrists of " D .HELPER
", who stands stiff and quiet.">)
		     (T <TELL
"Duffy seems to read your thoughts, as he appears with " D .PERSON " and "
D .HELPER " in handcuffs.">)>)
	      (<EQUAL? ,HERE <META-LOC .PERSON>>
	       <TELL "Duffy appears with a solemn look.">
	       <COND (<==? .PERSON ,STILES>
		      <TELL
" He unfastens his nippers from the davenport and pulls Stiles to his feet.">)
		     (<AND <==? .PERSON ,MONICA> ,MONICA-TIED-TO>
		      <TELL
" He unfastens Monica from the " D ,MONICA-TIED-TO
", pulls her to her feet, and puts his own nippers on her wrists.">)
		     (T <TELL
" He puts nippers on the wrists of " D .PERSON
", who stands stiff and quiet.">)>)
	      (T <TELL
"Duffy seems to read your thoughts, as he appears with " D .PERSON
" in handcuffs.">)>
	<COND (<AND ,MONICA-TIED-TO <EQUAL? .PERSON ,MONICA>>
	       <RELEASE-MONICA>)>
	<TELL
" \"Let's not have any trouble, now,\" says Duffy, in his unique way.
They head for the driveway, where a police car waits with engine
purring.|" CR>)>
 <END-HEADER "February 28">
 <COND (<OR ,MONICA-ADMITTED-HELPING?	;"mechanism proved"
	    ,PHONG-ADMITTED-HELPING?
	    <AND ,PLAYER-PUSHED-BUTTON
		 <OR ,POWDER-ANALYZED <FSET? ,INSIDE-GUN ,TOUCHBIT>>>>
	<TELL
"The elaborate set-up in Mr. Linder's office was ingenious.
You deserve congratulations for your work in detecting it.|" CR>
	<COND (<==? .PERSON ,STILES>
	       <TELL
"I am sorry to report that the trial jury acquitted Ralph Stiles of the
murder of his rival, Freeman Linder. In view of the available evidence,
they apparently believed that his lack of access to the Linder house
made it doubtful that he could construct the hidden gun mechanism.">)
	      (<==? .PERSON ,GLOBAL-LINDER>
	       <COND (<FSET? ,MEDICAL-REPORT ,TOUCHBIT>
		      <TELL
"At the inquest, the coroner ruled that " "Mr. Linder's death was suicide,
based on all the available evidence. However, my knowledge of Linder's
personality makes me doubt that, knowing he would be killed, he would
devise such an elaborate scheme to try to punish Mr. Stiles for the
affair with Mrs. Linder. ">)
		     (T
		      <TELL
"At the inquest, the coroner ruled that " "the available evidence was
inconclusive, in that Linder appears to have had no motive for suicide. ">)>
	       <TELL
"I think that, if you had been more careful in observing the people in
Linder's household, you would have discovered that he had an accomplice,
at least.|">)
	      (<AND .HELPER
		    <FSET? ,GUN-RECEIPT ,TOUCHBIT>
		    ,MONICA-HAS-MOTIVE
		    <OR ,SEEN-MONICA-AT-CLOCK ,USED-CLOCK-KEY>>
	       <TELL
"The web of evidence certainly seems to implicate both Monica Linder
and Mr. Phong. During interrogation, Phong admitted helping Mr. Linder
carry out the plan to frame Mr. Stiles for attempted murder, but he
repeatedly denied that Linder's death was intended. He bargained with
the District Attorney and entered a plea of guilty to charges of
conspiracy and extortion. After a short trial, the judge gave him a
suspended sentence and recommended him for deportation to his home
country.|" CR
"Monica turned out to be a tougher nut to crack. She refused to talk
during interrogation, and she was awaiting trial when she heard about
Phong's suspended sentence. She then made a plea like his, and the
judge had little choice but to give her the same sentence. Instead of
deportation, she will be on probation for five years.|" CR
"I can't help thinking that everyone in the Linder household conspired
in the original plan, but that Monica acted alone in turning the plan
into murder. I suppose we'll never know the real truth now.">)
	      (<EQUAL? ,PHONG .PERSON .HELPER>
	       <TELL
"I am sorry to report that the trial jury acquitted Mr. Phong of
the murder of his employer. Apparently they believed that ">
	       <COND (<NOT <FSET? ,GUN-RECEIPT ,TOUCHBIT>>
		      <TELL
"the available evidence against him was circumstantial, since there was
no definite link between him and the murder weapon. In addition, it
seems that ">)>
	       <TELL
"he lacks the mechanical skills necessary to construct the hidden gun
mechanism.|" CR>
	       <COND (.HELPER
		      <TELL
"While Monica could have conspired with him and aided him, she too was
acquitted of conspiracy, because ">
		      <COND (<NOT <FSET? ,GUN-RECEIPT ,TOUCHBIT>>
			     <TELL
"he was. If only we had tried her for plain murder instead of conspiracy!|"
CR>)
			    (,MONICA-HAS-MOTIVE
			     <TELL "the available
evidence against her was circumstantial, since there was no definite
link between her and the hidden gun mechanism.|" CR>)
			    (<OR ,SEEN-MONICA-AT-CLOCK ,USED-CLOCK-KEY>
			     <TELL "she had no
apparent motive.|" CR>)>)>)
	      (<==? .PERSON ,MONICA>
	       <COND (,MONICA-HAS-MOTIVE
		      <COND (<OR ,SEEN-MONICA-AT-CLOCK ,USED-CLOCK-KEY>
			     <TELL
"I am glad to report that the trial jury, based on your testimony and her
confession in court,
convicted Monica Linder of the murder of her father in revenge for the
death of her mother. Congratulations "
			     <COND (<0? ,DUFFY-HINT-NUM>
				    "on your fine detective work.|")
				   (<G? 3 ,DUFFY-HINT-NUM>
		"on the fine teamwork between you and Sergeant Duffy.|")
				   (T
	"to you, but even more to Detective Duffy on his promotion.|")>
			     CR
"Which reminds me of another fascinating case I would like to assign you to...|
|
Coming soon: Another INTERLOGIC Mystery from Infocom.|">
			     <EPILOGUE>)
			    (T
			     <TELL
"I am sorry to report that the trial jury acquitted Monica Linder of
the murder of her father. Apparently they believed that " "the available
evidence against her was circumstantial, since there was no definite
link between her and the hidden gun mechanism.|" CR>)>)
		     (T <TELL
"I am sorry to report that the trial jury
acquitted Monica Linder of the murder of her father, because " "she had no
apparent motive.|" CR>)>)>)
       (T	;"no proof of mechanism"
	<COND (<==? .PERSON ,GLOBAL-LINDER>
	       <TELL
"According to your report and deposition and the available physical
evidence, you seem to believe that Mr. Linder shot himself through the
window of his office. If you continue to come up with such odd
conclusions, I will be forced to transfer you to the traffic-control
department.|" CR>
	       <CASE-OVER>)>
	<TELL
"According to your report and deposition, the only question in this case
is who shot Mr. Linder through the window of his office. However, I
believe that the real story is not so simple.|" CR>
	<COND (<NOT <==? .PERSON ,STILES>>
	       <TELL
"In fact, in view of the flimsy evidence available, the District
Attorney has decided not to indict " D .PERSON>
	       <COND (.HELPER <TELL " and " D .HELPER>)>
	       <TELL " in this case.">)>
	<COND (<==? .PERSON ,STILES>
	       <SETG STILES-CONVICTED T>
	       <TELL
"But, despite my reservations, the trial jury did convict Mr. Stiles
of the murder. Through plea-bargaining, his sentence was reduced from
execution to twenty years.">)
	      (<AND <==? .PERSON ,MONICA>
		    <OR ,SEEN-MONICA-AT-J-BOX .HELPER>>
	       <COND (.HELPER
		      <SET FLG T>	;"T = nothing TELLed for Phong"
		      <COND (,SIDE-FOOTPRINTS-MATCHED
			     <SET FLG <>>
			     <TELL
" In his opinion, Phong's foot prints outside are not incriminating,
even though they were apparently made at the time of the shooting. After
all, Phong's household duties could easily have taken him there for any
number of reasons. In Phong's own deposition, he claimed to have heard
noises outside, which could have been made by Mr. Stiles.">)>
		      <COND (,SEEN-MONICA-AT-J-BOX
			     <COND (.FLG
				    <TELL
" There is no evidence that " "Phong" " was at the scene of the shooting.">)>
			     <TELL
" Monica's actions in the workshop may be suspicious, but she claimed that
she thought of a new twist on the household wiring during the film, and she
seems to be enough of a tinkerer to make that believable.">)
			    (.FLG
			     <TELL
" There is no evidence that " "either one"
" was at the scene of the shooting.">)
			    (T <TELL
" There is no evidence that " "Monica"
" was at the scene of the shooting.">)>)
		     (,SEEN-MONICA-AT-J-BOX
		       <TELL
" Monica's actions in the workshop may be suspicious, but she claimed that
she thought of a new twist on the household wiring during the film, and she
seems to be enough of a tinkerer to make that believable.">)>)
	      (<AND <EQUAL? .PERSON ,PHONG> ,SIDE-FOOTPRINTS-MATCHED>
	       <TELL
" In his opinion, Phong's foot prints outside are not incriminating,
even though they were apparently made at the time of the shooting. After
all, Phong's household duties could easily have taken him there for any
number of reasons. In Phong's own deposition, he claimed to have heard
noises outside, which could have been made by Mr. Stiles.">)
	      (T
	       <TELL " There is no evidence that ">
	       <COND (<EQUAL? .PERSON ,MONICA> <TELL "s">)>
	       <TELL "he" " was at the scene of the shooting.">)>)>
 <CASE-OVER>>

<GLOBAL STILES-CONVICTED <>>

<ROUTINE END-HEADER (STR)
	 <TELL "Text of a letter from Police Chief Klutz dated ">
	 <TELL .STR>
	 <TELL ":|
|
Dear Detective:|
|     ">>

<ROUTINE CASE-OVER ()
	 <COND (,STILES-CONVICTED
		<TELL
"|
|
Post script: A few months later, after you are transferred to another
department, you get a memo from your former boss. It says that new
evidence was discovered in the Linder case, causing the court to
reverse Stiles's conviction and set him free. Let's hope he doesn't
come around bent on revenge!" CR>)>
	 <TELL
"|
|
The case has come to an end. Would you like to start your
investigation over from scratch?">
	 <COND (<YES?> <RESTART>)>
	 <QUIT>>

<ROUTINE EPILOGUE ()
	 <TELL
"|
You have reached a complete solution to the story. If you
like, you may see the author's summary of the case. Of course,
you should come up with your own first! Would you like to see
the author's summary?">
	 <COND (<YES?>
		<TELL
"|
Freeman Linder discovered about a year ago that his wife had taken a
lover, Ralph Stiles. This discovery made their marriage deteriorate,
with growing bitterness and belligerence, until Mrs. Linder recently
took her own life with a gun. Linder planned to take revenge on Stiles
by framing him for attempted murder. He enlisted the help of his butler,
Phong, and his daughter, Monica.|
" CR
"Linder simultaneously sent two messages, a telegram to you and a phone
call to Stiles. He wanted you to come to the house, witness the alleged
crime, and then arrest Stiles. In the phone call he told Stiles to come
discreetly to the office door at 9:00 to get some pay-off money.|
" CR
"Linder planned an elaborate set-up inside the office. A gun was put in
the clock, aiming through the keyhole toward him, who would be sitting
behind his desk on the opposite side of the room. Using the butler's
button, he would trigger both the gun and the detonation of some
explosive attached to the window, thus simulating a shot fired through
the window at him.|
" CR
"Monica bought two identical small handguns for this plan. She hid one in
the clock, and Phong planted the other, which was fired in secret
beforehand, in the back yard just before 9:00, where you could find it
later.|
" CR
"When Stiles's car appeared, Phong went to the front door, rang the door
bell as a signal to Linder, and sneaked into the house. Linder kept an
eye on the window and, when Stiles appeared, pushed the button to fire
the shot. Stiles panicked and fled out the back of the yard but was
brought back inside by Sgt. Duffy.|
" CR
"The plot thickened, however, because Monica decided to take this
opportunity to murder her father. Her mother and she were very close.
Mr. Linder was often away on business during Monica's childhood, and
Mrs. Linder imbued her daughter with a love/hatred for him, saying that
he abandoned them. Monica helped her father construct the
remote-controlled gun, but she also blamed him for her mother's death
and had lost all love for him. She therefore aimed the gun to kill her
father when fired. Her idea was to convict Stiles of the murder and go
free herself.|
" CR
"Phong had no idea of Monica's plan until he saw Linder's corpse. He did
not spill the beans on Linder's plan, since he also had reason to want
Linder removed from the scene. Monica, as a last resort, may have attempted to
convince you that her father was dying of a stomach tumor and had
planned his own death. But Monica is the only one who could have twisted
Linder's plan into murder: the key to the clock was hidden on her
person, so she had final control of the gun's aim.|
">)>
	 <QUIT>>

<ROUTINE TOO-LATE-F ()
	<TELL
"|
A few days pass, and you don't hear from Linder.
But a small item in the newspaper catches your eye: a grifter named
Stiles was found dead on the beach one morning, with a cheap
handgun lying near and a single small bullet wound through his heart.
Does this death have anything to do with Linder and your visit?
Well, no need to lose sleep over it. Everyone sleeps the big sleep
sooner or later.|">>
