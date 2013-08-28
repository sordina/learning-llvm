
(function(){

var images = document.getElementsByTagName('img')

for( var i = 0; i < images.length; i++ )  {
  var im = images[i]
  if( im.getAttribute('src').match(/chart/)) {
    im.className += 'google'
  }
}

})()

