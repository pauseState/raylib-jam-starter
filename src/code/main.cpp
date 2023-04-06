// Standard includes
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

// Vendor libs
#include "raylib.h"

// Jam starter includes
#include "jam_platform.h"

int main(int argc, char *argv[]) {
    // ------------------------------------------------------------------------
    // Application window, etc. init

    constexpr char* GAME_LIB_PATH = "jam-starter-game.dylib";

    constexpr i32   SCREEN_WIDTH  = 800;
    constexpr i32   SCREEN_HEIGHT = 450;
    constexpr char* WINDOW_TITLE  = "Raylib Game Jam Starter Pack";

    void* game_lib = dlopen(GAME_LIB_PATH, RTLD_NOW);

    if (!game_lib) {
        fprintf(stderr, "Failed to load game library on specified path [%s].\n", GAME_LIB_PATH);
        exit(-1);
    }

    GameUpdateAndRenderFunc* GameUpdateAndRender = (GameUpdateAndRenderFunc*)dlsym(game_lib, "GameUpdateAndRender");

    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, WINDOW_TITLE);
    SetTargetFPS(60);

    // Application window, etc. init
    // ------------------------------------------------------------------------

    // ------------------------------------------------------------------------
    // Simulation init

    Vector2 ball_position = {-100.0f, -100.0f};

    // Simulation init
    // ------------------------------------------------------------------------

    while (!WindowShouldClose()) {
        // --------------------------------------------------------------------
        // Update phase

        ball_position = GetMousePosition();

        GameUpdateAndRender();

        // Update phase
        // --------------------------------------------------------------------

        // --------------------------------------------------------------------
        // Render phase

        BeginDrawing();
            ClearBackground(RAYWHITE);
            DrawCircleV(ball_position, 40, PURPLE);
            DrawText("Move the ball", 10, 10, 20, DARKGRAY);
        EndDrawing();

        // Render phase
        // --------------------------------------------------------------------
    }

    // ------------------------------------------------------------------------
    // Shutdown

    CloseWindow();

    dlclose(game_lib);

    // Shutdown
    // ------------------------------------------------------------------------

    return 0;
}
