//INDICAR LOS REPORTES ABIERTOS EN EL LISTADO
	$('div.it-r').click(function(){
		$('div.rl div.active').removeClass('active');	
		$(this).addClass('active');	
	})
	
	
	
	
//SCROLL EN EL LISTADO DE REPORTES		
	var tr = $( "#top-reports").height();	
	$('.c-scroll').css({'height':(($(window).height())-tr)});	
	
	$('div.scrolled').slimScroll({
		position: 'right',
		height: '80%',
		railVisible: true,
		alwaysVisible: true,
		railOpacity:1,
		distance:10,
		railColor: '',
		color: '#ebebeb',
		size:'8px',
		borderRadius:4,
		opacity: 1,
	});
	

//SCROLL AL INGRESAR UN REPORTE
	$('div.scrolled-reportar').slimScroll({
		position: 'right',
		height: '100%',
		railVisible: true,
		alwaysVisible: true,
		railOpacity:1,
		distance:10,
		railColor: '',
		color: '#65788a',
		size:'8px',
		borderRadius:4,
		opacity: 1,
	});


//SCROLL EN EL REPORTE
	$('div.scrolled-report').slimScroll({
		position: 'right',
		height: '100%',
		railVisible: true,
		alwaysVisible: true,
		railOpacity:1,
		distance:10,
		railColor: '',
		color: '#ebebeb',
		size:'8px',
		borderRadius:4,
		opacity: 1,
	});
		
		
//MOSTRAR EL FORM DE REGISTRO
	$('.registrate').click(function(){
		$('div.bloque-registro').slideDown();
		$('div.bloque-sesion').slideUp();	
	})


//MOSTRAR REPORTE
	$('div.it-r').click(function(){
		$('div.c-report').show();
	})


//MOSTRAR COLUMNAS
	$('li.reportar a').click(function(){
		setTimeout(function(){location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=4'}, 10000);
		if (geo_position_js.init()) {
		    console.log('Va a init');
		    geo_position_js.getCurrentPosition(function(pos) {
		        console.log('Get current');
		        var latitude = pos.coords.latitude;
		        var longitude = pos.coords.longitude;
		        //Redirigimos si esta fuera de montevideo
		        if ( latitude < -35 || latitude > -34.6695163){
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=4';
		        }
		        else if (longitude > -56.168270 || longitude < -56.4350581){
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=4';
		        }
		        else {
		        	location.href = '/around?latitude=' + latitude + ';longitude=' + longitude + '&zoom=4';
		        }
		    }, 
		    function(err) {
		        console.log('Entra a err');
		        if (err.code == 1) { // User said no
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=4';
		        } 
		        else { 
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=4';
		            /*if (err.code == 1) { // User said no
		                $link.html(translation_strings.geolocation_declined);
		            } else if (err.code == 2) { // No position
		                $link.html(translation_strings.geolocation_no_position);
		            } else if (err.code == 3) { // Too long
		                $link.html(translation_strings.geolocation_no_result);
		            } else { // Unknown
		                $link.html(translation_strings.geolocation_unknown);
		            }*/
		        }
		    }, 
		    {
		        enableHighAccuracy: true,
		        timeout: 10000
		    });
		}
	})

	$('li.reportes a').click(function(){
		setTimeout(function(){location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=2'}, 10000);
		if (geo_position_js.init()) {
		    console.log('Va a init');
		    geo_position_js.getCurrentPosition(function(pos) {
		        console.log('Get current');
		        var latitude = pos.coords.latitude;
		        var longitude = pos.coords.longitude;
		        //Redirigimos si esta fuera de montevideo
		        if ( latitude < -35 || latitude > -34.6695163){
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=2';
		        }
		        else if (longitude > -56.168270 || longitude < -56.4350581){
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=2';
		        }
		        else {
		        	location.href = '/around?latitude=' + latitude + ';longitude=' + longitude + '&zoom=2';
		        }
		    }, 
		    function(err) {
		        console.log('Entra a err');
		        if (err.code == 1) { // User said no
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=2';
		        } 
		        else { 
		            location.href = '/around?latitude=-34.906557;longitude=-56.199769&zoom=2';
		        }
		    }, 
		    {
		        enableHighAccuracy: true,
		        timeout: 10000
		    });
		}
	})

//RESPONSIVE TEXT
	/*$(document).ready(function() {
		$('.responsive').responsiveText();
		
	});*/

