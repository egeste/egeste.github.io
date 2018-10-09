---
title: 'Javascript Audio Visualization pt3, Building Awesome Audio Visualizations'
date: 2018-07-10 00:00:00
categories: [ programming ]
tags: [ javascript, visualization, react, react-vis ]
---
Ever wanted to use javascript to create rich audio visualizations? This is part 3 of my series on Javascript Audio Visualization. In this article, we'll be building a couple of fancy audio visualizations on top of our frequency data visualization we built in [Javascript Audio Visualization pt2, Building A Simple Data Visualization](http://egeste.net/blog/Javascript-Audio-Visualizations-pt-2/)

The only thing left to do now is make some awesome data visualizations. As before, our data visualizations are simply layers of react-vis components with data shaped to our liking. From the previous article, there are a couple things worth noting.

## Empty Frequencies

If you noticed in all of the linear style visualizations, and as is to be expected, the range of frequencies actually expressed in a typical song does not translate into data across all frequency ranges at all times.

![Frequency data gaps](./images/no_freq_data.png "Frequency data gaps")

This is not a bug, it's actually a factually correct representation of the frequency data at the moment it was sampled. But we're building "cool", not "factually accurate" (which is usually the same thing, but uncommonly artistically or spiritually). Since we don't care about the graph fidelity, we can just mutate the data as we see fit to achieve the desired outcome.

## Bounce

Let's start by simply filtering values below a certain threshold.

```es6
const filteredData = frequencyData.filter(y => y > 75)
```

This will make the resulting visualization sort of "bounce" as frequencies enter and exit our threshold of `75`, as well as removing those pesky empty frequencies at the end of the graph.

<iframe id="storybook-preview-iframe" title="preview" src="http://egeste.net/exploring-audio-vis/iframe.html?selectedKind=AudioVisualiser&selectedStory=With%20a%20LineSeries" allowfullscreen="" style="width: 640px; height: 400px; margin: 2rem auto; padding: 0px; display: block; border: 3px outset"></iframe>

## Put your thing down, flip it, & reverse it

If we want to make a bouncy spectrograph, we can just take our AreaSeries graph and add a `y0` value of `-y`.

```es6
const filteredData = frequencyData.filter(y => y > 75)
const forwardData = filteredData.map((y, x) => ({ x, y, y0: (y * -1) }))
const reversedData = forwardData.map(({ x, y, y0 }) => ({ y, y0, x: (x * -1) })).reverse()
const data = [ ...reversedData, ...forwardData ]
```

You basically just put your thing down flip it & reverse it.

<iframe id="storybook-preview-iframe" title="preview" src="http://egeste.net/exploring-audio-vis/iframe.html?selectedKind=AudioVisualiser&selectedStory=With%20a%20LineSeries" allowfullscreen="" style="width: 640px; height: 400px; margin: 2rem auto; padding: 0px; display: block; border: 3px outset"></iframe>

## I feel pretty



## Conclusion

In this article, we leveraged the React `AudioAnalyser` component we built in the previous article to create a `AudioVisualiser` component that allowed us to shape `frequencyData` into a format that can be consumed by a `LineSeries` in a `XYPlot`. The result was a simple spectrogram with excellent performance. In the next article, we'll start to look at other types of data visualizations.
