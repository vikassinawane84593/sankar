
import 'package:flutter/material.dart';
import 'package:sankar/home/screen/product%20detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  int selectedNavIndex = 0;
  String searchQuery = '';

  final List<String> categories = [
    'All',
    'Electronics',
    'Jewellery',
    "Men's Clothing",
    "Women's Clothing",
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Mens Cotton Jacket',
      'price': 1299,
      'image':
      'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
      'rating': 4.5,
      'category': "Men's Clothing",
    },
    {
      'name': 'Mens Casual T-Shirt',
      'price': 899,
      'image':
      'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
      'rating': 4.2,
      'category': "Men's Clothing",
    },
    {
      'name': 'Gold Dragon Bracelet',
      'price': 599,
      'image':
      'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg',
      'rating': 4.6,
      'category': 'Jewellery',
    },
    {
      'name': 'External Hard Drive',
      'price': 2499,
      'image':
      'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
      'rating': 4.8,
      'category': 'Electronics',
    },
    {
      'name': 'Womens Casual Jacket',
      'price': 1799,
      'image':
      'https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg',
      'rating': 4.4,
      'category': "Women's Clothing",
    },
    {
      'name': 'Solid Gold Ring',
      'price': 999,
      'image':
      'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg',
      'rating': 4.3,
      'category': 'Jewellery',
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesCategory =
          selectedCategory == 0 ||
              product['category'] == categories[selectedCategory];

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void openProductDetails(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        title: const Text(
          'Sankar Shop',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cart screen coming soon'),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 28,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Promotional Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF7A00),
                      Color(0xFFFFA64D),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Discover New Arrivals',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explore amazing products\nat great prices.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 0;
                          searchQuery = '';
                        });
                      },
                      child: const Text('Shop Now'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Categories Heading
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              // Category List
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final isSelected =
                        selectedCategory == index;

                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(categories[index]),
                        selected: isSelected,
                        selectedColor:
                        const Color(0xFFFF7A00),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 26),

              // Featured Products Heading
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${visibleProducts.length} items',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Product Grid
              if (visibleProducts.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount: visibleProducts.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final product = visibleProducts[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        openProductDetails(product);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  product['image'],
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              product['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              '₹${product['price']}',
                              style: const TextStyle(
                                color: Color(0xFFFF7A00),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 17,
                                ),
                                const SizedBox(width: 4),
                                Text('${product['rating']}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedNavIndex,
        selectedItemColor: const Color(0xFFFF7A00),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            setState(() {
              selectedNavIndex = 0;
            });
          } else if (index == 1) {
            setState(() {
              selectedNavIndex = 1;
              selectedCategory = 0;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Screen coming soon'),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
