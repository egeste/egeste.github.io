---
layout: post
title: "Emergence"
subtitle: "On the gap between what you build and what it becomes."
date: 2026-03-09 00:00:00 -0000
tags: [engineering, philosophy, emergence, complexity, craft]
author: Steve
description: "How a simple mesh animation became a living system, and what it taught me about the gap between rules and behavior."
---

If you've been on this site for more than a few seconds, you've probably noticed the background. Dots drifting across the screen. Lines forming between them when they get close enough. Clusters gathering, thickening, then thinning out and dispersing. New dots appearing. Old ones fading away.

Watch it long enough and something shifts. The movement stops looking random. You may start to see patterns - neighborhoods forming, densities pulsing, whole regions going quiet while others light up. It starts to look like it's breathing. Like it wants something.

It doesn't.

## What It Actually Knows

The entire behavior set of the mesh is shockingly small. Each node knows how to do exactly five things: move in a direction, draw a line to anything nearby, get older, die, and occasionally - if another mature node is close enough - procreate.

That's it. There's no flocking algorithm. No pathfinding. No central coordination. No node has any concept of the patterns you're watching.

The children inherit traits from their parents - a small bundle of genetic values that influence how fast they move, how social they are, how long they live:

```javascript
genetics: {
  speed: parentNode ? parentNode.genetics.speed * (0.9 + Math.random() * 0.2) : Math.random(),
  sociability: parentNode ? parentNode.genetics.sociability * (0.9 + Math.random() * 0.2) : Math.random(),
  longevity: parentNode ? parentNode.genetics.longevity * (0.9 + Math.random() * 0.2) : Math.random()
}
```

The population is governed by a logistic map - one of the most studied equations in mathematics, and one of the strangest:

```javascript
const nextRatio = r * currentRatio * (1 - currentRatio);
```

One line. Multiply the current population ratio by a growth rate and by the remaining capacity. That's it. But this equation contains a universe.

When the growth parameter `r` is low, the population settles to a single stable value. Predictable. Boring. Increase `r` and something happens - the population stops converging and begins oscillating between two values. Increase it further and those two values split into four. Then eight. Then sixteen. Each split is a *bifurcation* - a point where the system's behavior fundamentally doubles in complexity.

Keep pushing and the bifurcations cascade until the system crosses a threshold into chaos. Not randomness - *chaos*. Deterministic, governed entirely by that one equation, yet effectively unpredictable. And within the chaos, if you look closely, there are windows of sudden order. Brief periodicities that appear, hold, and shatter again.

In the mesh, `r` oscillates slowly over time. The population target drifts through stable regimes, periodic regimes, and the edges of chaotic ones. The nodes don't know this. They just live and die. But the rhythm of the whole system - the way it breathes, the way clusters swell and thin - that rhythm is the logistic map playing out across dozens of small lives.

That's the entire system. Five behaviors, three inherited traits, and one equation with a universe inside it. Everything else you see - the clustering, the breathing, the sense of something alive - is emergent. It exists in the space between the rules, in a place no one designed.

## Something From Nothing

This isn't a trick. This is how the universe works.

Neurons don't know about thoughts. No individual neuron has ever had an idea. But billions of them, following simple electrochemical rules - fire or don't fire, strengthen this connection, weaken that one - produce consciousness. Or at least something close enough that we've spent a few thousand years arguing about it.

Ants don't know about colonies. No ant has a blueprint of the nest. But local interactions - follow this pheromone trail, pick up this grain of sand, feed this larva - produce architecture, agriculture, warfare, and something that looks unsettlingly like decision-making.

Traders don't know about markets. Each one is responding to local signals - price, rumor, gut feeling. But the aggregate produces cycles, crashes, bubbles, and a kind of collective intelligence that no individual participant possesses.

The mesh on this page is a tiny, cheap instance of the same fundamental pattern. Simple agents. Local rules. No central plan. And behavior that exceeds anything specified.

The word for this is emergence, and once you start seeing it, you see it everywhere.

## Building Conditions

You can't design emergence. But you can design the conditions for it.

**Specify behaviors, not outcomes.** I never told the mesh to cluster. I never told it to breathe or pulse. I told individual nodes how to move, how to reproduce, how to die. The patterns are consequences, not instructions. The moment you try to dictate the emergent behavior directly, you kill it. You get an animation, not a system.

**Death is not optional.** Early versions of the mesh were immortal. Nodes spawned and never left. Within seconds, the canvas was a dense, undifferentiated mass - no structure, no movement, no life. It looked full but felt dead. Adding death - real death, with fadeouts and genetic pressure and overpopulation stress - was what made the system come alive. Turnover creates space. Space creates possibility. Possibility creates pattern.

**The container shapes the contents.** One commit changed the edge behavior from deletion to wrapping - nodes that drift off the right side reappear on the left. That single change transformed the entire feel of the system. The population stabilized. The patterns became richer. The same agents, the same rules, but a different boundary condition, and a completely different world emerged. What you leave out of the system matters as much as what you put in.

**Structured instability is the goal.** The logistic map doesn't stabilize the population. It pushes the system through bifurcation after bifurcation - stable, then oscillating, then doubling, then edging toward chaos. The interesting dynamics live in those transitions. Too much order and the system is dead. Too much chaos and it's noise. The sweet spot is the narrow band right before the next bifurcation, where the system is complex enough to surprise you but coherent enough to hold together.

## But Why?

You could build a mesh animation in an afternoon. Connect some dots, make them drift, call it a day. It would look fine. But it wouldn't *do* anything you didn't explicitly tell it to do. It would be a screensaver, not a system.

The gap between those two things is where the interesting work lives. Not just in mesh animations - in organizations, in products, in any system where you want behavior that exceeds what you specified. The discipline is the same: define the smallest set of rules that produces the richest possible dynamics, and then get out of the way.

The mesh is running behind this text right now. Click somewhere and add a node. Watch what happens. Watch how the existing network responds - how connections form, how the local density shifts, how your node ages and eventually fades.

You didn't design the pattern that forms. Neither did I.
