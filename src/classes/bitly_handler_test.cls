@isTest
private class bitly_handler_test {

	@isTest static void test_login() {
		// Implement test code
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setStaticResource('bitly_login_callout_mock');
		mock.setStatusCode(200);
		mock.setHeader('Content-Type', 'application/json');
		Test.setMock(HttpCalloutMock.class, mock);

		String access_token = bitly_handler.logToService('userN','passW');

		System.assertNotEquals(null,access_token);

		//INVALID
		mock = new StaticResourceCalloutMock();
		mock.setStaticResource('bitly_login_invalid_callout_mock');
		mock.setStatusCode(200);
		mock.setHeader('Content-Type', 'application/json');
		Test.setMock(HttpCalloutMock.class, mock);

		access_token = bitly_handler.logToService('Invalid','passW');

		System.assertEquals(null,access_token);

		//INVALID
		mock = new StaticResourceCalloutMock();
		mock.setStaticResource('bitly_login_invalid_callout_mock');
		mock.setStatusCode(401);
		mock.setHeader('Content-Type', 'application/json');
		Test.setMock(HttpCalloutMock.class, mock);

		access_token = bitly_handler.logToService('Invalid','passW');

		System.assertEquals(null,access_token);

	}

	@isTest static void test_getNewUrl() {
		// Implement test code
		MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
		multimock.setStaticResource(bitly_handler.BITLY_LOGIN_URL, 'bitly_login_callout_mock');

		String mockEndPoint = bitly_handler.BITLY_SERVICE_URL;
		mockEndPoint +='c52b4dcff1fc82b78d26bf153f995e4ac3bc64a2&longUrl=https://na30.salesforce.com/_ui/common/apex/debug/ApexCSIPage';
		multimock.setStaticResource(mockEndPoint, 'bitly_newUrl_callout_mock');
		multimock.setStatusCode(200);
		multimock.setHeader('Content-Type', 'application/json');
		Test.setMock(HttpCalloutMock.class, multimock);

		String access_token = bitly_handler.logToService('userN','passW');
		System.assertNotEquals(null,access_token);

		String new_url = bitly_handler.getNewUrl(access_token,'https://na30.salesforce.com/_ui/common/apex/debug/ApexCSIPage');
		System.assertEquals('http://sforce.co/1L6tlUq',new_url);
	}

}