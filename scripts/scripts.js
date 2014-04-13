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
		min: 14,
		max: 120,
		step: 1,
		range: 'min',
		slide: function( event, ui ) {
			var value = ui.value + 'px';
			$('#textSize').val(ui.value);
			$('#messageSpan').css('font­size', value);
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
    $('.application .tools .item.objects .bar_slider').slider({
		value: 100,
		min: 50,
		max: 200,
		step: 1,
		range: 'min',
		slide: function( event, ui ) {
			
		}
    });
});