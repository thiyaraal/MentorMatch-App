importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');

firebase.initializeApp({
	apiKey: 'AIzaSyDFOjkB2iyu-r0pf7bgjFRvHMntyHdvXo8',
	appId: '1:121006467880:web:edd8a51f2e7bdcde72fe1d',
	messagingSenderId: '121006467880',
	projectId: 'mentor-match-412713',
	authDomain: 'mentor-match-412713.firebaseapp.com',
	storageBucket: 'mentor-match-412713.appspot.com',
	measurementId: 'G-8NT8C5VNJE',
});

const messaging = firebase.messaging();

messaging.usePublicVapidKey('3cbnCarWEAprNa28A5tQB8ggzRR55J7GISpnZj9jdPc'); // Add this line with your VAPID public key

messaging.onBackgroundMessage(function (payload) {
	console.log('[firebase-messaging-sw.js] Received background message ', payload);
	const notificationTitle = payload.notification.title;
	const notificationOptions = {
		body: payload.notification.body,
		icon: '/firebase-logo.png',
	};

	self.registration.showNotification(notificationTitle, notificationOptions);
});
