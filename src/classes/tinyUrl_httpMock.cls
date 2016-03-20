@isTest
public class tinyUrl_httpMock implements HttpCalloutMock {

	protected Integer code;
	protected String status;
	protected String body;
	protected Blob bodyAsBlob;
	protected Map<String, String> responseHeaders;

	public tinyUrl_httpMock(Integer code, String status, String body, Map<String, String> responseHeaders) {
		this.code = code;
		this.status = status;
		this.body = body;
		this.bodyAsBlob = null;
		this.responseHeaders = responseHeaders;
	}

	public tinyUrl_httpMock(Integer code, String status, Blob bodyAsBlob, Map<String, String> responseHeaders) {
		this.code = code;
		this.status = status;
		this.body = null;
		this.bodyAsBlob = bodyAsBlob;
		this.responseHeaders = responseHeaders;
	}

	public HTTPResponse respond(HTTPRequest req) {

		HttpResponse res = new HttpResponse();
		for (String key : this.responseHeaders.keySet()) {
			res.setHeader(key, this.responseHeaders.get(key));
		}
		res.setBody(this.body);
		res.setStatusCode(this.code);
		res.setStatus(this.status);
		return res;
	}

	}
