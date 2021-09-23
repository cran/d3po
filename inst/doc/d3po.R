## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----pkgs, message=FALSE, warning=FALSE---------------------------------------
library(dplyr)
library(igraph)
library(d3po)

## -----------------------------------------------------------------------------
glimpse(pokemon)

## ----box1, fig.height=7-------------------------------------------------------
d3po(pokemon) %>%
  po_box(daes(x = type_1, y = speed, group = name, color = color_1)) %>%
  po_title("Distribution of Pokemon Speed by Type")

## ----bar1---------------------------------------------------------------------
pokemon_count <- pokemon %>% 
 group_by(type_1, color_1) %>% 
 count()

## ----bar2---------------------------------------------------------------------
d3po(pokemon_count) %>%
  po_bar(
    daes(x = type_1, y = n, group = type_1, color = color_1)
  ) %>%
  po_title("Count of Pokemon by Type")

## -----------------------------------------------------------------------------
d3po(pokemon_count) %>%
  po_treemap(
    daes(size = n, group = type_1, color = color_1)
  ) %>%
  po_title("Share of Pokemon by Type")

## -----------------------------------------------------------------------------
d3po(pokemon_count) %>%
  po_pie(
    daes(size = n, group = type_1, color = color_1)
  ) %>%
  po_title("Share of Pokemon by Type")

## ----line1--------------------------------------------------------------------
pokemon_decile <- pokemon %>% 
  filter(type_1 %in% c("grass", "fire", "water")) %>% 
  group_by(type_1 ,color_1) %>% 
  summarise(
    decile = 0:10,
    weight = quantile(weight, probs = seq(0, 1, by = .1))
  )

## ----line2--------------------------------------------------------------------
d3po(pokemon_decile) %>%
  po_line(
    daes(x = decile, y = weight, group = type_1, color = color_1)
  ) %>%
  po_title("Decile of Pokemon Weight by Type")

## ----area1--------------------------------------------------------------------
pokemon_density <- density(pokemon$weight, n = 30)

pokemon_density <- tibble(
 x = pokemon_density$x,
 y = pokemon_density$y,
 variable = "weight",
 color = "#5377e3"
)

## ----area2--------------------------------------------------------------------
d3po(pokemon_density) %>%
 po_area(
  daes(x = x, y = y, group = variable, color = color)
 ) %>%
 po_title("Approximated Density of Pokemon Weight")

## ----scatterplot1-------------------------------------------------------------
pokemon_def_vs_att <- pokemon %>% 
  group_by(type_1, color_1) %>% 
  summarise(
    mean_def = mean(defense),
    mean_att = mean(attack),
    n_pkmn = n()
  )

d3po(pokemon_def_vs_att) %>%
  po_scatter(
    daes(x = mean_att, y = mean_def, size = n_pkmn, group = type_1, color = color_1)
  ) %>%
  po_title("Average Attack vs Average Defense by Type")

## ----network1-----------------------------------------------------------------
tr <- make_tree(40, children = 3, mode = "undirected")

## ----network2-----------------------------------------------------------------
d3po(tr) %>% 
  po_layout() # optional

## ----network3-----------------------------------------------------------------
edges <- igraph::as_data_frame(tr, "edges")

## -----------------------------------------------------------------------------
d3po() %>% 
  po_edges(data = edges)

## -----------------------------------------------------------------------------
d3po(pokemon_count) %>%
  po_treemap(
    daes(size = n, group = type_1, color = color_1, align = "left")
  ) %>%
  po_title("Share of Pokemon by Type") %>% 
  po_labels("left", "top") %>% 
  po_font("Times")

