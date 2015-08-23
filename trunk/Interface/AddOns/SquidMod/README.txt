--------------------------------------------------
          SquidMod - the Griffon Killer
          
           author:      SAM
           Thanx to:    Vjeux
                        Ecksen
                        SinfulCreature
          
         www.asymmetric-art.com/SquidMod/
--------------------------------------------------
--------------------------------------------------
                     Content
--------------------------------------------------

1. Installing the AddOn
2. Using the AddOn
3. Using the Photoshop templates

--------------------------------------------------
            1. Installing the AddOn
--------------------------------------------------

Install location:
World_of_Warcraft/Interface/AddOns/

Place the SquidMod folder in your AddOns directory
which is located in the Interface directory which
should be in the same directory as your World of
Warcraft directory.

If you don't have an Interface folder/directory
or an AddOn directory, you can simply create new
once.

If the SquidMod AddOn loaded properly you should
see a text message stating that SquidMod has loaded
when you log into the game.

--------------------------------------------------
               2. Using the AddOn
--------------------------------------------------

type /squid in your chat to get a list of available
commands.

These commands are listed here:

/squid toggle    Toggles the graphics
/squid hide      Hides the end cap graphics
/squid unhide    Shows the end cap graphics

/squid octopus   A squid
/squid griffon   The default graphic
/squid lion      Made by Blizzard
/squid murloc1   Dead murloc
/squid murloc2   Murloc female watching her eggs
/squid skull     Scary
/squid whelp     Dragon whelp
/squid emblem    Guild Emblem Template
/squid human     Racial theme for the humans
/squid dwarf     Racial theme for the dwarfs
/squid gnome     Racial theme for the gnomes
/squid nightelf  Racial theme for the night-elfs
/squid orc       Racial theme for the orcs
/squid troll     Racial theme for the trolls
/squid tauren    Racial theme for the tauren
/squid forsaken  Racial theme for the forsaken
/squid guardian  Guardian (created by SinfulCreature)

If you don't want to type /squid toggle so many
times, you can simply create a macro with this
single line in it:

/squid toggle

Place the macro button on your hotbar and simply
click it to toggle the graphics.

--------------------------------------------------
        3. Using the Photoshop templates
--------------------------------------------------

Note: the template files are supplied "as is".
If you can't figure out how to use them after
reading this README - do NOT contact me with
questions. Any requests of such nature will
be ignored.

If you want to display your own grahics in the
"emblem" end caps, there are two template files
supplied with this AddOn.

emblemTemplate1.psd
emblemTemplate2.psd

These templates are in photoshop format so all
you need to do is open them up in photoshop and
replace the default layer with your own graphic,
flatten the layers and save as a Targa [.tga]
file.

Note: some versions of Photoshop has very poor
Targa support - so you may need to find another
piece of software to do the conversion from
Photoshop to Targa. I use the Gimp to do the
conversion as Photoshop Elements 2 doesn't handle
targa and transparensy all too well.

Note: The file you create need to be renamed

'emblemLeft.tga' or 'emblemRight.tga'

and placed in your SquidMod/skin/ folder. You will
need to overwrite the existing 2 files with the
same name.

If you name it emblemLeft.tga it will replace
the left end cap. If you name it emblemright.tga
it will replace the right end cap.

to enable your emblem graphics type

/squid emblem

If you have done everything right - your graphics
will replace the current endcap graphics.

Possible problems and solutions:

Problem: Your images does not show up - just the
default once with the octopus and SquidMod banner
show up.

Solution: Make sure your files have the correct
names: emblemLeft.tga and emblemRight.tga.
The filenames are case-sensitive. you need to
replace the default once.

Problem: Only a green sqare turns up (one or two).

Solution: Make sure your SquidMod folder contains
the files emblemLeft.tga and emblemRight.tga
and that these files are really in Targa-format
You can't use a photoshop file and just rename
the file-suffix.

Problem: Your image shows up - but the parts
that are supposed to be transparent are not.

Solution: The alpha channel of the targa file
is screwed up. Problem is with the software you
used to create the targa file. Do the conversion
from photoshop to targa in some other application
which has better Targa support.

Problem: The right emblem is a mirror image?

Solution: Yes it is. If you want to have letters
or text or a logo or graphic that need to have
a certain orientation - you need to mirror it
before you save the targa - do not mirror the
entire image! Just the layer - otherwise it
won't work.