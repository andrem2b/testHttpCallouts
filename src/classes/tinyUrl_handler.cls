public with sharing class tinyUrl_handler {

	static final private String TINY_URL='http://tinyurl.com/api-create.php?url=';

	public static String getNewUrl(String inUrl){
		String outUrl = '';

		if (!String.isNotBlank(inUrl)) {
			throw new urlShortner.CustomException('Invalid URL');
		}


		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(TINY_URL+inUrl);
		request.setMethod('GET');
		request.setHeader('Accept', 'application/text');
		// Set the body as a JSON object
		HttpResponse response = http.send(request);
		// Parse the JSON response
		if (response.getStatusCode() != 200) {
			throw new urlShortner.CustomException('The status code returned was not expected: ' +
						response.getStatusCode() + ' ' + response.getStatus());

		} else {
			System.debug(response.getBody());
			outUrl = response.getBody();
		}

		return outUrl;
	}

}
