#let GOAL(body, color: green, width: 100%, breakable: true) = {
  block(
    width: width,
    radius: 3pt,
    stroke: 0.5pt,
    fill: color,
    inset: 10pt,
    breakable: breakable,
  )[
    Points to talk about in this section:
    #body
  ]
}