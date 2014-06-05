/*
 * pormibarrio.js
 * FixMyStreet JavaScript for PMB
 */

$(function(){
	//Script para obtener las direcciones a partir del punto
	$('svg').click(function(){
		var lat = $('[name="latitude"]').val();
		var lon = $('[name="longitude"]').val();
		//Hacemos el pedido
		var url = 'http://nominatim.openstreetmap.org/reverse?format=json&lat='+lat+'&lon='+lon+'&zoom=18&addressdetails=1';
		var directions = [];
		var dir_box = '';
		$.getJSON(url).done(function(res){
			if (typeof res.address.house_number !== 'undefined' && res.address.house_number !== false) {
				var dir_box = '<div id="address-pick"><ul><label>Elija una direccion<label>';
	    	var house_numbers = res.address.house_number.split(',');
				$.each(house_numbers, function(key, number){
					dir_box += '<li>'+res.address.road+','+number+'</li>';
				});
				dir_box += '</ul></div>';	
				$('#address-pick').replaceWith(dir_box);
				$('#address-pick li').click(function(data){
					var addr_split = $(this).text().split(',');
					$('#form_address').val(addr_split[0]);
					$('#form_address_comp').val(addr_split[1]);
				});
			}
		});
	});
	//Script para consulta de calle
	var minlength = 3;

  $("#form_address").keyup(function () {
      value = $(this).val();

      if (value.length >= minlength ) {
      	url = 'http://www.montevideo.gub.uy/ubicacionesRestProd/calles?nombre='+value;
          $.getJSON(url).done(function(resp){
          	console.log(resp);
          });
      }
  });
});