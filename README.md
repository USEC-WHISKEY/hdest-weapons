<p align="center">
	<img src="static/coverimage.png?raw=true">
</p>

# Bryan's Weapons

What was originally intended as a library for creating Hideous Destructor weapons has turned into a modern tactical weapons pack. These weapons come with the benefit of some modularity, allowing for weapon attachments such as scopes, muzzle, and miscellaneous attachments such as a flashlight. 

## How to play

This mod requires GZdoom. 

GZDoom: https://zdoom.org/index

Hideous Destructor: https://github.com/MatthewTheGlutton/HideousDestructor

If you aren't using `git` you can download this repository as a ZIP via the green code button at the top of this page.

![cloneimage](static/cloneimage.png?raw=true)

Otherwise, clone the repository:

```
git clone https://github.com/abramsba/bryan-hdest-weapons.git
```

And then load this mod as you would any other Doom mod.

```
gzdoom -file "HideousDestructor" "bryan-hdest-weapons"
```

ZDL (ZDoom Launcher) is also available to help manage loading multiple wads.

https://zdoom.org/wiki/ZDL

## Credits

Programming: Me

Weapon Sprites: [Clay](https://www.artstation.com/donor_clay)

Sound Effects: [Duncoo Soo](https://www.duncansoo.com/)

Player Sprites: Ultra64

Play testing: a1337spy, Shredder

## Permissions

The source code for this project is licensed under GNU v3. You are free to fork this code and make your own adjustments.

Permission to reuse any game assets, sounds, or graphics are not granted unless you are using them in a project for either Hideous Destructor or creating a weapon that derives from `BHDWeapon`, the base class of the weapons for this mod. Reusing the player sprite is permitted if using the sprite within Hideous Destructor.

## Weapons

### Glock

<p align="center">
	<img src="graphics/gunimages/glock/glock_pickup_base.png">
	<img src="graphics/gunimages/glock/glock_pickup_silencer.png">
</p>

### MP5 & MP5 M203

<p align="center">
<img src="graphics/gunimages/mp5/none/base.png">
<img src="graphics/gunimages/mp5/low/flashlight.png">
<img src="graphics/gunimages/mp5/high/silencer.png">
<img src="graphics/gunimages/mp5/none/flashlight_silencer.png">
</p>

<p align="center">
<img src="graphics/gunimages/mp5m203/none/base.png">
<img src="graphics/gunimages/mp5m203/low/flashlight.png">
<img src="graphics/gunimages/mp5m203/high/silencer.png">
<img src="graphics/gunimages/mp5m203/none/flashlight_silencer.png">
</p>

### M4 & M4 M203

<p align="center">
<img src="graphics/gunimages/m4/carryhandle/base.png">
<img src="graphics/gunimages/m4/lowsight/flashlight.png">
<img src="graphics/gunimages/m4/other/silencer.png">
<img src="graphics/gunimages/m4/carryhandle/flashlight_silencer.png">
</p>

<p align="center">
<img src="graphics/gunimages/m4m203/carryhandle/base.png">
<img src="graphics/gunimages/m4m203/lowsight/flashlight.png">
<img src="graphics/gunimages/m4m203/other/silencer.png">
<img src="graphics/gunimages/m4m203/carryhandle/flashlight_silencer.png">
</p>

### M14

<p align="center">
<img src="graphics/gunimages/m14/none/base.png">
<img src="graphics/gunimages/m14/low/flashlight.png">
</p>
<p align="center">
<img src="graphics/gunimages/m14/high/silencer.png">
<img src="graphics/gunimages/m14/none/flashlight_silencer.png">
</p>

### Fauxtech Origin 12

<p align="center">
<img src="graphics/gunimages/fostech/none/base.png">
<img src="graphics/gunimages/fostech/high/flashlight.png">
<img src="graphics/gunimages/fostech/low/silencer.png">
<img src="graphics/gunimages/fostech/high/flashlight_silencer.png">
</p>

### M249

<p align="center">
<img src="graphics/gunimages/m249/none/base.png">
<img src="graphics/gunimages/m249/low/flashlight.png">
<img src="graphics/gunimages/m249/high/silencer.png">
<img src="graphics/gunimages/m249/none/flashlight_silencer.png">
</p>

## Ammo

Each weapon has its own magazine/drum/pouch. The Glock and MP5 are chambered in the the default Hideous Destructor 9mm bullet. The Fauxtech Origin also reuses thd default Hideous Destructor shotgun shells. Ammo for the M203 uses the default rocket grenade ammo as well. 

- Glock Magazine (9mm): 15 rounds
- MP5 Magazine (9mm): 30 rounds
- M4 Magazine (5.56mm): 30 rounds
- M14 Magazine: (7.62mm): 20 rounds
- Fauxtech Drum: 20 shells
- M249 Pouch: (5.56mm): 200 rounds

## Using Attachments

Attachments will either be found in backpacks or already equipped on weapons dropped by enemies or find in the level. An attachment must be compatible with the weapon to be able to attach it. To swap an attachment, simply use an attachment item. It will remove the attachment already occupying the slot, place it back in your inventory, and attach the item just used. 

There is a keybind available in the options for opening an attachment manager.

## Replacement Options

There are three modes available for changing the way the weapons appear in the game.

- *None*: Weapons from this mod won't spawn in the level. Players can only use the weapons if they create a loadout configuration to start with them.
- *Mixed*: Weapons from this mod will sometimes replace their Hideous Destructor counter-part. Both weapons will appear.
- *Replace*: All weapons from Hideous Destructor are replaced with an equivalent from this weapon pack, if available.

The counter-parts are:

- Pistol -> Glock
- SMG -> MP5/MP5 M203
- Shotgun/SSG -> Enemies drop shotgun or ssg, but map spawns are replaced with Fauxtech Origin.
- ZM66 -> M4/M4 M203
- Liberator -> M14
- Chaingun -> M249

## Loadout Manager

Weapons are configured based on the follow syntax: `w## ba# bs# bm#`. The values for input are shown below.

- `w##` is the weapon reference number
- `ba#` is the muzzle attachment reference number
- `bs#` is the sight attachment reference number
- `bm#` is the misc. attachment reference number

Magazines for weapons correspond to their weapon number, except for the M203 weapon variants. 

- `m01`: Glock magazine
- `m02`: MP5 magazine
- `m03`: M4 magazine
- `m04`: M14 Magazine
- `m05`: Fauxtech Origin Drum
- `m06`: M249 Pouch
- `m07`: RPG Rocket

Note: The M4 and Fauxtech origin by default have no rear sight. You have to pick one yourself or you will only see the front sight image.

### Weapon IDs

- `w01`: Glock
- `w02`: MP5
- `w03`: M4
- `w04`: M14
- `w05`: Fauxtech Origin
- `w06`: M249
- `w07`: M4 M203
- `w08`: MP5 M203
- `w09`: RPG Launcher

### Muzzle IDs

- `ba1`: 5.56mm suppressor
- `ba3`: 9mm suppressor
- `ba4`: 7.62mm suppressor

### Sight IDs

- `bs1`: M4 Rear ironsight
- `bs2`: M4 Carryhandle
- `bs3`: Fauxtech Origin Diamond Sight
- `bs4`: ACOG
- `bs5`: Red dot
- `bs6`: Holo sight
- `bs7`: Reflex sight

### Misc IDs

- `bm1`: Flashlight attachment

## Sight Options

An option is available that will draw the weapon front sight any non-magnified sight. 