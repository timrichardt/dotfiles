import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive

import XMonad.Layout.CenteredMaster
import XMonad.Layout.SimplestFloat
import XMonad.Layout.NoBorders

import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatSnap
-- import XMonad.Actions.WindowGo
import XMonad.Actions.GridSelect
import XMonad.Actions.FloatSnap
import XMonad.Actions.UpdatePointer

import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Theme

xK_XF86AudioLowerVolume  = 0x1008FF11 :: KeySym
xK_XF86AudioRaiseVolume  = 0x1008FF13 :: KeySym
xK_XF86AudioMute         = 0x1008FF12 :: KeySym
xK_XF86MonBrightnessUp   = 0x1008FF02 :: KeySym
xK_XF86MonBrightnessDown = 0x1008FF03 :: KeySym
xK_XF86Launch1           = 0x1008FF41 :: KeySym
xK_XFAudioPlay           = 0x1008FF14 :: KeySym
xK_XFAudioStop           = 0x1008FF15 :: KeySym
xK_XFAudioNext           = 0x1008FF17 :: KeySym
xK_XFAudioPrev           = 0x1008FF16 :: KeySym
xK_XF86ScreenSaver       = 0x1008FF2D :: KeySym

layout = Tall 1 (3/173) (81/173)
         ||| Tall 1 (3/173) (92/173)
         ||| simplestFloat
         ||| Full

manager = composeAll
             [ className =? "MPlayer"        --> doFloat
             , className =? "Gimp"           --> doFloat
             , className =? "Skype"          --> doFloat
             , className =? "Pidgin"         --> doFloat
             , className =? "Gnuplot"        --> doFloat
             , resource  =? "desktop_window" --> doIgnore
             , resource  =? "kdesktop"       --> doIgnore
             , className =? "gkrellm"        --> doIgnore
             , className =? "XTerm"          --> doCenterFloat
             , className =? "XClock"         --> doCenterFloat
             , isFullscreen                  --> doFullFloat
             , isDialog                      --> doFloat]

myGSConfig =  defaultGSConfig
    { gs_cellheight = 42
    , gs_cellwidth = 250
    , gs_cellpadding = 10
    , gs_font = "xft:Source Code Pro:regular:size=11"
    }

myXPConfig = defaultXPConfig                                    
    { 
        font  = "xft:Source Code Pro:bold:size=16" 
        , fgColor = "#dcdccc"
        , bgColor = "#3f3f3f"
        , bgHLight    = "#4186be"
        , fgHLight    = "#f0dfaf"
        , position = Top
        , historySize = 512
        , showCompletionOnTab = True
        , historyFilter = deleteConsecutive
        , promptBorderWidth = 0
        , height = 42
    }

keymap conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
   [ -- ((modMask .|. shiftMask, xK_Return), spawnHere $ XMonad.terminal conf)
     ((modMask              , xK_y     ), goToSelected myGSConfig)
   , ((modMask              , xK_s     ), spawnHere $ XMonad.terminal conf)
   , ((modMask              , xK_o     ), spawnHere "xterm -geometry 140x30 -e ranger")
   , ((modMask .|. shiftMask, xK_c     ), kill)
   , ((modMask              , xK_space ), sendMessage NextLayout)
   , ((modMask              , xK_n     ), refresh)
   , ((modMask              , xK_u     ), xmonadPrompt myXPConfig)
   , ((modMask              , xK_q     ), shellPrompt myXPConfig)
   -- , ((modMask              , xK_Tab   ), windows W.focusUp >> windows W.shiftMaster)
   , ((modMask              , xK_Tab   ), windows W.focusUp)
   , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusDown)
   , ((modMask              , xK_m     ), windows W.focusMaster)
   , ((modMask              , xK_Return), windows W.swapMaster)
   , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown)
   , ((modMask              , xK_j     ), prevWS)
   , ((modMask              , xK_k     ), nextWS)
   , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp)
   , ((modMask              , xK_h     ), sendMessage Shrink)
   , ((modMask              , xK_l     ), sendMessage Expand)
   , ((modMask              , xK_t     ), withFocused $ windows . W.sink)
   , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
   , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))
   , ((modMask              , xK_Left  ), withFocused $ snapMove L Nothing)
   , ((modMask              , xK_Right ), withFocused $ snapMove R Nothing)
   , ((modMask              , xK_Up    ), withFocused $ snapMove U Nothing)
   , ((modMask              , xK_Down  ), withFocused $ snapMove D Nothing)
   , ((modMask .|. shiftMask, xK_Left  ), withFocused $ snapShrink R Nothing)
   , ((modMask .|. shiftMask, xK_Right ), withFocused $ snapGrow R Nothing)
   , ((modMask .|. shiftMask, xK_Up    ), withFocused $ snapShrink D Nothing)
   , ((modMask .|. shiftMask, xK_Down  ), withFocused $ snapGrow D Nothing)
   , ((modMask .|. shiftMask, xK_F12   ), io (exitWith ExitSuccess))
   , ((modMask .|. shiftMask, xK_F5    ), spawn "xbacklight -set 10")
   , ((modMask .|. shiftMask, xK_F6    ), spawn "xbacklight -set 33")
   , ((modMask .|. shiftMask, xK_F7    ), spawn "xbacklight -set 67")
   , ((modMask .|. shiftMask, xK_F8    ), spawn "xbacklight -set 100")
   , ((modMask              , xK_a     ), spawn "if [[ `pgrep -l alsamixer` == \"\" ]]; then xterm -geometry 140x30 -e alsamixer; else killall alsamixer; fi")
   , ((modMask              , xK_c     ), spawn "if [[ `pgrep -l xclock` == \"\" ]]; then xclock -digital -twentyfour -brief -face \"Source Code Pro:size=92:weight=bold:slant=italic\" -geometry 500x300 -padding 60 -fg \"#7f9f7f\" -bg \"#3f3f3f\"; else killall xclock; fi")
   , ((modMask              , xK_F12   ), spawn "xmonad --recompile; xmonad --restart")
   --, ((modMask              , xK_i     ), withFocused $ W.shiftMaster)
   ]
   ++
   [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_5]),
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

mousemap (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask              , button1), (\w -> focus w >> mouseMoveWindow w >> snapMagicMove (Just 50) (Just 50) w))
    , ((modMask .|. shiftMask, button1), (\w -> focus w >> mouseMoveWindow w >> snapMagicResize [L,R,U,D] (Just 50) (Just 50) w))
    , ((modMask              , button3), (\w -> focus w >> mouseResizeWindow w >> snapMagicResize [R,D] (Just 50) (Just 50) w))
    ]

main = xmonad defaultConfig {
         layoutHook = smartBorders $ layout,
         manageHook = manager,
         -- handleEventHook = (),
         workspaces = map show [1..5],
         modMask = mod4Mask,
         keys = keymap,
         mouseBindings = mousemap,
         logHook = fadeInactiveLogHook 0.7,
         -- startupHook = (),
         normalBorderColor = "#1f1f1f",
         focusedBorderColor = "#ff0000",
         terminal = "xterm -geometry 130x30",
         focusFollowsMouse = True,
         clickJustFocuses = False,
         borderWidth = 1
         }
