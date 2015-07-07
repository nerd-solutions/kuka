Template.slideShowTemplate.created = () ->
	if window.location.search.match(/print-pdf/gi)
		link=document.createElement('link')
		link.rel='stylesheet'
		link.type='text/css'
		link.href='css/print/pdf.css'
		document.getElementsByTagName('head')[0].appendChild(link)
Template.slideShowTemplate.rendered = () ->
	#Full list of configuration options available here:
	#https://github.com/hakimel/reveal.js#configuration
	Reveal.initialize
		#	The "normal" size of the presentation, aspect ratio will be preserved
		#	when the presentation is scaled to fit different resolutions. Can be
		#	specified using percentage units.
		width: 960
		height: 700

		#	Factor of the display size that should remain empty around the content
		margin: 0.1
		#	Bounds for smallest/largest possible scale to apply to content
		minScale: 0.2
		maxScale: 1.5
		

		# Slide every 5 seconds
		autoSlide: 5000
		controls: true
		progress: true

		# Show slide number
		slideNumber: true
		history: true
		transitionSpeed: 'default' #, // default / fast / slow
		backgroundTransition: 'default' #, // default / none / slide / concave / convex / zoom
		keyboard: true
		overview: true
		center: true
		touch: true
		loop: false
		rtl: false
		fragments: true
		embedded: false
		help: true
		autoSlide: 0
		autoSlideStoppable: true
		mouseWheel: false
		hideAddressBar: true
		previewLinks: false
		#transition: 'default'
		transition: Reveal.getQueryHash().transition or 'default'
		transitionSpeed: 'default'
		backgroundTransition: 'default'
		viewDistance: 3
		parallaxBackgroundImage: ''
		parallaxBackgroundSize: ''
		parallaxBackgroundHorizontal: ''
		parallaxBackgroundVertical: ''
		theme: 'league'
		math:
			mathjax:'http://cdn.mathjax.org/mathjax/latest/MathJax.js'
			config: 'TeX-AMS_HTML-full' #// See http://docs.mathjax.org/en/latest/config-files.html

#   },
#   dependencies: [{
#     src: 'plugin/math/math.js',
#     async: true
#   }]
# });
# dependencies: [
#    {
#      src: 'lib/js/classList.js'
#      condition: ->
#        !document.body.classList
#    }
#    {  

Template.slideShowTemplate.helpers
	isChrome:->
		/Chrome/i.test(navigator.userAgent)

	foo: () ->
		

Template.slideShowTemplate.destroyed = () ->
	# ...	# ...

Router.map ->

	@route 'slideShowTemplate',
		path:'/slideShow'
		template:'slideShowTemplate'

