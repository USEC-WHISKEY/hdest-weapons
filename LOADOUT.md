# HD Loadout Options

Example of a fully equip M4 M203 with magazines, explosives, and elite solider kit:

```
bw7 bs 6 ba 1 bm 1, m56 10, rkt 5, sol
```

![loadoutmgr](https://i.imgur.com/NtEH06T.png)

## Weapons

* `bw1`: M16
* `bw2`: M16 M203
* `bw6`: M4
* `bw7`: M4 M203
	* `b56`: 5.56 round
	* `m56`: 5.56 NATO magazine

![m16](https://i.imgur.com/edqnn5T.png)
![m4](https://i.imgur.com/G06jjIh.png)

* `bw8`: MP5K
	* `9mm`: 9mm round
	* `mmp`: MP5K magazine

![mp5k](https://i.imgur.com/AIt2FN3.png)

* `bw3`: KAR98K
	* `b79`: 7.92 round
	* `mka`: 7.92 clip

![kar98k](https://i.imgur.com/UA2Fk8h.png)

## Attachments

Attachments are organized into three groups and stored by the `SerialId` property in the actor class. The ID you need to use in the loadout manager is dependent on which attachments you have loaded. If the class can't be found or the weapon is incompatible, no attachment will be set.

* `ba`: ID for barrel attachment
* `bs`: ID for scope attachment
* `bm`: ID for misc attachment

### SerialID's

The ID's here I placed for convenience so you don't have to dive in the example code to find them. 

#### Scopes

* Red dot sight `1`

![sight1](https://i.imgur.com/FfQp6r1.png)

* ACOG red sight image `2`

![sight2](https://i.imgur.com/IkmXUX6.png)

* ACOG green sight image `3`

![sight3](https://i.imgur.com/sg8Kf5P.png)

* ACOG green with red dot sight `6`

![sight4](https://i.imgur.com/IV0bvqq.png)

* ACOG red with red dot sight `7`

![sight5](https://i.imgur.com/73WHgMX.png)

* Red dot sight `4`

![sight6](https://i.imgur.com/0Eizxud.png)

* Green dot sight `5`

![sight7](https://i.imgur.com/fTrLgmo.png)

#### Barrels

* Sound Suppressor `1`

![barrel1](https://i.imgur.com/2qGg8Mu.png)

* Flash Suppressor `2`

![barrel2](https://i.imgur.com/DDAF7ca.png)

#### Misc

* Flashlight `1`

![flashlight1](https://i.imgur.com/SJKC3lS.png)