Template.voteSlider.rendered = () ->
	if !id?
		throw Meteor.Error 404, 'Error 500: Not found', 'Slider must be assigned an id'
	slider=document.getElementById(@id)
	noUiSlider.create slider,
		start[0]
		snap:true
		connect:true
		range
			min:0
			'poor':1
			'lacking':2
			'ok':3
			'good':4
			'great':5
			max:5
	console.log 'voteSlider Rendered'
	# ...