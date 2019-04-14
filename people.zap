

	.FUNCT	YOU-F
	EQUAL?	PRSA,V?ASK-ABOUT \?ELS5
	EQUAL?	PRSI,YOU \?ELS5
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?TELL-ME \FALSE
	EQUAL?	PRSI,YOU \FALSE
	CALL	PERFORM,V?TELL-ME,PRSO,WINNER
	RTRUE	


	.FUNCT	OBJECT-PAIR-F,P1,P2,?TMP1
	GET	P-PRSO,P-MATCHLEN
	LESS?	2,STACK \?ELS5
	EQUAL?	PRSA,V?ARREST \?ELS8
	PRINTR	"You think it over. You realize that this arrest is pretty far-fetched. It could only mean humiliation for you."
?ELS8:	EQUAL?	PRSA,V?COMPARE \TRUE
	PRINTR	"That's too many things to compare all at once!"
?ELS5:	EQUAL?	PRSA,V?ARREST \?ELS16
	FSET?	CORPSE,INVISIBLE /?ELS16
	GET	P-PRSO,1 >P1
	IN?	P1,GLOBAL-OBJECTS \?CND19
	GETP	P1,P?CHARACTER
	GET	CHARACTER-TABLE,STACK >P1
?CND19:	GET	P-PRSO,2 >P2
	IN?	P2,GLOBAL-OBJECTS \?CND22
	GETP	P2,P?CHARACTER
	GET	CHARACTER-TABLE,STACK >P2
?CND22:	CALL	ARREST,P1,P2
	RSTACK	
?ELS16:	EQUAL?	PRSA,V?COMPARE \FALSE
	GET	P-PRSO,1 >?TMP1
	GET	P-PRSO,2
	CALL	PERFORM,PRSA,?TMP1,STACK
	RTRUE	


	.FUNCT	PLAYER-F
	EQUAL?	PRSA,V?SHOOT \?ELS5
	EQUAL?	PRSO,PLAYER \?ELS5
	PRINTR	"What, and let down the Police Department track-and-field team?!"
?ELS5:	ZERO?	PLAYER-HIDING \?ELS11
	LOC	PLAYER
	IN?	STACK,ROOMS /FALSE
?ELS11:	ZERO?	PRSO /FALSE
	EQUAL?	PRSA,V?WALK \?ELS17
	CALL	TOO-BAD-SIT-HIDE
	RSTACK	
?ELS17:	ZERO?	PLAYER-HIDING /?ELS19
	EQUAL?	PRSA,V?ASK-FOR,V?ASK-ABOUT,V?GOODBYE /?THN22
	EQUAL?	PRSA,V?HELLO,V?TELL,V?$CALL \?ELS19
?THN22:	CALL	TOO-BAD-SIT-HIDE
	RSTACK	
?ELS19:	CALL	STANDING-VERB?
	ZERO?	STACK /FALSE
	IN?	PRSO,WINNER /?ELS27
	EQUAL?	PRSA,V?EXAMINE \?ELS32
	EQUAL?	P-ADVERB,W?CAREFULLY /?ELS32
	EQUAL?	PRSO,CLOCK /?THN35
	LOC	PRSO
	EQUAL?	OFFICE,STACK \?ELS32
?THN35:	PRINTI	"You'd do a much better job if you stood up, but let's see..."
	CRLF	
	RFALSE	
?ELS32:	IN?	PLAYER,CARVED-CHAIR \?ELS40
	EQUAL?	PRSA,V?RING,V?PUSH,V?FIND \?ELS40
	EQUAL?	PRSO,OFFICE-BUTTON,BUTTON /FALSE
?ELS40:	EQUAL?	PRSA,V?TAKE \?ELS44
	EQUAL?	PRSO,HINT /FALSE
?ELS44:	CALL	TOO-BAD-SIT-HIDE
	RSTACK	
?ELS27:	ZERO?	PRSI /FALSE
	IN?	PRSI,WINNER /FALSE
	CALL	TOO-BAD-SIT-HIDE
	RSTACK	


	.FUNCT	STANDING-VERB?
	EQUAL?	PRSA,V?WALK-TO /TRUE
	EQUAL?	PRSA,V?WALK-AROUND,V?WALK,V?USE /TRUE
	EQUAL?	PRSA,V?UNTIE,V?UNLOCK,V?TIE-WITH /TRUE
	EQUAL?	PRSA,V?TIE-TO,V?THROUGH,V?TAKEOUT /TRUE
	EQUAL?	PRSA,V?TAKE,V?SMELL,V?SLAP /TRUE
	EQUAL?	PRSA,V?SIT,V?SEARCH-OBJECT-FOR,V?SEARCH /TRUE
	EQUAL?	PRSA,V?RUB-OVER,V?RUB,V?RING /TRUE
	EQUAL?	PRSA,V?REVIVE,V?READ,V?RAPE /TRUE
	EQUAL?	PRSA,V?RAISE,V?PUT-UNDER,V?PUT /TRUE
	EQUAL?	PRSA,V?PUSH,V?PICK,V?PHONE /TRUE
	EQUAL?	PRSA,V?OPEN,V?MUNG,V?MOVE /TRUE
	EQUAL?	PRSA,V?MAKE,V?LOOK-UNDER,V?LOOK-OUTSIDE /TRUE
	EQUAL?	PRSA,V?LOOK-INSIDE,V?LOOK-BEHIND,V?LOCK /TRUE
	EQUAL?	PRSA,V?KNOCK,V?KISS,V?KILL /TRUE
	EQUAL?	PRSA,V?KICK,V?HIDE-BEHIND,V?HANDCUFF /TRUE
	EQUAL?	PRSA,V?FOLLOW,V?FINGERPRINT,V?EXAMINE /TRUE
	EQUAL?	PRSA,V?ENTER,V?EAT,V?DRINK /TRUE
	EQUAL?	PRSA,V?CLOSE,V?BRUSH,V?ATTACK \FALSE
	RTRUE


	.FUNCT	TOO-BAD-SIT-HIDE
	SET	'P-CONT,FALSE-VALUE
	LOC	PLAYER
	IN?	STACK,ROOMS /?ELS5
	EQUAL?	PRSA,V?SIT \?ELS10
	PRINTR	"You're already sitting down."
?ELS10:	PRINTR	"You'd do a much better job if you stood up."
?ELS5:	ZERO?	PLAYER-HIDING /FALSE
	EQUAL?	PRSA,V?HIDE-BEHIND \?ELS24
	PRINTR	"You're already hiding."
?ELS24:	PRINTR	"You can't do that while you're hiding."


	.FUNCT	PHONG-F,ARG=0,OBJ,L
	LOC	PHONG >L
	EQUAL?	ARG,M-OBJDESC \?ELS5
	CALL	IN-MOTION?,PHONG
	ZERO?	STACK \TRUE
	FSET?	PHONG,TOUCHBIT \?ELS10
	FSET?	LINDER,TOUCHBIT /?ELS13
	LOC	LINDER
	EQUAL?	HERE,STACK \?ELS13
	CRLF	
	PRINTI	"""Excuse me, sir,"" says Phong, ""but the detective has arrived."""
	CRLF	
	CRLF	
	RTRUE	
?ELS13:	EQUAL?	L,BUTLER-ROOM \?ELS19
	PRINTI	"Phong is lying on the bed, "
	IN?	RECURSIVE-BOOK,PHONG \?ELS24
	PRINTR	"reading a book."
?ELS24:	PRINTR	"meditating."
?ELS19:	EQUAL?	L,KITCHEN \?ELS32
	LESS?	PRESENT-TIME,710 \?ELS32
	PRINTI	"Phong is here, "
	SUB	PRESENT-TIME,480
	DIV	STACK,60
	ADD	1,STACK
	GET	KITCHEN-ACTIVITIES,STACK
	PRINT	STACK
	PRINTR	"."
?ELS32:	EQUAL?	L,OFFICE \?ELS38
	IN?	CORPSE,OFFICE \?ELS38
	ZERO?	PHONG-SEEN-CORPSE? /?ELS38
	PRINTR	"Phong is gazing out the window."
?ELS38:	EQUAL?	L,ENTRY \?ELS44
	PRINTR	"Phong is waiting for you to do something."
?ELS44:	PRINTI	"Phong is here, "
	CALL	PICK-ONE,PHONG-HERE
	PRINT	STACK
	PRINTR	"."
?ELS10:	FSET	PHONG,TOUCHBIT
	GETP	PHONG,P?TEXT
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	WINNER,PHONG \?ELS56
	EQUAL?	PRSA,V?FIND \?ELS61
	EQUAL?	PRSO,PHONG-KEYS \?ELS61
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,PHONG,PRSO
	RTRUE	
?ELS61:	EQUAL?	PRSA,V?THANKS,V?FIND /FALSE
	EQUAL?	PRSA,V?SLAP \?ELS67
	PRINTR	"""No, I must be careful about that."""
?ELS67:	EQUAL?	PRSA,V?GIVE \?THN76
	EQUAL?	PRSO,OUTSIDE-GUN /?THN76
	EQUAL?	PRSO,GENERIC-GUN,GENERIC-KEY,PHONG-KEYS /?THN80
?THN76:	EQUAL?	PRSA,V?SGIVE \?ELS71
	EQUAL?	PRSI,OUTSIDE-GUN /?THN80
	EQUAL?	PRSI,GENERIC-GUN,GENERIC-KEY,PHONG-KEYS \?ELS71
?THN80:	CALL	TAKE-PHONG-KEYS
	RSTACK	
?ELS71:	EQUAL?	PRSA,V?UNLOCK /?THN84
	EQUAL?	PRSA,V?LOCK,V?CLOSE,V?OPEN \?ELS83
?THN84:	FSET?	CORPSE,INVISIBLE \?ELS90
	PRINTR	"""You'll have to ask Mr. Linder about that."""
?ELS90:	EQUAL?	PRSO,CLOCK \?ELS94
	PRINTR	"""I don't have the key for the clock."""
?ELS94:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \?ELS98
	IN?	PHONG-KEYS,PHONG \?ELS98
	FCLEAR	PRSO,LOCKED
	EQUAL?	PRSA,V?OPEN \?CND101
	FSET	PRSO,OPENBIT
?CND101:	PRINTR	"""Okey."""
?ELS98:	EQUAL?	PRSA,V?LOCK,V?CLOSE \FALSE
	IN?	PHONG-KEYS,PHONG \FALSE
	FCLEAR	PRSO,OPENBIT
	EQUAL?	PRSA,V?LOCK \?CND110
	FSET	PRSO,LOCKED
?CND110:	PRINTR	"""Okey."""
?ELS83:	CALL	COM-CHECK,PHONG
	ZERO?	STACK \TRUE
	CALL	PICK-ONE,WHY-ME
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS56:	EQUAL?	PRSA,V?ACCUSE \?ELS122
	ZERO?	PHONG-SEEN-CORPSE? \?ELS127
	PRINTR	"""What are you talking about?"" He looks frightened."
?ELS127:	ZERO?	SIDE-FOOTPRINTS-MATCHED /?ELS131
	FSET?	GUN-RECEIPT,TOUCHBIT \?ELS131
	SET	'PHONG-ADMITTED-HELPING?,TRUE-VALUE
	CALL	DISCRETION,PHONG,MONICA
	PRINTR	"""It's true I helped set you up for deception with the guns. But only because Mr. Linder asked me to! He said he wanted to frighten Stiles. He wasn't supposed to be killed! Monica must have muffed it. Or else ... could she ...?"" He looks confused and angry."
?ELS131:	ZERO?	SIDE-FOOTPRINTS-MATCHED /?ELS137
	PRINTI	"""I don't see why you're accusing me!"
	PRINTI	" Sure, I was in the yard, because "
	PRINTI	"I thought I heard a noise outside and went out to investigate."
	PRINTR	" It's part of my job, you know."""
?ELS137:	FSET?	GUN-RECEIPT,TOUCHBIT \?ELS142
	CALL	DISCRETION,PHONG,MONICA
	PRINTI	"""I don't see why you're accusing me!"
	PRINTR	" You should ask Monica about those guns."""
?ELS142:	PRINTR	"""You haven't a clue, and you know it!"""
?ELS122:	ZERO?	PRSI /?ELS154
	SET	'OBJ,PRSI
	ZERO?	OBJ /?ELS154
	EQUAL?	PRSA,V?CONFRONT,V?ASK-ABOUT \?ELS154
	EQUAL?	PRSO,PHONG /?THN151
?ELS154:	ZERO?	PRSO /?ELS150
	IN?	PRSO,GLOBAL-OBJECTS \?ELS150
	SET	'OBJ,PRSO
	ZERO?	OBJ /?ELS150
	EQUAL?	PRSA,V?WHAT,V?FIND \?ELS150
?THN151:	CALL	GRAB-ATTENTION,PHONG
	ZERO?	STACK /TRUE
	CALL	SAID-TO,PHONG
	EQUAL?	OBJ,BUTTON \?ELS164
	PRINTR	"""That's my butler's button, of course."""
?ELS164:	EQUAL?	OBJ,GLOBAL-CAN-OF-WORMS \?ELS168
	PRINTR	"""I didn't think you had any interest in gardening! Those little babies are the best thing for the clay soil around here. You can just order them by mail and open them up when they arrive."""
?ELS168:	EQUAL?	OBJ,GENERIC-GUN \?ELS172
	PRINTR	"""I don't have one, if that's what you mean."""
?ELS172:	EQUAL?	OBJ,BLACK-WIRE \?ELS176
	PRINTR	"""Oh, Monica wired the house for butler's buttons."""
?ELS176:	EQUAL?	OBJ,WHITE-WIRE \?ELS180
	PRINTR	"""Oh, Monica wired the windows with burglar alarms."""
?ELS180:	EQUAL?	OBJ,GENERIC-GREEN-WIRE,GENERIC-WIRE \?ELS184
	PRINTR	"""There's wire all over the house. You'll have to ask Monica."""
?ELS184:	EQUAL?	OBJ,GENERIC-KEY,PHONG-KEYS \?ELS188
	IN?	PHONG-KEYS,PHONG \?ELS193
	PRINTR	"""I have the keys for all the doors in the house."""
?ELS193:	PRINTR	"""Don't you remember? I gave you all the keys I have."""
?ELS188:	EQUAL?	OBJ,CLOCK-KEY \?ELS201
	IN?	CLOCK-KEY,PLAYER \?ELS206
	PRINTR	"""That looks like the key to Mr. Linder's clock."""
?ELS206:	PRINTR	"""There's only one key to Mr. Linder's clock. I think he keeps it in the office somewhere."""
?ELS201:	EQUAL?	OBJ,GLOBAL-LINDER,LINDER,CORPSE \?ELS214
	IN?	LINDER,HERE \?ELS219
	PRINTR	"""That man is a marvel. Always seems to have several deals going at once. I don't know how he does it."" Linder beams with self-pride."
?ELS219:	ZERO?	PHONG-SEEN-CORPSE? /?ELS223
	SET	'PHONG-HAS-MOTIVE,CORPSE
	CALL	DISCRETION,PHONG,MONICA
	PRINTI	"""Frankly, Detective, I can't say I"
	PRINTI	"'m sorry he's dead"
	PRINTI	". He always promised me wealth here in America, but I've never seen it. I could "
	PRINTI	"have managed"
	PRINTR	" the Asian branch of his business if he'd let me. If I had any money, I'd quit on the spot and return home."""
?ELS223:	SET	'PHONG-HAS-MOTIVE,LINDER
	CALL	DISCRETION,PHONG,MONICA
	PRINTI	"""Frankly, Detective, I can't say I"
	PRINTI	" like him much"
	PRINTI	". He always promised me wealth here in America, but I've never seen it. I could "
	PRINTI	"manage"
	PRINTR	" the Asian branch of his business if he'd let me. If I had any money, I'd quit on the spot and return home."""
?ELS214:	EQUAL?	OBJ,GLOBAL-MONICA,MONICA \?ELS232
	CALL	DISCRETION,PHONG,MONICA
	PRINTI	"""She's an intelligent girl. Mr. Linder is very proud of her, but I think she acts too much like a man."
	ZERO?	PHONG-SEEN-CORPSE? /?CND235
	PRINTI	" She really muffed it this time."
?CND235:	PRINTR	""""
?ELS232:	EQUAL?	OBJ,GLOBAL-AFFAIR,GLOBAL-MRS-LINDER \?ELS244
	CALL	DISCRETION,PHONG,LINDER
	PRINTR	"""If only Mr. Linder had been home more, he could have kept her in line."""
?ELS244:	EQUAL?	OBJ,GLOBAL-PHONG,PHONG \?ELS248
	SET	'PHONG-HAS-MOTIVE,PHONG
	PRINTR	"""Mr. Linder brought me here from Asia, to help manage his business and run his house. I guess I do more running than managing. If I can help you, just push the button anywhere in the house."""
?ELS248:	ZERO?	SHOT-FIRED /?ELS252
	EQUAL?	OBJ,GLOBAL-SHOT \?ELS252
	PRINTR	"""I was in the kitchen and heard a sound like a gunshot, so I ran to the office and found you and Mr. Linder. You were closer to it than I was."""
?ELS252:	EQUAL?	OBJ,GLOBAL-STILES,STILES \?ELS258
	CALL	DISCRETION,PHONG,LINDER
	PRINTR	"""He used to come around here now and then, when Mr. Linder was away. I never thought much about it until the fighting between Mr. and Mrs. got bad, just before Mrs. Linder passed on."" He pauses. ""I think Mr. Linder has been calling him on the telephone a lot lately."""
?ELS258:	EQUAL?	OBJ,GLOBAL-SUICIDE \?ELS262
	SET	'MONICA-HAS-MOTIVE,PHONG
	CALL	DISCRETION,PHONG,LINDER,MONICA
	PRINTR	"""Everyone was sad about that. Mr. Linder just threw himself into his work, as usual. Monica was terribly depressed, didn't even come out of her room for a long time. I doubt she'll ever get over it."""
?ELS262:	EQUAL?	OBJ,WILL \?ELS266
	ZERO?	PHONG-SEEN-CORPSE? /?ELS271
	CALL	DISCRETION,PHONG,MONICA
	PRINTR	"""Mr. Linder probably kept it in his bank safe. I've never seen it."""
?ELS271:	PRINTR	"""You'll have to ask Mr. Linder about that."""
?ELS266:	EQUAL?	OBJ,BROOM \?ELS280
	PRINTR	"""What can I tell you? That's a 'flathead broom,' invented by your American Shakers, I believe."""
?ELS280:	EQUAL?	OBJ,DOORBELL \?ELS284
	ZERO?	PHONG-SEEN-CORPSE? /?ELS284
	PRINTR	"He seems surprised. ""Uh, that was just some door-to-door salesman."""
?ELS284:	EQUAL?	OBJ,GUN-RECEIPT \?ELS290
	CALL	DISCRETION,PHONG,MONICA
	PRINTR	"""Yes, I think Monica bought those, using some other name."""
?ELS290:	EQUAL?	OBJ,MATCHBOOK \?ELS294
	PRINTI	"""I've heard Mr. Linder mention that restaurant."
	PRINTR	" But I don't recognize the phone number."""
?ELS294:	EQUAL?	OBJ,BRASS-LANTERN \?ELS298
	PRINTI	"""I've heard Mr. Linder mention that restaurant."
	PRINTR	""""
?ELS298:	EQUAL?	OBJ,MEDICAL-REPORT,TUMOR \?ELS302
	PRINTR	"Phong looks surprised but not alarmed. ""This is the first I've heard of this."""
?ELS302:	EQUAL?	OBJ,MUDDY-SHOES \?ELS306
	SET	'SIDE-FOOTPRINTS-MATCHED,TRUE-VALUE
	PRINTI	"""Those are my gardening boots. They're muddy because, while you were in the office, "
	PRINTI	"I thought I heard a noise outside and went out to investigate."
	PRINTR	""""
?ELS306:	EQUAL?	OBJ,OFFICE-BUTTON,CLOCK /?THN311
	EQUAL?	OBJ,POWDER,CLOCK-POWDER \?ELS310
?THN311:	ZERO?	PLAYER-PUSHED-BUTTON /?CND313
	SET	'PHONG-ADMITTED-HELPING?,TRUE-VALUE
	CALL	DISCRETION,PHONG,MONICA
	PRINTR	"""I might as well tell you: Mr. Linder concocted this scheme to frighten Stiles, and he got Monica and me to help him. But he was supposed to be only wounded, not killed!"""
?CND313:	ZERO?	PHONG-SEEN-CORPSE? /?CND319
	PRINTI	"Phong seems shaken, but all he says is, "
?CND319:	EQUAL?	OBJ,OFFICE-BUTTON \?ELS329
	PRINTR	"""That's my butler's button, of course."""
?ELS329:	EQUAL?	OBJ,CLOCK \?ELS333
	PRINTR	"""Mr. Linder has a certain fondness for elaborate things like that."""
?ELS333:	PRINTR	"""If it's dust you're after, I plead guilty to plenty of it."""
?ELS310:	EQUAL?	OBJ,PIECE-OF-WIRE,CLOCK-WIRES,PIECE-OF-PUTTY \?ELS341
	PRINTR	"""Oh, I guess that's part of the burglar alarm."""
?ELS341:	EQUAL?	OBJ,RECURSIVE-BOOK \?ELS345
	PRINTR	"""It's a mystery called 'Deadline.' Monica recommended it to me."""
?ELS345:	EQUAL?	OBJ,TELEGRAM \?ELS349
	PRINTR	"""Yes, that's the telegram Mr. Linder sent this morning."""
?ELS349:	EQUAL?	OBJ,THREAT-NOTE \FALSE
	ZERO?	PHONG-ADMITTED-HELPING? /?ELS358
	PRINTR	"""Yes, now you know that Mr. Linder forged that note. Stiles didn't send it to him."""
?ELS358:	PRINTR	"""Yes, that's the note that Stiles sent to Mr. Linder."""
?ELS367:	PRINTR	"""I'm sorry, Detective, but I can't help you."""
?ELS150:	EQUAL?	PRSO,PHONG \?ELS375
	EQUAL?	PRSA,V?HELP \?ELS375
	PRINTR	"Phong looks offended. ""I'm quite capable by myself, you know."""
?ELS375:	EQUAL?	PRSO,PHONG \?ELS381
	EQUAL?	PRSA,V?RUB \?ELS381
	CALL	PHONG-FIGHTS
	RSTACK	
?ELS381:	EQUAL?	PRSO,PHONG \?ELS385
	EQUAL?	PRSA,V?ASK-FOR \?ELS385
	FSET	PHONG,TOUCHBIT
	EQUAL?	PRSI,OUTSIDE-GUN /?THN393
	EQUAL?	PRSI,GENERIC-GUN,PHONG-KEYS,GENERIC-KEY \FALSE
?THN393:	CALL	PERFORM,V?ASK-ABOUT,PHONG,PRSI
	RTRUE	
?ELS385:	EQUAL?	PRSO,PHONG \?ELS398
	EQUAL?	PRSA,V?SEARCH-OBJECT-FOR,V?SEARCH \?ELS398
	IN?	OUTSIDE-GUN,PHONG \?ELS405
	CALL	PHONG-FIGHTS
	RSTACK	
?ELS405:	IN?	PHONG-KEYS,PHONG \FALSE
	EQUAL?	PRSA,V?SEARCH /?THN410
	EQUAL?	PRSA,V?SEARCH-OBJECT-FOR \FALSE
	EQUAL?	PRSI,GENERIC-KEY,PHONG-KEYS \FALSE
?THN410:	MOVE	PHONG-KEYS,PLAYER
	FCLEAR	PHONG-KEYS,NDESCBIT
	PRINTI	"You find a "
	PRINTD	PHONG-KEYS
	PRINTR	" in Phong's pocket and take it."
?ELS398:	EQUAL?	PRSO,PHONG \?ELS419
	EQUAL?	PRSA,V?SHOW \?ELS419
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSI
	RTRUE	
?ELS419:	EQUAL?	PRSA,V?TAKE \?ELS423
	EQUAL?	PRSO,OUTSIDE-GUN /?THN426
	EQUAL?	PRSO,GENERIC-GUN,GENERIC-KEY,PHONG-KEYS \?ELS423
?THN426:	CALL	TAKE-PHONG-KEYS
	RSTACK	
?ELS423:	EQUAL?	PRSA,V?TAKEOUT \?ELS429
	EQUAL?	PRSI,LINDER-BACK-DOOR,MONICA-BACK-DOOR,OFFICE-BACK-DOOR \?ELS429
	CALL	PHONG-FIGHTS
	RSTACK	
?ELS429:	EQUAL?	PRSA,V?ARREST \FALSE
	CALL	ARREST,PHONG
	RSTACK	


	.FUNCT	PHONG-FIGHTS
	PRINTR	"Phong's smile disappears and his body shifts subtly toward a fighting stance. ""I don't think you really want to try that, Detective."""


	.FUNCT	TAKE-PHONG-KEYS
	ZERO?	PHONG-SEEN-CORPSE? /?ELS5
	MOVE	PHONG-KEYS,PLAYER
	FCLEAR	PHONG-KEYS,NDESCBIT
	PRINTR	"""Here, you may as well take them. I don't see how Mr. Linder can object now."""
?ELS5:	PRINTR	"""I don't think Mr. Linder would like that."""


	.FUNCT	LINDER-F,ARG=0,OBJ,L
	LOC	LINDER >L
	EQUAL?	ARG,M-OBJDESC \?ELS5
	CALL	IN-MOTION?,LINDER
	ZERO?	STACK \TRUE
	FSET?	LINDER,TOUCHBIT \?ELS10
	IN?	LINDER,HERE \?ELS13
	IN?	HERE,ROOMS \?ELS13
	PRINTR	"Linder is pacing back and forth."
?ELS13:	PRINTI	"Linder is sitting on the "
	LOC	LINDER
	PRINTD	STACK
	PRINTR	"."
?ELS10:	FSET	LINDER,TOUCHBIT
	GETP	LINDER,P?TEXT
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	WINNER,LINDER \?ELS27
	EQUAL?	PRSA,V?FIND \?ELS32
	EQUAL?	PRSO,GUN-RECEIPT \?ELS32
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,LINDER,PRSO
	RTRUE	
?ELS32:	EQUAL?	PRSA,V?THANKS,V?FIND /FALSE
	EQUAL?	PRSA,V?GIVE \?ELS42
	EQUAL?	PRSO,DRINK /FALSE
?ELS42:	EQUAL?	PRSA,V?SGIVE \?ELS38
	EQUAL?	PRSI,DRINK /FALSE
?ELS38:	EQUAL?	PRSA,V?PUSH \?ELS46
	EQUAL?	PRSO,OFFICE-BUTTON \?ELS46
	PRINTR	"""I don't need Phong yet."""
?ELS46:	EQUAL?	PRSA,V?TIME \?ELS52
	PRINTI	"Linder looks at his wrist watch and says, ""I have "
	CALL	TIME-PRINT,PRESENT-TIME
	PRINTR	""""
?ELS52:	CALL	COM-CHECK,LINDER
	ZERO?	STACK \TRUE
	PRINTR	"""Don't tell me what to do!"""
?ELS27:	ZERO?	PRSO /?ELS68
	IN?	PRSO,GLOBAL-OBJECTS \?ELS68
	SET	'OBJ,PRSO
	ZERO?	OBJ /?ELS68
	EQUAL?	PRSA,V?WHAT,V?FIND /?THN65
?ELS68:	ZERO?	PRSI /?ELS64
	SET	'OBJ,PRSI
	ZERO?	OBJ /?ELS64
	EQUAL?	PRSO,LINDER \?ELS64
	EQUAL?	PRSA,V?ASK-ABOUT,V?CONFRONT \?ELS64
?THN65:	CALL	GRAB-ATTENTION,LINDER
	ZERO?	STACK /TRUE
	CALL	SAID-TO,LINDER
	EQUAL?	OBJ,BUTTON \?ELS78
	PRINTR	"""That's the butler's button, of course."""
?ELS78:	EQUAL?	OBJ,BLACK-WIRE \?ELS82
	PRINTI	"""Yes, Monica wired "
	PRINTI	"the whole house for butler's buttons."
	PRINTR	" With all modesty, I think she's quite a mechanic."""
?ELS82:	EQUAL?	OBJ,WHITE-WIRE \?ELS86
	PRINTI	"""Yes, Monica wired "
	PRINTI	"all the windows for burglars."
	PRINTR	" With all modesty, I think she's quite a mechanic."""
?ELS86:	EQUAL?	OBJ,GENERIC-GREEN-WIRE,GENERIC-WIRE \?ELS90
	PRINTR	"""That's Monica's territory. I don't interfere."""
?ELS90:	EQUAL?	OBJ,GLOBAL-CALL \?ELS94
	PRINTR	"""What phone call? I haven't talked with Stiles since my wife's death. I'm really afraid he wants to do me in."""
?ELS94:	EQUAL?	OBJ,GENERIC-KEY \?ELS98
	PRINTR	"""Phong keeps the house keys for me."""
?ELS98:	EQUAL?	OBJ,GLOBAL-LINDER,LINDER \?ELS102
	PRINTR	"""You've probably read about me in the papers. In fact they just published something about me when I won that award. And I've heard lots about you. That's why I asked you here."""
?ELS102:	EQUAL?	OBJ,GLOBAL-AFFAIR,GLOBAL-MRS-LINDER,GLOBAL-SUICIDE \?ELS106
	PRINTR	"""It's still too painful for me to talk about, I'm afraid."""
?ELS106:	EQUAL?	OBJ,MONEY \?ELS110
	PRINTR	"""Money?! I asked you here to prevent a crime. I hope you're not thinking of some outlandish fee!"""
?ELS110:	EQUAL?	OBJ,GLOBAL-MONICA,MONICA \?ELS114
	PRINTR	"""She's a loyal and intelligent girl. I'm very proud of her."""
?ELS114:	EQUAL?	OBJ,GLOBAL-PHONG,PHONG \?ELS118
	PRINTR	"""He and I go back a long time. Met in Asia, you know. And since I spend as much time there as here, he takes care of the house for me. A fine fellow, and I trust him implicitly."""
?ELS118:	EQUAL?	OBJ,GLOBAL-STILES,STILES,DANGER \?ELS122
	FSET?	THREAT-NOTE,TOUCHBIT \?ELS127
	PRINTR	"""All I know about Stiles is that he's a writer of some kind, and sometimes he plays bit parts in films. I've never really met the man."""
?ELS127:	EQUAL?	HERE,OFFICE \?ELS131
	CALL	I-LINDER-EXPLAIN
	RTRUE	
?ELS131:	PRINTR	"""I'll explain all that shortly, after I finish this drink."""
?ELS122:	EQUAL?	OBJ,PLAYER \?ELS137
	PRINTR	"""My friend Klutz, the Police Chief, recommended you to me."""
?ELS137:	EQUAL?	OBJ,GENERIC-CAR,GENERIC-GUN /?THN142
	EQUAL?	OBJ,GLOBAL-PTA,WILL \?ELS141
?THN142:	PRINTR	"""That has nothing to do with why I asked you here."""
?ELS141:	EQUAL?	OBJ,BROOM \?ELS147
	PRINTR	"""Oh, Phong must have left it there after cleaning up."""
?ELS147:	EQUAL?	OBJ,CARVED-CHAIR \?ELS151
	PRINTR	"""I found that in an obscure but wealthy estate in Asia during the war and brought it home as booty. Sitting in it makes me feel like an 'Oriental Potentate.'"""
?ELS151:	EQUAL?	OBJ,CAT \?ELS155
	PRINTR	"""She's Monica's cat. You'd do better to ask her."""
?ELS155:	EQUAL?	OBJ,CLOCK \?ELS159
	PRINTR	"""I've always admired elaborate machines, and that's the finest example I could hope to own."""
?ELS159:	EQUAL?	OBJ,GUN-RECEIPT \?ELS163
	PRINTR	"""I didn't ask you here so you could search the house!"""
?ELS163:	EQUAL?	OBJ,MATCHBOOK,BRASS-LANTERN \?ELS167
	CALL	DISCRETION,LINDER,PHONG
	PRINTR	"""I think Phong goes there sometimes. I've never been there myself."" He almost flinched before answering, but now he's as smooth as ever."
?ELS167:	EQUAL?	OBJ,MEDICAL-REPORT,TUMOR \?ELS171
	ZERO?	LINDER-SAW-MEDICAL-REPORT /?ELS174
	PRINTI	"""I already told you that I haven't seen it before."""
	CRLF	
	JUMP	?CND172
?ELS174:	PRINTI	"Linder looks surprised and a bit alarmed. ""This is the first I've heard of this. I don't know why my doctor didn't tell me about it."""
	CRLF	
?CND172:	SET	'LINDER-SAW-MEDICAL-REPORT,TRUE-VALUE
	RETURN	LINDER-SAW-MEDICAL-REPORT
?ELS171:	EQUAL?	OBJ,OFFICE-BUTTON \?ELS183
	PRINTR	"""That's the butler's button, of course."""
?ELS183:	EQUAL?	OBJ,PAPERS,FILE-CABINET \?ELS187
	PRINTR	"""I wish you wouldn't meddle in my files while we're trying to talk."""
?ELS187:	EQUAL?	OBJ,PIECE-OF-WIRE,CLOCK-WIRES,PIECE-OF-PUTTY \?ELS191
	PRINTR	"""Oh, uh, that's part of the burglar alarm."""
?ELS191:	EQUAL?	OBJ,TELEGRAM \?ELS195
	PRINTR	"""Yes, that's the telegram I sent this morning."""
?ELS195:	EQUAL?	OBJ,THREAT-NOTE \?ELS199
	PRINTR	"""Yes, that's the note that Stiles sent to me."""
?ELS199:	CALL	PICK-ONE,LINDER-ASKED
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS64:	EQUAL?	PRSO,LINDER \?ELS207
	EQUAL?	PRSA,V?RUB \?ELS207
	PRINTR	"Linder looks bewildered, almost alarmed. ""Whatever do you have in mind?"""
?ELS207:	EQUAL?	PRSO,LINDER \?ELS213
	EQUAL?	PRSA,V?SHOW \?ELS213
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSI
	RTRUE	
?ELS213:	EQUAL?	PRSO,LINDER \?ELS217
	EQUAL?	PRSA,V?TURN-UP \?ELS217
	PRINTR	"Many have tried, but none has succeeded."
?ELS217:	EQUAL?	PRSA,V?TAKEOUT \?ELS223
	EQUAL?	PRSI,LINDER-BACK-DOOR,MONICA-BACK-DOOR,OFFICE-BACK-DOOR \?ELS223
	PRINTR	"Many have tried, but none has succeeded."
?ELS223:	EQUAL?	PRSA,V?ARREST \FALSE
	CALL	ARREST,LINDER
	RSTACK	


	.FUNCT	STILES-F,ARG=0,OBJ,L
	LOC	STILES >L
	EQUAL?	ARG,M-OBJDESC \?ELS5
	EQUAL?	L,OFFICE-PORCH,OFFICE-PATH \?ELS8
	CALL	IN-MOTION?,STILES
	ZERO?	STACK \TRUE
	FSET?	STILES,TOUCHBIT \?ELS13
	PRINTR	"Stiles is waiting for you to say something."
?ELS13:	PRINTR	"The visitor is in a hurry."
?ELS8:	CALL	IN-MOTION?,STILES
	ZERO?	STACK /?ELS21
	PRINTR	"Sgt. Duffy is leading Stiles by the handcuffs."
?ELS21:	ZERO?	MET-STILES? /?ELS25
	LESS?	PRESENT-TIME,780 \?ELS29
	PRINTI	"Stiles is fastened to the davenport, "
	PRINTR	"looking sullen."
?ELS29:	PRINTI	"Stiles is fastened to the davenport, "
	PRINTR	"yawning and trying not to doze off."
?ELS25:	PRINTI	"Sgt. Duffy is holding a prisoner by the arm."
	CRLF	
	GETP	STILES,P?TEXT
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	WINNER,STILES \?ELS43
	ZERO?	TOO-LATE /?ELS48
	EQUAL?	PRSA,V?FIND \?ELS48
	EQUAL?	PRSO,PLAYER /?ELS48
	PRINTR	"""I wouldn't tell you even if I knew."""
?ELS48:	ZERO?	TOO-LATE /?ELS54
	EQUAL?	PRSA,V?INVENTORY \?ELS54
	PRINTR	"""I've never seen you before."""
?ELS54:	EQUAL?	PRSA,V?THANKS,V?FIND /FALSE
	CALL	COM-CHECK,STILES
	ZERO?	STACK \TRUE
	CALL	PICK-ONE,WHY-ME
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS43:	ZERO?	PRSI /?ELS72
	SET	'OBJ,PRSI
	ZERO?	OBJ /?ELS72
	EQUAL?	PRSO,STILES \?ELS72
	EQUAL?	PRSA,V?ASK-ABOUT,V?CONFRONT /?THN69
?ELS72:	ZERO?	PRSO /?ELS68
	IN?	PRSO,GLOBAL-OBJECTS \?ELS68
	SET	'OBJ,PRSO
	ZERO?	OBJ /?ELS68
	EQUAL?	PRSA,V?WHAT,V?FIND \?ELS68
?THN69:	CALL	GRAB-ATTENTION,STILES
	ZERO?	STACK /TRUE
	CALL	SAID-TO,STILES
	EQUAL?	OBJ,GLOBAL-CALL \?ELS82
	PRINTI	"""Linder phoned me today and almost commanded me to come here tonight to talk about our deal. Last time, he at least was decent enough to buy me lunch. He"
	PRINTR	" said he wanted to pay me a bundle to leave town."""
?ELS82:	ZERO?	TOO-LATE \?ELS86
	EQUAL?	OBJ,GLOBAL-DUFFY \?ELS86
	PRINTR	"""Is that your man? When I came running out of the woods, he grabbed me as if I was some kind of criminal. He wouldn't let me go! So here I am."""
?ELS86:	EQUAL?	OBJ,GENERIC-GUN \?ELS92
	PRINTR	"""Don't ask me. I never touch them."""
?ELS92:	ZERO?	TOO-LATE \?ELS96
	EQUAL?	OBJ,STILES-SHOES \?ELS96
	SET	'BACK-FOOTPRINTS-MATCHED,TRUE-VALUE
	PRINTR	"""What about them? They're muddy because I had to run through the yard and woods to get away from the shooting."""
?ELS96:	EQUAL?	OBJ,TELEGRAM \?ELS102
	PRINTR	"""I don't get it. I think he's more dangerous than I am!"""
?ELS102:	EQUAL?	OBJ,MONEY \?ELS106
	PRINTI	"""Yeah, Linder"
	PRINTR	" said he wanted to pay me a bundle to leave town."""
?ELS106:	EQUAL?	OBJ,GLOBAL-MONICA,MONICA \?ELS110
	CALL	DISCRETION,STILES,MONICA
	PRINTR	"""She's probably just another dizzy dame, but I don't really know her well enough to say."""
?ELS110:	EQUAL?	OBJ,GLOBAL-AFFAIR,GLOBAL-MRS-LINDER,GLOBAL-SUICIDE \?ELS114
	CALL	DISCRETION,STILES,MONICA
	PRINTR	"""Virginia was a special woman. Repressed for years. I think that, if only ... Say, I don't have to answer your questions!"""
?ELS114:	EQUAL?	OBJ,GLOBAL-LINDER,LINDER,CORPSE \?ELS118
	PRINTR	"""He's a smooth operator. I can think of many people who'd like to plug him. Not me, of course. I still don't understand why he sounded so urgent when he called me today and asked me to come here tonight."""
?ELS118:	EQUAL?	OBJ,GLOBAL-PHONG,PHONG \?ELS122
	CALL	DISCRETION,STILES,PHONG
	PRINTI	"""He seems straight, but I don't really trust "
	CALL	TANDY?
	ZERO?	STACK /?ELS127
	PRINTI	"his kind"
	JUMP	?CND125
?ELS127:	PRINTI	"slanteyes"
?CND125:	PRINTR	"."""
?ELS122:	ZERO?	SHOT-FIRED /?ELS137
	EQUAL?	OBJ,GLOBAL-SHOT \?ELS137
	PRINTR	"""I was just walking up to Linder's office when there was this explosion and the window fell apart. 'Holy jumping catfish!' I thought, 'Someone took a shot at me!' So I ran to the gate, but it was locked. The only way out I could see was through the woods."""
?ELS137:	EQUAL?	OBJ,GLOBAL-STILES,STILES \?ELS143
	PRINTR	"""There's not much to tell. I'm a writer, but that doesn't take you far these days. So I do some film work on the side. Some day my agent will wise up and find me a decent publisher."""
?ELS143:	ZERO?	TOO-LATE \?ELS147
	EQUAL?	OBJ,INSIDE-GUN,OUTSIDE-GUN \?ELS147
	PRINTR	"""I've never seen it before. Anyhow, I don't like guns."""
?ELS147:	EQUAL?	OBJ,MATCHBOOK /?THN154
	EQUAL?	OBJ,INTNUM \?ELS153
	EQUAL?	P-NUMBER,1729 \?ELS153
?THN154:	PRINTI	"""That's my phone number! Linder must have jotted it down the day we had lunch at that restaurant,"
	PRINTR	" when he first offered me money to leave town."""
?ELS153:	EQUAL?	OBJ,BRASS-LANTERN \?ELS161
	PRINTI	"""I think that's the name of the restaurant where Linder took me to lunch,"
	PRINTR	" when he first offered me money to leave town."""
?ELS161:	ZERO?	TOO-LATE \?ELS165
	EQUAL?	OBJ,MEDICAL-REPORT,TUMOR \?ELS165
	PRINTR	"""So the old man was on the way out, eh? Wish I'd known that."" He pauses. ""I mean, I could have taken his money and blown town until he kicked the bucket, then come back. Too late now."""
?ELS165:	ZERO?	TOO-LATE \?ELS171
	EQUAL?	OBJ,THREAT-NOTE \?ELS171
	PRINTR	"""Holy smoke! That sort of looks like my writing, but I didn't write it."""
?ELS171:	CALL	PICK-ONE,STILES-ASKED
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS68:	EQUAL?	PRSA,V?PHONE,V?LOOK-UP \?ELS181
	CALL	PERFORM,PRSA,MATCHBOOK
	RTRUE	
?ELS181:	ZERO?	TOO-LATE /?ELS183
	EQUAL?	PRSA,V?SEARCH /?THN186
	EQUAL?	PRSO,MONEY \?ELS189
	EQUAL?	PRSA,V?TAKE,V?GIVE /?THN186
?ELS189:	EQUAL?	PRSI,MONEY \?ELS183
	EQUAL?	PRSA,V?SGIVE,V?SEARCH-OBJECT-FOR,V?ASK-FOR \?ELS183
?THN186:	PRINTR	"When you try it, he whirls around in a fighting stance. ""Don't mess around with me, buddy. I've handled thieves before."""
?ELS183:	EQUAL?	PRSO,STILES \?ELS195
	EQUAL?	PRSA,V?SHOW \?ELS195
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSI
	RTRUE	
?ELS195:	EQUAL?	PRSO,STILES \?ELS199
	EQUAL?	PRSA,V?RUB,V?SLAP \?ELS199
	PRINTI	"Stiles"
	PRINTI	"'s eyes are full of hate, and "
	PRINTR	"he says something unprintable."
?ELS199:	EQUAL?	PRSO,STILES \?ELS205
	EQUAL?	PRSA,V?TIE-WITH,V?TIE-TO \?ELS205
	ZERO?	TOO-LATE \?ELS205
	PRINTR	"There's no need. Duffy's cuffs are secure enough."
?ELS205:	EQUAL?	PRSO,STILES \?ELS211
	EQUAL?	PRSA,V?UNTIE \?ELS211
	ZERO?	TOO-LATE \?ELS211
	PRINTR	"Your key won't fit the cuffs."
?ELS211:	EQUAL?	PRSA,V?TAKEOUT \?ELS217
	ZERO?	TOO-LATE \?ELS217
	EQUAL?	PRSI,LINDER-BACK-DOOR,MONICA-BACK-DOOR,OFFICE-BACK-DOOR \?ELS217
	PRINTR	"Your key won't fit the cuffs."
?ELS217:	EQUAL?	PRSA,V?ARREST \FALSE
	CALL	ARREST,STILES
	RSTACK	


	.FUNCT	STILES-SHOES-F
	EQUAL?	PRSA,V?PUT,V?COMPARE \?ELS5
	EQUAL?	PRSO,SIDE-FOOTPRINTS-CAST,SIDE-FOOTPRINTS /?THN8
	EQUAL?	PRSI,SIDE-FOOTPRINTS-CAST,SIDE-FOOTPRINTS \?ELS5
?THN8:	PRINTI	"The shoes don't seem to match "
	PRINTI	"the foot prints that you found in the "
	PRINTR	"side yard."
?ELS5:	EQUAL?	PRSA,V?PUT,V?COMPARE \?ELS13
	EQUAL?	PRSO,BACK-FOOTPRINTS-CAST,BACK-FOOTPRINTS /?THN16
	EQUAL?	PRSI,BACK-FOOTPRINTS-CAST,BACK-FOOTPRINTS \?ELS13
?THN16:	EQUAL?	PRSA,V?PUT /?THN23
	EQUAL?	P-ADVERB,W?CAREFULLY \?ELS22
?THN23:	SET	'BACK-FOOTPRINTS-MATCHED,TRUE-VALUE
	PRINTR	"The shoes and the foot prints match each other perfectly."
?ELS22:	PRINTI	"The shoes look similar to "
	PRINTI	"the foot prints that you found in the "
	PRINTR	"back yard."
?ELS13:	CALL	RANDOM-SHOES-F
	RSTACK	


	.FUNCT	MONICA-F,ARG=0,OBJ,L,X,?TMP1
	LOC	MONICA >L
	EQUAL?	ARG,M-OBJDESC \?ELS5
	CALL	IN-MOTION?,MONICA
	ZERO?	STACK \TRUE
	FSET?	MONICA,TOUCHBIT \?ELS10
	ZERO?	MONICA-TIED-TO /?ELS13
	PRINTI	"Monica is fastened to the "
	PRINTD	MONICA-TIED-TO
	PRINTI	" with the "
	PRINTD	MONICA-TIED-WITH
	PRINTR	"."
?ELS13:	EQUAL?	L,MONICA-ROOM \?ELS18
	PRINTR	"Monica is lying on her bed, softly sobbing."
?ELS18:	EQUAL?	L,TOILET-ROOM \?ELS22
	PRINTR	"Monica is leaning over the toilet, gasping."
?ELS22:	PRINTR	"Monica is here, biting her nails."
?ELS10:	FSET	MONICA,TOUCHBIT
	PRINTI	"Monica "
	LOC	MONICA >?TMP1
	LOC	LINDER
	EQUAL?	?TMP1,STACK \?CND33
	PRINTI	"stops talking and "
?CND33:	PRINTI	"looks at you sharply. "
	GETP	MONICA,P?TEXT
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	WINNER,MONICA \?ELS41
	FSET	MONICA,TOUCHBIT
	EQUAL?	PRSA,V?FIND \?ELS46
	EQUAL?	PRSO,CLOCK-KEY \?ELS46
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,MONICA,PRSO
	RTRUE	
?ELS46:	EQUAL?	PRSA,V?THANKS,V?FIND /FALSE
	EQUAL?	PRSA,V?GIVE \?THN57
	EQUAL?	PRSO,INSIDE-GUN /?THN57
	EQUAL?	PRSO,GENERIC-GUN,GENERIC-KEY,CLOCK-KEY /?THN61
?THN57:	EQUAL?	PRSA,V?SGIVE \?ELS52
	EQUAL?	PRSI,INSIDE-GUN /?THN61
	EQUAL?	PRSI,GENERIC-GUN,GENERIC-KEY,CLOCK-KEY \?ELS52
?THN61:	PRINTR	"""Why should I?"""
?ELS52:	CALL	COM-CHECK,MONICA
	ZERO?	STACK \TRUE
	CALL	PICK-ONE,WHY-ME
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS41:	EQUAL?	PRSA,V?ACCUSE \?ELS72
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	ZERO?	MONICA-SEEN-CORPSE? \?ELS77
	PRINTR	"""What murder? What are you talking about?"" Her cheeks quiver like jelly."
?ELS77:	ZERO?	SEEN-MONICA-AT-CLOCK \?ELS81
	ZERO?	MONICA-ADMITTED-HELPING? \?ELS81
	PRINTR	"""You were there when it happened. Isn't it obvious that Stiles did it?"""
?ELS81:	ZERO?	MONICA-SAW-MEDICAL-REPORT \?ELS87
	FCLEAR	MEDICAL-REPORT,INVISIBLE
	FCLEAR	TUMOR,INVISIBLE
	SET	'MONICA-SAW-MEDICAL-REPORT,TRUE-VALUE
	SET	'MONICA-ADMITTED-HELPING?,TRUE-VALUE
	PRINTI	"""It's true I helped set up the gun mechanism. But Dad was already dying! You can find the medical report on the desk "
	IN?	MONICA,MONICA-ROOM \?CND90
	PRINTI	"here "
?CND90:	PRINTR	"in my room. He was ... dying ..."" She breaks down in tears."
?ELS87:	ZERO?	MONICA-SAW-CORONER-REPORT \?ELS98
	PRINTR	"""I've told you already: he was dying!"" Tears dribble down her cheeks."
?ELS98:	PRINTR	"""I don't understand! I believed that medical report, and I don't know why the doctor lied to me about the tumor. You think I wanted to murder my own father? I thought he was dying already!"" Her eyes are pleading with you now, begging you to believe her."
?ELS72:	ZERO?	PRSI /?ELS110
	SET	'OBJ,PRSI
	ZERO?	OBJ /?ELS110
	EQUAL?	PRSO,MONICA \?ELS110
	EQUAL?	PRSA,V?ASK-ABOUT,V?CONFRONT /?THN107
?ELS110:	ZERO?	PRSO /?ELS106
	IN?	PRSO,GLOBAL-OBJECTS \?ELS106
	SET	'OBJ,PRSO
	ZERO?	OBJ /?ELS106
	EQUAL?	PRSA,V?WHAT,V?FIND \?ELS106
?THN107:	CALL	GRAB-ATTENTION,MONICA
	ZERO?	STACK /TRUE
	CALL	SAID-TO,MONICA
	FSET	MONICA,TOUCHBIT
	EQUAL?	OBJ,MONEY,GLOBAL-PTA /?THN121
	EQUAL?	OBJ,GLOBAL-TERRY,GENERIC-CAR \?ELS120
?THN121:	PRINTR	"""That has nothing to do with why Dad asked you here."""
?ELS120:	EQUAL?	OBJ,BUTTON \?ELS126
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTR	"""That's the butler's button, you cheesehead."""
?ELS126:	EQUAL?	OBJ,GENERIC-GUN \?ELS130
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTR	"""I have nothing to say to you about that."""
?ELS130:	EQUAL?	OBJ,BLACK-WIRE \?ELS134
	PRINTR	"""That bell system is just one of the features I've put in this house. Beyond your imagination, probably."""
?ELS134:	EQUAL?	OBJ,WHITE-WIRE \?ELS138
	PRINTR	"""That alarm system is another of the features I've put in this house. You probably know the kind of low-life that would try to break in here."""
?ELS138:	EQUAL?	OBJ,GENERIC-GREEN-WIRE,GENERIC-WIRE \?ELS142
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTI	"""You want wire? You can find all kinds "
	EQUAL?	HERE,WORKSHOP \?CND145
	PRINTI	"here "
?CND145:	PRINTR	"in the workshop."""
?ELS142:	EQUAL?	OBJ,GLOBAL-MONICA,MONICA \?ELS153
	PRINTR	"""I have no secrets. Anyone can see what I am."""
?ELS153:	EQUAL?	OBJ,GENERIC-KEY,PHONG-KEYS \?ELS157
	PRINTR	"""Phong keeps the house keys. Ask him."""
?ELS157:	EQUAL?	OBJ,GLOBAL-LINDER,LINDER,CORPSE \?ELS161
	ZERO?	MONICA-CLAMS-UP /?CND162
	PRINTI	"""What can I say? He"
	ZERO?	MONICA-SEEN-CORPSE? /?ELS170
	PRINTI	" wa"
	JUMP	?CND168
?ELS170:	PRINTI	"'"
?CND168:	PRINTR	"s my father, a hard-working, clever man."""
?CND162:	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	ZERO?	MONICA-SEEN-CORPSE? /?ELS184
	SET	'MONICA-HAS-MOTIVE,CORPSE
	PRINTI	"She rambles a bit, as if dreaming. ""To be honest, I feel relieved ... that he's met his Maker. Now I won't feel as if I'm under his thumb when he's home. He really treated all of us like ... his property, even Mother. I guess I'm an orphan now, but ... """
	PRINT	SHE-CLAMS-UP
	CRLF	
	RTRUE	
?ELS184:	SET	'MONICA-HAS-MOTIVE,LINDER
	CALL	DISCRETION,MONICA,LINDER
	PRINTI	"""Oh, I can tell you lots about him. Do you want to know if he was a good husband? A good father? Anything but a selfish ..."""
	PRINT	SHE-CLAMS-UP
	CRLF	
	RTRUE	
?ELS161:	EQUAL?	OBJ,GLOBAL-AFFAIR,GLOBAL-MRS-LINDER \?ELS193
	SET	'MONICA-HAS-MOTIVE,GLOBAL-MRS-LINDER
	CALL	DISCRETION,MONICA,LINDER
	ZERO?	MONICA-CLAMS-UP /?ELS198
	PRINTR	"""That's between Mother and me."""
?ELS198:	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTI	"""She was the most noble woman I've ever known. Did her best to be a 'good wife' even though she was alone so much. No one understood her as I did, certainly not Father. Sometimes I feel I could just ..."" She slams a clenched fist into her palm."
	PRINT	SHE-CLAMS-UP
	CRLF	
	RTRUE	
?ELS193:	EQUAL?	OBJ,GLOBAL-MURDER,DANGER \?ELS207
	ZERO?	MONICA-SEEN-CORPSE? \?ELS212
	PRINTR	"""What do you think this is, a cheap whodunit?"""
?ELS212:	ZERO?	MONICA-ADMITTED-HELPING? \?ELS216
	PRINTI	"""Isn't it obvious? That "
	CALL	TANDY?
	ZERO?	STACK /?ELS221
	PRINTI	"idiot"
	JUMP	?CND219
?ELS221:	PRINTI	"bastard"
?CND219:	PRINTR	" Stiles squibbed him off!"""
?ELS216:	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ACCUSE,MONICA,GLOBAL-MURDER
	RTRUE	
?ELS207:	EQUAL?	OBJ,GLOBAL-PHONG,PHONG \?ELS233
	CALL	DISCRETION,MONICA,PHONG
	PRINTI	"""He's a right gee, no matter what some people say about his "
	CALL	TANDY?
	ZERO?	STACK /?ELS238
	PRINTI	"kind"
	JUMP	?CND236
?ELS238:	PRINTI	"race"
?CND236:	PRINTR	"."""
?ELS233:	EQUAL?	OBJ,GLOBAL-STILES,STILES \?ELS248
	ZERO?	MONICA-ADMITTED-HELPING? /?ELS253
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTI	"""That poor "
	CALL	TANDY?
	ZERO?	STACK /?ELS259
	PRINTI	"idiot"
	JUMP	?CND257
?ELS259:	PRINTI	"bastard"
?CND257:	PRINTR	". First he fell in love with Mother, a married woman; then he actually trusted her husband. I don't know what he uses for brains."""
?ELS253:	ZERO?	MONICA-SEEN-CORPSE? /?ELS269
	PRINTI	"""That "
	CALL	TANDY?
	ZERO?	STACK /?ELS275
	PRINTI	"idiot"
	JUMP	?CND273
?ELS275:	PRINTI	"bastard"
?CND273:	PRINTR	" who killed Dad? I'd spit in his face if it was worth the trouble."""
?ELS269:	CALL	DISCRETION,MONICA,STILES
	PRINTR	"""Oh, that lover boy thinks he's a smooth apple, all right. If you ask me, he's just a harmless grifter."""
?ELS248:	EQUAL?	OBJ,PLAYER \?ELS289
	PRINTI	"""I don't know anything about you, but I "
	ZERO?	MONICA-SEEN-CORPSE? /?ELS294
	PRINTI	"had hoped you could"
	JUMP	?CND292
?ELS294:	PRINTI	"hope you can"
?CND292:	PRINTR	" help Dad."""
?ELS289:	EQUAL?	OBJ,GLOBAL-SUICIDE \?ELS305
	PRINTR	"""I don't want to talk about it."""
?ELS305:	EQUAL?	OBJ,GLOBAL-TERRY \?ELS309
	PRINTR	"""Terry's a good friend of mine, that's all."""
?ELS309:	EQUAL?	OBJ,WILL \?ELS313
	ZERO?	MONICA-SEEN-CORPSE? /?ELS318
	SET	'PHONG-HAS-MOTIVE,WILL
	CALL	DISCRETION,MONICA,PHONG
	PRINTR	"""Dad kept it in his bank safe. I'll bet Phong would like to see it."""
?ELS318:	PRINTR	"""You'll have to ask Dad about that."""
?ELS313:	EQUAL?	OBJ,FILE-CABINET \?ELS327
	PRINTR	"""That has nothing to do with why Dad asked you here."""
?ELS327:	EQUAL?	OBJ,CAT \?ELS331
	PRINTR	"""She's my cat. I named her Asta, because she's at least as smart as the dog in 'The Thin Man.'"""
?ELS331:	EQUAL?	OBJ,CLOCK-KEY \?ELS335
	IN?	CLOCK-KEY,MONICA \?ELS340
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTR	"""I don't know where Dad keeps it."""
?ELS340:	PRINTR	"""That's the only key for the clock. So what?"""
?ELS335:	EQUAL?	OBJ,GUN-RECEIPT \?ELS348
	PRINTR	"""What about it? It's no crime to get a little heat for self-protection."""
?ELS348:	EQUAL?	OBJ,INSIDE-GUN \?ELS352
	FSET?	INSIDE-GUN,TOUCHBIT \?ELS357
	PRINTR	"Monica has the wild look of a trapped animal. ""I can't understand why that heater was inside the clock."""
?ELS357:	PRINTR	"""I don't know what you're talking about."""
?ELS352:	EQUAL?	OBJ,MEDICAL-REPORT,TUMOR \?ELS365
	ZERO?	MONICA-SEEN-CORPSE? /?ELS368
	ZERO?	MONICA-ADMITTED-HELPING? /?ELS372
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ACCUSE,MONICA,GLOBAL-MURDER
	RTRUE	
?ELS372:	ZERO?	MONICA-SAW-MEDICAL-REPORT /?ELS375
	PRINTI	"""I already told you: Dad was about to kick the bucket anyway."""
	CRLF	
	JUMP	?CND366
?ELS375:	FCLEAR	MEDICAL-REPORT,INVISIBLE
	FCLEAR	TUMOR,INVISIBLE
	PRINTI	"""Dad gave "
	EQUAL?	OBJ,MEDICAL-REPORT \?ELS387
	PUSH	STR?109
	JUMP	?CND383
?ELS387:	PUSH	STR?110
?CND383:	PRINT	STACK
	PRINTI	"so I could try to understand what was wrong and what his chances were. Now I guess Stiles has ended Dad's pain."""
	CRLF	
	JUMP	?CND366
?ELS368:	CALL	DISCRETION,MONICA,LINDER
	ZERO?	MONICA-SAW-MEDICAL-REPORT /?ELS394
	PRINTI	"""I already told you: Dad's about to kick the bucket."""
	CRLF	
	JUMP	?CND366
?ELS394:	PRINTI	"""How did you find that? Dad gave it to me so I could try to understand what's wrong and what his chances are. They don't look good."" She looks alarmed."
	CRLF	
?CND366:	SET	'MONICA-SAW-MEDICAL-REPORT,TRUE-VALUE
	RTRUE	
?ELS365:	EQUAL?	OBJ,PIECE-OF-WIRE,CLOCK-WIRES,PIECE-OF-PUTTY \?ELS403
	ZERO?	MONICA-ADMITTED-HELPING? \?ELS403
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTR	"""Oh, uh, that's part of a timed lock I set up for the office."""
?ELS403:	EQUAL?	OBJ,OFFICE-BUTTON,CLOCK /?THN410
	EQUAL?	OBJ,POWDER,CLOCK-POWDER /?THN410
	EQUAL?	OBJ,PIECE-OF-WIRE,CLOCK-WIRES,PIECE-OF-PUTTY \?ELS409
	ZERO?	MONICA-ADMITTED-HELPING? /?ELS409
?THN410:	ZERO?	MONICA-SEEN-CORPSE? /?ELS418
	ZERO?	PLAYER-PUSHED-BUTTON /?ELS418
	SET	'MONICA-ADMITTED-HELPING?,TRUE-VALUE
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTR	"""You seem to have discovered Dad's little plot to frighten Stiles. Sure, I helped set it up for him. But I don't know what went wrong. He wasn't supposed to die!"" Her lower lip is quivering."
?ELS418:	EQUAL?	OBJ,OFFICE-BUTTON \?ELS424
	PRINTR	"""That's the butler's button, you cheesehead."""
?ELS424:	PRINTR	"""Phong really ought to do a better job of cleaning around here."""
?ELS409:	EQUAL?	OBJ,OUTSIDE-GUN \?ELS432
	ZERO?	MONICA-ADMITTED-HELPING? /?ELS437
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	PRINTR	"""That gat you found? Phong planted it so it would look as if Stiles used it."""
?ELS437:	ZERO?	MONICA-SEEN-CORPSE? /?ELS442
	CALL	DISCRETION,MONICA,STILES
	PRINTR	"""That gat you found? It must belong to Stiles."""
?ELS442:	PRINTR	"""I've never seen it before. It looks as if you don't take good care of it."""
?ELS432:	EQUAL?	OBJ,RECURSIVE-BOOK \?ELS451
	PRINTR	"""It's a swell mystery called 'Deadline.' I haven't figured it out yet."""
?ELS451:	EQUAL?	OBJ,TELEGRAM \?ELS455
	PRINTR	"""That must be the telegram Dad sent this morning."""
?ELS455:	EQUAL?	OBJ,STUB \?ELS459
	PRINTR	"""That looks like my ticket stub. I didn't know I dropped it."""
?ELS459:	EQUAL?	OBJ,GLOBAL-FILM \?ELS463
	ZERO?	FILM-SEEN /?ELS468
	PRINTR	"""It was called 'Dead End'. I don't think this Bogart guy is pretty enough to make it big."""
?ELS468:	PRINTR	"""I think we'll see 'Dead End'. Terry wants to check out this guy named Bogart."""
?ELS463:	PRINTI	"""I don't know anything about it, shamus."
	INC	'MONICA-QUESTIONS
	LESS?	6,MONICA-QUESTIONS \?CND480
	PRINTI	" And I'm really getting tired of your questions."
?CND480:	PRINTR	""""
?ELS106:	EQUAL?	PRSO,MONICA \?ELS488
	EQUAL?	PRSA,V?GOODBYE \?ELS488
	FSET	MONICA,TOUCHBIT
	PRINTR	"""If I never see you again, it's jake with me."""
?ELS488:	EQUAL?	PRSO,MONICA \?ELS494
	EQUAL?	PRSA,V?RUB \?ELS494
	FSET	MONICA,TOUCHBIT
	ZERO?	MONICA-TIED-TO \?ELS501
	CALL	MONICA-PUSHES
	RSTACK	
?ELS501:	PRINTR	"Monica writhes away from your touch and manages to kick you in the shin."
?ELS494:	EQUAL?	PRSO,MONICA \?ELS507
	EQUAL?	PRSA,V?ASK-FOR \?ELS507
	FSET	MONICA,TOUCHBIT
	ZERO?	MONICA-TIED-TO /?ELS514
	PRINTR	"""How can I give you anything when I'm tied up?"""
?ELS514:	EQUAL?	PRSI,INSIDE-GUN,GENERIC-GUN /?THN520
	EQUAL?	PRSI,PHONG-KEYS,GENERIC-KEY,CLOCK-KEY \FALSE
?THN520:	CALL	PERFORM,V?ASK-ABOUT,MONICA,PRSI
	RTRUE	
?ELS507:	EQUAL?	PRSO,MONICA \?ELS529
	SET	'OBJ,PRSI
	ZERO?	OBJ /?ELS529
	EQUAL?	PRSA,V?SEARCH-OBJECT-FOR,V?SEARCH /?THN526
?ELS529:	EQUAL?	PRSI,MONICA \?ELS525
	SET	'OBJ,PRSO
	ZERO?	OBJ /?ELS525
	EQUAL?	PRSA,V?TAKE \?ELS525
?THN526:	FSET	MONICA,TOUCHBIT
	ZERO?	MONICA-TIED-TO \?ELS536
	CALL	MONICA-PUSHES
	RSTACK	
?ELS536:	IN?	CLOCK-KEY,MONICA \?ELS538
	EQUAL?	PRSA,V?SEARCH /?THN541
	EQUAL?	OBJ,GENERIC-KEY,CLOCK-KEY \?ELS538
?THN541:	MOVE	CLOCK-KEY,PLAYER
	FCLEAR	CLOCK-KEY,INVISIBLE
	FSET	CLOCK-KEY,TOUCHBIT
	PRINTR	"You find a single key in Monica's pocket and take it."
?ELS538:	IN?	INSIDE-GUN,MONICA \FALSE
	EQUAL?	PRSA,V?SEARCH /?THN549
	EQUAL?	OBJ,GENERIC-GUN,INSIDE-GUN \FALSE
?THN549:	SET	'SEEN-MONICA-AT-CLOCK,TRUE-VALUE
	MOVE	INSIDE-GUN,PLAYER
	FCLEAR	INSIDE-GUN,INVISIBLE
	FSET	INSIDE-GUN,TOUCHBIT
	PRINTR	"You find a hand gun in Monica's pocket and take it."
?ELS525:	EQUAL?	PRSO,MONICA \?ELS556
	EQUAL?	PRSA,V?SHOW \?ELS556
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSI
	RTRUE	
?ELS556:	EQUAL?	PRSO,MONICA \?ELS560
	EQUAL?	PRSA,V?SLAP \?ELS560
	IN?	MONICA,MONICA-ROOM \?ELS560
	FSET	MONICA,TOUCHBIT
	PRINTR	"Monica screams, ""Leave me alone! I'll get over it! Please!"""
?ELS560:	EQUAL?	PRSA,V?SLAP \?ELS566
	ZERO?	MONICA-TIED-TO /?ELS566
	FSET	MONICA,TOUCHBIT
	PRINTR	"Monica's eyes are full of hate, and she says something unprintable."
?ELS566:	EQUAL?	PRSO,MONICA \?ELS572
	EQUAL?	PRSA,V?TIE-TO \?ELS572
	FSET	MONICA,TOUCHBIT
	ZERO?	MONICA-TIED-TO /?ELS577
	PRINTI	"She's already fastened to the "
	PRINTD	MONICA-TIED-TO
	PRINTR	"."
?ELS577:	ZERO?	CLOCK-FIXED /?ELS582
	FSET?	PRSI,FURNITURE \?ELS582
	IN?	HANDCUFFS,PLAYER \?ELS582
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	SET	'MONICA-TIED-TO,PRSI
	SET	'MONICA-TIED-WITH,HANDCUFFS
	PRINTI	"(with your handcuffs)"
	CRLF	
	JUMP	?CND575
?ELS582:	CALL	MONICA-PUSHES
	RTRUE	
?CND575:	ZERO?	MONICA-TIED-WITH /?ELS593
	MOVE	MONICA-TIED-WITH,PRSI
	FCLEAR	MONICA-TIED-WITH,TAKEBIT
	FSET	MONICA-TIED-WITH,NDESCBIT
	GET	GOAL-TABLES,MONICA-C
	PUT	STACK,GOAL-ENABLE,FALSE-VALUE
	GET	MOVEMENT-GOALS,MONICA-C
	ADD	STACK,MG-LENGTH
	PUT	MOVEMENT-GOALS,MONICA-C,STACK
	PRINTR	"She puts up a struggle, but you manage to do it."
?ELS593:	PRINTI	"There's nothing to tie her "
	PRINTR	"with!"
?ELS572:	EQUAL?	PRSO,MONICA \?ELS602
	EQUAL?	PRSA,V?TIE-WITH \?ELS602
	FSET	MONICA,TOUCHBIT
	ZERO?	MONICA-TIED-WITH /?ELS607
	PRINTI	"She's already fastened with the "
	PRINTD	MONICA-TIED-WITH
	PRINTR	"."
?ELS607:	ZERO?	CLOCK-FIXED /?ELS612
	EQUAL?	PRSI,HANDCUFFS \?ELS612
	CALL	FIND-FLAG,HERE,FURNITURE >X
	ZERO?	X /?PRD617
	PRINTI	"(to the "
	PRINTD	X
	PRINTI	")"
	CRLF	
	PUSH	X
	JUMP	?CND615
?PRD617:	PUSH	0
?CND615:	SET	'MONICA-TIED-TO,STACK
	JUMP	?CND605
?ELS612:	CALL	MONICA-PUSHES
	RTRUE	
?CND605:	ZERO?	MONICA-TIED-TO /?ELS628
	SET	'MONICA-CLAMS-UP,TRUE-VALUE
	SET	'MONICA-TIED-WITH,PRSI
	MOVE	PRSI,MONICA-TIED-TO
	FCLEAR	PRSI,TAKEBIT
	FSET	PRSI,NDESCBIT
	GET	GOAL-TABLES,MONICA-C
	PUT	STACK,GOAL-ENABLE,FALSE-VALUE
	GET	GOAL-TABLES,MONICA-C
	PUT	STACK,ATTENTION-SPAN,999
	PRINTR	"She puts up a struggle, but you manage to do it."
?ELS628:	PRINTI	"There's nothing to "
	EQUAL?	PRSI,HANDCUFFS \?ELS640
	PUSH	STR?111
	JUMP	?CND636
?ELS640:	PUSH	STR?112
?CND636:	PRINT	STACK
	PRINTR	"her to!"
?ELS602:	EQUAL?	PRSA,V?UNTIE \?ELS644
	ZERO?	MONICA-TIED-TO \?ELS649
	PRINTR	"She's not even tied up!"
?ELS649:	ZERO?	PRSI /?ELS653
	EQUAL?	PRSI,MONICA-TIED-TO /?ELS653
	PRINTI	"She's not fastened to the "
	PRINTD	PRSI
	PRINTR	"!"
?ELS653:	MOVE	MONICA-TIED-WITH,PLAYER
	PRINTI	"Monica rubs her wrists as you take the "
	PRINTD	MONICA-TIED-WITH
	PRINTI	"."
	ZERO?	FINGERPRINT-OBJ \?CND662
	ZERO?	DUFFY-AT-CORONER \?CND662
	PRINTI	" Her eyes dart from door to door, then she bolts for the hallway. But, within seconds, Sgt. Duffy brings her back."
?CND662:	CALL	RELEASE-MONICA
	PRINTR	" She refuses to look at you."
?ELS644:	EQUAL?	PRSA,V?TAKEOUT \?ELS672
	EQUAL?	PRSI,LINDER-BACK-DOOR,MONICA-BACK-DOOR,OFFICE-BACK-DOOR \?ELS672
	ZERO?	MONICA-TIED-TO /?ELS679
	PRINTI	"You can't take her and the "
	PRINTD	MONICA-TIED-TO
	PRINTR	" both!"
?ELS679:	CALL	MONICA-PUSHES
	RSTACK	
?ELS672:	EQUAL?	PRSA,V?ARREST \FALSE
	CALL	ARREST,MONICA
	RSTACK	


	.FUNCT	MONICA-PUSHES
	PRINTI	"Monica pushes you away with surprising strength. ""I don't know what game you're playing, Detective, but count me out. If you think I'm just a dumb twi"
	CALL	TANDY?
	ZERO?	STACK \?CND3
	PRINTI	"s"
?CND3:	PRINTR	"t, think again."" Her eyes burn like polished gems."


	.FUNCT	RELEASE-MONICA
	SET	'MONICA-TIED-TO,FALSE-VALUE
	SET	'MONICA-TIED-WITH,FALSE-VALUE
	FSET	MONICA-TIED-WITH,TAKEBIT
	FCLEAR	MONICA-TIED-WITH,NDESCBIT
	RTRUE	


	.FUNCT	CAT-F
	EQUAL?	PRSA,V?KICK \?ELS5
	PRINTR	"Like a fly, the cat springs up just in time, then goes to a different corner to settle down."
?ELS5:	EQUAL?	PRSA,V?HELLO,V?RUB \FALSE
	PRINTR	"The cat purrs a little louder and curls one paw."


	.FUNCT	GLOBAL-PERSON,?TMP1
	EQUAL?	PRSA,V?PHONE,V?$CALL,V?FOLLOW /FALSE
	EQUAL?	PRSA,V?WAIT-FOR,V?FIND,V?WHAT /FALSE
	EQUAL?	PRSA,V?TELL-ME,V?ASK-ABOUT \?ELS9
	ZERO?	PRSO /?ELS9
	FSET?	PRSO,PERSON \?ELS15
	IN?	PRSO,GLOBAL-OBJECTS \FALSE
?ELS15:	EQUAL?	PRSO,GLOBAL-DUFFY /FALSE
?ELS9:	EQUAL?	PRSA,V?TELL \?ELS17
	PRINTI	"You can't speak to someone who isn't here."
	CRLF	
	SET	'P-CONT,FALSE-VALUE
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?ARREST \?ELS21
	EQUAL?	PRSO,GLOBAL-LINDER \?ELS26
	CALL	ARREST,GLOBAL-LINDER
	RSTACK	
?ELS26:	GETP	PRSO,P?CHARACTER
	GET	CHARACTER-TABLE,STACK
	CALL	ARREST,STACK
	RSTACK	
?ELS21:	EQUAL?	PRSA,V?TELL-ME,V?ASK-ABOUT /?THN34
	ZERO?	NOW-PRSI \?ELS33
?THN34:	PRINTD	PRSO
	JUMP	?CND31
?ELS33:	PRINTD	PRSI
?CND31:	EQUAL?	PRSA,V?ASK-FOR,V?ASK-ABOUT,V?GOODBYE /?THN47
	EQUAL?	PRSA,V?HELLO,V?TELL,V?$CALL \?ELS44
?THN47:	GETP	PRSO,P?CHARACTER
	GET	CHARACTER-TABLE,STACK
	LOC	STACK
	GETP	STACK,P?CORRIDOR >?TMP1
	GETP	HERE,P?CORRIDOR
	BAND	?TMP1,STACK
	ZERO?	STACK /?ELS44
	PRINTI	" can't hear you."
	CRLF	
	JUMP	?CND42
?ELS44:	PRINTI	" isn't here!"
	CRLF	
?CND42:	SET	'P-CONT,FALSE-VALUE
	RTRUE	


	.FUNCT	GLOBAL-MRS-LINDER-F
	EQUAL?	PRSA,V?FOLLOW \?ELS5
	PRINTR	"You will eventually, shamus, you will."
?ELS5:	EQUAL?	PRSA,V?PHONE,V?$CALL \FALSE
	PRINTR	"You're not with her yet."


	.FUNCT	HINT-F
	EQUAL?	PRSA,V?ASK-FOR \?ELS9
	EQUAL?	PRSO,GLOBAL-DUFFY \?THN6
?ELS9:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSI,GLOBAL-DUFFY /FALSE
?THN6:	PRINTR	"You'll have to be more specific."


	.FUNCT	GLOBAL-DUFFY-F
	EQUAL?	PRSA,V?PHONE \?ELS5
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS5
	CALL	PHONE-IN?,HERE
	ZERO?	STACK /?ELS5
	ZERO?	SEEN-DUFFY? /?ELS12
	PRINTR	"Duffy must be around here somewhere. There's no point in trying to phone him."
?ELS12:	PRINTR	"The night clerk at the station says he'll give Duffy your message."
?ELS5:	ZERO?	SEEN-DUFFY? \?ELS21
	PRINTI	"Sergeant Duffy is probably at the station, working late as usual."
	CRLF	
	RETURN	2
?ELS21:	EQUAL?	PRSA,V?WAIT-FOR \?ELS27
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS27
	ZERO?	FINGERPRINT-OBJ \?THN35
	ZERO?	DUFFY-AT-CORONER \?THN35
	ZERO?	MET-DUFFY? \?ELS34
?THN35:	CALL	V-WAIT,10000,PRSO
	RSTACK	
?ELS34:	PRINTR	"You'd wait quite a while, since Sergeant Duffy is always nearby but never approaches you without a good reason."
?ELS27:	ZERO?	FINGERPRINT-OBJ \?THN43
	ZERO?	DUFFY-AT-CORONER /?ELS42
?THN43:	CALL	DO-FINGERPRINT
	RETURN	2
?ELS42:	EQUAL?	PRSA,V?SHOOT,V?ARREST \?ELS48
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS48
	PRINTI	"Oh, come on now! Not trusty "
	PRINTD	PRSO
	PRINTR	"!"
?ELS48:	EQUAL?	PRSA,V?FIND \?ELS54
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS54
	PRINTR	"Like a lurking grue in the dark places of the earth, Sergeant Duffy is never far from the scene of a crime. If you witness a crime, you can be sure he'll show up soon. Then, if you ANALYZE something, he will appear in an instant to take it to the lab. When the results are available, he will rush them back to you. If you ARREST someone, he will be there with the handcuffs. You can't find a more dedicated civil servant."
?ELS54:	EQUAL?	PRSA,V?FOLLOW \?ELS60
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS60
	ZERO?	DUFFY-WITH-STILES /?ELS67
	CALL	PERFORM,PRSA,STILES,PRSI
	RTRUE	
?ELS67:	PRINTR	"Duffy is too quick to follow."
?ELS60:	ZERO?	MET-DUFFY? \?ELS74
	CALL	I-MEET-DUFFY?
	ZERO?	STACK \TRUE
	PRINTR	"It looks as though Duffy didn't hear you."
?ELS74:	EQUAL?	PRSA,V?$CALL \?ELS81
	EQUAL?	PRSO,GLOBAL-DUFFY /FALSE
?ELS81:	EQUAL?	WINNER,GLOBAL-DUFFY \?ELS85
	EQUAL?	PRSA,V?MAKE,V?SANALYZE,V?ANALYZE \?ELS90
	SET	'WINNER,PLAYER
	CALL	PERFORM,PRSA,PRSO,PRSI
	RTRUE	
?ELS90:	EQUAL?	PRSA,V?ARREST \?ELS92
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ARREST,PRSO
	RTRUE	
?ELS92:	EQUAL?	PRSA,V?THANKS,V?FIND /FALSE
	EQUAL?	PRSA,V?GIVE \?ELS100
	EQUAL?	PRSO,HINT \?ELS100
	EQUAL?	PRSI,PLAYER /?THN97
?ELS100:	EQUAL?	PRSA,V?SGIVE \?ELS96
	EQUAL?	PRSI,HINT \?ELS96
	EQUAL?	PRSO,PLAYER \?ELS96
?THN97:	CALL	DUFFY-HINT
	RSTACK	
?ELS96:	EQUAL?	PRSA,V?TAKE \?ELS104
	PRINTI	"Duffy"
	ZERO?	DUFFY-WITH-STILES \?CND107
	PRINTI	" appears for an instant but"
?CND107:	PRINTR	" politely declines your offer."
?ELS104:	EQUAL?	PRSA,V?PHONE \?ELS115
	EQUAL?	PRSO,CORONER \?ELS115
	ZERO?	DUFFY-WITH-STILES /?ELS122
	PRINTR	"""I will, as soon as I case the joint."""
?ELS122:	PRINTR	"""Oh, I called the coroner as soon as I saw the body. They'll be here as soon as they have time."""
?ELS115:	EQUAL?	PRSO,STILES \?ELS131
	EQUAL?	PRSA,V?UNTIE \?ELS131
	PRINTR	"""What?? I won't release a suspect!"""
?ELS131:	CALL	COM-CHECK,GLOBAL-DUFFY
	ZERO?	STACK \TRUE
	PRINTR	"""With all respect, I think you should do that yourself."""
?ELS85:	EQUAL?	PRSA,V?ASK-ABOUT \?ELS143
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS143
	ZERO?	DUFFY-WITH-STILES \?CND146
	PRINTI	"Duffy appears for a moment. "
?CND146:	PRINTI	""""
	EQUAL?	PRSI,CORONER \?ELS155
	LESS?	PRESENT-TIME,720 \?ELS155
	PRINTI	"Oh, I called the coroner as soon as I saw the body. They'll be here as soon as they have time."
	JUMP	?CND153
?ELS155:	EQUAL?	PRSI,CORONER,AUTOPSY \?ELS161
	ZERO?	DUFFY-AT-CORONER \?THN165
	LESS?	PRESENT-TIME,720 \?ELS164
?THN165:	PRINTI	"Oh, I called the coroner as soon as I saw the body. They'll be here as soon as they have time."
	JUMP	?CND153
?ELS164:	PRINTI	"I thought I told you already. The coroner "
	ZERO?	DUFFY-SAW-MEDICAL-REPORT /?CND173
	PRINTI	"found no evidence of the alleged stomach tumor. In fact, he could find no organic disease that would either explain the death or support the theory that Linder wanted to die. He "
?CND173:	PRINTI	"concluded that Linder died of a single small-caliber bullet through the heart. And here's something peculiar: there were no traceable rifle marks on the bullet."
	JUMP	?CND153
?ELS161:	EQUAL?	PRSI,GLOBAL-DUFFY \?ELS182
	PRINTI	"Come off it, Detective. We've worked together before. You sure you didn't stop at a bar tonight?"
	JUMP	?CND153
?ELS182:	EQUAL?	PRSI,BATHTUB,TUB-ROOM \?ELS186
	PRINTI	"Ah, that's where the late Mrs. Linder did herself in. A messy business, Detective."
	JUMP	?CND153
?ELS186:	EQUAL?	PRSI,GLOBAL-SUICIDE \?ELS190
	PRINTI	"She shot herself in the bathtub."
	JUMP	?CND153
?ELS190:	EQUAL?	PRSI,GUN-RECEIPT \?ELS194
	PRINTI	"Oh, I know that place, Fritzi's. Untidy, but clean."
	JUMP	?CND153
?ELS194:	EQUAL?	PRSI,MEDICAL-REPORT \?ELS198
	SET	'DUFFY-SAW-MEDICAL-REPORT,TRUE-VALUE
	PRINTI	"Fascinating! It could have been a suicide, then."
	JUMP	?CND153
?ELS198:	EQUAL?	PRSI,RECURSIVE-BOOK \?ELS202
	PRINTI	"Ah, Connecticut! I have relations there, you know. In fact, one young one wants to be a detective some day."
	JUMP	?CND153
?ELS202:	PRINTI	"I wish I could help you, Detective."
?CND153:	PRINTI	""""
	ZERO?	DUFFY-WITH-STILES \?CND211
	PRINTI	" He scurries off again."
?CND211:	CRLF	
	RTRUE	
?ELS143:	EQUAL?	PRSA,V?ASK-FOR \?ELS217
	EQUAL?	PRSI,HINT \?ELS217
	CALL	DUFFY-HINT
	RSTACK	
?ELS217:	EQUAL?	PRSA,V?GIVE \?ELS225
	EQUAL?	PRSI,GLOBAL-DUFFY /?THN222
?ELS225:	EQUAL?	PRSA,V?SGIVE \?ELS221
	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS221
?THN222:	PRINTI	"Duffy"
	ZERO?	DUFFY-WITH-STILES \?CND230
	PRINTI	" appears for an instant but"
?CND230:	PRINTR	" politely declines your offer."
?ELS221:	EQUAL?	PRSA,V?GOODBYE \?ELS238
	PRINTR	"""You can't leave yet, Detective. Think of your reputation!"""
?ELS238:	EQUAL?	PRSA,V?HELLO \?ELS242
	ZERO?	DUFFY-WITH-STILES /?ELS247
	PRINTR	"""Hello again, Detective."""
?ELS247:	PRINTR	"Duffy peeks around a corner, tips his hat to you, and disappears again."
?ELS242:	EQUAL?	PRSO,GLOBAL-DUFFY \?ELS256
	EQUAL?	PRSA,V?SHOW \?ELS256
	CALL	PERFORM,V?ASK-ABOUT,PRSO,PRSI
	RTRUE	
?ELS256:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,HINT \FALSE
	EQUAL?	PRSI,GLOBAL-DUFFY \FALSE
	CALL	DUFFY-HINT
	RSTACK	


	.FUNCT	COM-CHECK,PER
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?SHOW,PER,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?FOLLOW \?ELS7
	EQUAL?	PRSO,PLAYER \?ELS7
	PRINTR	"""I would rather not."""
?ELS7:	EQUAL?	PRSA,V?GIVE \?ELS13
	EQUAL?	PRSI,PLAYER \?ELS13
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?TAKE,PRSO,PER
	RTRUE	
?ELS13:	EQUAL?	PRSA,V?SGIVE \?ELS17
	EQUAL?	PRSO,PLAYER \?ELS17
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?TAKE,PRSI,PER
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?GOODBYE \?ELS21
	ZERO?	PRSO /?THN24
	EQUAL?	PRSO,PER \?ELS21
?THN24:	SET	'WINNER,PLAYER
	CALL	PERFORM,V?GOODBYE,WINNER
	RTRUE	
?ELS21:	EQUAL?	PRSA,V?HELLO \?ELS27
	ZERO?	PRSO /?THN30
	EQUAL?	PRSO,PER \?ELS27
?THN30:	SET	'WINNER,PLAYER
	CALL	PERFORM,V?HELLO,PER
	RTRUE	
?ELS27:	EQUAL?	PRSA,V?HELP \?ELS33
	EQUAL?	PRSO,PLAYER /?THN39
	ZERO?	PRSO \?ELS38
?THN39:	CALL	PERFORM,V?GIVE,HINT,PLAYER
	RTRUE	
?ELS38:	FSET?	PRSO,PERSON \FALSE
	PRINTR	"""I don't need your help."""
?ELS33:	EQUAL?	PRSA,V?INVENTORY \?ELS48
	PRINTI	""""
	PRINTI	"You're the detective!"
	PRINTR	""""
?ELS48:	EQUAL?	PRSA,V?SHOW \?ELS52
	EQUAL?	PRSO,PLAYER \?ELS52
	PRINTR	"""I'm sure you can find it, Detective."""
?ELS52:	EQUAL?	PRSA,V?TELL-ME \?ELS58
	EQUAL?	PRSO,PLAYER \?ELS58
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,PER,PRSI
	RTRUE	
?ELS58:	EQUAL?	PRSA,V?WAIT /?THN63
	EQUAL?	PRSA,V?WAIT-FOR \?ELS62
	EQUAL?	PRSO,PLAYER \?ELS62
?THN63:	SET	'WINNER,PLAYER
	CALL	PERFORM,V?$CALL,PER
	RTRUE	
?ELS62:	EQUAL?	PRSA,V?WHAT \FALSE
	SET	'WINNER,PLAYER
	CALL	PERFORM,V?ASK-ABOUT,PER,PRSO
	RTRUE	


	.FUNCT	DESCRIBE-PERSON,PERSON,STR=0
	PRINTD	PERSON
	PRINTI	" is "
	ZERO?	STR \?ELS7
	PUSH	STR?118
	JUMP	?CND3
?ELS7:	PUSH	STR
?CND3:	PRINT	STACK
	PRINTR	"."


	.FUNCT	DISCRETION,P1,P2,P3=0
	CALL	META-LOC,P2
	EQUAL?	HERE,STACK \?ELS5
	ZERO?	P3 /?ELS5
	CALL	META-LOC,P3
	EQUAL?	HERE,STACK \?ELS5
	PRINTD	P1
	PRINTI	" looks briefly toward "
	PRINTD	P2
	PRINTI	" and "
	PRINTD	P3
	PRINTR	" and then speaks in a whisper."
?ELS5:	CALL	META-LOC,P2
	EQUAL?	HERE,STACK \?ELS11
	PRINTD	P1
	PRINTI	" looks briefly toward "
	PRINTD	P2
	PRINTR	" and then speaks in a whisper."
?ELS11:	ZERO?	P3 /FALSE
	CALL	META-LOC,P3
	EQUAL?	HERE,STACK \FALSE
	PRINTD	P1
	PRINTI	" looks briefly toward "
	PRINTD	P3
	PRINTR	" and then speaks in a whisper."


	.FUNCT	INHABITED?,RM
	CALL	POPULATION,RM
	ZERO?	STACK /FALSE
	RTRUE	


	.FUNCT	POPULATION,RM,PR=0,CNT=0,OBJ
	FIRST?	RM >OBJ /?CND1
	RETURN	CNT
?CND1:	
?PRG4:	FSET?	OBJ,PERSON \?ELS8
	FSET?	OBJ,INVISIBLE /?ELS8
	INC	'CNT
	ZERO?	PR /?CND6
	CALL	DESCRIBE-PERSON,OBJ,STR?119
	JUMP	?CND6
?ELS8:	FSET?	OBJ,CONTBIT \?CND6
	CALL	POPULATION,OBJ,PR
	ADD	CNT,STACK >CNT
?CND6:	NEXT?	OBJ >OBJ /?KLU20
?KLU20:	ZERO?	OBJ \?PRG4
	RETURN	CNT


	.FUNCT	RANDOM-SHOES-F,OBJ
	SET	'OBJ,PRSO
	ZERO?	OBJ /?ELS9
	EQUAL?	PRSA,V?TAKE,V?GIVE /?THN6
?ELS9:	SET	'OBJ,PRSI
	ZERO?	OBJ /?ELS5
	EQUAL?	PRSA,V?SGIVE,V?SEARCH-OBJECT-FOR,V?ASK-FOR \?ELS5
?THN6:	EQUAL?	OBJ,PHONG-SHOES \?ELS16
	CALL	PHONG-FIGHTS
	RSTACK	
?ELS16:	EQUAL?	OBJ,MONICA-SHOES \?ELS18
	ZERO?	MONICA-TIED-TO \?ELS23
	CALL	MONICA-PUSHES
	RSTACK	
?ELS23:	PRINTR	"Monica writhes away from your touch and manages to kick you in the shin."
?ELS18:	EQUAL?	OBJ,STILES-SHOES \?ELS29
	PRINTR	"""Please don't take them! I'm cold enough as it is!"""
?ELS29:	EQUAL?	OBJ,LINDER-SHOES \FALSE
	LOC	LINDER
	ZERO?	STACK /?ELS38
	PRINTR	"""I'm beginning to wonder if I got a decent detective or not!"""
?ELS38:	CALL	TANDY?
	ZERO?	STACK /?ELS42
	PRINTR	"You can't be that desperate!"
?ELS42:	PRINTR	"Necrophilia went out with raccoon coats!"
?ELS5:	EQUAL?	PRSA,V?PUT,V?COMPARE \?ELS50
	EQUAL?	PRSO,BACK-FOOTPRINTS-CAST /?THN55
	EQUAL?	PRSO,BACK-FOOTPRINTS,SIDE-FOOTPRINTS-CAST,SIDE-FOOTPRINTS /?THN57
?THN55:	EQUAL?	PRSI,BACK-FOOTPRINTS-CAST /?THN57
	EQUAL?	PRSI,BACK-FOOTPRINTS,SIDE-FOOTPRINTS-CAST,SIDE-FOOTPRINTS \?ELS50
?THN57:	PRINTI	"The shoes don't seem to match "
	PRINTI	"the foot prints that you found in the "
	PRINTR	"yard."
?ELS50:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	PRSO,LINDER-SHOES,PHONG-SHOES \?ELS67
	PRINTR	"They're straw slippers with thongs, clean and obviously comfortable."
?ELS67:	EQUAL?	PRSO,STILES-SHOES \?ELS71
	PRINTR	"They're pointed wing tips with sensational welt features, but a bit shabby and more than a bit muddy."
?ELS71:	EQUAL?	PRSO,MONICA-SHOES \FALSE
	PRINTR	"They're tan pumps with Cuban heels, clean and stylish."

	.ENDI
