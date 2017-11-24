---
title: 'Javascript Audio Visualization pt1, Web Audio API'
date: 2017-11-23 00:00:00
categories: [ programming ]
tags: [ javascript, audio, visualization, react, react-vis, d3-shape ]
---
Ever wanted to use javascript to create rich audio visualizations?

I've been interested in [electronic music](https://soundcloud.com/egeste) ever since I was about 12 years old, and I sure do miss the old days of [winamp visualization plugins](https://en.wikipedia.org/wiki/Winamp). I found them fascinating to just sit and watch for hours on end. The artistry was on full display, but so was the raw technical skill. I used to think that something that complex would never be achievable in web browsers with javascript, but times have changed.

The web browser has evolved, introducing new APIs and capabilities that are starting to more closely resemble an operating system than a browser. Tools like [Backbone.js](http://backbonejs.org/), [Ember.js](https://www.emberjs.com/), and [React](https://reactjs.org/) have completely reimagined what building frontend applications looks like. Libraries like [D3.js](https://d3js.org/) and [p5.js](https://p5js.org/) have shown us that [we can render complex graphical information like never before](https://github.com/d3/d3/wiki/Gallery). All the while, transpilers and toolchains like [CoffeeScript](http://coffeescript.org/), [webpack](https://webpack.js.org/), [Babel](https://babeljs.io/), and [asm.js](http://asmjs.org/) have pushed the boundaries of what "javascript" even means. At this point, people have starting implementing crazy stuff like [Quake](http://www.quakejs.com/), or even [an entire Linux kernel](https://bellard.org/jslinux/), all in javascript.

Basically, the time is right for some seriously cool experimentation.

> All the examples used in this article can be found in my [exploring-audio-vis github repository](https://github.com/egeste/exploring-audio-vis/)

# Getting Started

For this project, I decided to use [React](https://reactjs.org/) with Uber's [react-vis](https://github.com/uber/react-vis) library. The reason for this choice is simply that these are the tools I've been working with a lot during at [Synack](https://www.synack.com/), so I've grown pretty familiar with them. I'm also using [Storybook](https://storybook.js.org/), simply because it makes testing components in isolation very simple, and provides most of the webpack/build configuration I need out of the box.

## Utilizing the Web Audio API

(Much thanks to [Patrick Wied](https://www.patrick-wied.at/blog/how-to-create-audio-visualizations-with-javascript-html))


Before we can even begin to look at data visualization, we need to be able to extract the frequency data from the audio file we want to play. The tool that makes this possible is the new [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API)'s `AudioContext`. To construct it is easy enough.

```javascript
const audioContext = new AudioContext()
```

Next, we need to bind our `<audio />` element to our new `AudioContext` to produce a `MediaElementAudioSourceNode`.

```javascript
const audioSource = audioContext.createMediaElementSource(audioPlayerRef.audioEl)
```

Here, `audioPlayerRef` is the instance of [ReactAudioPlayer](...) we use to control audio playback, and `audioEl` is an instance property of that component that represents an `<audio />` element.

Next, we create (and cache) our `audioAnalyser` from our newly created `audioContext`

```javascript
this.audioAnalyser = audioContext.createAnalyser()
```

Finally, we `connect()` our `audioSource` to our `audioAnalyser`, as well as the target `audioContext` `destination`.

> Note: Failing to `connect()` your `audioSource` to `audioContext.destination` will result in no sound during playback.

```javascript
audioSource.connect(this.audioAnalyser)
audioSource.connect(audioContext.destination)
```

> Note: There already exist some libraries that wrap the new [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) in React. While writing thig blog, I came across [react-audio](https://www.npmjs.com/package/react-audio). I'm sure there are more.

Now that we have our `audioAnalyser`, all we need to do is query it for the frequency data currently being played at any given point in time. To do this, we invoke the `getByteFrequencyData`, and pass it a properly sized `Uint8Array` to inject the data into.

```javascript
const frequencyData = new Uint8Array(this.audioAnalyser.frequencyBinCount)
this.audioAnalyser.getByteFrequencyData(frequencyData)
```

At this point, we can query the `audioAnalyser` at any time to extract the frequency data.

```javascript
console.log(frequencyData)
```

Which produces something that looks like this: `[ 137, 172, 187, 176, 143, 120, ... ]`

## Polling the audioAnalyser

We need to continually poll the `audioAnalyser` for new data as our audio component continues to play. While javascript provides `setTimeout` and `setInterval` for time-based operations, it's better in this case to prefer `requestAnimationFrame` simply because we intend to render the data that the `audioAnalyser` produces.

> If you're unfamiliar with `requestAnimationFrame` and why it's used for rendering-specific tasks, check out the [MDN article](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame) on it.

```javascript
onAudioFrame = () => {
  if (!this.state.playing || !this.audioAnalyser) return
  const frequencyData = new Uint8Array(this.audioAnalyser.frequencyBinCount)
  this.audioAnalyser.getByteFrequencyData(frequencyData)
  doSomethingWith(frequencyData)
  requestAnimationFrame(this.onAudioFrame)
}
```

Invoking this function will cause `onAudioFrame` to continue to be invoked at every available animation frame as long as `this.state.playing` is `true`, and `this.audioAnalyser` is defined.


## Building a React Component

> Comments for this component are inline. [Check out the latest source](https://github.com/egeste/exploring-audio-vis/blob/master/src/components/AudioAnalyser.js) for bugfixes/errata.

```javascript
import React, {
  PureComponent
} from 'react'

import PropTypes from 'prop-types'

import ReactAudioPlayer from 'react-audio-player'

export default class AudioAnalyser extends PureComponent {

  static propTypes = {
    ...ReactAudioPlayer.propTypes,
    onFrequencyData: PropTypes.func.isRequired
  }

  // Track our playing state
  state = { playing: false }

  // Analyse a single "frame" of audio
  onAudioFrame = () => {
    // Don't do anything if we're paused, or if we don't have an analyser
    if (!this.state.playing || !this.audioAnalyser) return

    // Create a new Uint8Array to inject the frequency data into
    const frequencyData = new Uint8Array(this.audioAnalyser.frequencyBinCount)

    // Inject the frequency data into the array
    this.audioAnalyser.getByteFrequencyData(frequencyData)

    // Invoke our `onFrequencyData` prop
    this.props.onFrequencyData(frequencyData)

    // On the next animation frame, repeat the process
    requestAnimationFrame(this.onAudioFrame)
  }

  // Handle the audio player ref once it's rendered
  onAudioPlayerRef = audioPlayerRef => {
    if (!audioPlayerRef || !audioPlayerRef.audioEl) return

    // Allow the audio element to read data from dubious sources
    audioPlayerRef.audioEl.crossOrigin="anonymous"

    // Interface with the Web Audio API
    const audioContext = new AudioContext()
    const audioSource = audioContext.createMediaElementSource(audioPlayerRef.audioEl)
    this.audioAnalyser = audioContext.createAnalyser()

    // Connect our audio source to the analyser
    audioSource.connect(this.audioAnalyser)

    // And also to the audio destination
    audioSource.connect(audioContext.destination)
  }

  // Create a simple interface for tracking play state
  onUpdatePlaying = (playing, callback) => (...args) => {
    // Figure out what the current/new play state is
    const isCurrentlyPlaying = this.state.playing
    const shouldNowBePlaying = playing

    // Cache the new play state
    this.setState({ playing })

    // Start tracking the audio frequencies if we started playing
    if (!isCurrentlyPlaying && shouldNowBePlaying) {
      this.onAudioFrame()
    }

    // Invoke the callback with whatever args we were passed
    if (typeof callback === 'function') {
      return callback(...args)
    }
  }

  render() {
    return (
      <ReactAudioPlayer controls
        { ...this.props }
        ref={ this.onAudioPlayerRef }
        onAbort={ this.onUpdatePlaying(false, this.props.onAbort) }
        onEnded={ this.onUpdatePlaying(false, this.props.onEnded) }
        onPause={ this.onUpdatePlaying(false, this.props.onPause) }
        onPlay={ this.onUpdatePlaying(true, this.props.onPlay) }
      />
    )
  }

}
```

# Conclusion

In this article we covered basic implementation and strategy for extracting audio frequency data from a playing audio file, and provided a component performs the task using React conventions. In the next article we'll start to build a simple data visualization. From there we'll format and aggregate the data to match our data visualization's component interface. Hopefully this won't end up like my last blog series, and I actually complete it.
