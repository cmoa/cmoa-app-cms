var app = function () {
  return {

    // Vars
    artworkIndexPath: null,
    artworks: [],

    // Methods
    init: function () {
    },

    initExhibitionsIndex : function () {
      var updatePositions = function () {
        var els = $('.table-exhibitions tbody tr .position span');
        var positions = [], el;
        for (var i=0; i<els.length; i++) {
          el = $(els[i]);
          el.text(i + 1);
          // Find the id
          var id = parseInt(el.parents('tr').data('id'));
          positions[positions.length] = id;
        }

        // Update the position on server
        var params = {
          positions: positions.join(',')
        };

        $.getJSON(app.exhibitionsPositionsPath, params);
      };

      // Make media sortable
      $('.table-exhibitions tbody').sortable({
        handle: '.position span',
        cursor: 'move',
        stop: function (event, ui) {
          updatePositions();
        }
      });
    },

    initArtworkIndex : function () {
      var processFilterParams = function () {
        var params = [];
        var artist = $('#filter_artist').val();
        var category = $('#filter_category').val();
        var location = $('#filter_location').val();
        if (artist !== '') {
          params[params.length] = 'filter_artist=' + artist;
        }
        if (category !== '') {
          params[params.length] = 'filter_category=' + category;
        }
        if (location !== '') {
          params[params.length] = 'filter_location=' + location;
        }
        window.location.href = app.artworkIndexPath + '?' + params.join('&');
      }

      // Setup dropdowns
      $('#filter_artist, #filter_category, #filter_location').change(function (e) {
        processFilterParams();
      });

      // Reset filter
      $('#resetFilter').click(function (e) {
        window.location.href = app.artworkIndexPath;
      });
    },

    initToursArtworkEdit: function () {
      // Make list sortable
      $('.artwork-list ol').sortable({
        handle: '.position',
        cursor: 'move',
        stop: function (event, ui) {
          updatePositions();
        }
      });

      // Init the artwork dropdowns
      $('.dropdown-toggle').dropdown();
      $(document).on('click', '.dropdown-menu a', function (e) {
        // Update dropdown title
        var text = $(this).text();
        $(this).parents('.btn-group').find('.dropdown-toggle .text').text(text);
        // Update hidden form field
        var id = $(this).data('id');
        $(this).parents('li.clearfix').find('input.input-artwork-id').val(id);
        var position = parseInt($(this).parents('li.clearfix').find('.position').text()) - 1;
        $(this).parents('li.clearfix').find('input.input-position').val(position);
        e.preventDefault();
      });

      // Add artwork
      $('#addArtwork').click(function (e) {
        e.preventDefault();

        var html = $($('.dropdown-sample').html());
        var totalChildren = $('.artwork-list ol > li').size();
        html.find('.position').text(totalChildren + 1);
        $('.artwork-list ol').append(html);
        toggleNoArtworkNote();
      });

      // Remove artwork
      var updatePositions = function () {
        $('.artwork-list ol > li .position').each(function (index, el) {
          $(el).text(index + 1);
          $(el).parents('li.clearfix').find('input.input-position').val(index);
        });
      };

      var toggleNoArtworkNote = function () {
        if ($('.artwork-list ol > li').length === 0) {
          $('#noArtworkNote').show();
        } else {
          $('#noArtworkNote').hide();
        }
      };

      $(document).on('click', 'button.action-remove', function (e) {
        e.preventDefault();
        $(this).parents('li').remove();
        updatePositions();
        toggleNoArtworkNote();
      });
    },

    initArtworkShow : function () {
      var updatePositions = function (tableClass, kind) {
        var els = $('.' + tableClass + ' tbody tr .position span');
        var positions = [], el;
        for (var i=0; i<els.length; i++) {
          el = $(els[i]);
          el.text(i + 1);
          // Find the id
          var id = parseInt(el.parents('tr').data('id'));
          positions[positions.length] = id;
        }

        // Update the position on server
        var params = {
          positions: positions.join(','),
          kind: kind
        };

        $.getJSON(app.mediaPositionsPath, params);
      };

      // Make media sortable
      $('.table-media-images tbody').sortable({
        handle: '.position span',
        cursor: 'move',
        stop: function (event, ui) {
          updatePositions('table-media-images', 'image');
        }
      });
      $('.table-media-audio tbody').sortable({
        handle: '.position span',
        cursor: 'move',
        stop: function (event, ui) {
          updatePositions('table-media-audio', 'audio');
        }
      });
      $('.table-media-video tbody').sortable({
        handle: '.position span',
        cursor: 'move',
        stop: function (event, ui) {
          updatePositions('table-media-video', 'video');
        }
      });
    },

    initArtistShow : function () {
      var updatePositions = function () {
        var els = $('.table-links tbody tr .position span');
        var positions = [], el;
        for (var i=0; i<els.length; i++) {
          el = $(els[i]);
          el.text(i + 1);
          // Find the id
          var id = parseInt(el.parents('tr').data('id'));
          positions[positions.length] = id;
        }

        // Update the position on server
        var params = {
          positions: positions.join(',')
        };
        $.getJSON(app.linksPositionsPath, params);
      };

      // Make media sortable
      $('.table-links tbody').sortable({
        handle: '.position span',
        cursor: 'move',
        stop: function (event, ui) {
          updatePositions();
        }
      });
    }

  };
}();