# Daniel's Qtile Configuration

from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess

@hook.subscribe.startup_once
def autostart():
    if qtile.core.name == 'wayland':
        subprocess.Popen(['/home/dhenn/.local/bin/autostart-wl'])

if qtile.core.name == 'x11':
    lock = "slock"
elif qtile.core.name == 'wayland':
    lock = "waylock --init-color '#000000' --input-color '#333333'"

browser="qutebrowser"
terminal = os.environ['TERMINAL']

# hotkey definitions
mod = "mod4"
alt = "mod1"

keys = [

    # Navigation
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod, alt], "h", lazy.layout.shuffle_left()),
    Key([mod, alt], "l", lazy.layout.shuffle_right()),
    Key([mod, alt], "k", lazy.layout.shuffle_up()),
    Key([mod, alt], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.grow_left()),
    Key([mod, "shift"], "l", lazy.layout.grow_right()),
    Key([mod, "shift"], "j", lazy.layout.grow_down()),
    Key([mod, "shift"], "k", lazy.layout.grow_up()),

    Key([mod], "n", lazy.layout.next(), desc="focus to next window"),
    Key([alt], "Tab", lazy.layout.next(), desc="focus to next window"),
    Key([mod], "p", lazy.layout.previous(), desc="focus to prev window"),
    Key([alt, "shift"], "Tab", lazy.layout.previous(), desc="focus to prev window"),
    Key([mod], "m", lazy.next_layout(), desc="Toggle tiling mode"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "q", lazy.window.kill()),

    # Volume/Brightness Controls
    Key([], "XF86AudioMute", lazy.spawn('pamixer --toggle-mute'), desc='mute'),
    Key([], "XF86AudioRaiseVolume", lazy.spawn('pamixer -i 5'), desc='raise volume'),
    Key([], "XF86AudioLowerVolume", lazy.spawn('pamixer -d 5'), desc='lower volume'),
    Key([], "XF86MonBrightnessUp", lazy.spawn('brightnessctl set +10%'), desc='increase brightness'),
    Key([], "XF86MonBrightnessDown", lazy.spawn('brightnessctl set 10%-'), desc='decrease brightness'),

    # Qtile Commands
    Key([mod, "shift"], "Escape", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the Config"),
    Key([mod, "shift"], "Backspace", lazy.spawn(lock), desc="Lock the displays"),

    # Applications
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "e", lazy.spawn("my-term -e ranger"), desc="Launch file explorer"),
    Key([mod], "v", lazy.spawn("pavucontrol-qt"), desc="Launch volume control"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Notifications
    Key([mod], "d", lazy.spawn("print-date"), desc="get the date"),
    Key([mod], "t", lazy.spawn("print-time"), desc="get the time"),
    Key([mod], "Escape", lazy.spawn("dunstctl close"))
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
fg="bcbcbc"
bg="262626"

layouts = [
    layout.Columns(
        border_focus=[fg],
        border_focus_stack=[fg],
        border_normal=[bg],
        border_normal_stack=[bg],
        border_on_single=False,
        border_width=2
        ),
    layout.Max(
        border_focus=[fg],
        border_width=0
        )
    ]

widget_defaults = dict(
    font="Roboto Mono",
    fontsize=15,
    padding=3,
    foreground=fg,
    background=bg,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    active=[fg],
                    this_current_screen_border="#626262",
                    inactive="#404040",
                    highlight_method="block"
                    ),
                widget.Chord(),
                widget.Prompt(),
                widget.Spacer(),
                widget.Battery(
                    format="{percent:2.0%}",
                    fmt="  {}  ",
                    ),
                widget.Clock(
                    format="%H:%M",
                    fmt="{}  ",
                    ),
            ],
            26,
        ),
        wallpaper="/home/dhenn/pictures/Wallpapers/Chief.jpg",
        wallpaper_mode="stretch",
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
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
        border_focus=[fg],
        border_normal=[bg],
        border_width=2,
        float_rules=[
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
    ]
)

#@lazy.window.function 
#def resize_floating_window(window, width: int = 0, height: int = 0): 
#    window.cmd_set_size_floating(window.width + width, window.height + height)
#
#@lazy.window.function
#def move_floating_window(window, x: int = 0, y: int = 0):
#    new_x = window.float_x + x
#    new_y = window.float_y + y
#    window.cmd_set_position_floating(new_x, new_y)
#
#keys.extend([
#    Key([mod, "shift"], "Left", resize_floating_window(width=-30), desc='increase width by 10'), 
#    Key([mod, "shift"], "Right", resize_floating_window(width=30), desc='decrease width by 10'), 
#    Key([mod, "shift"], "Up", resize_floating_window(height=-30), desc='increase height by 10'), 
#    Key([mod, "shift"], "Down", resize_floating_window(height=30), desc='decrease height by 10'),
#    Key([mod], "Left", move_floating_window(x=-30)),
#    Key([mod], "Right", move_floating_window(x=30)),
#    Key([mod], "Up", move_floating_window(y=-30)),
#    Key([mod], "Down", move_floating_window(y=30))
#    ]
#)

###########
# Options #
###########
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True


wmname = "LG3D"
