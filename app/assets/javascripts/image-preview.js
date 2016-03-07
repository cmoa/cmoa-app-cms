$.fn.imagePreview = function (input)
{
  var $container = this;
  var $input = $(input);
  var id = "image_preview_" + Date.now();
  $container.append("<img id='" + id + "'>" );
  var $img = $("#" + id);
  //Start the image as hidden
  $img.hide();

  //When the input has a file chosen start loading the image
  $input.change(function() {
    if ($input.files && $input.files[0])
    {
        var reader = new FileReader();
        reader.onload = function (e) {
            $img.attr('src', e.target.result);
            $img.show();
        }
        reader.readAsDataURL(input.files[0]);
    }
    else
    {
      $img.hide();
    }
  });



};
