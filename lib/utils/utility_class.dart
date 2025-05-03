import 'package:flutter/material.dart';
import 'package:sippy_ca/core/app_colors.dart';
import 'package:sippy_ca/features/homepage/data/models/beverage.dart';
// import 'package:intl/intl.dart'; // Uncomment if needed for formatting
// import 'package:url_launcher/url_launcher.dart'; // Uncomment if needed for launching URLs
// import 'package:sippy_ca/core/config/get_it_setup.dart'; // Uncomment if needed for GetIt
// import 'package:sippy_ca/utils/dialog_services.dart'; // Uncomment if needed for DialogServices
// import 'package:sippy_ca/features/product_page/data/models/rating_model.dart'; // Uncomment if needed for RatingModel

class UtilityClass {
  static EdgeInsets horizontalPadding =
      const EdgeInsets.symmetric(horizontal: 20);

  static EdgeInsets horizontalAndVerticalPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  static EdgeInsets horizontalAndHalfVerticalPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  static String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static String? passwordValidator(String? value) {
    // Check if the password is empty
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    // Check password length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for uppercase letters
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letters
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digits
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    // Check for special characters
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  static String? firstNameValidator(String? value) {
    // Check if the first name is empty
    if (value == null || value.isEmpty) {
      return 'First name cannot be empty';
    }

    // Check for valid length
    if (value.length < 2) {
      return 'First name must be at least 2 characters long';
    }

    // Check for invalid characters (optional)
    // Allow spaces and hyphens for compound names
    if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value)) {
      return 'First name contains invalid characters';
    }

    return null; // First name is valid
  }

  static String? lastNameValidator(String? value) {
    // Check if the last name is empty
    if (value == null || value.isEmpty) {
      return 'Last name cannot be empty';
    }

    // Check for valid length
    if (value.length < 2) {
      return 'Last name must be at least 2 characters long';
    }

    // Check for invalid characters (optional)
    // Allow spaces and hyphens for compound names
    if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value)) {
      return 'Last name contains invalid characters';
    }

    return null; // Last name is valid
  }

//Button Container Styles

  static final buttonDecorationFill = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColors.primaryColor,
        AppColors.primaryColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius:
        BorderRadius.circular(0), // Consider making this non-zero for better UI
  );

  static BoxDecoration setButtonDecoration(Color color) {
    return BoxDecoration(
      border: Border.all(color: color, width: 2),
      color: color,
      borderRadius: BorderRadius.circular(0), // Consider making this non-zero
    );
  }

  static BoxDecoration setGradientDecoration(Color color1, Color color2) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color1,
          color2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(0), // Consider making this non-zero
    );
  }

  static final buttonDecorationOnlyOutline = BoxDecoration(
    border: Border.all(color: AppColors.secondaryColor, width: 1),
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(0), // Consider making this non-zero
  );

  static BoxDecoration setButtonOutlineDecoration(
    Color color,
  ) {
    return BoxDecoration(
      border: Border.all(color: color, width: 1),
      color: Colors.transparent,
      borderRadius:
          BorderRadius.circular(10), // Consistent radius with login page
    );
  }

// //Button Container Styles'

//   static String formatAmount(dynamic amount) {
//     try {
//       // Convert to a numeric type if it's a String
//       num numericAmount = amount is String ? num.parse(amount) : amount;
//       // Use NumberFormat to format the number
//       final formatter = NumberFormat('#,##0.##'); // Ensure intl package is imported
//       return formatter.format(numericAmount);
//     } catch (e) {
//       // Handle invalid input gracefully
//       print("Error formatting amount: $e"); // Log error for debugging
//       return 'Invalid amount';
//     }
//   }

//   static List<Map<String, dynamic>> categoryItems = [
//     {
//       "title": "Residential",
//       "icon": Icon(
//         Icons.home_outlined,
//         color: Colors.green[500],
//       )
//     },
//     {
//       "title": "Commercial",
//       "icon": Icon(
//         Icons.business_outlined,
//         color: Colors.green[500],
//       )
//     },
//     {
//       "title": "Land",
//       "icon": Icon(
//         Icons.landscape_outlined,
//         color: Colors.green[500],
//       )
//     },
//     {
//       "title": "Hospitality",
//       "icon": Icon(
//         Icons.hotel_outlined,
//         color: Colors.green[500],
//       )
//     },
//     {
//       "title": "Industrial",
//       "icon": Icon(
//         Icons.factory_outlined,
//         color: Colors.green[500],
//       )
//     },
//     {
//       "title": "Speciality",
//       "icon": Icon(
//         Icons.star_border_outlined,
//         color: Colors.green[500],
//       )
//     }
//   ];

//   static final List<Category> categories = [
//     Category(
//       type: "Residential",
//       subcategories: [
//         "Apartments/Flats",
//         "Houses",
//         "Duplexes",
//         "Townhouses",
//         "Studios",
//         "Shared Accommodation",
//         "Villas",
//         "Serviced Apartments"
//       ],
//     ),
//     Category(
//       type: "Commercial",
//       subcategories: [
//         "Office Spaces",
//         "Retail Shops",
//         "Warehouses",
//         "Workshops",
//         "Showrooms",
//         "Co-working Spaces"
//       ],
//     ),
//     Category(
//       type: "Land",
//       subcategories: ["Empty Plots", "Agricultural Land", "Industrial Land"],
//     ),
//     Category(
//       type: "Hospitality",
//       subcategories: [
//         "Hotels and Resorts",
//         "Guesthouses",
//         "Event Venues",
//         "Holiday Homes"
//       ],
//     ),
//     Category(
//       type: "Industrial",
//       subcategories: [
//         "Factories",
//         "Cold Storage Facilities",
//         "Industrial Sheds"
//       ],
//     ),
//     Category(
//       type: "Specialty",
//       subcategories: [
//         "Hostels",
//         "Health Facilities",
//         "Schools/Training Centers",
//         "Parking Spaces"
//       ],
//     ),
//   ];

  static List<Map<String, dynamic>> availabilty = [
    {
      "option": "Everyday",
      "value": 7,
    },
    {
      "option": "Weekdays",
      "value": 5,
    },
    {
      "option": "Weekends",
      "value": 2,
    }
  ];

  static List<Map<String, dynamic>> durationType = [
    {"option": "Hourly", "textValue": "Hour", "value": 1},
    {"option": "Daily", "textValue": "Day", "value": 1},
    //{"option": "Weekly", "textValue": "Week", "value": 7},
    //{"option": "Monthly", "textValue": "Month", "value": 30},
    {"option": "Per Annum", "textValue": "Annum", "value": 1},
  ];

  static List images = [
    "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
    "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
    "https://wallpapers.com/images/featured/2ygv7ssy2k0lxlzu.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
    "https://media.cntraveller.com/photos/611bf0b8f6bd8f17556db5e4/1:1/w_2000,h_2000,c_limit/gettyimages-1146431497.jpg",
    "https://img.freepik.com/premium-photo/fantastic-view-kirkjufellsfoss-waterfall-near-kirkjufell-mountain-sunset_761071-868.jpg",
    "https://www.travelandleisure.com/thmb/KLPvXakEKLGE5AY2jVyovl3Md1k=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/iceland-BEAUTCONT1021-b1aeafa7ac2847a484cbca48d3172b6c.jpg",
    "https://w0.peakpx.com/wallpaper/265/481/HD-wallpaper-nature.jpg",
    //"https://e0.pxfuel.com/wallpapers/163/906/desktop-wallpaper-beautiful-nature-with-girl-beautiful-girl-with-nature-and-moon-high-resolution-beautiful.jpg",
  ];

  static List<String> uniqueCategories = [
    "Clothing",
    "Accessories",
    "Footwear",
    "Electronics",
    "Jewelry"
  ];

  // --- Added Beverage List ---
  static final List<String> beverages = [
    "Coffee",
    "Espresso",
    "Latte",
    "Cappuccino",
    "Black Tea",
    "Green Tea",
    "Herbal Tea",
    "Iced Tea",
    "Hot Chocolate",
    "Milk",
    "Chocolate Milk",
    "Orange Juice",
    "Apple Juice",
    "Grape Juice",
    "Lemonade",
    "Cola",
    "Lemon-Lime Soda",
    "Ginger Ale",
    "Root Beer",
    "Sparkling Water",
    "Still Water",
    "Smoothie",
    "Milkshake",
    "Energy Drink",
    "Sports Drink",
    // Add more specific or regional beverages as needed
  ];
  // --- End of Beverage List ---

  static final List<BeverageItem> brandedBeverages = [
    const BeverageItem(
      itemId: "bev001",
      name: "Starbucks Pike Place Roast",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_cup_of_coffee.JPG/800px-A_cup_of_coffee.JPG",
      price: 3.45,
      description:
          "A smooth, well-rounded blend of Latin American coffees with subtle notes of cocoa and toasted nuts, freshly brewed every day at Starbucks.",
    ),
    const BeverageItem(
      itemId: "bev002",
      name: "Pepsi",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Pepsi_can_2012.jpg/800px-Pepsi_can_2012.jpg",
      price: 1.25,
      description:
          "A popular cola-flavored soda with a bold and refreshing taste, best served chilled.",
    ),
    const BeverageItem(
      itemId: "bev003",
      name: "Coca-Cola",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Coca-Cola_Can_2015.jpg/800px-Coca-Cola_Can_2015.jpg",
      price: 1.30,
      description:
          "The original Coca-Cola classic—sweet, bubbly, and refreshing with a rich cola flavor.",
    ),
    const BeverageItem(
      itemId: "bev004",
      name: "Red Bull",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/RedBullCan.jpg/800px-RedBullCan.jpg",
      price: 2.50,
      description:
          "A high-energy drink that revitalizes body and mind. Perfect for when you need an energy boost.",
    ),
    const BeverageItem(
      itemId: "bev005",
      name: "Monster Energy",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Monster_Energy_drink_can_%282021%29.jpg/800px-Monster_Energy_drink_can_%282021%29.jpg",
      price: 2.70,
      description:
          "Unleash the beast with Monster Energy—a powerful blend of caffeine and B vitamins.",
    ),
    const BeverageItem(
      itemId: "bev006",
      name: "Gatorade Cool Blue",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Gatorade_Bottle_Blue.jpg/800px-Gatorade_Bottle_Blue.jpg",
      price: 1.75,
      description:
          "Stay hydrated with Gatorade Cool Blue—a thirst-quenching sports drink packed with electrolytes.",
    ),
    const BeverageItem(
      itemId: "bev007",
      name: "Powerade Mountain Berry Blast",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Powerade_Mountain_Berry_Blast.jpg/800px-Powerade_Mountain_Berry_Blast.jpg",
      price: 1.70,
      description:
          "Rehydrate and replenish with the berry flavor of Powerade, designed for peak performance.",
    ),
    const BeverageItem(
      itemId: "bev008",
      name: "Lipton Iced Tea Lemon",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Lipton_Ice_Tea_Lemon.jpg/800px-Lipton_Ice_Tea_Lemon.jpg",
      price: 1.50,
      description:
          "Lipton Iced Tea with lemon flavor—a refreshing and lightly sweetened iced tea beverage.",
    ),
    const BeverageItem(
      itemId: "bev009",
      name: "Arizona Green Tea",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/AriZona_Green_Tea_with_Ginseng_and_Honey_can.jpg/800px-AriZona_Green_Tea_with_Ginseng_and_Honey_can.jpg",
      price: 1.00,
      description:
          "Classic AriZona Green Tea with Ginseng and Honey—a fan favorite known for its delicious taste.",
    ),
    const BeverageItem(
      itemId: "bev010",
      name: "Nestea Lemon Iced Tea",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Nestea_Lemon.jpg/800px-Nestea_Lemon.jpg",
      price: 1.60,
      description:
          "Cool and refreshing Nestea Lemon Iced Tea—a light and citrusy beverage.",
    ),
  ];

  static String greetUser() {
    // Get the current hour of the day
    final hour = DateTime.now().hour;

    // Determine the greeting based on the hour
    if (hour >= 5 && hour < 12) {
      return "Good Morning!";
    } else if (hour >= 12 && hour < 17) {
      // Changed from "Good day!" for better flow
      return "Good Afternoon!";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening!";
    } else {
      // Covers late night and early morning before 5 AM
      return "Good Night!";
    }
  }

  // static double calculateAverageRating(List<RatingModel> ratings) {
  //   if (ratings.isEmpty) return 0.0; // Handle empty list

  //   double totalRating = 0.0; // Use double for potential fractional ratings
  //   int count = 0; // Variable to count the number of valid ratings

  //   for (var rating in ratings) {
  //     // Ensure rating.rating is not null and is a valid number
  //     if (rating.rating != null) {
  //        // Assuming rating.rating is int or double
  //       totalRating += rating.rating!;
  //       count++;
  //     }
  //   }

  //   // Avoid division by zero and return the average rating, formatted to one decimal place
  //   return count > 0
  //       ? double.parse((totalRating / count).toStringAsFixed(1))
  //       : 0.0;
  // }

  // static String formatDate(DateTime dateTime) {
  //   final now = DateTime.now();
  //   final difference = now.difference(dateTime);

  //   if (difference.inSeconds < 60) {
  //     return 'now';
  //   } else if (difference.inMinutes < 60) {
  //     final minutes = difference.inMinutes;
  //     return '$minutes min${minutes == 1 ? '' : 's'} ago'; // Handle pluralization
  //   } else if (difference.inHours < 24) {
  //      final hours = difference.inHours;
  //     return '$hours hour${hours == 1 ? '' : 's'} ago'; // Handle pluralization
  //   } else if (difference.inDays < 7) {
  //      final days = difference.inDays;
  //     return '$days day${days == 1 ? '' : 's'} ago'; // Handle pluralization
  //   } else if (difference.inDays < 30) {
  //     final weeks = (difference.inDays / 7).floor();
  //     return '$weeks week${weeks == 1 ? '' : 's'} ago'; // Handle pluralization
  //   } else if (difference.inDays < 365) {
  //     final months = (difference.inDays / 30).floor(); // Approximation
  //     return '$months month${months == 1 ? '' : 's'} ago'; // Handle pluralization
  //   } else {
  //     // Use intl package for better date formatting if needed
  //     // return DateFormat('d MMM y').format(dateTime); // Example: 5 Jan 2023
  //     final years = (difference.inDays / 365).floor();
  //      return '$years year${years == 1 ? '' : 's'} ago'; // Handle pluralization
  //   }
  // }

  // static void dialNumber(BuildContext context, String phoneNumber) async {
  //   // Sanitize phone number (remove spaces, dashes, etc.)
  //   final String sanitizedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
  //   final Uri telUri = Uri(
  //     scheme: 'tel',
  //     path: sanitizedPhoneNumber,
  //   );

  //   try {
  //      if (await canLaunchUrl(telUri)) {
  //       await launchUrl(telUri);
  //     } else {
  //       // Consider using DialogServices if GetIt is set up
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Could not launch dialer for $phoneNumber')),
  //       );
  //       // getIt<DialogServices>().showMessageError("Unable to dial $phoneNumber");
  //     }
  //   } catch (e) {
  //      ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error launching dialer: $e')),
  //       );
  //      // getIt<DialogServices>().showMessageError("Error dialing $phoneNumber: $e");
  //   }
  // }

  // static void sendSMS(BuildContext context, String phoneNumber, {String body = ''}) async {
  //    // Sanitize phone number
  //   final String sanitizedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
  //   final Uri smsUri = Uri(
  //     scheme: 'sms',
  //     path: sanitizedPhoneNumber,
  //     queryParameters: <String, String>{ // Add body if provided
  //       if (body.isNotEmpty) 'body': body,
  //     },
  //   );

  //    try {
  //      if (await canLaunchUrl(smsUri)) {
  //       await launchUrl(smsUri);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Could not launch SMS app for $phoneNumber')),
  //       );
  //       // getIt<DialogServices>().showMessageError("Unable to send SMS to $phoneNumber");
  //     }
  //   } catch (e) {
  //      ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error launching SMS app: $e')),
  //       );
  //      // getIt<DialogServices>().showMessageError("Error sending SMS to $phoneNumber: $e");
  //   }
  // }

  // static String extractFormattedTime(String timestamp) {
  //   try {
  //      DateTime dateTime = DateTime.parse(timestamp).toLocal(); // Convert to local time
  //     // Use intl package for more robust formatting if needed
  //     // return DateFormat('h:mm a').format(dateTime); // Example: 5:30 PM
  //     // Basic formatting without intl:
  //     int hour = dateTime.hour;
  //     int minute = dateTime.minute;
  //     String period = hour < 12 ? 'AM' : 'PM';
  //     hour = hour % 12;
  //     if (hour == 0) hour = 12; // Handle midnight/noon
  //     String minuteStr = minute < 10 ? '0$minute' : '$minute';
  //     return '$hour:$minuteStr $period';
  //   } catch (e) {
  //     print("Error parsing timestamp for time extraction: $e");
  //     return "Invalid Time";
  //   }
  // }

  // static DateTimeRange calculatePeriod({
  //   required DateTime startDate,
  //   int years = 0,
  //   int months = 0,
  //   int weeks = 0,
  //   int days = 0,
  //   int hours = 0, // Added hours
  // }) {
  //   if (years < 0 || months < 0 || weeks < 0 || days < 0 || hours < 0) {
  //      throw ArgumentError("Duration components cannot be negative.");
  //   }
  //   if (years == 0 && months == 0 && weeks == 0 && days == 0 && hours == 0) {
  //     // Return a range of zero duration if all components are zero
  //     return DateTimeRange(start: startDate, end: startDate);
  //     // Or throw error if zero duration is not allowed:
  //     // throw ArgumentError("At least one duration component must be positive.");
  //   }

  //   // Calculate the ending date using Duration for days and hours
  //   DateTime endDate = startDate.add(Duration(days: days + (weeks * 7), hours: hours));

  //   // Add months and years carefully, handling potential date rollovers
  //   // This approach tries to preserve the day of the month where possible
  //   int targetYear = endDate.year + years;
  //   int targetMonth = endDate.month + months;

  //   // Adjust year and month if targetMonth exceeds 12
  //   targetYear += (targetMonth - 1) ~/ 12;
  //   targetMonth = (targetMonth - 1) % 12 + 1;

  //   // Find the last day of the target month/year
  //   int lastDayOfTargetMonth = DateTime(targetYear, targetMonth + 1, 0).day;

  //   // Ensure the day doesn't exceed the last day of the target month
  //   int targetDay = endDate.day > lastDayOfTargetMonth ? lastDayOfTargetMonth : endDate.day;

  //   endDate = DateTime(
  //       targetYear,
  //       targetMonth,
  //       targetDay,
  //       endDate.hour,
  //       endDate.minute,
  //       endDate.second,
  //       endDate.millisecond,
  //       endDate.microsecond);

  //   // Ensure end date is not before start date (can happen with complex month/year logic if not careful)
  //   if (endDate.isBefore(startDate)) {
  //       // This case should ideally not happen with the logic above, but as a safeguard:
  //       print("Warning: Calculated end date is before start date. Returning zero duration range.");
  //       return DateTimeRange(start: startDate, end: startDate);
  //   }

  //   return DateTimeRange(start: startDate, end: endDate);
  // }
}

// Example Category class if needed for the commented-out code
// class Category {
//   final String type;
//   final List<String> subcategories;
//   Category({required this.type, required this.subcategories});
// }
