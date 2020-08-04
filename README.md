<p align="center">
	<img src="static/coverimage.png?raw=true">
</p>

# Bryan's Weapons

What was originally intended as a library for creating Hideous Destructor weapons has turned into a modern tactical weapons pack. These weapons come with the benefit of some modularity, allowing for weapon attachments such as scopes, muzzle, and miscellaneous attachments such as a flashlight. 

## How to play

This mod requires GZdoom & Hideous Destructor. LZDoom is also supported though there are some UI issues.

GZDoom/LZDoom: https://zdoom.org/index

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

Sound Effects: [Duncan Soo](https://www.duncansoo.com/)

Player Sprites: Ultra64

Play testing: Shredder, a1337spy

Special thanks to Shredder for being the Hideous Destructor consultant. 

Textures used in hub map taken from Kingpin texture pack on Realm667

https://realm667.com/

## Permissions

The source code for this project is licensed under GNU v3. You are free to fork this code and make your own adjustments.

The gun art assets, sounds, and player sprite are not allowed to be reused in other projects. Permission is only granted if you plan on forking this repository to create your own modifications. Permission for other Doom mods, or other games, is not granted. 

## Multiplayer

Multiplayer compatibility has not been extensively tested. 

## Player Skin

This pack includes a tactical operator player skin. To use run the command `hd_skin BryanOperator`. 

<p><img src="static/operator.png"></p>

## Game Options

Options for this mod can be found in at the bottom of the default GZdoom options menu.

### Replace Mode

- None: Weapons from this mod will not spawn in levels. Gear can only be obtained via the loadout manager.
- Replace: Hideous Destructor weapon spawns will be replaced with weapons from this mod.
- Map: Weapons are only replaced at the start of the level.

WARNING: Vanilla loadouts and certain vanilla weapons will not function properly if using replace mode. This is intended to replace the default weapons entirely. It is still possible to spawn vanilla items via the loadout manager, but they will not function properly. If you want to use both weapons, play using map start or map mixed. The following items are replaced:

- Pistol with the Glock
- SMG with the MP5
- ZM66 with the M4
- Liberator with the M14
- Chaingun with the M249
- D.E.R.P. robot with the F.H. robot
- T.H.E.R.P. robot

Also note that other mods that spawn or replace actors if using "Replace" mode may continue to spawn even though they should be replaced. You'll be able to pick up these items and use them, but dropping them will trigger a replacement. 

### Sight Mode

- Full: The entire back of the sight is shown. Uses the most screen space.
- Minimal: Only the parts vital to being able to aim are shown.

### Attachment Spawn Mode

- None: Weapons when they spawn will not have any attachments other than default sights.
- Random: Weapons will spawn with random attachments. 

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

### RPG

<p align="center">
<img src="graphics/gunimages/rpg/base.png">
</p>

## Ammo

Each weapon has its own magazine/drum/pouch. The Glock and MP5 are chambered in the the default Hideous Destructor 9mm bullet. The Fauxtech Origin also reuses thd default Hideous Destructor shotgun shells. Ammo for the M203 uses the default rocket grenade ammo as well. 

<p>
	<img src="sprites/ammo/5BOXA0.png">
	<img src="sprites/ammo/7BBXA0.png">
	<img src="sprites/ammo/BBOXA0.png">
</p>

- Glock Magazine (9mm): 15 rounds
- MP5 Magazine (9mm): 30 rounds
- M4 Magazine (5.56mm): 30 rounds
- M14 Magazine: (7.62mm): 20 rounds
- Fauxtech Drum: 20 shells
- M249 Pouch: (5.56mm): 200 rounds

For the M249 pouch, a reloading tool is available. It is similar to the 7mm reloader. It needs an empty M249 magazine and 200 5.56 rounds.

## Using Attachments

Attachments will either be found in backpacks or already equipped on weapons dropped by enemies or find in the level. An attachment must be compatible with the weapon to be able to attach it. To swap an attachment, simply use an attachment item. It will remove the attachment already occupying the slot, place it back in your inventory, and attach the item just used. 

There is a keybind available in the options for opening an attachment manager.

## Loadout Manager

Weapons are configured based on the follow syntax: `w## ba# bs# bm#`. The values for input are shown below.

- `w##` is the weapon reference number
- `ba#` is the muzzle attachment reference number
- `bs#` is the sight attachment reference number
- `bm#` is the misc. attachment reference number

It's possible via the loadout manager to place attachments on weapons that otherwise wouldn't be supported. This is a known issue. You can remove the attachment, but you won't be able to put it back on later.

Magazines for weapons correspond to their weapon number, except for the M203 weapon variants. 

- `m01`: Glock magazine

<p><img src="sprites/glock/bglockmag.png"></p>

- `m02`: MP5 magazine

<p><img src="sprites/mp5/mp5clip.png"></p>

- `m03`: M4 magazine

<p><img src="sprites/m4/m4clip.png"></p>

- `m04`: M14 Magazine

<p><img src="sprites/m14/bm14clip.png"></p>

- `m05`: Fauxtech Origin Drum

<p><img src="sprites/fostech/pfosmag.png"></p>

- `m06`: M249 Pouch

<p><img src="sprites/mf240/bm249clip.png"></p>

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
- `w09`: RPG

### Muzzle IDs

- `ba1`: 5.56mm suppressor
- `ba2`: 5.56mm flash suppressor
- `ba3`: 9mm suppressor
- `ba4`: 7.62mm suppressor
- `ba5`: Fauxtech Silencerr
- `ba6`: Fauxtech Improved Choke
- `ba7`: Fauxtech Modified Choke
- `ba8`: Fauxtech Full Choke

### Sight IDs

- `bs1`: M4 Rear ironsight

<p><img src="sprites/accessory/fullsize/m4rearsight.png"></p>

- `bs2`: M4 Carryhandle

<p><img src="sprites/accessory/fullsize/m4carryhandle.png"></p>

- `bs3`: Fauxtech Origin Diamond Sight

<p><img src="sprites/accessory/fullsize/fostechrear.png"></p>

- `bs4`: ACOG

<p><img src="sprites/accessory/fullsize/acog.png"></p>

- `bs5`: Red dot

<p><img src="sprites/accessory/fullsize/reddot.png"></p>

- `bs6`: Holo sight

<p><img src="sprites/accessory/fullsize/holo.png"></p>

- `bs7`: Reflex sight

<p><img src="sprites/accessory/fullsize/rreflex.png"></p>

- `bs8`: 10x Scope

<p><img src="sprites/accessory/fullsize/rreflex.png"></p>

### Misc IDs

- `bm1`: Flashlight attachment

### Attachment Loadout IDs

These are for adding attachments as loose items in your inventory if you plan to switch between multiple sights.

- `m4i`: M4 default rear sight
- `m4c`: M4 carryhandle
- `dia`: Fauxtech diamond sight
- `acg`: ACOG
- `rdt`: Red-dot Sight
- `hrd`: Holo sight
- `rfr`: Reflex sight
- `s10`: 10x Sight

- `sl5`: 5.56 silencer
- `sl7`: 7.62 silencer
- `sl9`: 9mm silencer
- `slf`: Fauxtech Silencer
- `ck1`: Fauxtech improved choke
- `ck2`: Fauxtech modified choke
- `ck3`: Fauxtech full choke

- `gfl`: Misc flashlight attachment

### Misc Loadout IDs

- `r04`: M249 pouch reloader
- `fhr`: F.H. robot
- `thp`: Tactical H.E.R.P.

### Crafting IDs

- `bcr`: Ball crafter
- `ccr`: Case crafter
- `asm`: Bullet Assembler
- `rsm`: Rocket Aseembler
