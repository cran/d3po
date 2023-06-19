## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>",
  fig.width = 10,
  fig.height = 5
)

## ----pkgs, message=FALSE, warning=FALSE---------------------------------------
#  library(dplyr)
#  library(d3po)

## -----------------------------------------------------------------------------
#  glimpse(pokemon)

## ----box1, fig.height=7-------------------------------------------------------
#  d3po(pokemon) %>%
#    po_box(daes(x = type_1, y = speed, color = color_1)) %>%
#    po_title("Distribution of Pokemon speed by main type")

## ----bar1---------------------------------------------------------------------
#  dout <- pokemon %>%
#    group_by(type_1, color_1) %>%
#    count()
#  
#  d3po(dout) %>%
#    po_bar(daes(x = type_1, y = n, color = color_1)) %>%
#    po_title("Share of Pokemon by main type")

## -----------------------------------------------------------------------------
#  dout <- pokemon %>%
#    group_by(type_1, color_1) %>%
#    count()
#  
#  d3po(dout) %>%
#    po_treemap(daes(size = n, group = type_1, color = color_1)) %>%
#    po_title("Share of Pokemon by main type")

## -----------------------------------------------------------------------------
#  d3po(dout) %>%
#    po_pie(daes(size = n, group = type_1, color = color_1)) %>%
#    po_title("Share of Pokemon by main type")

## -----------------------------------------------------------------------------
#  d3po(dout) %>%
#    po_donut(daes(size = n, group = type_1, color = color_1)) %>%
#    po_title("Share of Pokemon by main type")

## ----line1--------------------------------------------------------------------
#  dout <- pokemon %>%
#    filter(
#      type_1 == "water"
#    ) %>%
#    group_by(type_1, color_1) %>%
#    reframe(
#      probability = c(0, 0.25, 0.5, 0.75, 1),
#      quantile = quantile(speed, probability)
#    )
#  
#  d3po(dout) %>%
#    po_line(daes(
#      x = probability, y = quantile, group = type_1,
#      color = color_1
#    )) %>%
#    po_title("Sample Quantiles for Water Pokemon Speed")

## ----area1--------------------------------------------------------------------
#  d3po(dout) %>%
#    po_line(daes(
#      x = probability, y = quantile, group = type_1,
#      color = color_1
#    ), stacked = FALSE) %>%
#    po_title("Sample Quantiles for Water Pokemon Speed")

## ----scatterplot1-------------------------------------------------------------
#  dout <- pokemon %>%
#    group_by(type_1, color_1) %>%
#    summarise(
#      attack = mean(attack),
#      defense = mean(defense)
#    ) %>%
#    mutate(log_attack_x_defense = log(attack * defense))
#  
#  d3po(dout) %>%
#    po_scatter(daes(
#      x = defense, y = attack,
#      size = log_attack_x_defense, group = type_1, color = color_1
#    )) %>%
#    po_title("Pokemon Mean Attack vs Mean Defense by Main Type")

## -----------------------------------------------------------------------------
#  dout <- map_ids(d3po::maps$asia$japan)
#  dout$value <- ifelse(dout$id == "TK", 1L, NA)
#  dout$color <- ifelse(dout$id == "TK", "#bd0029", NA)
#  
#  d3po(dout) %>%
#    po_geomap(
#      daes(
#        group = id, color = color, size = value,
#        tooltip = name
#      ),
#      map = d3po::maps$asia$japan
#    ) %>%
#    po_title("Pokemon was created in the Japanese city of Tokyo")

## -----------------------------------------------------------------------------
#  d3po(pokemon_network) %>%
#    po_network(daes(size = size, color = color, layout = "kk")) %>%
#    po_title("Connections Between Pokemon Types")

## -----------------------------------------------------------------------------
#  dout <- pokemon %>%
#    group_by(type_1, color_1) %>%
#    count()
#  
#  d3po(dout) %>%
#    po_treemap(daes(size = n, group = type_1, color = color_1)) %>%
#    po_title("Share of Pokemon by main type") %>%
#    po_labels("left", "top", F) %>%
#    po_background("#ffcc00") %>%
#    po_font("Comic Sans MS", 20, "uppercase")

