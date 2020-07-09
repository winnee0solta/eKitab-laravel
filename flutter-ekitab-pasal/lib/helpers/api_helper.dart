class ApiHelper {
  static final String domain = "http://192.168.1.68:8000";
  static final String baseurl = domain + "/api/mobile"; 

  static final String categoryimageurl = domain + "/images/categories/"; 

  static final String loginurl = baseurl + "/login"; 
  static final String registerurl = baseurl + "/register";

  static final String resetpassword = baseurl + "/reset-password"; 
  static final String checktoken = baseurl + "/check-token"; 
  static final String updatepassword = baseurl + "/update-password"; 

  static final String accountverification = baseurl + "/email-verification"; 
  static final String resendcode = baseurl + "/email-verification/resend"; 

  static final String profile = baseurl + "/profile"; 
  static final String updateprofile = baseurl + "/profile/update"; 
  
  static final String categories = baseurl + "/categories"; 
  static final String books = baseurl + "/books"; 
  static final String addbook = baseurl + "/books/add"; 
  static final String mybooks = baseurl + "/books/my-books";  
  static final String book = baseurl + "/books/book"; 
  static final String removebook = baseurl + "/books/book/remove"; 

  static final String updatebook = baseurl + "/books/book/update"; 
  static final String hirebook = baseurl + "/books/book/hire"; 

  static final String mycart = baseurl + "/my-cart"; 
  static final String removecartbook = baseurl + "/my-cart/remove"; 

  static final String changehirestatus = baseurl + "/book/change-hired-status";

  static final String hiredbooks = baseurl + "/book/hired-books";
  static final String categorybooks = baseurl + "/book/category";

  static final String trash = baseurl + "/"; 
}
