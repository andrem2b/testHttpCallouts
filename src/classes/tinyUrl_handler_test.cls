@isTest
private class tinyUrl_handler_test {

	@isTest static void test_getNewUrl_invalidUrl() {

		try{
			String shortUrl = tinyUrl_handler.getNewUrl('');
		}catch (urlShortner.CustomException e) {
			System.assert(
							e.getMessage().contains('Invalid URL'),
							'Expected exception is valid'
						);
		}

	}

	@isTest static void test_getNewUrl() {
		// Implement test code
		String theShortOne = 'u';
		urlShortner_httpMock myMock = new urlShortner_httpMock(
										200,
										'200',
										theShortOne,
										new Map<String, String> {'Content-Type'=> 'application/json'}
									);
		// Set mock callout class
		Test.setMock(HttpCalloutMock.class, myMock);

	    String shortUrl = tinyUrl_handler.getNewUrl('www.this_is_long_long_long_long_long_long_long_long_url');

		System.assertEquals(theShortOne,shortUrl);
	}

	@isTest static void test_getNewUrl_error() {
		// Implement test code
		urlShortner_httpMock myMock = new urlShortner_httpMock(
										400,
										'400',
										'',
										new Map<String, String> {'Content-Type'=> 'application/json'});
		// Set mock callout class
		Test.setMock(HttpCalloutMock.class, myMock);

		try{
			String shortUrl = tinyUrl_handler.getNewUrl('www.sample.org');
		}catch (urlShortner.CustomException e) {
			System.assert(
							e.getMessage().contains('The status code returned was not expected:'),
							'Expected exception is valid'
						);
		}
	}

}
