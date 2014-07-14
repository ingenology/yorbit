'use strict';

// GLOBAL VARIABLES
var date,
	typeSize = '60px',
	shapeWidth,
	shapeHeight,
	shapeScale,
	globalFontStyle,
	mapContent;

/*****************************************
/* NAVIGATION 
/*****************************************/
var triggerBttn = $( '#trigger-overlay' ),
	overlay = $( '.overlay' ),
	closeBttn = $( '.overlay-close' );

function toggleOverlay() {
	if (overlay.hasClass('open') ) {
		overlay.removeClass('open');
		overlay.addClass('close');
	}
	if ( !overlay.hasClass('close') ) {
		overlay.addClass('open');
	}
}

function overlayReset() {
	overlay.removeClass('close');
}

triggerBttn.click(function() {
	toggleOverlay();
});
closeBttn.click(function() {
	toggleOverlay();
	setTimeout(overlayReset, 1000);
});

// DATE PICKER
$(function() {
	$( '#dateIn' ).datepicker({
		'dateFormat': 'yy-mm-dd'
	});
});

$('.map-type .button').click(function() {
	var data = $(this).attr('data');
	$('#mapType').val(data);
	$(this).parent().find('.button').removeClass('active');
	$(this).addClass('active');
});

$('#modal1 .btn').click(function() {
	var value = $('#dateIn').val();
	var fullDate = new Date();
	var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)? (fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
	
	var dateStripped = fullDate.getFullYear() + twoDigitMonth + fullDate.getDate();
	var valueStripped = value.replace(/\-/g,'');

	/*
	if (value === '') {
		alert('Hey, select a date.');
	} else if (valueStripped >= dateStripped) {
		alert('Hey, select a date that is not in the future.');
	}
	*/
});

/*****************************************
/* ACCORDIANS 
/*****************************************/

$('.application .tools .item .title').click(function() {
	var parent = $(this).parent();
	$('#text_color_picker, #shape_color_picker').spectrum('hide');
	if ( !parent.hasClass('active') ) {
		$('.application .tools .item').removeClass('active');
		parent.addClass('active');
	} else {
		$('.application .tools .item').removeClass('active');
	}
});

/*****************************************
/* TEXT 
/*****************************************/

// TYPE SIZE SLIDER
$(function() {
    $('.application .tools .item.type .bar_slider').slider({
        value: 60,
        min: 8,
        max: 120,
        step: 2,
        range: 'min',
        slide: function( event, ui ) {
            var val = ui.value + 'px';
            $('#map-content .text-item.active').css('font-size', val);
            typeSize = val;
        }
    });
});

//TEXT COLOR PICKER
$('#text_color_picker').spectrum({
    color: '#f00',
    preferredFormat: 'rgb',
    showInput: false,
    clickoutFiresChange: true,
    replacerClassName: 'color-picker',
    showAlpha: true,
    change: function() {
		var color = $('#text_color_picker').val();
	    if ($('#map-content .text-item').hasClass('active')) {
			$('#map-content .text-item.active').css('color', color);
		}
		if ($('#disable-canvas').hasClass('disabled')) {
			$('#disable-canvas').removeClass('disabled');
			$('#disable-canvas').html('Hide Canvas');
			$('#map-content').fadeIn(150);
		}
	}
});

$('.application .tools').scroll(function() {
	$('#text_color_picker').spectrum('hide');
});

//ADD TEXT TO CANVAS
$('#add_text').click(function() {
	var text = $('#messageIn').val();
	var number = $('.text-item').length;
	var color = $('#text_color_picker').spectrum('get');
	var fontWeight = 'normal';
	var	fontStyle = 'normal';
	var fontFamily = $('#font-select').val();

	if (globalFontStyle === 'regular') {
		fontWeight = '400';
		fontStyle = 'normal';
	} else if (globalFontStyle === 'bold') {
		fontWeight = '600';
		fontStyle = 'normal';
	} else if (globalFontStyle === 'italic') {
		fontWeight = '400';
		fontStyle = 'italic';
	}

	$('#map-content .shape').removeClass('active');
	if (text === '' || text === undefined || text === null) {
		alert('Please enter a value to be added to the canvas.');
	} else if ($('#map-content .text-item').hasClass('active')) {
		alert('Please deselect your text item to add a new one.');
	} else {
		number = Number(number) + Number(1);

		$('#map-content .text-item').removeClass('active');
		$('#map-content').append('<div class="text-item ui-draggable" id="text' + number + '" style="color: ' + color + '; font-weight: ' + fontWeight + '; font-style: ' + fontStyle +'; font-size: ' + typeSize + '; font-family: ' + fontFamily + '"><span>' + text +'</span><div class="delete"></div></div>');
		$('#messageIn').val('');
		$('.application .tools .item.type .bar_slider').slider('value', '60');
	}
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

// APP SCRIPTS
$('.application .tools .item.type .button').click(function() {
	var data = $(this).attr('data');
	$(this).parent().find('.button').removeClass('active');
	$(this).addClass('active');

	//APPLIES DIFFERENT STYLES
	if (data === 'regular') {
		globalFontStyle = 'regular';
		if ($('#map-content .text-item').hasClass('active')) {
			$('#map-content .text-item.active').css({
				'font-weight': '400',
				'font-style': 'normal'
			});
		}
	} else if (data === 'bold') {
		globalFontStyle = 'bold';
		if ($('#map-content .text-item').hasClass('active')) {
			$('#map-content .text-item.active').css({
				'font-weight': '600',
				'font-style': 'normal'
			});
		}
	} else if (data === 'italic') {
		globalFontStyle = 'italic';
		if ($('#map-content .text-item').hasClass('active')) {
			$('#map-content .text-item.active').css({
				'font-weight': '400',
				'font-style': 'italic'
			});
		}
	}
});

// FONT SELECTION
$('#font-select').change(function() {
	var content = $(this).val();
	
	$('#map-content .text-item.active').css({
		'font-family': content
	});
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

//REWRITES CONTENTS OF TEXT OBJECT
$('#messageIn').keyup(function() {
	var content = $(this).val();
	if ($('#map-content .text-item').hasClass('active')) {
		if (content === '') {
			$('#map-content .text-item.active').remove();
			$('#messageIn').val('');
		} else {
			$('#map-content .text-item.active span').text(content);
		}
	}
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

//TOGGLE ACTIVE TEXT
$('#map-content').on('mousedown', '.text-item', function() {
	$(this).draggable();
});

$('#map-content').on('click', '.text-item', function() {
	if ($(this).hasClass('active')) {
		$(this).removeClass('active');
		$('#messageIn').val('');
		$('.application .tools .item.type .bar_slider').slider('value', '60');
	} else {
		var content = $(this).text();
		$('#messageIn').val(content);
		$('#map-content .text-item').removeClass('active');
		$(this).addClass('active');
		typeSize = $(this).css('font-size');
		typeSize = typeSize.slice(0, - 2);
		$('.application .tools .item.type .bar_slider').slider('value', typeSize);
	}
});

//DELETE TEXT ITEM
$('#map-content').on('click', '.text-item .delete', function() {
	$(this).parent().fadeOut(150, function() {
		$(this).remove();
	});
});

/*****************************************
/* OBJECTS
/*****************************************/

//WIDTH SLIDER
$(function() {
    $('.application .tools .item.objects .bar_sliderW').slider({
        value: 100,
        min: 1,
        max: 600,
        step: 1,
        range: 'min',
        slide: function( event, ui ) {
            var val = ui.value + 'px';
            $('#map-content .shape.active').css('width', val);
        }
    });
});
 
//HEIGHT SLIDER
$(function() {
    $('.application .tools .item.objects .bar_sliderH').slider({
        value: 100,
        min: 1,
        max: 600,
        step: 1,
        range: 'min',
        slide: function( event, ui ) {
            var val = ui.value + 'px';
            $('#map-content .shape.active').css('height', val);
        }
    });
});

//SCALE SLIDER
$(function() {
    $('.application .tools .item.objects .bar_sliderS').slider({
        value: 50,
        min: 1,
        max: 600,
        step: 1,
        range: 'min',
        slide: function( event, ui ) {
            var val = ui.value + 'px';
            var valPlain = ui.value;
            $('.application .tools .item.objects .bar_sliderW').slider('value', valPlain);
			$('.application .tools .item.objects .bar_sliderH').slider('value', valPlain);
            $('#map-content .shape.active').css({
				'height': val,
				'width': val
			});
			if ($('#map-content .shape.active').hasClass('circle-item')) {
				valPlain = valPlain / 2;
				valPlain = valPlain + 'px';
				$('#map-content .shape.active').css({
					'-webkit-border-radius': valPlain,
					'-moz-border-radius': valPlain,
					'-o-border-radius': valPlain,
					'-ms-border-radius': valPlain,
					'border-radius': valPlain
				});
			}
		}
	});
});

//SHAPE COLOR PICKER
$('#shape_color_picker').spectrum({
    color: '#f00',
    preferredFormat: 'rgb',
    showInput: false,
    clickoutFiresChange: true,
    replacerClassName: 'button color-picker',
    showAlpha: true,
    change: function() {
		var color = $('#shape_color_picker').val();
	    if ($('#map-content .shape').hasClass('active')) {
			$('#map-content .shape.active').css('background-color', color);
		}
		if ($('#disable-canvas').hasClass('disabled')) {
			$('#disable-canvas').removeClass('disabled');
			$('#disable-canvas').html('Hide Canvas');
			$('#map-content').fadeIn(150);
		}
	}
});

$('.application .tools').scroll(function() {
	$('#shape_color_picker').spectrum('hide');
});

//ADD SQUARE TO CANVAS
$('#add_square').click(function() {
	var number = $('.square-item').length;
	var backgroundColor = $('#shape_color_picker').spectrum('get');
	number = Number(number) + Number(1);
	$('#map-content .text-item, #map-content .shape').removeClass('active');
	$('#map-content').append('<div class="square-item shape ui-draggable" id="square' + number + '" style="background-color: ' + backgroundColor + ';"><div class="delete"></div></div>');
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

//ADD CIRCLE TO CANVAS
$('#add_circle').click(function() {
	var number = $('.square-item').length;
	var backgroundColor = $('#shape_color_picker').spectrum('get');
	number = Number(number) + Number(1);
	$('#map-content .text-item, #map-content .shape').removeClass('active');
	$('#map-content').append('<div class="circle-item shape ui-draggable" id="circle' + number + '" style="background-color: ' + backgroundColor + ';"><div class="delete"></div></div>');
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

//TOGGLE ACTIVE SHAPE
$('#map-content').on('mousedown', '.shape', function() {
	$(this).draggable();
});

$('#map-content').on('click', '.shape', function() {
	if ($(this).hasClass('active')) {
		$(this).removeClass('active');
		$('.application .tools .item.objects .bar_sliderW').slider('value', '100');
		$('.application .tools .item.objects .bar_sliderH').slider('value', '100');
	} else {
		$('#map-content .text-item, #map-content .shape').removeClass('active');
		$(this).addClass('active');
		shapeWidth = $(this).css('width');
		shapeWidth = shapeWidth.slice(0, - 2);
		$('.application .tools .item.objects .bar_sliderW').slider('value', shapeWidth);
		shapeHeight = $(this).css('height');
		shapeHeight = shapeHeight.slice(0, - 2);
		$('.application .tools .item.objects .bar_sliderH').slider('value', shapeHeight);
	}
});

$('#map-content').on('click', '.shape .delete', function() {
	$(this).parent().fadeOut(150, function() {
		$(this).remove();
	});
});

$('#delete_shape').click(function() {
	$('#map-content .shape.active').remove();
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

//PATTERN SLIDERS
$(function() {
    $('.application .tools .item.patterns .bar_slider').slider({
		value: 50,
		min: 1,
		max: 100,
		step: 1,
		range: 'min',
		slide: function( event, ui ) {
			var val = ui.value;
			val = val / 100;
			$('#map-content .pattern').stop().css('opacity', val);
		}
    });
});

function patternSet(patternClass) {
	var opacity = $('.application .tools .item.patterns .bar_slider').slider('value');
	opacity = opacity / 100;
	$('#map-content .pattern').remove();
	$('#map-content').append('<div class="pattern ' + patternClass + '"></div>');
	$('#map-content .pattern').fadeTo(150, opacity);
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
}

$('.application .tools .item.patterns .square.circles').click(function() {
	patternSet('circles');
});
$('.application .tools .item.patterns .square.squares').click(function() {
	patternSet('squares');
});
$('.application .tools .item.patterns .square.stripes').click(function() {
	patternSet('stripes');
});

$('#delete-pattern').click(function() {
	$('#map-content .pattern').fadeOut(150, function() {
		$('#map-content .pattern').remove();
		$('.application .tools .item.patterns .bar_slider').slider('value', 50);
	});
	if ($('#disable-canvas').hasClass('disabled')) {
		$('#disable-canvas').removeClass('disabled');
		$('#disable-canvas').html('Hide Canvas');
		$('#map-content').fadeIn(150);
	}
});

$('#disable-canvas').click(function() {
	if ($(this).hasClass('disabled')) {
		$(this).removeClass('disabled');
		$(this).html('Hide Canvas');
		$('#map-content').fadeIn(150);
	} else {
		$(this).addClass('disabled');
		$(this).html('Show Canvas');
		$('#map-content').fadeOut(150);
	}
});

function renderMap(latitude, longitude) {
	var mapOptions = {
	    center: new google.maps.LatLng(latitude, longitude),
	    zoom: 8,
	    maxZoom: 9,
	    panControl:false,
	    zoomControl:false,
	    mapTypeControl:false,
	    scaleControl:false,
	    streetViewControl:false,
	    overviewMapControl:false,
	    rotateControl:false,
	    disableDefaultUI: false
	};

	var map = new google.maps.Map(document.getElementById('map'), mapOptions);

	var getTileUrl = function(tile, zoom) {
	    $('#imgZoom').val(zoom);
	    $('#imgCent').val(map.center);
	    
	    return urlIn + '/default/' + dateIn + '/' +
	        googleLevel + '/' +
	        zoom + '/' + tile.y + '/' +
	        tile.x + '.jpg';
	};

	var layerOptions = {
	    alt: 'MODIS_Terra_Aerosol',
	    getTileUrl: getTileUrl,
	    maxZoom: zoomMax,
	    minZoom: 1,
	    name: 'MODIS_Terra_Aerosol',
	    tileSize: new google.maps.Size(256,256),
	    opacity: 1.0
	};

	var imageMapType = new google.maps.ImageMapType(layerOptions);
	map.overlayMapTypes.insertAt(0, imageMapType);
}

// MAP SCRIPTS
$(window).ready(function() {
	if ($('body').hasClass('create')) {
		var modifiedMapLocation = encodeURIComponent(mapLocation);
		var latitude,
			longitude;
		
		$.ajax({
			url: 'http://maps.google.com/maps/api/geocode/json?sensor=true&address=' + modifiedMapLocation,
			cache: false,
	        crossDomain: true,
	        dataType: 'json',
			success : function(data) {
		        console.log(data);
		        latitude = data.results[1].geometry.location.lat;
		        longitude = data.results[1].geometry.location.lng;

		        renderMap(latitude, longitude);
		        $('#ajax-loader').fadeOut(150);
		    }
		});
	}
	if ($('body').hasClass('share')) {

		mapCenter = mapCenter.substr(1);
		var coordinates = mapCenter.substr(0, mapCenter.length-1);
		coordinates = coordinates.split(',');

		var mapOptions = {
			center: new google.maps.LatLng(coordinates[0], coordinates[1]),
			zoom: mapZoom,
			maxZoom: zoomMax,
			panControl:false,
			zoomControl:false,
			mapTypeControl:false,
			scaleControl:false,
			streetViewControl:false,
			overviewMapControl:false,
			rotateControl:false
		};

		var map = new google.maps.Map(document.getElementById('map'), mapOptions);

		var getTileUrl = function(tile, zoom) {
		    $('#imgZoom').val(zoom);
		    $('#imgCent').val(map.center);
		    
		    return urlIn + '/default/' + mapDate + '/' +
		        googleLevel + '/' +
		        zoom + '/' + tile.y + '/' +
		        tile.x + '.jpg';
		};

		var layerOptions = {
		    alt: 'MODIS_Terra_Aerosol',
		    getTileUrl: getTileUrl,
		    maxZoom: zoomMax,
		    minZoom: 1,
		    name: 'MODIS_Terra_Aerosol',
		    tileSize: new google.maps.Size(256,256),
		    opacity: 1.0
		};

		var imageMapType = new google.maps.ImageMapType(layerOptions);
		map.overlayMapTypes.insertAt(0, imageMapType);
        $('#ajax-loader').fadeOut(150);
	}
});

//SAVE MAP
$('#save-map').click(function() {
	//GETS AND CLEANS MAP CONTENT
	$('#map-content .background').remove();
	$('#map-content .text-item, #map-content .shape').removeClass('active ui-draggable');
	$('#map-content .text-item .delete, #map-content .shape .delete').remove();
	mapContent = $('#map-content').html();
	
	//ASSIGNS MAP CONTENT TO HIDDEN FIELDS
	$('#formMapContent').val(mapContent);

	//SUBMITS FORM
	$('#map-creation').submit();
});

/*****************************************
/* NOTIFICATIONS
/*****************************************/

$(document).ready(function() {
	setTimeout(function(){
		$('.notification').animate({
			'opacity': '0',
			'top': '-100px'
		}, 400, function() {
			$('.notification').remove();
		});
	}, 3000);
});

/*****************************************
/* SOCIAL SHARING
/*****************************************/

$('#share-now').click(function() {
	$('.share-overlay').fadeIn(300);

	return false;
});

$('.addthis_toolbox a, .close_navigation').click(function() {
	$('.share-overlay').fadeOut(300);

	return false;
});