#include <stdio.h>

#include "jam_platform.h"

extern "C" DEFINE_GAME_UPDATE_AND_RENDER_FUNC(GameUpdateAndRender) {
    printf("What a horrible night to have a curse...\n");
}
