### Astral Ascent Steam Boot Params Nvidia
`gamemoderun __VK_LAYER_NV_optimus=NVIDIA_only __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia LD_PRELOAD=$LD_PRELOAD:./bin64/libsteam_api.so:./bin64/libsentry.so %command%`
### Balatro Amd
`PROTON_ENABLE_WAYLAND=1 SDL_VIDEODRIVER="windows" %command%`

