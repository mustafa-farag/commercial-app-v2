class ApiPath {
  static String products() => 'products/';
  static String deliveryMethods() => 'deliveryMethods/';
  static String user(String uid) => 'users/$uid';
  static String shippingAddress(String uid) => 'users/$uid/shippingAddresses/';
  static String addToCart(String uid , String addToCartId) => 'users/$uid/cart/$addToCartId';
  static String getCartProducts(String uid) => 'users/$uid/cart/';
}