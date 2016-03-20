public class tinyUrl_multi_httpMock implements HttpCalloutMock {
	Map<String, HttpCalloutMock> requests;

	public tinyUrl_multi_httpMock(Map<String, HttpCalloutMock> requests) {
		this.requests = requests;
	}

	public HTTPResponse respond(HTTPRequest req) {
		HttpCalloutMock mock = requests.get(req.getEndpoint());
		if (mock != null) {
			return mock.respond(req);
		} else {
			throw new urlShortner.CustomException('HTTP callout not supported for test methods');
		}
	}

	public void addRequestMock(String url, HttpCalloutMock mock) {
		requests.put(url, mock);
	}
}
