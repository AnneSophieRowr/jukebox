$(document).ready(function(){

  $('#song_file').uploadify({
    'swf'           : '../flash/uploadify.swf',
    'uploader'      : 'create',
    'fileTypeDesc'  : 'Music files',
    'fileTypeExts'  : '*.mp3',
    'buttonText'    : 'Choisissez un fichier',
    'width'         : '200'
  });

});
