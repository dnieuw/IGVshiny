HTMLWidgets.widget({

  name: 'IGVbrowser',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
        
        var bed = "https://s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/refGene.hg19.bed.gz",
        bedindex = "https://s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/refGene.hg19.bed.gz.tbi",
        bam = "https://data.broadinstitute.org/igvdata/BodyMap/hg19/IlluminaHiSeq2000_BodySites/brain_merged/accepted_hits.bam",
        genome = "hg19",
        location = "chr8:128,747,267-128,754,546",
        browser = igv.createBrowser(el, {
          showNavigation: true,
          showRuler: true,
          genome: genome,
          locus: location,
          tracks: [
            {
              name: "Genes",
              type: "annotation",
              format: "bed",
              sourceType: "file",
              url: bed,
              indexURL: bedindex,
              order: Number.MAX_VALUE,
              visibilityWindow: 300000000,
              displayMode: "EXPANDED"
            }, {
              url: bam,
              name: 'Brain (BodyMap)'
            }
          ]
        });
        
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});