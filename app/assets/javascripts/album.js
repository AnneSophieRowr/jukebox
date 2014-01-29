$(document).ready(function(){

  $("#album_artist_id").multiselect({
    includeSelectAllOption: true,
    selectAllText: 'Tout sélectionner',
    nonSelectedText: 'Aucune sélection',
    enableFiltering: true, 
    enableCaseInsensitiveFiltering: true,
    maxHeight: 300
  }); 

});

