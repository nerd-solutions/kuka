# Meteor.subscribe 'logInfo',{route:'Space X Downloader',limit:100}
Observe=null
warningShown=false
Session.setDefault('name',false)
Session.setDefault 'enableDataLabels',true
Session.setDefault 'enableMarkers',true
Session.setDefault 'color',false

drawChart = (data)->
	$('#appChart').highcharts
		credits:
			enabled:false
		chart:
			zoomType:'x'
			type: 'area'
			animation: Highcharts.svg
			marginRight: 10
		title: text: 'Application Logs'
		subtitle:
			text: if document.ontouchstart is undefined then 'Click and drag in the plot area to zoom in' else 'Pinch the chart to zoom in'
		xAxis:
			type: 'datetime'
	#		minRange: 1 * 24 * 3600000 # one days
	#		tickPixelInterval: 150
		yAxis:
			title: text: 'Value'
			plotLines: [ {
				value: 0
				width: 1
				color: '#808080'
			} ]
		tooltip: 
			# crosshairs: true
			# shared: true
			formatter: ->
				result=	"<b>#{this.series.name}</b><br/>"
				result+= Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', @x) + '<br/>'
				result += "#{this.y}<br/>#{this.key}<br/>"
				result

		plotOptions:
			area:
				fillColor:
					linearGradient:
						x1:0
						y1:0
						x2:0
						y2:1
					stops:[
							[0,Highcharts.getOptions().colors[0]]
							[1,Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
						]
				marker:radius:2
				lineWidth:1
				states:
					hover:
						enabled:true
						lineWidth:1
						halo:
							size:9
							attributes:
								fill:Highcharts.getOptions().colors[2]
								'stroke-width':2
								stroke:Highcharts.getOptions().colors[1]


				threshold:null
				series:
					turboThreshold:0
		legend: 
			enabled: true
		exporting: 
			enabled: true
		series: [{
			name:'Space X Downloader',
			allowPointSelect:true,
			marker:{enabled:true},
			showInLegend:true,
			data:data}]








Template.appChart.destroyed = () ->
	if Observe?
		Observe.stop()

Template.appChart.rendered=->
	Meteor.call 'getLogs',Router.current().data().name,Meteor.bindEnvironment (e,s)->
		if e?
			console.log "Error",e
		else
			console.log 'success'

	data=[]

	# Meteor.call 'getLogInfo2',@data.name,(e,s)->
	# 	if e?
	# 		console.log 'Error:\n',e
	# 	else
	# 		console.log 'Success:',s



	# Meteor.subscribe 'logInfo',{name:@data.name,limit:100}

	data=AppLogs.find({AppName:@data.name},{sort:{CreationTime:-1}}).map (e)->
		{x:e.CreationTime.getTime(),y:e.Level,name:e.User}
	drawChart data


	Session.set 'points', data.length
	





	Observe=AppLogs.find().observeChanges 
		# Use either added() OR(!) addedAt()
		addedAt: (document, atIndex, before) ->
			if warningShown is false
				console.log '%c Replace this once you fix the database','color:red;'
				warningShown=true


			# x=document.CreationTime.getTime()
			x=new Date(document.CreationTime).getTime()
			y=document.Level

			chart = $('#container').highcharts()

			series=chart.get(document.AppName)

			if !series?
				chart.addSeries({id:document.AppName,name:document.AppName,data:[]})
				series=chart.get(document.AppName)




			series.addPoint([x,y])
			console.log 'added at ',atIndex
			Session.set 'itemsCount',series.points.length
			Session.set 'points', AppLogs.find().count()
		changed: (newDocument, oldDocument) ->
			console.log 'changed'
				# ...
		# Use either removed() OR(!) removedAt()
		removedAt: (oldDocument, atIndex) ->
				Session.set 'points', AppLogs.find().count()
				# x=document.CreationTime.getTime()
				x=new Date(oldDocument.CreationTime).getTime()
				y=oldDocument.Level

				chart = $('#container').highcharts()
				series=chart.get(oldDocument.AppName)
				series.removePoint(atIndex)


				console.log 'removed at ',atIndex
	




Template.highcharts.helpers
	itemsCount:->
		Session.get 'itemsCount'
	logCount: () ->
		Session.get 'points'

updateChart=(data)->
	console.log 'update data',data


		# ...
Template.highcharts.events

	'click #label': () ->
		chart = $('#container').highcharts()
		chart.series[0].update({
				dataLabels:
					enabled:Session.get 'enableDataLabels'
			})
		Session.set 'enableDataLabels',!Session.get('enableDataLabels')

	'click #marker': () ->
		chart = $('#container').highcharts()
		chart.series[0].update({
				marker:
					enabled:Session.get 'enableMarkers'
			})
		Session.set 'enableMarkers',!Session.get('enableMarkers')


	'click #color': () ->
		chart = $('#container').highcharts()

		chart.series[0].update({
				color:Session.get('color')?null:Highcharts.getOptions().colors[1]
			})

		Session.set 'color',!Session.get('color')

	'click #column': () ->
		chart = $('#container').highcharts()
		chart.series[0].update
			type:'column'

	'click #line': () ->
		chart = $('#container').highcharts()
		chart.series[0].update
			type:'line'

	'click #spline': () ->
		chart = $('#container').highcharts()
		chart.series[0].update
			type:'spline'

	'click #area': () ->
		chart = $('#container').highcharts()
		chart.series[0].update
			type:'area'

	'click #pie': () ->
		chart = $('#container').highcharts()
		chart.series[0].update
			type:'pie'



Router.map ->
	@route 'highcharts',
		path:'/highcharts'
	# ...

