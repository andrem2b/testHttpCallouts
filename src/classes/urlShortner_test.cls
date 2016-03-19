@isTest
private class urlShortner_test {

	@isTest static void test_getAvailableServices() {
		// Implement test code
		Object result = urlShortner.getAvailableServices();
	}

	@isTest static void test_obtainNewUrl() {
		// Implement test code
		urlShortner.wrapResult result = (urlShortner.wrapResult) urlShortner.obtainNewUrl('','');
		System.assertEquals(true,result.error);

		//tinyUrl
		result = (urlShortner.wrapResult)urlShortner.obtainNewUrl('','www.something.com');
		System.assertEquals(false,result.error);
		//bitly
		result = (urlShortner.wrapResult)urlShortner.obtainNewUrl('atoken','www.something.com');
		System.assertEquals(false,result.error);


	}

	@isTest static void test_logInToBitly() {
		// Implement test code
		urlShortner.wrapResult result = (urlShortner.wrapResult) urlShortner.logInToBitly('','');
		System.assertEquals(true,result.error,' Error when bitly credentials are invalid is OK!');
		System.assertEquals('INVALID login',result.errorMsg,' Error message when bitly credentials are invalid is OK!');

		result = (urlShortner.wrapResult)urlShortner.logInToBitly('root','fivestars');
		String token =  ((Map <String,String>)result.results).get('token');
		System.assertEquals('testoken',token,' Bitly credentials are OK login is OK!');

	}


}
