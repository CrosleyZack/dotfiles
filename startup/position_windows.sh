#!/bin/bash

# To use, set as a program to run on OS start. This can be done on Ubuntu
#	in Applications > Statup Applications
# Note: This script should work on any X Window Manager system.

# Get display names
INTERNAL="XWAYLAND1"
EXTERNAL="XWAYLAND0"

# Get desktop size. See https://askubuntu.com/questions/584688/how-can-i-get-the-monitor-resolution-using-the-command-line
X=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Y=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)
echo "position_windows.sh: screen size $X x $Y"
logger "position_windows.sh: screen size $X x $Y"

# enum options for layout
VERT_MAXED=1
VERT_HORZ_MAXED=2
FULLSCREEN=3

function position {
    # $1 indicates program to position - must be name of executable in bash path
    # $2 indicates workspace to put on (0 indexed)
    # $3 indicates desired window state:
    #	- 1 -> vertically maxed
    #	- 2 -> vertically and horizontally maxed
    #	- 3 -> fullscreen
    # $4 indicates if multiple windows should be placed on successive desktops.
    # $5 if $3==1, horizontal space for window to use
    # $6 if $3==1, X placement of window
    # Get process ids for running windows.
    WINIDS=$(wmctrl -lx | grep -i $1 | cut -f1 -d " ")
    if [ -z "$WINIDS" ]; then
        echo "WARN: no Windows found for process $1"
    fi
    # For each process, move the program to the appropriate desktop.
    INDEX=0
    for WINID in $WINIDS
    do
	echo "win id = " $WINID
	# get workspace number to move to.
	WORKSPACE=$(($2+INDEX))
	echo "position_windows.sh: moving $1 to workspace $WORKSPACE"
	logger "position_windows.sh: moving $1 to workspace $WORKSPACE"
	wmctrl -i -r $WINID -t $WORKSPACE
	# increment index if applicable.
	if [ "$4" = true ]
	then
	    INDEX=$((INDEX+1))
	fi
	# Wait for successful move.
	sleep 1s
	# change window size based on arguments
	#   if 3, make full screen
	if [[ $3 -eq $FULLSCREEN ]]; then
            echo "position_windows.sh: changing $1 to fullscreen: (wmctrl -i -r $WINID -b toggle,fullscreen)"
            logger "position_windows.sh: changing $1 to fullscreen: (wmctrl -i -r $WINID -b toggle,fullscreen)"
	    wmctrl -i -r $WINID -b "toggle,fullscreen"
	elif [[ $3 -eq $VERT_HORZ_MAXED ]]; then
            echo "position_windows.sh: changing $1 to maximized horz (wmctrl -i -r $WINID -e 0,0,0,$X,$Y)"
            logger "position_windows.sh: changing $1 to maximized horz (wmctrl -i -r $WINID -e 0,0,0,$X,$Y)"
            # The -e option expects a list of comma separated integers: "gravity,X,Y,width,height"
	    wmctrl -i -r $WINID -e "0,0,0,$X,$Y"
	elif [[ $3 -eq $VERT_MAXED ]]; then
	    # if 1 make vertically maxed
            echo "position_windows.sh: changing $1 to maximized vert (wmctrl -i -r $WINID -e $6,0,$5,$X,$Y)"
            logger "position_windows.sh: changing $1 to maximized vert (wmctrl -i -r $WINID -e $6,0,$5,$X,$Y)"
	    wmctrl -i -r $WINID -e "0,$6,0,$5,$Y"
	fi
	sleep 0.5s
    done
}

VERT_MAXED=1
VERT_HORZ_MAXED=2
FULLSCREEN=3

# TODO:
#  Get list of display names
#  If more than one, set largest as primary
#  move each window to primary display
# NOTE: looks like location might require calculation
#  see https://github.com/jc00ke/move-to-next-monitor/blob/master/move-to-next-monitor

THIRD=$(($X / 3))
HALF=$(($X / 2))
#        program desktop_id
#                  window_size      array_windows
#                                         xSize ySize
# position zoom    7 $VERT_MAXED      false $HALF 0 &
# position docker  7 $VERT_MAXED      false $HALF $HALF &
# position podman  7 $VERT_MAXED      false $HALF 0 &
position bitwarden 7 $VERT_HORZ_MAXED false $X    $Y &
position firefox   8 $VERT_HORZ_MAXED false $X    $Y &
# position signal    9 $VERT_MAXED      false $HALF 0 &
position spotify   9 $VERT_MAXED      false $HALF 0 &
position slack     9 $VERT_MAXED      false $HALF $HALF &
position code      1 $FULLSCREEN      true  $X    $Y &
