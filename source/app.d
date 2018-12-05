import bindbc.sdl;

alias em_callback_func = extern(C) void function() @nogc nothrow;
extern(C) void emscripten_set_main_loop(em_callback_func func, int fps, int simulate_infinite_loop) @nogc nothrow;

extern(C) int main(int argc, const char** argv) @nogc nothrow {
    SDL_Init(SDL_INIT_VIDEO);
    scope(exit) SDL_Quit();

    auto window = SDL_CreateWindow(
        "SDL Tutorial",
	SDL_WINDOWPOS_UNDEFINED,
	SDL_WINDOWPOS_UNDEFINED,
	640,
	480,
	SDL_WINDOW_SHOWN);
    scope(exit) SDL_DestroyWindow(window);

    emscripten_set_main_loop(&mainLoop, 60, 1);
    return 0;
}

extern(C) void mainLoop() @nogc nothrow {
}

