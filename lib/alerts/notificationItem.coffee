Template.notificationItem.events
	'click #notificationItem': (e) ->
		e.target.classList.add('fade-out')
		Session.set('selected_notification',@_id)
		Meteor.setTimeout ->
			x = Session.get 'selected_notification'

			if !id?
				id=x
			else
				console.log 'id',id
			l=Notifications.update _id:id,
				$set:
					isRead:true
			console.log 'result',l
			l

		,1000


		return
Template.notificationItem.helpers
	errorType:->
		switch @level
			when 'warning' then  'exclamation-triangle'
			when 'info' then 'info'
			when 'error' then 'exclamation-circle'
			else 'info'