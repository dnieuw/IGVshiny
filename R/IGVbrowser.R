#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
IGVbrowser <- function(message, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'IGVbrowser',
    x,
    width = width,
    height = height,
    package = 'IGVshiny',
    elementId = elementId
  )
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
