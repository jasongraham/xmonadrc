import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.xmonad/mainxmobarrc"
  xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.xmonad/auxxmobarrc"
  xmonad $ defaultConfig
    { terminal = "urxvtc"
    , modMask = mod4Mask -- rebind to windows key
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , handleEventHook = docksEventHook <+> handleEventHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc0
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
            >> dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc1
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
    }
    `additionalKeys`
    [ ((mod4Mask, xK_Print), spawn "sleep 0.5; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((mod4Mask, xK_b), sendMessage ToggleStruts)
    , ((mod4Mask, xK_n), spawn "~/bin/pomodoro_toggle")
    , ((mod4Mask, xK_p), spawn "rofi -modi run -show run")
    , ((mod4Mask .|. shiftMask, xK_p), spawn "rofi-pass")
    -- If systemd user session work this way again in the future, I can come
    -- back to this.
    --, ((mod4Mask .|. shiftMask, xK_q), spawn "systemctl --user exit")
    ]

