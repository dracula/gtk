#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

BRANCH=$(basename $(git symbolic-ref HEAD 2>/dev/null))

LINK_NAMES=("bottom-inactive.png"
            "bottom-left-inactive.png"
            "bottom-right-active.png"
            "left-active.png"
            "left-inactive.png"
            "menu-inactive.png"
            "menu-prelight.png"
            "menu-pressed.png"
            "right-inactive.png")

LINK_TARGETS=("bottom-active.png"
            "bottom-left-active.png"
            "bottom-right-inactive.png"
            "right-active.png"
            "right-active.png"
            "menu-active.png"
            "menu-active.png"
            "menu-active.png"
            "right-active.png")


if [ "$BRANCH" != "master" ]; then
    THEME_NAME="Dracula-${BRANCH}"
elif [ "$BRANCH" == "master" ]; then
    THEME_NAME="Dracula"
fi

for  screen in '' '-hdpi' '-xhdpi'; do

    case "${screen}" in
    -hdpi)
        DPI='144'
        ;;
    -xhdpi)
        DPI='192'
        ;;
    *)
        DPI='96'
        ;;
    esac

    ASSETS_DIR="${THEME_NAME}${screen}/xfwm4"
    mkdir -p $ASSETS_DIR
    
    for i in assets/*; do  

        BASE_FILE_NAME=`basename -s .svg $i`

        if [ -f $ASSETS_DIR/$BASE_FILE_NAME.png ]; then
            echo $ASSETS_DIR/$BASE_FILE_NAME.png exists.
        else
            echo
            echo Rendering $ASSETS_DIR/$BASE_FILE_NAME.png
            $INKSCAPE --export-dpi=$DPI \
                    --export-filename=$ASSETS_DIR/$BASE_FILE_NAME.png $i \
            && $OPTIPNG -o7 --quiet $ASSETS_DIR/$BASE_FILE_NAME.png
        fi
    done

    for i in ${!LINK_NAMES[@]}; do
        ln -sf ${LINK_TARGETS[$i]} $ASSETS_DIR/${LINK_NAMES[$i]} 
    done
    cp themerc $ASSETS_DIR/
done
exit 0
