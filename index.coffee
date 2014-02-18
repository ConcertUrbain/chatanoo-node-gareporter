io = require('socket.io-client')
socket = io.connect('http://notify.chatanoo.org:3131')

ua = require('universal-analytics')

socket.on 'connect', ()->
	console.log('Connected to Chatanoo Notify Server!')

report_to_ga = (service, data)->
	console.log("send: #{service}: #{data.method} by #{data.byUser}")
	visitor = ua('UA-44078448-1', data.byUser)
	visitor.event(service, data.method).send()

socket.on 'queries', 	(data)-> report_to_ga('queries', data)
socket.on 'search', 	(data)-> report_to_ga('search', data)
socket.on 'comments', 	(data)-> report_to_ga('comments', data)
socket.on 'medias', 	(data)-> report_to_ga('medias', data)
socket.on 'items', 		(data)-> report_to_ga('items', data)
socket.on 'datas', 		(data)-> report_to_ga('datas', data)
socket.on 'users', 		(data)-> report_to_ga('users', data)
		
	