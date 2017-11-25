---
title: 'Javascript Audio Visualization pt2, Building A Simple Data Visualization'
date: 2017-11-24 00:00:00
categories: [ programming ]
tags: [ javascript, visualization, react, react-vis ]
---
Ever wanted to use javascript to create rich audio visualizations? This is part 2 of my series on Javascript Audio Visualization. In this article, we'll be building a simple data visualization to use with the frequency data we are extracting in [Javascript Audio Visualization pt1, Web Audio API](http://egeste.net/blog/Javascript-Audio-Visualizations-pt-1/)

## Getting Started

As mentioned in the previous article, I'll be using Uber's [react-vis](https://github.com/uber/react-vis) library for data visualizations. I won't go over all the details on how to use react-vis. For that, check out the documentation on their github.

The goal for this visualization is simple. Create what amounts to a line chart where the Y axis represents `amplitude` and the X axis represents `frequency`. A line chart is actually featured at the beginning of the [react-vis README](https://github.com/uber/react-vis/blob/master/README.md#usage) as follows:

```javascript
<XYPlot
  width={300}
  height={300}>
  <HorizontalGridLines />
  <LineSeries
    data={[
      {x: 1, y: 10},
      {x: 2, y: 5},
      {x: 3, y: 15}
    ]}/>
  <XAxis />
  <YAxis />
</XYPlot>
```

Doesn't get much easier than that. In fact, if we build a simple "connector" to bridge our `AudioAnalyser`'s `onFrequencyData` interface directly to a rendering function, we can implement a simple line graph visualization without needing to write a custom component. Such an implementation would look something like this:

```javascript
import React, {
  PureComponent
} from 'react'

import PropTypes from 'prop-types'

import AudioAnalyser from './AudioAnalyser'

export default class AudioVisualiser extends PureComponent {

  static propTypes = {
    renderFrequencyData: PropTypes.func.isRequired
  }

  state = { frequencyData: [] }

  onFrequencyData = frequencyData => this.setState({ frequencyData })

  render() {
    return (
      <div>
        <AudioAnalyser src={ this.props.src }
          onFrequencyData={ this.onFrequencyData }
          style={ { width: '100%' } }
        />
        { this.props.renderFrequencyData([ ...this.state.frequencyData ]) }
      </div>
    )
  }

}
```

With this interface, we can simply create an instance of `AudioVisualiser`, pass it a `src` audio file to play, and provide a `renderFrequencyData` function that returns an instance of a React component. To that end, let's wire these things together to create our line graph audio visualiser.

```javascript
<AudioVisualiser src={ /* some-audio-source */ }
  renderFrequencyData={ frequencyData => {
    // The upper third of data is outside of normal hearing/music range. Strip it out.
    const oneThirdLength = frequencyData.length / 3
    const lowerTwoThirds = frequencyData.slice(0, -oneThirdLength)

    // Iterate over the frequencies, mapping the amplitude to `y` and the index to `x`.
    const data = lowerTwoThirds.map((y, x) => ({ x, y }))

    // Render a standard line graph with the data
    return (
      <XYPlot width={ 600 } height={ 300 }>
        <LineSeries data={ data } />
        <XAxis />
        <YAxis />
      </XYPlot>
    )
  } }
/>
```

Which gives us a sort of spectogram of the audio we're playing, as seen below.

<iframe id="storybook-preview-iframe" title="preview" src="http://egeste.net/exploring-audio-vis/iframe.html?selectedKind=AudioVisualiser&selectedStory=With%20a%20LineSeries" allowfullscreen="" style="width: 640px; height: 360px; margin: 2rem auto; padding: 0px; display: block; border: 3px outset"></iframe>

## Conclusion

In this article, we leveraged the React `AudioAnalyser` component we built in the previous article to create a `AudioVisualiser` component that allowed us to shape `frequencyData` into a format that can be consumed by a `LineSeries` in a `XYPlot`. The result was a simple spectrogram with excellent performance. In the next article, we'll start to look at other types of data visualizations.
