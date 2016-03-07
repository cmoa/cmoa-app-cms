$.fn.imagePreview = function (input)
{
  var $container = this;
  var $input = $(input); //jQuery version
  var input = $input.get(0); //Node version
  var id = "image_preview_" + Date.now() + "_" +  random();
  $container.append("<img id='" + id + "'>" );
  var $img = $("#" + id);
  //Start the image as hidden
  $img.hide();

  //When the input has a file chosen start loading the image
  $input.change(function() {

    if (input.files && input.files[0])
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


  return $img; //Return for chain
};

function random()
{
  return Math.floor((Math.random() * 100000) + 1);
}
