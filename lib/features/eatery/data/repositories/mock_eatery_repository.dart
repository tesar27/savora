import 'package:savora/features/eatery/domain/models/eatery.dart';
import 'package:savora/features/eatery/domain/models/eatery_deal.dart';
import 'package:savora/features/eatery/domain/models/eatery_review.dart';
import 'package:savora/features/eatery/domain/models/opening_hours.dart';
import 'package:savora/features/eatery/domain/repositories/eatery_repository.dart';

/// In-memory mock repository used during UI development.
///
/// Replace with `SupabaseEateryRepository` (remote) backed by
/// `IsarEateryRepository` (cache) when connecting to production.
class MockEateryRepository implements EateryRepository {
  // ─── Shared fixtures ────────────────────────────────────────────────────────

  static const List<OpeningHours> _standardHours = <OpeningHours>[
    OpeningHours(day: 'Monday', open: '11:30', close: '23:00'),
    OpeningHours(day: 'Tuesday', open: '11:30', close: '23:00'),
    OpeningHours(day: 'Wednesday', open: '11:30', close: '23:00'),
    OpeningHours(day: 'Thursday', open: '11:30', close: '23:00'),
    OpeningHours(day: 'Friday', open: '11:30', close: '00:00'),
    OpeningHours(day: 'Saturday', open: '11:30', close: '00:00'),
    OpeningHours(day: 'Sunday', open: '12:00', close: '23:00'),
  ];

  static const List<OpeningHours> _cafeHours = <OpeningHours>[
    OpeningHours(day: 'Monday', open: '08:00', close: '20:00'),
    OpeningHours(day: 'Tuesday', open: '08:00', close: '20:00'),
    OpeningHours(day: 'Wednesday', open: '08:00', close: '20:00'),
    OpeningHours(day: 'Thursday', open: '08:00', close: '20:00'),
    OpeningHours(day: 'Friday', open: '08:00', close: '21:00'),
    OpeningHours(day: 'Saturday', open: '09:00', close: '21:00'),
    OpeningHours(day: 'Sunday', open: '10:00', close: '18:00'),
  ];

  static const List<EateryReview> _italianReviews = <EateryReview>[
    EateryReview(id: 'r-it-1', reviewerName: 'Berfin', rating: 5.0, timeAgo: '1 day ago', comment: 'Best pasta I have ever had – the 2-for-1 deal is incredible value!'),
    EateryReview(id: 'r-it-2', reviewerName: 'Sandra', rating: 2.0, timeAgo: '1 day ago'),
    EateryReview(id: 'r-it-3', reviewerName: 'Lütfiye', rating: 5.0, timeAgo: '2 days ago', comment: 'Cozy atmosphere and very friendly staff.'),
    EateryReview(id: 'r-it-4', reviewerName: 'Achsah', rating: 5.0, timeAgo: '6 days ago'),
    EateryReview(id: 'r-it-5', reviewerName: 'Foivos', rating: 4.0, timeAgo: '1 week ago', comment: 'Solid deal, would recommend to friends visiting Freiburg.'),
  ];

  static const List<EateryReview> _burgerReviews = <EateryReview>[
    EateryReview(id: 'r-bg-1', reviewerName: 'Marco', rating: 5.0, timeAgo: '2 days ago', comment: 'Juicy burgers and generous portions, the deal is a steal!'),
    EateryReview(id: 'r-bg-2', reviewerName: 'Elena', rating: 4.0, timeAgo: '3 days ago'),
    EateryReview(id: 'r-bg-3', reviewerName: 'Tomas', rating: 5.0, timeAgo: '1 week ago', comment: 'Came twice already using the Savora deal.'),
    EateryReview(id: 'r-bg-4', reviewerName: 'Hannah', rating: 3.0, timeAgo: '2 weeks ago'),
    EateryReview(id: 'r-bg-5', reviewerName: 'Yusuf', rating: 5.0, timeAgo: '3 weeks ago', comment: 'Worth every cent.'),
  ];

  static const List<EateryReview> _cafeReviews = <EateryReview>[
    EateryReview(id: 'r-cf-1', reviewerName: 'Priya', rating: 5.0, timeAgo: '1 day ago', comment: 'The cake selection is divine and the 2-for-1 deal is perfect for dates!'),
    EateryReview(id: 'r-cf-2', reviewerName: 'Lars', rating: 4.0, timeAgo: '4 days ago'),
    EateryReview(id: 'r-cf-3', reviewerName: 'Mia', rating: 5.0, timeAgo: '1 week ago'),
    EateryReview(id: 'r-cf-4', reviewerName: 'David', rating: 5.0, timeAgo: '2 weeks ago', comment: 'Relaxed vibe, great coffee. Highly recommend.'),
    EateryReview(id: 'r-cf-5', reviewerName: 'Sofie', rating: 4.0, timeAgo: '3 weeks ago'),
  ];

  // ─── Eatery catalogue ───────────────────────────────────────────────────────

  static final Map<String, Eatery> _data = <String, Eatery>{
    'fino': const Eatery(
      id: 'fino',
      name: 'Fino',
      category: 'Cafe, Ice Cream, Drinks',
      rating: 4.8,
      ratingCount: 1240,
      reviewCount: 320,
      distance: '70 km',
      imageUrl: 'https://images.pexels.com/photos/5938/food-salad-healthy-lunch.jpg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Hauptstraße 12, Freiburg',
      city: 'Freiburg',
      phone: '+49 761 123 4567',
      redeemedText: '100+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'fino-d1',
          title: '2-for-1 Cakes',
          savingsLabel: '~8 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 cakes of your choice – the cheaper or equally priced one is complimentary. Show this deal before ordering.',
        ),
        EateryDeal(
          id: 'fino-d2',
          title: '2-for-1 Winery Deal',
          savingsLabel: '~12 €',
          validityDays: 14,
          locationType: 'In-store',
          description: 'Order 2 glasses of wine and the cheaper or equal one is on the house. Must be presented to staff before ordering.',
        ),
      ],
      reviews: _cafeReviews,
      openingHours: _cafeHours,
    ),

    'tama-bistro': const Eatery(
      id: 'tama-bistro',
      name: 'Tama Bistro',
      category: 'Bistro, Burgers, Lunch',
      rating: 4.9,
      ratingCount: 980,
      reviewCount: 234,
      distance: '71 km',
      imageUrl: 'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Bertoldstraße 5, Freiburg',
      city: 'Freiburg',
      phone: '+49 761 987 6543',
      redeemedText: '100+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'tama-d1',
          title: '2-for-1 Main Dish',
          savingsLabel: '~14 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 main dishes from our menu – the cheaper or equally priced one is free. Show the deal before ordering.',
        ),
      ],
      reviews: _burgerReviews,
      openingHours: _standardHours,
    ),

    'losteria-freiburg': const Eatery(
      id: 'losteria-freiburg',
      name: "L'Osteria Freiburg Ramparts",
      category: 'Italian, Pizza, Pasta',
      rating: 4.8,
      ratingCount: 1785,
      reviewCount: 394,
      distance: '71 km',
      imageUrl: 'https://images.pexels.com/photos/2619967/pexels-photo-2619967.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Rempartstraße 4, Freiburg im Breisgau',
      city: 'Freiburg',
      phone: '+49 761 744 075',
      rank: '#1',
      redeemedText: '3.8k+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'lost-d1',
          title: '2-for-1 Pasta or Salat',
          savingsLabel: '~14 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 salads or pasta dishes of your choice – the cheaper/equally priced is not charged. Must be shown before ordering.',
        ),
        EateryDeal(
          id: 'lost-d2',
          title: '2-for-1 Aperitivi',
          savingsLabel: '~7 €',
          validityDays: 6,
          locationType: 'In-store',
          description: 'Order 2 aperitifs of your choice – the cheaper/equally priced one is complimentary. Show this before ordering.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),

    'enchilada-freiburg': const Eatery(
      id: 'enchilada-freiburg',
      name: 'Enchilada Freiburg',
      category: 'Mexican, Tacos, Dinner',
      rating: 4.8,
      ratingCount: 1560,
      reviewCount: 312,
      distance: '71 km',
      imageUrl: 'https://images.pexels.com/photos/4958792/pexels-photo-4958792.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Kaiser-Joseph-Straße 175, Freiburg',
      city: 'Freiburg',
      phone: '+49 761 202 9190',
      rank: '#2',
      redeemedText: '2.4k+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'ench-d1',
          title: '2-for-1 Main Dish',
          savingsLabel: '~16 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order any 2 main dishes from our dinner menu – the cheaper one is on us. Present deal before ordering.',
        ),
      ],
      reviews: _burgerReviews,
      openingHours: _standardHours,
    ),

    'golden-slice': const Eatery(
      id: 'golden-slice',
      name: 'Golden Slice',
      category: 'Pizza, Casual Dining',
      rating: 4.7,
      ratingCount: 870,
      reviewCount: 180,
      distance: '18 km',
      imageUrl: 'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Münsterplatz 8, Freiburg',
      city: 'Freiburg',
      phone: '+49 761 555 1234',
      redeemedText: '2k+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'gs-d1',
          title: '2-for-1 Family Pizza',
          savingsLabel: '~18 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 family-size pizzas from our menu and the less expensive one is complimentary. Show before ordering.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),

    'urban-grill': const Eatery(
      id: 'urban-grill',
      name: 'Urban Grill',
      category: 'Steak, Burgers',
      rating: 4.6,
      ratingCount: 720,
      reviewCount: 155,
      distance: '23 km',
      imageUrl: 'https://images.pexels.com/photos/1437267/pexels-photo-1437267.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Wilhelmstraße 9, Freiburg',
      city: 'Freiburg',
      phone: '+49 761 321 6789',
      redeemedText: '1.5k+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'ug-d1',
          title: '2-for-1 Burgers',
          savingsLabel: '~14 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order any 2 burgers from our grill menu – the cheaper one is on the house. Must be shown before ordering.',
        ),
      ],
      reviews: _burgerReviews,
      openingHours: _standardHours,
    ),

    'rosso-trattoria': const Eatery(
      id: 'rosso-trattoria',
      name: 'Rosso Trattoria',
      category: 'Italian, Fine Dining',
      rating: 4.9,
      ratingCount: 1100,
      reviewCount: 270,
      distance: '11 km',
      imageUrl: 'https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Schillerstraße 3, Basel',
      city: 'Basel',
      phone: '+41 61 270 1234',
      redeemedText: '1.1k+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'rt-d1',
          title: '2-for-1 Tasting Menu',
          savingsLabel: '~45 €',
          validityDays: 14,
          locationType: 'In-store',
          description: 'Reserve a table for 2 and enjoy the tasting menu – the second menu is complimentary. Book at least 24 h in advance.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),

    'sea-cove': const Eatery(
      id: 'sea-cove',
      name: 'Sea Cove',
      category: 'Seafood, Grill',
      rating: 4.9,
      ratingCount: 950,
      reviewCount: 220,
      distance: '15 km',
      imageUrl: 'https://images.pexels.com/photos/2233729/pexels-photo-2233729.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Rheinufer 7, Basel',
      city: 'Basel',
      phone: '+41 61 388 9900',
      redeemedText: '950+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'sc-d1',
          title: '2-for-1 Chef Special',
          savingsLabel: '~32 €',
          validityDays: 7,
          locationType: 'In-store',
          description: 'Order 2 of today\'s chef special – the lower-priced one is complimentary. Must be shown to staff before the meal.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),

    'the-brunch-lab': const Eatery(
      id: 'the-brunch-lab',
      name: 'The Brunch Lab',
      category: 'Brunch, Coffee',
      rating: 4.6,
      ratingCount: 640,
      reviewCount: 130,
      distance: '8 km',
      imageUrl: 'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Leopoldstraße 22, Zurich',
      city: 'Zurich',
      phone: '+41 44 211 5500',
      redeemedText: '350+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'tbl-d1',
          title: '2-for-1 Brunch Combo',
          savingsLabel: '~18 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 brunch combos (drink + main + pastry) – the lower-priced combo is on us. Offer valid until 14:00.',
        ),
      ],
      reviews: _cafeReviews,
      openingHours: _cafeHours,
    ),

    'sora-ramen': const Eatery(
      id: 'sora-ramen',
      name: 'Sora Ramen',
      category: 'Japanese, Noodles',
      rating: 4.7,
      ratingCount: 780,
      reviewCount: 160,
      distance: '9 km',
      imageUrl: 'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Langstraße 44, Zurich',
      city: 'Zurich',
      phone: '+41 44 400 7788',
      redeemedText: '420+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'sr-d1',
          title: '2-for-1 Ramen Bowls',
          savingsLabel: '~16 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 ramen bowls of your choice – the cheaper bowl is complimentary. Show deal before ordering.',
        ),
      ],
      reviews: _burgerReviews,
      openingHours: _standardHours,
    ),

    'the-noodle-house': const Eatery(
      id: 'the-noodle-house',
      name: 'The Noodle House',
      category: 'Asian, Noodles',
      rating: 4.8,
      ratingCount: 860,
      reviewCount: 195,
      distance: '12 km',
      imageUrl: 'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Ankerstraße 9, Zurich',
      city: 'Zurich',
      phone: '+41 44 520 3344',
      redeemedText: '860+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'tnh-d1',
          title: '2-for-1 Noodle Set',
          savingsLabel: '~13 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 noodle set menus – the equivalent or lower-priced one is on us. Must present before ordering.',
        ),
      ],
      reviews: _burgerReviews,
      openingHours: _standardHours,
    ),

    'bella-verona': const Eatery(
      id: 'bella-verona',
      name: 'Bella Verona',
      category: 'Italian, Pasta',
      rating: 4.8,
      ratingCount: 1200,
      reviewCount: 260,
      distance: '17 km',
      imageUrl: 'https://images.pexels.com/photos/725991/pexels-photo-725991.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Oetenbachgasse 14, Zurich',
      city: 'Zurich',
      phone: '+41 44 211 0011',
      redeemedText: '1.2k+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'bv-d1',
          title: '2-for-1 Pasta Plate',
          savingsLabel: '~14 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 pasta plates of your choice – the cheaper or equally priced one is complimentary. Show before ordering.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),

    'pizza-harbor': const Eatery(
      id: 'pizza-harbor',
      name: 'Pizza Harbor',
      category: 'Pizza, Delivery',
      rating: 4.7,
      ratingCount: 700,
      reviewCount: 145,
      distance: '10 km',
      imageUrl: 'https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Feldbergstraße 18, Basel',
      city: 'Basel',
      phone: '+41 61 333 5566',
      redeemedText: '700+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'ph-d1',
          title: '2-for-1 Margherita',
          savingsLabel: '~13 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 Margherita pizzas and the second one is on us. Deal must be shown to staff before ordering.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),

    'stone-oven-co': const Eatery(
      id: 'stone-oven-co',
      name: 'Stone Oven Co.',
      category: 'Wood-fired Pizza',
      rating: 4.8,
      ratingCount: 980,
      reviewCount: 210,
      distance: '16 km',
      imageUrl: 'https://images.pexels.com/photos/4109074/pexels-photo-4109074.jpeg?auto=compress&cs=tinysrgb&w=1200',
      address: 'Steinenvorstadt 25, Basel',
      city: 'Basel',
      phone: '+41 61 272 4488',
      redeemedText: '980+ redeemed',
      deals: <EateryDeal>[
        EateryDeal(
          id: 'soc-d1',
          title: '2-for-1 Pizza Slices',
          savingsLabel: '~12 €',
          validityDays: 30,
          locationType: 'In-store',
          description: 'Order 2 wood-fired pizza slices of your choice – the cheaper or equal one is free. Present before ordering.',
        ),
      ],
      reviews: _italianReviews,
      openingHours: _standardHours,
    ),
  };

  // ─── EateryRepository implementation ────────────────────────────────────────

  @override
  Future<Eatery?> getEatery(String id) async => _data[id];

  @override
  Future<List<Eatery>> getEateries({
    String? cityId,
    String? category,
    int page = 0,
    int pageSize = 20,
  }) async {
    List<Eatery> results = _data.values.toList();

    if (cityId != null) {
      results = results
          .where((Eatery e) => e.city.toLowerCase() == cityId.toLowerCase())
          .toList();
    }

    if (category != null) {
      results = results
          .where((Eatery e) =>
              e.category.toLowerCase().contains(category.toLowerCase()))
          .toList();
    }

    final int start = page * pageSize;
    if (start >= results.length) return <Eatery>[];
    return results.sublist(start, (start + pageSize).clamp(0, results.length));
  }
}
