# Daniel's Qtile Configuration

from libqtile import qtile, bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

####################
# Autostart script #
####################
import os
import subprocess
from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    if qtile.core.name == 'x11':
        subprocess.Popen(['/home/dhenn/.config/qtile/autostart-x11.sh'])
    elif qtile.core.name == 'wayland':
        subprocess.Popen(['/home/dhenn/.config/qtile/autostart-wl.sh'])

if qtile.core.name == 'x11':
    terminal = "urxvt"
    browser = "qutebrowser"
    lock = "slock"
elif qtile.core.name == 'wayland':
    terminal = "alacritty"
    lock = "waylock --init-color '#000000' --input-color '#3355FF' --fail-color '#EE3333'"
    browser = "qutebrowser"

################
#   HOTKEYS    #
################
mod = "mod4"
alt = "mod1"

keys = [

    # Navigation
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "n", lazy.layout.next(), desc="Move window focus to next window"),
    Key([alt], "Tab", lazy.layout.next(), desc="Move window focus to next window"),
    Key([mod], "p", lazy.layout.previous(), desc="Move window focus to prev window"),
    Key([alt, "shift"], "Tab", lazy.layout.previous(), desc="Move window focus to prev window"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle tiling mode"),

    # Volume/Brightness Controls
    Key([], "XF86AudioMute", lazy.spawn('pamixer --toggle-mute'), desc='mute'),
    Key([], "XF86AudioRaiseVolume", lazy.spawn('pamixer -i 5'), desc='raise volume'),
    Key([], "XF86AudioLowerVolume", lazy.spawn('pamixer -d 5'), desc='lower volume'),
    Key([], "XF86MonBrightnessUp", lazy.spawn('brightnessctl set +10%'), desc='increase brightness'),
    Key([], "XF86MonBrightnessDown", lazy.spawn('brightnessctl set 10%-'), desc='decrease brightness'),
    
    # Window Commands
    KeyChord([mod, "shift"], "w", [
        Key([], "h", lazy.layout.shuffle_left()),
        Key([], "l", lazy.layout.shuffle_right()),
        Key([], "k", lazy.layout.shuffle_up()),
        Key([], "j", lazy.layout.shuffle_down()),
        Key([], "q", lazy.window.kill()),
        Key([], "Left", lazy.layout.grow_left()),
        Key([], "Right", lazy.layout.grow_right()),
        Key([], "Down", lazy.layout.grow_down()),
        Key([], "Up", lazy.layout.grow_up())
        ],
        mode=True,
        name="Window"),

    # Qtile Commands
    KeyChord([mod, "shift"], "q", [
        Key([], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([], "r", lazy.reload_config(), desc="Reload the Config"),
        Key([], "l", lazy.spawn(lock), desc="Lock the displays")
        ],
        mode=False,
        name="Qtile"),

    # Applications
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "e", lazy.spawn("alacritty -e ranger"), desc="Launch file explorer"),
    Key([mod], "space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

#######################
# Layouts and Widgets #
#######################
fg="000000"
bg="e8e0cc"
hl="3a94c5"

layouts = [
    layout.Max(
        border_focus=[hl],
        border_width=0
        ),
    layout.Columns(
        border_focus=[hl],
        border_focus_stack=[hl],
        border_normal=[bg],
        border_normal_stack=[bg],
        border_on_single=True,
        border_width=3
        )
    ]

widget_defaults = dict(
    font="Roboto Mono",
    fontsize=16,
    padding=3,
    foreground=bg,
    background=fg,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    active=[bg],
                    this_current_screen_border=[hl],
                    inactive="#555555",
                    highlight_method="block"
                    ),
                widget.Chord(),
                widget.Prompt(),
                widget.Spacer(),
                widget.PulseVolume(fmt="VOL:{}  ",
                                   get_volume_command="pamixer --get-volume"),
                widget.Battery(
                    format="{percent:2.0%}",
                    fmt="BAT:{}   ",
                    ),
                widget.Clock(
                    format="%H:%M",
                    ),
                widget.Spacer(length=15),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

###########
# Options #
###########
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True


wmname = "LG3D"
