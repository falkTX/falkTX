# Hi there 👋 Welcome to my profile page! 🤓

Here is a list of projects I have worked on, either for a job or for fun and research, sometimes as a challenge too.

A possibly updated version of this content is also available online at [falktx.berlin](https://falktx.berlin/).

If you are interested on hiring me for something similar to what you see here, please get in touch!  
You can reach me at [falktx@falktx.com](mailto:falktx@falktx.com), expect negotiable rates around 60eur/h, half of that if doing it as an open-source project.
Other details about my work can be found [in my CV](https://falktx.com/files/cv.pdf).

If you are just browsing through and like what you see here, please know I have a [Patreon page](https://patreon.com/falktx) you can subscribe to. :)

## Audio plugins

### [DISTRHO Plugin Framework](https://github.com/DISTRHO/DPF)

[DISTRHO Plugin Framework](https://github.com/DISTRHO/DPF), or DPF for short, is a **minimalistic C++ framework for audio plugins**.  
I started it many years ago after being disappointed with the available options for making desktop audio plugins.
Pretty much all the existing options did not support Linux (most still don't) or did so in a subpar way.

The idea behind DPF was (and still is) to have something that is stupid simple and works well, intentionally not supporting more esoteric features. This applies to graphics as well, for which DPF does not implement its own draw operations but instead uses Cairo, OpenGL or Vulkan through a [pugl](https://github.com/lv2/pugl) backend.

By having OpenGL as a possible graphics drawing API, many existing "mini toolkits" can be easily ported over to work with DPF.  
I added NanoVG as one of such "mini toolkits", directly integrated in the DPF project.  
Also added others like [oui-blendish](https://github.com/IceDragon200/oui-blendish) and [Dear ImGui](https://github.com/ocornut/imgui) to the separate [DPF-Widgets](https://github.com/DISTRHO/DPF-Widgets) project.

So far I have implemented LADSPA, DSSI, LV2, VST2, VST3 and CLAP plugin formats, with an extra standalone type that can use JACK if available otherwise falls back to the default audio driver in the system (via RtAudio and SDL).

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

A wasm/browser version is available to try online at [aida.kx.studio](https://aida.kx.studio/).

![AIDA-X](https://raw.githubusercontent.com/AidaDSP/AIDA-X/main/docs/Screenshot.png)
\

#### [Cardinal](https://github.com/DISTRHO/Cardinal)

Cardinal is a modular synthesizer plugin, based on [VCV Rack](https://vcvrack.com/) but with a focus on being a fully self-contained plugin version.

Created first and foremost as a way to have Rack as a conventional open-source audio plugin, following good practices for an audio plugin (a proper audio plugin should be self-contained as much as possible, as to not interfere with the DAW/Host; loading external modules clearly goes against this idea, which is how Rack operates).  
Also as a way to have a Rack version with support for more than just the basic 3 desktop operating systems, plus LV2 format. 

I created a few custom modules and also ported [AIDA-X](#aida-x), [Carla](#carla), [glBars](#glbars), [Ildaeil](#ildaeil) and [PitchTrackingSeries](#pitchtrackingseries) to it.

A wasm/browser version is available to try online at [cardinal.kx.studio/live](https://cardinal.kx.studio/live).

![Cardinal](https://raw.githubusercontent.com/DISTRHO/Cardinal/main/docs/Screenshot_Basic-Patching.png)
\

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
\

#### [Ildaeil](https://github.com/DISTRHO/Ildaeil)

Ildaeil is mini-plugin host working as a plugin, allowing one-to-one plugin format reusage.  
The idea is to load it as a plugin inside the DAW and then the other "real" plugin inside Ildaeil.  
This allows, for example, a VST3 host to load LV2 plugins.

Ildaeil is mostly "glue code" to combine all aspects of [Carla](#carla) and [DPF](#dpf).  
[Dear ImGui](https://github.com/ocornut/imgui) is used for handling UI things.  
Most of the complexity in Ildaeil comes from embedding hosted plugin GUIs while still displaying Ildaeil's own OpenGL-based GUI.

![Ildaeil](https://kx.studio/repo/screenshots/ildaeil.png)
\

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
\

![master_me expert view](https://raw.githubusercontent.com/trummerschlunk/master_me/master/img/screenshot-expert.png)
\

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
\

![PingPongPan](https://raw.githubusercontent.com/DISTRHO/mini-series/master/plugins/PingPongPan/Screenshot.png)
\

#### [MVerb](https://github.com/DISTRHO/MVerb)

An open-source reverb, [originally created as VST2](https://github.com/martineastwood/mverb/), which I have ported to DPF as a way to get its GUI running on Linux and with an LV2 version too.
It also serves as a way to test text rendering.

![MVerb](https://raw.githubusercontent.com/DISTRHO/MVerb/master/plugins/MVerb/Screenshot.png)
\

#### [Nekobi](https://github.com/DISTRHO/Nekobi)

A simple single-oscillator synth based on the Roland TB-303.
The [original nekobee](https://github.com/gordonjcp/nekobee) was abandoned and coded in DSSI plugin format which most audio hosts do not support.

I ported it to DPF as a way to get a small synth example.  
Graphics done by [António Saraiva](http://www.facebook.com/melmaquiano).

![Nekobi](https://raw.githubusercontent.com/DISTRHO/nekobi/master/plugins/Nekobi/Screenshot.png)
\

#### [PitchTrackingSeries](https://github.com/DISTRHO/PitchTrackingSeries)

Note: This project is meant to be a plugin series, but for now there is only 1 plugin - Audio To CV Pitch - for converting audio input into CV output (in 1V/Oct range).

This plugin was started by [Bram Giesen](https://bramgiesen.com/), using [aubio library](https://github.com/aubio/aubio) for the pitch detection heavy work.

I worked on the final tweaks and polishing.

#### [ProM](https://github.com/DISTRHO/ProM)

This is an audio plugin that makes use of the the [projectM awesome music visualizer](https://github.com/projectM-visualizer/projectm/).

I started the project as a way to have more complex OpenGL setups working with DPF, but also because it's cool.

![ProM](https://raw.githubusercontent.com/DISTRHO/prom/master/plugins/ProM/Screenshot.png)
\

#### [Zinc](https://github.com/DISTRHO/Zinc)

Small utility plugins for getting sound out of plugin hosts into [JACK](https://jackaudio.org/).  
These plugins do not have any GUI or configuration whatsoever.

I created these plugins as a way to more reliably test my work-in-progress [OBS audio plugin support](#obs-audio-plugin-support), as (at the time I started the project) OBS did/does not have a way to monitor the audio output without starting a live stream.

It includes a "soft" zinc variant, that buffers audio and thus has latency, but works with hosts that dynamically change the amount of samples on each plugin process run.  
A "hard" zinc variant directly syncs the plugin host audio thread with the plugin-created JACK client, thus having no extra latency.
It requires that the plugin host is already using JACK and uses it to drive its audio engine.

### JUCE porting

My [DISTRHO-Ports](https://github.com/DISTRHO/DISTRHO-Ports) project contains a few plugins I have (im)ported and been maintaining since a few years. They either did not have a Linux version initially or lacked LV2 plugin support (which for many years was not officially part of JUCE).

Most of my work for these have been on the build setup, a few times requiring doing code fixes as well.

I [started an LV2 wrapper back in 2011](https://repo.or.cz/juce-lv2.git), which I maintained to keep up with JUCE related changes. This unofficial wrapper still exists in [DISTRHO/JUCE juce6 branch](https://github.com/DISTRHO/JUCE/tree/juce6), which has been super-seeded by an official JUCE LV2 one in JUCE7. None of my code ended up in the new official wrapper.

You can find my [set of JUCE7 patches here](https://github.com/DISTRHO/DISTRHO-Ports/tree/master/libs/juce7/patches). These include:

- Forcing GPLv3 mode
- Disabling splash screen analytics
- Bringing back old VST2 interface file (GPLv3+ licensed) from JUCE5
- Enabling VST2 by default now that it does not need VST2 SDK anymore
- Tweaks for improved Linux behaviour
- Older macOS and mingw/win32 compatibility

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

#### [MOD Convolution Loader](https://github.com/moddevices/mod-convolution-loader)

A DPF-based IR convolution plugin created for [MOD Audio](https://mod.audio/), based on my work-in-progress [One-Knob Plugin Series'](https://github.com/DISTRHO/OneKnob-Series/) IR-based reverb project, which in turn uses my [custom fork of HiFi-LoFi's FFTConvolver](https://github.com/falkTX/FFTConvolver) engine.

This MOD-specific plugin started from the need of a proprietary and commercially-compatible IR convolution engine for audio plugins.

A mono cabinet-focused and a stereo reverb-focused loader are available.

#### [portal-lv2](https://github.com/falkTX/portal-lv2)

A plugin made for modular hosts that support multi-threaded processing, allowing to split a single audio processing chain into 2 and thus forcing parallelization of the audio path.
The implementation of the plugin is quite simple, just some buffer copying and thread-sync via semaphores.

Created out of curiosity, to see if such setup would even work. Turns out it is quite useful, specially on multi-threaded systems where single-CPU-core performance is very limited. See https://forum.mod.audio/t/introducing-portal/9329 for a user discussion about it.

## Desktop applications

#### [Carla](https://github.com/falkTX/Carla)

A modular, feature-full audio plugin host, so we can load all the audio plugins mentioned above on this page.
Has a split backend vs frontend design, which allows the backend to be used in other projects (such as Cardinal, Ildaeil, LMMS and Zrythm).

Backend is written in C and C++, frontend has some C++ but still mostly in Python + Qt.  
The backend has no required external dependencies, I wrote a lot of custom low-level code (dealing with shared memory, semaphores, IPC, threading, etc) so it could be this way.  
A few libraries are included in Carla codebase (like RtAudio, RtMidi and serd+sord+sratom+lilv combo) not just for easy building but also for patching their sources.

Carla integrates directly in JACK with its multi-client engine (1 plugin = 1 client) or all plugins as a single client, or abstracted from JACK with its own internal patchbay graph.  
Native audio and MIDI is provided through the use of JUCE, RtAudio+RtMidi or SDL.

Carla natively supports LADSPA, DSSI, LV2, VST2, VST3 and CLAP plugin formats.  
Plugin bridging is possible too, using a custom implementation.

Extra file support includes SF2/3 using fluidsynth, SFZ using an internal SFZero fork and JSFX.

Still experimental, under Linux Carla can load JACK standalone applications within itself by faking a JACK server. This uses a similar setup as plugin bridges do, but with some extra LD_PRELOAD "magic" to force applications to see a custom libjack.so from Carla instead of the real one. Applications end up talking to Carla but have no knowledge of such. Only parts of the JACK API are implemented in this mode, but enough to already get most applications to work.

![Carla](https://kx.studio/repo/screenshots/carla-git.png)
\

#### [Cadence and tools](https://github.com/falkTX/Cadence)

*This project has been abandoned, but still serves as reference and has been the starting point for other tools based on it.*

This is one of the very first projects I started, as a way to learn GUI programming and have something useful for managing JACK and Linux audio. All code was initially written in Python with Qt as the GUI, with a few tools later converted to C++ for having proper realtime performance.

Over time Cadence small parts have moved into other projects:

- patchbay canvas code was integrated in [Carla](#carla), where it received many updates
- [Carla](#carla)'s canvas was branched off into [RaySession](https://github.com/Houston4444/RaySession), which uses the same code as base but with its own style (external project, not my own)
- [pyjacklib](https://github.com/jackaudio/pyjacklib) became its own project (external project I am helping maintain)
- [qjackcapture](https://github.com/SpotlightKid/qjackcapture) from the jack render tool (another external project)
- bigmeter and xycontrollers were added as internal plugins in [Carla](#carla)
- [wineasio](https://github.com/wineasio/wineasio/) settings panel

The only big remaining part to still be split off is the jack2/jackdbus settings tool and then Cadence can really die as a project.

![Cadence](https://kx.studio/repo/screenshots/cadence.png)
\

#### [MOD Live-USB Welcome/Setup](https://github.com/moddevices/mod-live-usb)

I created a tool to serve as welcome screen for Linux-based Live USBs, meant to run in full screen and setup audio related things.
The intention was to show a setup screen at the start, which will then start a systemd service that handles the audio (JACK with internal clients).
Then external application windows are embed into it, as if they are part of the it.

This tool is written in C++ and Qt, with some KDE things because they are just so handy. Since it is booting from a self-contained system (the live USB), dependencies on KDE frameworks is not an issue. We can enjoy some text editing, terminal emulator, file explorer, pdf viewer and other complex widgets with just a few lines of code. :)

For the usecase I wrote this for the external application was actually a local webserver, so a Qt web browser widget is used.

It is likely that this live USB setup can be adapted for other applications, perhaps not even audio related.

![MOD Live-USB](https://raw.githubusercontent.com/moddevices/mod-live-usb/main/Screenshot.png)
\

#### [MOD Panel](https://github.com/moddevices/mod-panel)

A simple control panel to start a few services in a sequential manner (mod-host first, then mod-ui, then browsepy) and show their output logs each in their respective tab.

Written in Python and Qt.

![MOD Panel](https://raw.githubusercontent.com/moddevices/mod-panel/master/screenshot.png)
\

## Full-stack

#### [MOD Cloud Builder](https://github.com/moddevices/mod-cloud-builder)

A [docker-compose](https://docs.docker.com/compose/) setup for hosting an audio plugin building service targeting [MOD devices](https://mod.audio/), including pushing plugin builds into MOD units connected to the local network.

The official instance runs at [builder.mod.audio](http://builder.mod.audio/) and is intentionally kept as HTTP only, due to it needing to send requests into the local network (for connecting to MOD units over websockets).

A central, public-facing webserver actively listens for requests using [socket.io](https://socket.io/) and dispatches the actual build process to another (purely server-side) docker instance. The output of the build process is sent back to the main webserver, for keeping the page active (users might assume nothing is happening otherwise) and also as way to debug build failures.

#### [MOD Host](https://github.com/moddevices/mod-host) + [MOD UI](https://github.com/moddevices/mod-ui)

Not projects I created, but have been developing and maintaining since 2016, including the addition of completely new features and porting to work on other operating systems.

The host is written in C, works with JACK and loads LV2 audio plugins. A TCP socket is used to communicate with mod-ui, the webserver written in python using tornado. This webserver also serves as frontend via HTML/JS/CSS tech.

An online version of the webserver can be played with at [modbox.kx.studio](https://modbox.kx.studio/), intentionally has no audio as this is meant to show case the frontend side of it. Use [try.mod.audio](https://try.mod.audio/) for a version that does audio, running server-side and transmitted using WebRTC. (click "Enable streaming" on the top to start audio stream)

The mod-ui project is meant to be used on desktop systems, as part of my work for MOD Audio UG we never did a variant for mobile/touch devices.

#### Self hosting

Except for email and proprietary platforms, pretty much all my all social / online service usage is self-hosted. This includes stuff like data backups, video streaming (as creator/uploader) and website hosting.

I like Debian and Apache for hosting/serving web content, and know these fairly well at this point. When setting up self-hosted services I typically go with a systemd service (if the service is simple and self-contained), or rely on docker and/or docker-compose to keep them contained.

Here are a few interesting things I am hosting, that are not just static websites:

- [cardinal.kx.studio/live](https://cardinal.kx.studio/live) - Web-assembly build of Cardinal, using brotli-compressed assets and wasm-simd when supported on client side
- [Gitea](https://git.kx.studio/) - Nice and fast git hosting, can be compiled into a single monolithic binary (golang based)
- [Jitsi](https://meet.kx.studio/) - For quick and easy calls with friends (specially handy now that the Jitsi main instance requires a user account)
- [Mastodon](https://mastodon.falktx.com/) - ActivityPub based social media platform, complex setup with many services (come follow me!)
- [NextCloud](https://nextcloud.falktx.com/apps/gallery/s/HNidExQiALAAyoe) - PHP based, easy to manage and update (enjoy the photos!)
- [PeerTube](https://peertube.kx.studio/) - Video hosting and streaming, complex setup that only officially supports nginx, but I got it to work with Apache anyway :)

## Open-Source contributions

Here comes a list of projects I have contributed to, linking directly to either the list of commits from me or a pull-request if everything is contained within it. I am not a maintainer for any of these projects.

##### [Calf Studio Gear](https://github.com/calf-studio-gear/calf/commits?author=falktx)

Implemented LV2 UI show interface, so the plugins could be used in plugins hosts that do not support UIs of type Gtk2.

##### [Dragonfly Reverb](https://github.com/michaelwillis/dragonfly-reverb/commits?author=falkTX)

Help in maintenance, specially in regards to compatibility with DPF changes.

##### [drmr](https://github.com/nicklan/drmr/pull/12)

Many fixes for better LV2 handling, crashes and event timing. Project seems abandoned now, and a new one appeared as continuation of it - [github.com/psemiletov/drumrox](https://github.com/psemiletov/drumrox).

##### [pugl](https://github.com/lv2/pugl/commits?author=falkTX)

Help in bug-fixing and testing, with the occasional feature request/proposal. DPF relies on this mini library/toolkit for all event handling, so makes sense to keep good relations with upstream.

##### [Sassy Audio Spreadsheet](https://github.com/jarikomppa/sassy/pull/1)

Tweaks to code and build system for cross-platform support. Sadly still crashes under 64bit systems, but we can at least build it now.

##### [Wolf Shaper](https://github.com/wolf-plugins/wolf-shaper/commits?author=falkTX)

Build system and plugin meta-data fixes, implemented high-dpi support.

##### [zam-plugins](https://github.com/zamaudio/zam-plugins/commits?author=falkTX)

Project setup for usage with DPF, general fixes.

##### [ZynAddSubFX](https://github.com/zynaddsubfx/zynaddsubfx/commits?author=falkTX)

Fixes to codebase to work as an audio plugin and implement plugin support through DPF.

<!-- TODO: add the rest of them, including...
freaked
https://github.com/ninodewit/SHIRO-Plugins
https://github.com/falkTX/jack_interposer
https://github.com/falkTX/invada-studio-plugins-lv2
https://github.com/falkTX/protrekkr
-->

## Other work

Because there are other interesting things to show that do not really fit in other categories.

##### [KXStudio repositories for Debian-based systems](https://kx.studio/Repositories)

I have been packaging [audio applications](https://kx.studio/Repositories:Applications) and [plugins](https://kx.studio/Repositories:Plugins) compatible with Debian-based systems for a long while, via the KXStudio project. As a way to make these packages as generic as possible (as in, to work on as many systems as possible with minimal dependencies) I also build pretty much all needed dependencies/libraries statically.

##### [CMake](https://github.com/DISTRHO/dpf-cmake-action) and [Makefile setup for GitHub CI actions](https://github.com/DISTRHO/dpf-makefile-action)

Complex GitHub CI actions specialized for building DPF-based audio plugins that use CMake or Makefile as their build system.

Serves as a demonstration for other CI actions I have setup in other projects, which look alike these ones.

##### [FFmpeg JACK output support](https://github.com/falkTX/FFmpeg/commits/n4.4-jackoutdev)

Implementation of JACK as an FFmpeg output device, which I ended up not using in the end. Might still be useful as a base for someone else to (continue to) work on.

##### [jack2](https://jackaudio.org/)

I have been maintaining the JACK2 project since 2017, bringing back macOS and Windows releases and making sure it can still run on top of modern systems.

##### [Linux kernel patching](https://github.com/moddevices/linux-mainline/commits/linux-6.1.y-patches)

As part of my work for MOD Audio, I have patched the Linux kernel build. Includes importing fixes from vendor specific kernel, doing some fixes of my own and where everything else fails add some "temporary" hacks to get things working.

##### [MOD Audio](https://github.com/moddevices/mod-lv2-extensions) and [KXStudio custom LV2 extensions](https://github.com/KXStudio/LV2-Extensions)

Custom LV2 extensions for MOD Audio and KXStudio, extending both meta-data and C APIs. Includes the ttl definitions, making it suitable for parser and plugin validation tools.

##### [OBS audio plugin support](https://github.com/obsproject/obs-studio/pull/8919)

Work-in-progress pull request for OBS, integrating parts of [Carla Plugin Host](#carla) directly in it. This allows to load LADSPA, LV2, VST2, VST3, CLAP and JSFX all in a nice single package, not to mention running in a separate process so plugins cannot crash OBS.

##### [PawPaw](https://github.com/DISTRHO/PawPaw)

A collection of bash scripts for building a set of open-source libraries statically, for Linux, macOS, Windows and Web-assembly. Involves quite some patching as some libraries were not intended to be used statically, but we want static builds for audio plugins that typically need to be self-contained.

Also builds a set of LV2 plugins for macOS and Windows, packaged in an easy and convenient installer package.

Created out of the need to have the same set of libraries for many projects, which is tedious to maintain in several projects separately. Ended up being used for many of my projects, like Cardinal and Carla, and also JACK2 official builds.
