#' Shiny widget implementation of igv.js
#'
#' This shiny widget implements the javascript based Integrative Genomics Viewer made by the Broad Institute.
#' To follow the developments of igv.js please to https://github.com/igvteam/igv.js.
#' I do not claim any ownership of igv.js, I just want to be able to implement it in a shiny dashboard app.
#' 
#' @import htmlwidgets
#' @import plyr
#'
#' @export
IGVbrowser <- function(reference=NA, showKaryo=NA, showNavigation=NA, showRuler=NA, tracks=NA, 
											trackDefaults=NA, locus=NA, flanking=NA, search=NA, apiKey=NA, doubleClickDelay=NA,
											width = NULL, height = NULL) {
  # forward options using x

  x <- list(
		reference = reference,
		showKaryo = showKaryo,
		showNavigation = showNavigation,
		showRuler = showRuler,
		tracks = tracks,
		trackDefaults = trackDefaults,
		locus = locus,
		flanking = flanking,
		search = search,
		apiKey = apiKey,
		doubleClickDelay = doubleClickDelay
	)

  # create widget
  htmlwidgets::createWidget(
    name = 'IGVbrowser',
    x,
    width = width,
    height = height,
    package = 'IGVshiny'
  )
}

#' IGV track factory IGVbrowser
#'
#' Outputs a dataframe which can be transformed correctly to json format and serve as the options of a igv.js annotation track.
#'
#' @param type Track type
#' @param sourceType Type of data source. Valid values are "file", "gcs" for Google Cloud Storage, and "ga4gh" for the Global Alliance API
#' @param format File format
#' @param name Display name (label). Required 
#' @param url URL to the track data resource, such as a file or webservice. Required 
#' @param indexURL URL to a file index, such as a BAM .bai, Tabix .tbi, or Tribble .idx file.
#' @param indexed Flag used to indicate if a file is indexed or not. If indexURL is provided this flag is redundant, its main purpose is to indicate that a file is not indexed.
#' @param order Integer value specifying relative order of track position on the screen. To pin a track to the bottom use Number.MAX_VALUE. If no order is specified, tracks appear in order of their addition.
#' @param color CSS color value for track features, e.g. "#ff0000" or "rgb(100,0,100)"
#' @param height Initial height of track viewport in pixels
#' @param autoHeight If true, then track height is adjusted dynamically, within the bounds set by minHeight and maxHeight, to accomdodate features in view
#' @param minHeight Minimum height of track in pixels
#' @param maxHeight Maximum height of track in pixels
#' @param visibilityWindow Maximum window size in base pairs for which indexed annotations or variants are displayed
#' @param displayMode Annotation display mode, one of "COLLAPSED", "EXPANDED", "SQUISHED"
#' @param expandedRowHeight Height of each row of features in "EXPANDED" mode
#' @param squishedRowHeight Height of each row of features in "SQUISHED" mode
#' @param nameField For GFF/GTF file formats. Name of column 9 property to be used for feature label
#' @param maxRows Maximum number of rows of features to display
#' @param searchable If true, feature names for this track can be searched for. Use this option with caution, it is memory intensive. This option should will not work with indexed tracks.
#' 
#' @name IGVbrowser-shiny
#'
#' @export
IGVtrack <- function(type=NA,
											sourceType=NA,
											format=NA,
											name,
											url,
											indexURL=NA,
											indexed=NA,
											order=NA,
											color=NA,
											height=NA,
											autoHeight=NA,
											minHeight=NA,
											maxHeight=NA,
											visibilityWindow=NA,
											#annotation-track specific arguments:
											displayMode=NA,
											expandedRowHeight=NA,
											squishedRowHeight=NA,
											nameField=NA,
											maxRows=NA,
											searchable=NA
											#alignment-track specific arguments:
										){
		track <- list(type = type, sourceType = sourceType, format = format, name = name, url = url, indexURL = indexURL, 
  	indexed = indexed, order = order, color = color, height = height, autoHeight = autoHeight, minHeight = minHeight, 
  	maxHeight = maxHeight, visibilityWindow = visibilityWindow, displayMode = displayMode, expandedRowHeight = expandedRowHeight, 
  	squishedRowHeight = squishedRowHeight, nameField = nameField, maxRows = maxRows, searchable = searchable)
		return(track[!is.na(track)])
}

#' Shiny bindings for IGVbrowser
#'
#' Output and render functions for using IGVbrowser within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a IGVbrowser
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name IGVbrowser-shiny
#'
#' @export
IGVbrowserOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'IGVbrowser', width, height, package = 'IGVshiny')
}

#' @rdname IGVbrowser-shiny
#' @export
renderIGVbrowser <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, IGVbrowserOutput, env, quoted = TRUE)
}
