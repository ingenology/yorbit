'use strict';

// GLOBAL VARIABLES
var date;
/*
$(document).ready(function() {
	$('#modal1').delay(400).animate({
		top: '18%',
		opacity: '1'
	}, 1100, 'easeOutQuint');
});
*/

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

	if (value === '') {
		alert('Hey, select a date.');
	} else if (valueStripped >= dateStripped) {
		alert('Hey, select a date that is not in the future.');
	} else {
		date = value;
		$('#modal1').animate({
			top: '-50%'
		}, 600, 'easeOutQuint', function() {
			$(this).hide(function() {
				$('#modal2').show();
				$('#modal2').animate({
					top: '18%',
					opacity: '1'
				}, 600, 'easeOutQuint');
			});
		});
	}
});

// APP SCRIPTS
$('.application .tools .item.type .button').click(function() {
	var data = $(this).attr('data');
	$(this).parent().find('.button').removeClass('active');
	$(this).addClass('active');
});

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
			$('#messageSpan').css('font-size', val);	
			$('#textSize').val(ui.value);
			
		}
    });
});

//ACCORDIAN
$('.application .tools .item .title').click(function() {
	var parent = $(this).parent();
	if ( parent.hasClass('active') ) {
		parent.removeClass('active');
	} else {
		//$(this).parent().parent().find('.item').removeClass('active');
		parent.addClass('active');
	}
});

//OBJECT SLIDERS
$(function() {
    $('.application .tools .item.objects .bar_sliderW').slider({
		value: 100,
		min: 50,
		max: 600,
		step: 1,
		range: 'min',
		slide: function( event, ui ) {
			var val = ui.value + 'px';
			$('#messageDiv').css('width', val);	
			$('#messageWidth').val(ui.value);
		}
    });
});

$(function() {
    $('.application .tools .item.objects .bar_sliderH').slider({
		value: 50,
		min: 50,
		max: 600,
		step: 1,
		range: 'min',
		slide: function( event, ui ) {
			var val = ui.value + 'px';
			$('#messageDiv').css('height', val);	
			$('#messageHeight').val(ui.value);
		}
    });
});

$(function() {
    $('.application .tools .item.objects .bar_sliderO').slider({
		value: 1,
		min: 0,
		max: 1,
		step: .1,
		range: 'min',
		slide: function( event, ui ) {
			var val = ui.value;
			$('#messageDiv').css('opacity', val);	
			$('#messageOpacity').val(val);
		}
    });
});

$(function() {
    $('.application .tools .item.objects .bar_sliderB').slider({
		value: 10,
		min: 0,
		max: 300,
		step: 1,
		range: 'min',
		slide: function( event, ui ) {
			var val = ui.value + 'px';
			$('#messageDiv').css('border-radius', val);	
			$('#borderRad').val(ui.value);
		}
    });
});