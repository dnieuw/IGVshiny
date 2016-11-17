HTMLWidgets.widget({

  name: 'IGVbrowser',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
        
        console.log(x.tracks)
        
        var genome = "hg19";
        var location = "chr8:128,747,267-128,754,546";
        
        igv.createBrowser(el, {
          showNavigation: true,
          showRuler: true,
          tracks: x.tracks,
          genome: genome,
          locus: location,
        });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});