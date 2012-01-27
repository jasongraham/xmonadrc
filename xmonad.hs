import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

-- needed to let offlineimap get access to gnome-keyring
startuphook :: X ()
startuphook = spawn "$HOME/bin/export_x_info.sh"

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
    { terminal = "urxvt"
    , modMask = mod4Mask -- rebind to windows key
    , manageHook = manageDocks <+> manageHook defaultConfig
    , startupHook = startuphook
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
    		{ ppOutput = hPutStrLn xmproc
    		, ppTitle = xmobarColor "green" "" . shorten 50
    		}
    }
    `additionalKeys`
    [ ((mod4Mask, xK_Print), spawn "sleep 0.5; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((mod4Mask .|. shiftMask, xK_l), spawn "slock")
    ]

