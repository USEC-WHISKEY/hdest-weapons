
// Constants
const I_FLAGS   = 0;
const I_MAG     = 1;
const I_AUTO    = 2;
const I_ZOOM    = 3;
const I_HEAT    = 4;
CONST I_BORE    = 6;
CONST I_GRIME   = 7;
CONST I_GRENADE = 8;

CONST I_3RD  = 31;

const F_CHAMBER        = 1;
const F_CHAMBER_BROKE  = 2;
const F_NO_FIRE_SELECT = 32;
const F_GL_MODE        = 64;
const F_UNLOAD_ONLY    = 128;
const F_EMPTY_CHAMBER  = 256;


const B_BARREL = 255;
const B_MISC   = 65280;
const B_SCOPE  = 16711680;

const LAYER_BARREL = -11;
const LAYER_MISC = 12;
const LAYER_SCOPE = 13;



const ENC_556MAG = 17;
const ENC_556MAG_EMPTY = ENC_556MAG * 0.4;
const ENC_556_LOADED = (ENC_556MAG * 0.6) / 50.;
const ENC_556 = ENC_556_LOADED * 1.4;
const ENC_556MAG_LOADED = ENC_556MAG_EMPTY * 0.4;

const ENC_762MAG = 19;
const ENC_762MAG_EMPTY = ENC_762MAG * 0.4;
const ENC_762_LOADED = (ENC_762MAG * 0.6) / 50.;
const ENC_762 = ENC_762_LOADED * 1.4;
const ENC_762MAG_LOADED = ENC_762MAG_EMPTY * 0.4;

const HDLD_556MAG = "556";
const HDLD_762MAG = "762";



// Constants for the Loadouts
const B_GLOCK_REFID   = "w01";
const B_MP5_REFID     = "w02";
const B_M4_REFID      = "w03";
const B_M14_REFID     = "w04";
const B_FAUX_REFID    = "w05";
const B_MF249_REFID   = "w06";
const B_M4M203_REFID  = "w07";
const B_MP5M203_REFID = "w08";
const B_RPGL_REFID    = "w09";

const B_GLOCK_MAG_REFID  = "m01";
const B_MP5_MAG_REFID    = "m02";
const B_556_MAG_REFID    = "m03";
const B_M14_MAG_REFID    = "m04";
const B_FAUX_DRUM_REFID  = "m05";
const B_MF249_MAG_REFID  = "m06";
const B_RPG_ROCKET_REFID = "m09";

// ID's and Ref's for Attachments
const B_M4_REARSIGHT_ID   = 1;
const B_M4_CARRYHANDLE_ID = 2;
const B_FAUX_SIGHT_ID     = 3;
const B_ACOG_RED_ID       = 4;
const B_SIGHT_CRDOT_ID    = 5;
const B_SIGHT_HOLO_ID     = 6;
const B_REFLEX_RED_ID     = 7;
const B_SCOPE_10X_ID      = 8;

const B_FLASHLIGHT_ID     = 1;

const B_556_SILENCER_ID   = 1;
const B_556_FLASH_ID      = 2;
const B_9MM_SILENCER_ID   = 3;
const B_762_SILENCER_ID   = 4;