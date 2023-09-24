# falkTX Portfolio

This is a list of projects I have worked on, either for a job or for fun and research, sometimes as a challenge too.

If you are interested on hiring me for something similar to what you see here, please get in touch!  
You can reach me at [falktx@falktx.com](mailto:falktx@falktx.com), expect negotiable rates around 60eur/h, half of that if doing it as an open-source project.
Other details about my work can be found [in my CV](https://falktx.com/files/cv.pdf).

If you are just browsing through and like what you see here, please know I have a [Patreon page](https://patreon.com/falktx) you can subscribe to. :)

## Audio plugins

### DISTRHO Plugin Framework

[https://github.com/DISTRHO/DPF](https://github.com/DISTRHO/DPF)

[DISTRHO Plugin Framework](https://github.com/DISTRHO/DPF), or DPF for short, is a **minimalistic C++ framework for audio plugins**.  
I started it many years ago after being disappointed with the available options for making desktop audio plugins.
Pretty much all the existing options did not support Linux (most still don't) or did so in a subpar way.
Those that did, like [JUCE](https://juce.com/), ended up generating 2Mb+ sized binaries for a very simple filter effect...

The idea behind DPF was (and still is) to have something that is stupid simple and works well, intentionally not supporting more esoteric features.
This applies to graphics as well, for which DPF does not implement its own draw operations but instead uses Cairo, OpenGL or Vulkan through a [pugl](https://github.com/lv2/pugl) backend.

By having OpenGL as a possible graphics drawing API, many existing "mini toolkits" can be easily ported over to work with DPF.  
I added NanoVG as one of such "mini toolkits", directly integrated in the DPF project.  
Also added others like [oui-blendish](https://github.com/IceDragon200/oui-blendish) and [Dear ImGui](https://github.com/ocornut/imgui) to the separate [DPF-Widgets](https://github.com/DISTRHO/DPF-Widgets) project.

### DPF Plugins

Bellow follows a list of plugins using DPF that I either created or ported to it, that I am currently maintaining.

For most of these projects I worked on the build setup, plugin format and OS-related low-level things, sometimes GUI implementation too.  
Very rarely I actually deal with the DSP implementation details, as that is not my area of expertise.  
Everything else is fine though. ;)

Please note that I keep my own DPF-based plugins under the [DISTRHO](https://github.com/DISTRHO) organization, just to help reduce clutter on my main GitHub account.  
Also, unfinished and very minor/simple ports are not listed here on this page.

#### [AIDA-X](https://github.com/AidaDSP/AIDA-X)

AIDA-X is an Amp Model Player based on [RTNeural](https://github.com/jatinchowdhury18/RTNeural). 
It loads previously-trained AI models meant to simulate guitar amplifiers.

It started as an [LV2 plugin from AidaDSP](https://github.com/AidaDSP/aidadsp-lv2), I ported it to DPF so that we could have it running as CLAP/VST2/VST3 + Standalone, with the GUI based on their existing designs (all drawing manually recreated in NanoVG).  
I also added some peak meters and post-amp IR convolution (based on work done for other projects).

An wasm/browser version is available to try online at [aida.kx.studio](https://aida.kx.studio/).

![AIDA-X](https://raw.githubusercontent.com/AidaDSP/AIDA-X/main/docs/Screenshot.png)

#### [Cardinal](https://github.com/DISTRHO/Cardinal)

Cardinal is a modular synthesizer plugin, based on [VCV Rack](https://vcvrack.com/) but with a focus on being a fully self-contained plugin version.

Created first and foremost as a way to have Rack as a conventional open-source audio plugin, following good practices for an audio plugin (a proper audio plugin should be self-contained as much as possible, as to not interfere with the DAW/Host; loading external modules clearly goes against this idea, which is how Rack operates).  
Also as a way to have a Rack version with support for more than just the basic 3 desktop operating systems, plus LV2 format. 

I created a few custom modules and also ported [AIDA-X](#aida-x), [Carla](#carla), [glBars](#glbars), [Ildaeil](#ildaeil) and [PitchTrackingSeries](#pitchtrackingseries) to it.

An wasm/browser version is available to try online at [cardinal.kx.studio/live](https://cardinal.kx.studio/live).

![Cardinal](https://raw.githubusercontent.com/DISTRHO/Cardinal/main/docs/Screenshot_Basic-Patching.png)

#### [Fadeli](https://github.com/DISTRHO/Fadeli)

An experiment with Faust Demo Library content as DPF plugins, started as a way to study and test [faust](https://faust.grame.fr/) and [faustpp](https://github.com/jpcima/faustpp) before picking the right approach to handle the [master_me](#master_me) audio plugin.

With some makefile magic any faust file placed in the `dsp/` directory is automagically added as part of the build, which generates CLAP, LADSPA, LV2, VST2 and VST3 automatically.

I come back to this project from time to time whenever some new faust-based project is needed.  
So Fadeli works nicely as a reference point and testing ground to build upon.

#### [glBars](https://github.com/DISTRHO/glBars)

This is a simple OpenGL bars visualization audio plugin (as seen in XMMS and XBMC/Kodi).  
Adapted from the [jack_glbars](https://github.com/nedko/jack_glbars) project by Nedko Arnaudov.

I created this project as a way to test raw OpenGL calls for a plugin GUI, something that is not static but reacts to audio.

![glBars](https://raw.githubusercontent.com/DISTRHO/glBars/master/plugins/glBars/Screenshot.png)

#### [Ildaeil](https://github.com/DISTRHO/Ildaeil)

Ildaeil is mini-plugin host working as a plugin, allowing one-to-one plugin format reusage.  
The idea is to load it as a plugin inside the DAW and then the other "real" plugin inside Ildaeil.  
This allows, for example, a VST3 host to load LV2 plugins.

Ildaeil is mostly "glue code" to combine all aspects of [Carla](#carla) and [DPF](#dpf).  
[Dear ImGui](https://github.com/ocornut/imgui) is used for handling UI things.  
Most of the complexity in Ildaeil comes from embedding hosted plugin GUIs while still displaying Ildaeil's own OpenGL-based GUI.

![Ildaeil](https://kx.studio/repo/screenshots/ildaeil.png)

#### [Max-Gen examples](https://github.com/DISTRHO/DPF-Max-Gen) (MaBitcrush, MaFreeverb, MaGigaverb, MaPitchshift)

An experiment with MAX gen~ based audio plugins and DPF.  
Based on https://github.com/Cycling74/gen-plugin-export.

Initially done as a way to have gen~ based LV2 plugins on the [MOD Audio platform](https://mod.audio/), then grew into [max-gen-skeleton](https://github.com/moddevices/max-gen-skeleton) for automated plugin builds.  
The same base code has been used for the [SHIRO-Plugins](https://github.com/ninodewit/SHIRO-Plugins) collection and a few commercial plugins pushed into the [MOD plugin store](https://pedalboards.mod.audio/plugins?text=urn:maxgen:) (K-Devices and SHIRO)

#### [master_me](https://github.com/trummerschlunk/master_me)

An automatic audio mastering plugin for live-streaming, podcasting and internet radio stations.  
In 2022 it was funded by the Prototype Fund, an open source software funding initiative by the german ministry of education and research.

The project was started by [Klaus Scheuermann](https://4ohm.de/) and a few other contributors, and I joined at the final implementation stage for turning their faust setup into a proper audio plugin.  
My work consisted of setting up the build infrastructure, plugin format handling (via DPF of course) and coding a custom GUI for it. Still help on its maintenance from time to time.

![master_me easy view](https://raw.githubusercontent.com/trummerschlunk/master_me/master/img/screenshot-easy.png)

![master_me expert view](https://raw.githubusercontent.com/trummerschlunk/master_me/master/img/screenshot-expert.png)

#### [Mini-Series](https://github.com/DISTRHO/Mini-Series) (3BandEQ, 3BandSplitter, PingPongPan)

A collection of small but useful plugins, based on the good old LOSER-Dev Plugins.  
One of my very first DPF-based plugin projects, simple in nature on purpose, as they were mostly the testing ground for all the basics of an audio plugin framework.  
Graphics done by [António Saraiva](http://www.facebook.com/melmaquiano).

This collection currently includes:

- 3 Band EQ
- 3 Band Splitter
- Ping Pong Pan

Might add more plugins to it later on, but for now they have served its purpose.

![3BandEQ](https://raw.githubusercontent.com/DISTRHO/mini-series/master/plugins/3BandEQ/Screenshot.png)

![PingPongPan](https://raw.githubusercontent.com/DISTRHO/mini-series/master/plugins/PingPongPan/Screenshot.png)

#### [MVerb](https://github.com/DISTRHO/MVerb)

An open-source reverb, [originally created as VST2](https://github.com/martineastwood/mverb/), which I have ported to DPF as a way to get its GUI running on Linux and with an LV2 version too.
It also serves as a way to test text rendering.

![MVerb](https://raw.githubusercontent.com/DISTRHO/MVerb/master/plugins/MVerb/Screenshot.png)

#### [Nekobi](https://github.com/DISTRHO/Nekobi)

A simple single-oscillator synth based on the Roland TB-303.
The [original nekobee](https://github.com/gordonjcp/nekobee) was abandoned and coded in DSSI plugin format which most audio hosts do not support.

I ported it to DPF as a way to get a small synth example.  
Graphics done by [António Saraiva](http://www.facebook.com/melmaquiano).

![Nekobi](https://raw.githubusercontent.com/DISTRHO/nekobi/master/plugins/Nekobi/Screenshot.png)

#### [PitchTrackingSeries](https://github.com/DISTRHO/PitchTrackingSeries)

Note: This project is meant to be a plugin series, but for now there is only 1 plugin - Audio To CV Pitch - for converting audio input into CV output (in 1V/Oct range).

This plugin was started by [Bram Giesen](https://bramgiesen.com/), using [aubio library](https://github.com/aubio/aubio) for the pitch detection heavy work.

I worked on the final tweaks and polishing.

#### [ProM](https://github.com/DISTRHO/ProM)

This is an audio plugin that makes use of the the [projectM awesome music visualizer](https://github.com/projectM-visualizer/projectm/).

I started the project as a way to have more complex OpenGL setups working with DPF, but also because it's cool.

![ProM](https://raw.githubusercontent.com/DISTRHO/prom/master/plugins/ProM/Screenshot.png)

#### [Zinc](https://github.com/DISTRHO/Zinc)

Small utility plugins for getting sound out of plugin hosts into [JACK](https://jackaudio.org/).  
These plugins do not have any GUI or configuration whatsoever.

I created these plugins as a way to more reliably test my work-in-progress [OBS audio plugin support](#obs-audio-plugin-host), as (at the time I started the project) OBS did/does not have a way to monitor the audio output without starting a live stream.

It includes a "soft" zinc variant, that buffers audio and thus has latency, but works with hosts that dynamically change the amount of samples on each plugin process run.  
A "hard" zinc variant directly syncs the plugin host audio thread with the plugin-created JACK client, thus having no extra latency.
It requires that the plugin host is already using JACK and uses it to drive its audio engine.

### JUCE porting

# TODO finalize text

The [DISTRHO-Ports](https://github.com/DISTRHO/DISTRHO-Ports) contains a few plugins I have (im)ported and been maintaining since a few years.  
They either did not have a Linux version initially or lacked LV2 plugin support (which for many years was not officially part of JUCE).  
Most of my work for these have been on the build setup, a few times requiring doing code fixes as well.

I [started an LV2 wrapper back in 2011](https://repo.or.cz/juce-lv2.git), which I maintained to keep up with JUCE related changes.  
This unofficial wrapper still exists in [DISTRHO/JUCE juce6 branch](https://github.com/DISTRHO/JUCE/tree/juce6), which has been super-seeded by an official JUCE LV2 one in JUCE7.  
None of my code ended up in the new official wrapper.

You can find my [set of JUCE7 patches here](https://github.com/DISTRHO/DISTRHO-Ports/tree/master/libs/juce7/patches). These include:

- Forcing GPLv3 mode
- Disabling splash screen analytics
- Bringing back old VST2 interface file (GPLv3+ licensed) from JUCE5
- Enabling VST2 by default now that it does not need VST2 SDK anymore
- Tweaks for improved Linux behaviour
- Old mingw compatibility

### From scratch

Besides using DPF and JUCE for plugins, I have also created some from scratch, using the format-specific APIs directly.  
Typically I would go with DPF for plugins, but while keeping DPF intentionally simple there will be a few things it cannot do (like multi MIDI IO).

#### [audio-bridge](https://github.com/falkTX/audio-bridge)

An LV2 audio plugin to bridge audio from the host (or a JACK client) into an ALSA device and vice-versa.  
Created as an attempt to get the [MOD Dwarf](https://mod.audio/dwarf/) unit working as USB audio interface, but very likely useful in other scenarios too.

The project is considered still in progress, as it needs more tweaks to become more reliable and resilient against unexpected audio timings (the Dwarf USB2 driver is far from optimal).

#### [FluidPlug](https://github.com/falkTX/FluidPlug)

Simple synth-like plugins that make use of soundfonts loaded through [fluidsynth library](https://www.fluidsynth.org/), with each plugin hardcoded to a soundfont.

Created as a way to get some simple sound generators for LV2 plugin hosts that do not yet support LV2 file parameters.

#### [JackAss](https://github.com/falkTX/JackAss)

Very simple VST2 plugin that receives MIDI from the host and outputs it in a JACK-MIDI port.
A FX variant is also available, exposes a few parameters that generate MIDI CC events when changed.

Created out of personal necessity.

#### [portal-lv2](https://github.com/falkTX/portal-lv2)

A plugin made for modular hosts that support multi-threaded processing, allowing to split a single audio processing chain into 2 and thus forcing parallelization of the audio path.
The implementation of the plugin is quite simple, just some buffer copying and thread-sync via semaphores.

Created out of curiosity, to see if such setup would even work. Turns out it is quite useful, specially on multi-threaded systems where single-CPU-core performance is very limited. See https://forum.mod.audio/t/introducing-portal/9329 for a user discussion about it.

# TODO remove this part, only mention relevant plugins, like convolution loader

Lots of plugins from https://github.com/moddevices most of them being LV2.
I participated in either creating or reviewing the plugins.
With MOD being a fixed mostly self-contained target, there is little maintenance for these.

## Desktop applications

### Carla

# TODO finalize text

An modular, feature-full audio plugin host, so we can load all those audio plugins.  
Has a split backend vs frontend design, which allows the backend to be used in other projects (as seen above in Cardinal and Ildaeil, but also part of LMMS and Zrythm).

Backend is written in C++ with frontend using Python + Qt.  
The backend has no required external dependencies, I wrote a lot of custom low-level code (dealing with shared memory, semaphores, IPC, threading, etc) so it could be this way.  
A few libraries are included in Carla codebase (like RtAudio, RtMidi and serd+sord+sratom+lilv combo) not just for easy building but also to patch their sources.

Carla integrates directly in JACK with its multi-client engine (1 plugin = 1 client) or all plugins as a single client, or abstracted from JACK with its own internal patchbay graph.  
Native audio and MIDI is provided through the use of JUCE, RtAudio+RtMidi and SDL.

Carla natively supports LADSPA, DSSI, LV2 and VST2 plugin formats, with JUCE used to have extra plugin support (VST3 and AU).  
A native VST3 host implementation is in currently in development.  
Plugin bridging works already, using a custom implementation.

Extra file support includes SF2/3 using fluidsynth, SFZ using an internal SFZero fork, JSFX (contributed by Jean ...)

Still experimental, under Linux Carla can load JACK standalone applications within itself, by faking a JACK server.  
This uses a similar setup as plugin bridges do, with LD_PRELOAD "magic" to force applications to see Carla's custom libjack.so instead of the real one.  
Applications end up talking to Carla but have no knowledge of such.  
Please note that only parts of the JACK API are implemented in this mode, but enough to get most applications to work.

### Cadence and tools

# TODO describe being abandoned, but the start of other tools that have grown from it

One of the very first projects I started is Cadence, as a way to learn GUI programming and have something useful for managing JACK and Linux audio.
All code was initially written in Python with Qt as the GUI, with a few tools later converted to C++ for having proper realtime performance.

Over time Cadence small parts have moved into other projects:

- patchbay canvas code was integrated in Carla, where it received many updates
- branched off from Carla canvas, RaySession uses the same code as base but with its own style (external project, not my own)
- pyjacklib became its own project (external project I am helping maintain)
- qjackrec thing (external project, not my own)
- bigmeter and xycontrollers were added as internal plugins in Carla

It is my plan to split things from Cadence even more, making smaller projects with their own independent releases instead of a big toolbox like it kinda is now.  
The canvas code likely needs to be its own thing, but it is not the case yet.

### MOD Live-USB Welcome/Setup

# TODO finalize text

I created a tool to serve as welcome screen for Linux-based Live USBs, meant to run in full screen and setup audio related things.  
The intention is to show a setup screen at the start, which will then start a systemd service that handles the audio (JACK with internal clients).  
Then external application windows are embed into it, as if they are part of the it.

This tool is written in C++ and Qt, with some KDE things because they are just so handy.  
Since it is booting from a self-contained system (the live USB), dependencies on KDE frameworks is not an issue.  
We can enjoy some text editing, terminal emulator, file explorer, pdf viewer and other complex widgets with just a few lines of code.

For the usecase I wrote this for the external application was actually a local webserver, so a Qt web browser widget is used.

It is likely that this live USB setup can be adapted for other applications, perhaps not even audio related.

## Backend

mod cloud builder

## Dev-Ops

Except for email and proprietary platforms, pretty much all my all social / online service usage is self-hosted.  
This includes stuff like data backups, video streaming (as creator/uploader) and website hosting.

I like Debian and Apache for hosting serving web content, and know those fairly well at this point.  
When setting up self-hosted services I typically go with a systemd service (if the service is simple and self-contained), or rely on docker and/or docker-compose to keep them contained.

Here are a few things I have hosted:

- [kx.studio](https://kx.studio/) - Good old static website hosting
- [Gitea](https://peertube.kx.studio/) - Nice and fast, can be compiled into a single binary (golang based)
- [Mastodon](https://mastodon.falktx.com/) - Complex with many services (come follow me!)
- [MOD Box](https://modbox.kx.studio/) - Custom setup, experimental, using server-side audio rendering streamed using WebRTC
- [NextCloud](https://nextcloud.falktx.com/apps/gallery/s/HNidExQiALAAyoe) - Easy to manage and update (enjoy the photos!)
- [PeerTube](https://peertube.kx.studio/) - Complex and only officially supports nginx, but it works
- [RocketChat](https://chat.kx.studio/) - Complex and fragile, will likely remove it soon

## Web audio

client-side web-assembly: Cardinal, Ildaeil

server-side with webrtc streaming: modbox

## Web development

- mod-ui maintenance and new development
- kxstudio site, no JS in use
- falktx and this site

https://github.com/falkTX/danoft ??

## Open-Source contributions

- calf
- dragonflyreverb many PRs
- lsp CI setup
- sassy linux build https://github.com/falkTX/sassy
- wolf-shaper high-dpi port
- zamaudio
- zynaddsubfx plugin support (started in carla, remade in DPF)

https://github.com/falkTX/drmr

https://github.com/ninodewit/SHIRO-Plugins

https://github.com/falkTX/jack_interposer

https://github.com/falkTX/invada-studio-plugins-lv2

https://github.com/falkTX/protrekkr

PS: list a bunch of pull requests for patches/fixes/etc

## Other work

CI/CD github actions

- Embed Linux buildroot
- Linux Live CD/USB ISO setups
- jack2 maintenance
- KXStudio repo packaging

https://github.com/falkTX/nooice

https://github.com/DISTRHO/PawPaw

https://github.com/wineasio/wineasio/

### WIP

#### [OneKnob-Series](https://github.com/DISTRHO/OneKnob-Series)

# TODO finalize text

The OneKnob-Series is planned to be a collection of stupidly simple but well-polished and visually pleasing audio plugins, with as little controls as possible, often just one knob and a few options.

It is still in development and research phase, I started it as a way to use/test/develop oui-blendish widgets within DPF.

![OneKnob-Series](https://github.com/DISTRHO/OneKnob-Series/blob/main/plugins/BrickwallLimiter/Screenshot.png)

https://github.com/falkTX/Chibi
https://github.com/falkTX/kuriborosu

https://github.com/falkTX/FFmpeg/commits/n4.4-jackoutdev

OBS audio plugin w/ carla
