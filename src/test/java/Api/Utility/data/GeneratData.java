package Api.Utility.data;

public class GeneratData {

	public static String getEmail() {

		String prefix = "Student_email";
		String provider = "@gmail.com";
		int random = (int) (Math.random() * 100000);
		String email = prefix + random + provider;
		return email;
	}

	// the below main method was created to make sure the above method work fine
//public static void main(String[] args) {
//	GeneratData data= new GeneratData();
//	System.out.println(data.getEmail());
//}
	/**
	 * generate Randon phone number 10 digits
	 * 
	 * @return String phone number
	 */

	public static String getPhoneNumber() {

		String phoneNumber = "2";
		for (int i = 0; i < 9; i++) {
			phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;

	}

//	public static void main(String[] args) {
//		String number = getPhoneNumber();
//		System.out.println(number);
//		System.out.println(number.length());
//	}

 public static String getLicensePlate() {
	 String prefix="AB";
	 String provider ="1Y3";
	 String State="CA";
	 int random= (int)(Math.random()*6);
	 String Registration=State+"-"+prefix+random+provider;
	return Registration;
 }
//public static void main(String[] args) {
// String registration =getLicensePlate();
// System.out.println(registration);
//}

public static String getAutoAddress() {
	String StreetAddress="12 W, stockton blvd ";
	int random= (int)(Math.random()*10);
	String wholeAddress=random+StreetAddress;
	return wholeAddress;
}
public static void main(String[] args) {
	String CompleteAddress=getAutoAddress();
	System.out.println(CompleteAddress);
}
}