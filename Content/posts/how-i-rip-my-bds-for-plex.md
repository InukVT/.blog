---
title: How I Rip My BD's for Plex
slug: how-i-rip-my-bds-for-plex
date: 2020-03-03 13:43
date_updated: 2020-03-03T13:43:38.000Z
tags: home server, automation, plex, how to
description: Ripping discs for use with Plex is easy and fast. Click here to know more!
---

I've successfully publidshed a post every monday the last month or so, and I plan to have the first monday in the month be about home servers. My home server runs FreeBSD, and last time I tried to compile Swift for it, [it didn't go to well](https://bugs.swift.org/browse/SR-10494), so I can't tack that on this umbrella. Instead I'll go through my how I take my Blu-Ray's and put them on my Plex server, this is legal in my country, as it's to view on an otherwise unsupported device (my phone, laptop or Apple TV).

## The Tools

My Blu Ray drive is the [LG BP55EB40](https://www.proshop.dk/Optiske-Drev-DVD-BR-Floppy/Hitachi-LG-BP55EB40-Bluray-BDRW-Braender-USB-20-Sort/2522229), which I got on a local drive. Currently I haven't found a way to flash it with firmware for region locked BD's, so for now I'm just getting region B discs.

## Process

First I pick up the disc I intend to rip, and put it in the external BD reader.

I then open MakeMKV, and click the folder icon, when the disc has loaded. I Select my desired directory for saving the raw dump.

Once MakeMKV is done dumping the raw disc, I open HandBrake, and select the raw's folder as source, selecting each individual episode. Note that some episodes shows multiple times, remember to look at the small preview.

When all the encoding is done, it's time to move the encoded files to the desired directory. I have a NAS, where my Plex server lives, and put my media there.

### HandBrake Settings

The container I use is MKV, while I have to transcode when watching on Apple TV as a result, I've experienced issues using the MP4 container, where audio and subtitles didn't carry, as a result I much prefer the transcoding.

I use [MakeMKV](https://www.makemkv.com) for drm removal as well as raw dumping of the drive. I'm not a big fan of the encoding options, especially for series, so I use [HandBrake](https://handbrake.fr) for encoding my raw BD dump. HandBrake is in my opinion much better for individual episode encoding.

I'm using the H.265 codec at 10-bit with the X.265 encoder, this makes for the smallest file sizes, though the difference between H.265 and H.264 are said to be negligable, so decide your codec on your own.

As for audio I use the pass-through option to not degrade the quality, and include Danish, Enlish and whatever the medias original language is. The Danish version is for younger family members, English is for those who prefer to hear and not read subtitles and the original audio track is for me, a complete sub over dub snob!

For subtitles I only include Danish and English, as I don't know anyone who needs other options.
