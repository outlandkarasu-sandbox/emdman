import bindbc.sdl;
import bindbc.sdl.image;
import core.stdc.stdio : printf;

alias em_arg_callback_func = extern(C) void function(void*) @nogc nothrow;
extern(C) void emscripten_set_main_loop_arg(em_arg_callback_func func, void *arg, int fps, int simulate_infinite_loop) @nogc nothrow;
extern(C) void emscripten_cancel_main_loop() @nogc nothrow;

void logError(size_t line = __LINE__)() @nogc nothrow {
    printf("%d:%s\n", line, SDL_GetError());
}

struct MainLoopArguments {
    SDL_Window* window;
    SDL_Surface* screen;
    SDL_Surface* dman;
}

extern(C) int main(int argc, const char** argv) @nogc nothrow {
    if(SDL_Init(SDL_INIT_VIDEO) != 0) {
        logError();
        return -1;
    }

    if(IMG_Init(IMG_INIT_PNG) != IMG_INIT_PNG) {
        logError();
        return -1;
    }

    SDL_Window* window;
    SDL_Renderer* renderer;
    if(SDL_CreateWindowAndRenderer(480, 640, SDL_WINDOW_SHOWN, &window, &renderer) != 0) {
        logError();
        return -1;
    }

    auto dman = IMG_Load("images/dman.png");
    if(!dman) {
        logError();
        return -1;
    }

    auto texture = SDL_CreateTextureFromSurface(renderer, dman);
    if(!texture) {
        logError();
        return -1;
    }
    SDL_FreeSurface(dman);

    SDL_SetRenderDrawColor(renderer, 0x00, 0x00, 0x00, 0x00);
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, null, null);
    SDL_RenderPresent(renderer);

    emscripten_set_main_loop_arg(&mainLoop, null, 0, 1);
    return 0;
}

extern(C) void mainLoop(void* arguments) @nogc nothrow {
    emscripten_cancel_main_loop();
}

