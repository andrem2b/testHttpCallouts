public with sharing class bitly_handler {

	static final public String BITLY_LOGIN_URL='https://api-ssl.bitly.com/oauth/access_token';
	static final public String BITLY_SERVICE_URL='https://api-ssl.bitly.com/v3/shorten?access_token=';

	public static String logToService(String username,String password){

		String access_token = '';

		Http h = new Http();
		// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
		HttpRequest req = new HttpRequest();
		req.setEndpoint(BITLY_LOGIN_URL);
		req.setMethod('POST');

		Blob headerValue = Blob.valueOf(username + ':' + password);
		String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
		req.setHeader('Authorization', authorizationHeader);
		HttpResponse res = h.send(req);

		String body = res.getBody();
		if(		res.getStatusCode() == 200 && String.isNotBlank(body)	){

			if(body.contains('INVALID_LOGIN')){
				//invalid login
				access_token = null;
			}else{
				access_token = body;
			}
		}else{
				//invalid status code
				access_token = null;
				//'Could not sign in, please try again'));
		}

		return access_token;

	}

	public static String getNewUrl(String access_token,String inUrl){

		String result = '';

		Http h = new Http();

		HttpRequest req = new HttpRequest();
		req.setEndpoint(BITLY_SERVICE_URL+access_token+'&longUrl=' + inUrl);
		req.setMethod('GET');
		req.setHeader('Accept', 'application/json');

		HttpResponse res = h.send(req);
		System.debug('\n res '+String.valueOf(res.getBody()));

		System.debug(res.getBody());
		if (  200 == res.getStatusCode()){
			Map<String, Object> source = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
			if (source.containsKey('data')){
				Object d= source.get('data');
 				Map<String, Object>  data=(Map<String, Object>)source.get('data');
				if (data.containsKey('url')){
					result = String.valueOf(data.get('url'));
				}
			}
		}

		return result;
	}


}
