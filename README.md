# falkTX Portfolio

This is a list of projects I have worked on, either for a job or for fun and research, sometimes as a challenge too.

If you are interested on hiring me for something similar to what you see here, please get in touch!  
You can reach me at [falktx@falktx.com](mailto:falktx@falktx.com), expect negotiable rates around 60eur/h.  
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

Please note that I keep DPF-based plugins under the [DISTRHO](https://github.com/DISTRHO) organization, just to help reduce clutter on my main account.  
Also, unfinished and very minor/simple plugins are not listed here on this page.

#### [AIDA-X](https://github.com/AidaDSP/AIDA-X)

AIDA-X is an Amp Model Player, allowing it to load models of AI trained music gear, which you can then play through! 🎸

Its main intended use is to provide high fidelity simulations of amplifiers.  
However, it is also possible to run entire signal chains consisting of any combination of amp, cab, dist, drive, fuzz, boost and eq.

This repository contains the source code for the [DPF-based](https://github.com/DISTRHO/DPF) plugin variant, see [aidadsp-lv2](https://github.com/AidaDSP/aidadsp-lv2) for the LV2 headless version of the same engine optimized to run on embedded systems such as [MOD Dwarf](https://mod.audio/dwarf/), RPi, Portenta-X8, Aida DSP OS and so on.

For ease of use, this plugin also contains a cabinet simulator via impulse response files, which runs after the Amp Model.

![AIDA-X](https://raw.githubusercontent.com/AidaDSP/AIDA-X/main/docs/Screenshot.png)

#### [Cardinal](https://github.com/DISTRHO/Cardinal)

Cardinal is a free and open-source virtual modular synthesizer plugin,
it is based on [VCV Rack](https://vcvrack.com/) but with a focus on being a fully self-contained plugin version.

More specifically, this is a DPF-based plugin wrapper around VCV Rack, using its code directly instead of forking the project,
with the target of having a proper, self-contained, fully free and open-source plugin version of Rack.

Cardinal contains Rack, some 3rd-party modules and a few internal utilities all in a single binary.  
All "Core" modules from Rack have been replaced by Cardinal equivalents, simplified to better work for an audio plugin.  
I created a few custom modules and also ported [Carla](####Carla), [Ildaeil](####Ildaeil) and [PitchTrackingSeries](####PitchTrackingSeries) to it.

See [CARDINAL-MODULES.md](https://github.com/DISTRHO/Cardinal/blob/main/docs/CARDINAL-MODULES.md) for the full list of internal modules

![Cardinal](https://raw.githubusercontent.com/DISTRHO/Cardinal/main/docs/Screenshot_Basic-Patching.png)

#### [Fadeli](https://github.com/DISTRHO/Fadeli)

An experiment with Faust Demo Library content as DPF plugins.

Basically glueing a few different projects together:

1. [DPF](https://github.com/DISTRHO/DPF)
2. [faust](https://faust.grame.fr/)
3. [faustpp](https://github.com/jpcima/faustpp)
4. [faust examples](https://faustdoc.grame.fr/examples/reverb/)

Any faust file placed in the `dsp/` directory is automatically added as part of the build.  
The template files in `template/` directory are passed through `faustpp` that converts the faust dsp file into a buildable DPF-based audio plugin.  
Then DPF takes care of the rest, producing CLAP, LADSPA, LV2, VST2 and VST3 plugins in one go.

#### [glBars](https://github.com/DISTRHO/glBars)

This is an OpenGL bars visualization plugin (as seen in XMMS and XBMC/Kodi).  
Adapted from the [jack_glbars](https://github.com/nedko/jack_glbars) project by Nedko Arnaudov.

![glBars](https://raw.githubusercontent.com/DISTRHO/glBars/master/plugins/glBars/Screenshot.png)

#### [Ildaeil](https://github.com/DISTRHO/Ildaeil)

Ildaeil is mini-plugin host working as a plugin, allowing one-to-one plugin format reusage.  
The idea is to load it as a plugin inside the DAW and then the other "real" plugin inside Ildaeil.  
This allows, for example, a VST3 host to load LV2 plugins.

Ildaeil is mostly "glue code" to combine all aspects of [Carla](####Carla) and [DPF](####DPF).  
[Dear ImGui](https://github.com/ocornut/imgui) is used for handling UI things.  
Most of the complexity in Ildaeil comes from embedding hosted plugin GUIs while still displaying Ildaeil's own OpenGL-based GUI.

![Ildaeil](https://kx.studio/repo/screenshots/ildaeil.png)

#### [Max-Gen examples](https://github.com/DISTRHO/DPF-Max-Gen) (MaBitcrush, MaFreeverb, MaGigaverb, MaPitchshift)

An experiment with Max generated code and DPF.

Based on https://github.com/Cycling74/gen-plugin-export.

#### [master_me](https://github.com/trummerschlunk/master_me)

Automatic audio mastering plugin for live-streaming, podcasting and internet radio stations.

In 2022 it was funded by the Prototype Fund, an open source software funding initiative by the german ministry of education and research.

![master_me](https://raw.githubusercontent.com/trummerschlunk/master_me/master/img/screenshot-easy.png)

![master_me](https://raw.githubusercontent.com/trummerschlunk/master_me/master/img/screenshot-expert.png)

#### [Mini-Series](https://github.com/DISTRHO/Mini-Series) (3BandEQ, 3BandSplitter, PingPongPan)

A collection of small but useful plugins, based on the good old LOSER-Dev Plugins.

This collection currently includes:
 - 3 Band EQ
 - 3 Band Splitter
 - Ping Pong Pan

![3BandEQ](https://raw.githubusercontent.com/DISTRHO/mini-series/master/plugins/3BandEQ/Screenshot.png)

![PingPongPan](https://raw.githubusercontent.com/DISTRHO/mini-series/master/plugins/PingPongPan/Screenshot.png)

#### [MVerb](https://github.com/DISTRHO/MVerb)

Studio quality, open-source reverb. Its release was intended to provide a practical demonstration of Dattorro’s figure-of-eight reverb structure and provide the open source community with a high quality reverb.

This is a DPF'ied build of [MVerb](https://github.com/martineastwood/mverb/), allowing a proper Linux version with UI.

![MVerb](https://raw.githubusercontent.com/DISTRHO/MVerb/master/plugins/MVerb/Screenshot.png)

#### [Nekobi](https://github.com/DISTRHO/Nekobi)

Simple single-oscillator synth based on the Roland TB-303.

This is a DPF'ied build of [nekobee](https://github.com/gordonjcp/nekobee), allowing LV2, VST2 and VST3 builds of the plugin,
plus a nicer UI with a simple cat animation. 🐈

![Nekobi](https://raw.githubusercontent.com/DISTRHO/nekobi/master/plugins/Nekobi/Screenshot.png)

<!--
#### [OneKnob-Series](https://github.com/DISTRHO/OneKnob-Series)

The OneKnob-Series is planned to be a collection of stupidly simple but well-polished and visually pleasing audio plugins, with as little controls as possible, often just one knob and a few options.

It is still in development and research phase, I started it as a way to use/test/develop oui-blendish widgets within DPF.

![OneKnob-Series](https://github.com/DISTRHO/OneKnob-Series/blob/main/plugins/BrickwallLimiter/Screenshot.png)
-->

#### [PitchTrackingSeries](https://github.com/DISTRHO/PitchTrackingSeries)

Is meant to be a plugin series, but for now there is only 1 variant - CV - for audio input and CV output (in 1V/Oct range).

The Audio To CV Pitch plugin is a tool that turns an audio signal into CV pitch and CV gate signals.  
This allows audio from instruments (such as guitars) to play and control synth sounds and effects.

This was started by [Bram Giesen](https://bramgiesen.com/), using [aubio library](https://github.com/aubio/aubio) for the pitch detection heavy work.  
I worked on the final tweaks and polishing.

#### [ProM](https://github.com/DISTRHO/ProM)

[projectM](http://projectm.sourceforge.net/) is an awesome music visualizer.   
DISTRHO ProM makes it work as an audio plugin

![ProM](https://raw.githubusercontent.com/DISTRHO/prom/master/plugins/ProM/Screenshot.png)

#### [Zinc](https://github.com/DISTRHO/Zinc)

An utility plugin for getting sound out of plugin hosts into [JACK](https://jackaudio.org/).

There are 2 variants - Soft Zinc and Hard Zinc.  
Both variants create a JACK client where audio from the host is played through.

These plugins do not have any GUI or configuration whatsoever.

The Soft Zinc plugin will copy audio data from the plugin host until it can be synced and sent into JACK.  
It is meant to be used on plugin hosts that are not using JACK, as a way to get audio from them into the JACK graph.

There is always some latency with this method.

The Hard Zinc plugin will attempt to directly sync the plugin host audio thread with the plugin-created JACK client.  
It requires that the plugin host is already using JACK and uses it to drive its audio engine.  
Any other usage is unsupported and is undefined behaviour (but typically results in xruns non-stop).

The plugin uses the JACK non-callback API and semaphores in order to get everything in sync.  
Under normal circunstances it shouldn't add any extra latency or DSP load.

### JUCE porting

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

https://github.com/falkTX/JackAss (using VST2 SDK)
LV2 and VST2 (using vestige header) https://github.com/falkTX/Carla/tree/main/source/plugin

https://github.com/falkTX/FluidPlug

Lots of plugins from https://github.com/moddevices most of them being LV2.
I participated in either creating or reviewing the plugins.
With MOD being a fixed mostly self-contained target, there is little maintenance for these.

https://github.com/falkTX/drmr ??

## Desktop applications

### Carla

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
- sassy linux build
- wolf-shaper high-dpi port
- zamaudio
- zynaddsubfx plugin support (started in carla, remade in DPF)

PS: list a bunch of pull requests for patches/fixes/etc

## Other work

- Embed Linux buildroot
- Linux Live CD/USB ISO setups
- jack2 maintenance
- KXStudio repo packaging

https://github.com/DISTRHO/PawPaw
