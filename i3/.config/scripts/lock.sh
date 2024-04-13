#!/bin/sh

OVERLAY="/home/cliffniff/.lockbg.png"
IMAGE="/tmp/lockbg.png"

rm "$IMAGE"
killall -q "i3lock"
while pgrep -x i3lock >/dev/null; do sleep 1; done

scrot "$IMAGE"
convert "$IMAGE" -scale 5% -resize 2000% "$OVERLAY" -gravity center -composite -matte "$IMAGE"

BLANK='#00000000'
CLEAR='#00000000'
DEFAULT='#ffffff80'
TEXT='#ffffff'
WRONG='#ffa69ebb'
VERIFYING='#ffd6a5'

i3lock \
--image="$IMAGE" \
--insidever-color=$BLANK     \
--ringver-color=$VERIFYING   \
--insidewrong-color=$WRONG   \
--ringwrong-color=$WRONG     \
--inside-color=$BLANK    \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--keyhl-color=$TEXT  \
--bshl-color=$WRONG  \
--indicator                  \
--verif-text="" \
--wrong-text="" \
--wrong-size=40 \
--noinput-text="" \
--no-modkey-text \
--scale \
--date-pos=100:100 
