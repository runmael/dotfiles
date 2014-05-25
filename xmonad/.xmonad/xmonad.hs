import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers(doCenterFloat)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.NamedScratchpad
import XMonad.Layout.LayoutModifier
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Fullscreen
import XMonad.Layout.Named
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Util.Scratchpad
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName
import System.IO

myTerminal = "urxvt"
myWorkspaces = ["1:misc", "2:dev", "3:www", "4:docs", "5:ranger", "6:pidgin", "7:mail", "8:music", "9:vbox"]
myNormalBorderColor = "#334444"
myFocusedBorderColor = "#dd7700"
tilda = "tilda"

myKeys = [
            ("M-`", scratchpadSpawnAction ) -- quake terminal
        ]

myLogHook h = dynamicLogWithPP $ defaultPP
    {
      --  ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
        ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
      , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
      , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  |  "
      {-
      , ppLayout            =   dzenColor "#ebac54" "#1B1D1E" .
                                (\x -> case x of
                                    "Simple Float"              ->      "~"
                                    _                           ->      x
                                )
                                -}
      , ppLayout            =   const ""
      , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
      , ppOutput            =   hPutStrLn h
    }

--1366
---fn 'Liberation Mono:size=7'
myXmonadBar = "dzen2 -x '1440' -y '0' -h '15' -w '900' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E' -fn 'Liberation Mono:size=7'"
myStatusBar = "conky -c /home/petar/.xmonad/.conky_dzen | dzen2 -x '900' -y '0' -w '466' -h '15' -ta 'r' -fg '#FFFFFF' -bg '#1B1D1E' -fn 'Monospace:size=10:style=Bold'"
myStatusBarTwo = "conky -c /home/petar/.xmonad/.conkyrc_two"

myManageHook = composeAll [
      title =? "ncmpcpp" --> doShift "8:music"
    , title =? "ranger" --> doShift "5:ranger"
--    , className =? "Tilda" --> doFloat
    , className =? "Thunderbird" --> doShift "7:mail"
    , className =? "Pidgin" --> doShift "6:pidgin"
    , manageDocks
    ] <+> manageScratchPad


manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
    where
    --h = 0.974    -- terminal height, 10%
    --w = 0.5       -- terminal width, 100%
    --t = 0.026   -- distance from top edge, 90%
    --l = 0.001   -- distance from left edge, 0%
    h = 0.5
    w = 1
    t = 0
    l = 0

startup :: X ()
startup = do
    spawn "urxvt -e ranger"
    spawn "thunderbird"
    setWMName "LG3D"
--    spawn "tilda"



basicLayout = Tall nmaster delta ratio where
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2


hugeLayout = Tall nmaster delta ratio where
    nmaster = 1
    delta   = 3/100
    ratio   = 50/50

tallLayout = named "tall" $ avoidStruts $ basicLayout
wideLayout = named "wide" $ avoidStruts $ Mirror basicLayout
movieLayout = named "movie" $ spacing 0 $ noBorders Full

myLayoutHook = spacing 2 $ smartBorders $ lessBorders OnlyFloat $ movie $ normal where
    normal     = tallLayout ||| wideLayout ||| movieLayout
    movie = onWorkspace "9:vbox" movieLayout

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/petar/.xmobarrc"
    dzenLeftBar <- spawnPipe myXmonadBar
    dzenRightBar <- spawnPipe myStatusBar
    dzenFloatBar <- spawnPipe myStatusBarTwo
    xmonad $ defaultConfig
        { terminal = myTerminal
        , workspaces = myWorkspaces
--        , keys = myKeys
        , startupHook = startup
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
--        , layoutHook = avoidStruts $ smartBorders $ spacing 2 $ layoutHook defaultConfig
        , layoutHook = myLayoutHook
        , logHook             = myLogHook dzenLeftBar >> fadeInactiveLogHook 0xdddddddd
--        , logHook = dynamicLogWithPP xmobarPP
--                        { ppOutput = hPutStrLn xmproc
--                        , ppTitle = xmobarColor "#0088bb" "" . shorten 50
--                        , ppSort = fmap (.namedScratchpadFilterOutWorkspace)
--                                           $ ppSort defaultPP
--                        , ppLayout = const ""
--                        }
        --, modMask = mod4Mask     -- Rebind Mod to the Windows key
        }
        `additionalKeysP`
        [ ("M-o", scratchPad) -- quake terminal
        ] where
           scratchPad = scratchpadSpawnActionTerminal "urxvt -depth 32 -bg rgba:0000/0000/0200/c800"
