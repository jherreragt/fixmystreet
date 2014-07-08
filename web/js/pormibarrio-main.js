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
		$('div.new-report').show();
		$('div.report-list').hide();
	})

	$('li.reportes a').click(function(){
		$('div.new-report').hide();
		$('div.report-list').show();		
	})

//RESPONSIVE TEXT
	/*$(document).ready(function() {
		$('.responsive').responsiveText();
		
	});*/

