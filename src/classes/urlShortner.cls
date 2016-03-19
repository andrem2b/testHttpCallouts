global with sharing class urlShortner {


	@RemoteAction
	global static Object getAvailableServices() {
		return new Map<String,String>{
			'bitly'=>'Use Bitly',
			'tiny'=>'Use TimyUrl'
		};
	}

	@RemoteAction
	global static Object logInToBitly(String user,String passw){
		wrapResult result =new wrapResult();

		if (String.isNotBlank(user) && String.isNotBlank(passw)){
			String token='';
			if(!Test.isRunningTest())
				token =  bitly_handler.logToService(user,passw);
			else
				token = 'testoken';
			result.results = (Object) new Map <String,String>{'token'=> token};
			result.error =false;
		}else{
			result.error =true;
			result.errorMsg = 'INVALID login';
		}

		return result;
	}

	@RemoteAction
	global static Object obtainNewUrl(String access_token,String originalUrl){
		wrapResult result =new wrapResult();

		if (String.isNotBlank(originalUrl)){
			String newUrl='';
			if(!Test.isRunningTest()){
				if (String.isNotBlank(access_token)){
					newUrl =  bitly_handler.getNewUrl(access_token,originalUrl);
				}else{
					newUrl =  tinyUrl_handler.getNewUrl(originalUrl);
				}
			}
			result.results = (Object) new Map <String,String>{'url'=> newUrl};
			result.error =false;
		}else{
			result.error =true;
			result.errorMsg = 'INVALID url';
		}

		return result;
	}

	public class wrapResult{
		public Object 	results{get;set;}
		public Boolean	error{get;set;}
		public String	errorMsg{get;set;}

		public wrapResult(){}

	}
	public class CustomException extends Exception {}
}
