/obj/item/weapon/diseasedisk
	name = "Blank GNA disk"
	icon = 'cloning.dmi'
	icon_state = "datadisk2"
	w_class = 1
	var/datum/disease2/effect/effect = null

/obj/item/weapon/diseasedisk/premade/New()
	name = "GNA disk (Waiting Syndrome)"
	effect = new /datum/disease2/effect/invisible

/obj/item/weapon/virusdish
	name = "Virus containment/growth dish"
	icon = 'items.dmi'
	icon_state = "implantcase-b"
	var/datum/disease2/disease/virus2 = null
	var/growth = 0
	var/info = 0
	var/analysed = 0

/obj/item/weapon/virusdish/attackby(var/obj/item/weapon/W as obj,var/mob/living/carbon/user as mob)
	if(istype(W,/obj/item/weapon/hand_labeler))
		return
	..()
	if(prob(50))
		user << "The dish shatters"
		if(virus2.infectionchance > 0)
			infect_virus2(user,virus2)
		del src

/obj/item/weapon/virusdish/examine()
	usr << "This is a virus containment dish"
	if(src.info)
		usr << "It has the following information about its contents"
		usr << src.info

/obj/item/weapon/storage/disease_diskbox
	name = "GNA Diskette Box"
	icon_state = "disk_kit"
	item_state = "syringe_kit"

/obj/item/weapon/storage/disease_diskbox/New()
	..()
	new /obj/item/weapon/diseasedisk(src)
	new /obj/item/weapon/diseasedisk(src)
	new /obj/item/weapon/diseasedisk(src)
	new /obj/item/weapon/diseasedisk(src)
	new /obj/item/weapon/diseasedisk(src)
	new /obj/item/weapon/diseasedisk(src)
	new /obj/item/weapon/diseasedisk/premade(src)


/obj/item/weapon/book/manual/virology
	name = "How to grow your own virus(UNFINISHED)"
	icon_state ="bookCloning"
	author = "Mitrofey Sviridov, CMO of Delta-7"		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned

//big pile of shit below.

	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<H3>How to grow your own virus</H3>
				So there�s full station of peoples who infected with GBS, there are too many monkeys or you just want to make your own little virus? No problem! This guide is intended to teach you how to grow virus, make vaccine for it, deal with infected and how to do it right, in a simple step-by-step process! If at any point of the guide you have a mental meltdown, virology probably is too hard for you and you should get a job-change as soon as possible before you get your first virus outbreak. And yes, English is not my language so there can be some errors in the text.

				<ol>
					<li><a href='#1'>Working Place</a></li>
					<li><a href='#2'>How to easely get virus sample</a></li>
					<li><a href='#3'>Getting isolated colony of viruses</a></li>
					<li><a href='#4'>Feeding of your new friends</a></li>
					<li><a href='#5'>Getting information about what you get</a></li>
					<li><a href='#6'>How to produse vaccine</a></li>
					<li><a href='#7'>How to change virus and produse it</a></li>
				</ol>

				<a name='1'><H4>Step 1: Acquire body</H4>
				This is pretty much vital for the process because without a body, you cannot clone it. Usually, bodies will be brought to you, so you do not need to worry so much about this step. If you already have a body, great! Move on to the next step.

				<a name='2'><H4>Step 2: Strip body</H4>
				The cloning machine does not like abiotic items. What this means is you can�t clone anyone if they�re wearing clothes, so take all of it off. If it�s just one person, it�s courteous to put their possessions in the closet. If you have about seven people awaiting cloning, just leave the piles where they are, but don�t mix them around and for God�s sake don�t let the Clown in to steal them.

				<a name='3'><H4>Step 3: Put body in cloning machine</H4>
				Grab the body and then put it inside the DNA modifier. If you cannot do this, then you messed up at Step 2. Go back and check you took EVERYTHING off - a commonly missed item is their headset.

				<a name='4'><H4>Step 4: Scan body</H4>
				Go onto the computer and scan the body by pressing �Scan - <Subject Name Here>�. If you�re successful, they will be added to the records (note that this can be done at any time, even with living people, so that they can be cloned without a body in the event that they are lying dead on port solars and didn�t turn on their suit sensors)! If not, and it says �Error: Mental interface failure.�, then they have left their bodily confines and are one with the spirits. If this happens, just shout at them to get back in their body, click �Refresh� and try scanning them again. If there�s no success, threaten them with gibbing. Still no success? Skip over to Step 7 and don�t continue after it, as you have an unresponsive body and it cannot be cloned. If you got �Error: Unable to locate valid genetic data.�, you are trying to clone a monkey - start over.

				<a name='5'><H4>Step 5: Clone body</H4>
				Now that the body has a record, click �View Records�, click the subject�s name, and then click �Clone� to start the cloning process. Congratulations! You�re halfway there. Remember not to �Eject� the cloning pod as this will kill the developing clone and you�ll have to start the process again.

				<a name='6'><H4>Step 6: Get clean SEs for body</H4>
				Cloning is a finicky and unreliable process. Whilst it will most certainly bring someone back from the dead, they can have any number of nasty disabilities given to them during the cloning process! For this reason, you need to prepare a clean, defect-free Structural Enzyme (SE) injection for when they�re done. If you�re a competent Geneticist, you will already have one ready on your working computer. If, for any reason, you do not, then eject the body from the DNA modifier (NOT THE CLONING POD) and take it next door to the Genetics research room. Put the body in one of those DNA modifiers and then go onto the console. Go into View/Edit/Transfer Buffer, find an open slot and click �SE� to save it. Then click �Injector� to get the SEs in syringe form. Put this in your pocket or something for when the body is done.

				<a name='7'><H4>Step 7: Put body in morgue</H4>
				Now that the cloning process has been initiated and you have some clean Structural Enzymes, you no longer need the body! Drag it to the morgue and tell the Chef over the radio that they have some fresh meat waiting for them in there. To put a body in a morgue bed, simply open the tray, grab the body, put it on the open tray, then close the tray again. Use one of the nearby pens to label the bed �CHEF MEAT� in order to avoid confusion.

				<a name='8'><H4>Step 8: Await cloned body</H4>
				Now go back to the lab and wait for your patient to be cloned. It won�t be long now, I promise.

				<a name='9'><H4>Step 9: Use the clean SE injector on person</H4>
				Has your body been cloned yet? Great! As soon as the guy pops out, grab your injector and jab it in them. Once you�ve injected them, they now have clean Structural Enzymes and their defects, if any, will disappear in a short while.

				<a name='10'><H4>Step 10: Give person clothes back</H4>
				Obviously the person will be naked after they have been cloned. Provided you weren�t an irresponsible little shit, you should have protected their possessions from thieves and should be able to give them back to the patient. No matter how cruel you are, it�s simply against protocol to force your patients to walk outside naked.

				<a name='11'><H4>Step 11: Send person on their way</H4>
				Give the patient one last check-over - make sure they don�t still have any defects and that they have all their possessions. Ask them how they died, if they know, so that you can report any foul play over the radio. Once you�re done, your patient is ready to go back to work! Chances are they do not have Medbay access, so you should let them out of Genetics and the Medbay main entrance.

				<p>If you�ve gotten this far, congratulations! You have mastered the art of cloning. Now, the real problem is how to resurrect yourself after that traitor had his way with you for cloning his target.



				</body>
				</html>
				"}
