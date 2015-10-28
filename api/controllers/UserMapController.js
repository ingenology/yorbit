/**
 * UserMapController
 *
 * @description :: Server-side logic for managing maps
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {

	searchMap: function(req, res) {
		var currentDate = DateHelper.getDate();
		var selectedDate = Number(req.param('dateIn').replace(/-/g, ""));

		if (selectedDate < 20120501) {
			req.addFlash('warning', 'Images for this date are not available.');
			return res.redirect('back');
		} else if (selectedDate >= currentDate) {
			req.addFlash('warning', 'Please select a date that is not in the future.');
			return res.redirect('back');
		} else {
			req.addFlash('pageData', {
				location: req.param('location'),
				dateIn: req.param('dateIn'),
				mapType: req.param('mapType'),
				longitude: req.param('longitude'),
				latitude: req.param('latitude')
			});
			return res.redirect('/step-2');
		}
	},

	showCreateLayout: function(req, res) {
		var pageData = req.getFlash('pageData')[0];

		// prevents someone from jumping in on step 2 without completing step 1
		if (!pageData.mapType || !pageData.dateIn || !pageData.location || !pageData.longitude || !pageData.latitude) {
			req.addFlash('warning', 'Please select a date and location.');
			return res.redirect('/step-1');
		} else {
			return res.view('create-layout', {
				mapType: pageData.mapType,
				dateIn: pageData.dateIn,
				location: pageData.location,
				longitude: pageData.longitude,
				latitude: pageData.latitude
			});
		}
	},

	storeMap: function(req, res) {
		UserMap.create({
			map_zoom: req.param('map_zoom'),
			map_center: req.param('map_center'),
			map_content: req.param('map_content'),
			map_location: req.param('map_location'),
			map_date: req.param('map_date'),
			map_type: req.param('map_type')
		}, function mapCreated(err, newMap) {
			// if validation error
			if (err) {
				console.log("err: ", err);
				console.log("err.invalidAttributes: ", err.invalidAttributes);

				return res.negotiate(err);
			}
			req.addFlash('success', 'Your map has been successfully created!');
			return res.redirect('map/' + newMap.id);
		});
	},

	viewMap: function(req, res) {
		var id = req.param('mapId');
		UserMap.findOne(id, function foundMap(err, map) {
			if (!map) {
				return res.mapNotFound(id);
			}
			console.log(map);
			return res.view('view-map', {
				map_zoom: map.map_zoom,
				map_center: map.map_center,
				map_content: map.map_content,
				map_location: map.map_location,
				map_date: map.map_date,
				mapType: map.map_type // different syntax because of other view
			});
		});
	}
};
