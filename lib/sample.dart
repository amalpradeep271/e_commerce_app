import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_state.dart';
import 'package:e_commerce_application/sample_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc Section
enum BottomNavItem { home, wishlist }

class BottomNavCubit extends Cubit<BottomNavItem> {
  BottomNavCubit() : super(BottomNavItem.home);

  void updateTab(BottomNavItem item) {
    emit(item);
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WishlistCubit()..loadWishlist(),
        ),
        BlocProvider(
          create: (context) => ProductCubit()..fetchProducts(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductsPage()),
                        );
                      },
                      child:
                          Text("See All", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProductLoaded) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      );
                    } else {
                      return Center(child: Text("Failed to load products"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// All Products Page
class AllProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..fetchProducts(),
        ),
        BlocProvider(
          create: (context) => WishlistCubit()..loadWishlist(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("All Products")),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(product: product);
                },
              );
            } else {
              return Center(child: Text("Failed to load products"));
            }
          },
        ),
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Image.network(
                    ImageDisplayHelper.generateSingleProductImageURL(
                      product.images[0],
                    ),
                    fit: BoxFit.cover),
              ),
              Text(product.title),
              Text("\$${product.price}"),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                bool isWishlisted = false;
                if (state is WishlistLoaded) {
                  isWishlisted = state.wishlistedItems
                      .any((p) => p.productId == product.productId);
                }
                return IconButton(
                  icon: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context.read<WishlistCubit>().toggleWishlist(product);
                    // context.read<WishlistCubit>().loadWishlist();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WishlistCubit()..loadWishlist(),
        ),
        BlocProvider(
          create: (context) => ProductCubit()..fetchProducts(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Wishlist')),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WishlistError) {
              return Center(child: Text(state.message));
            } else if (state is WishlistLoaded) {
              if (state.wishlistedItems.isEmpty) {
                return Center(child: Text('No items in wishlist'));
              }

              return ListView.builder(
                itemCount: state.wishlistedItems.length,
                itemBuilder: (context, index) {
                  final product = state.wishlistedItems[index];

                  return ListTile(
                    leading: Image.network(
                      product.images.isNotEmpty
                          ? ImageDisplayHelper.generateSingleProductImageURL(
                              product.images.first)
                          : 'https://via.placeholder.com/50', // Default placeholder image
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Text('${product.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        context.read<WishlistCubit>().toggleWishlist(product);
                      },
                    ),
                  );
                },
              );
            }

            return Center(child: Text('Unexpected State'));
          },
        ),
      ),
    );
  }
}

// Main UI
class BottomNavBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit()..fetchProducts(),
        ),
        BlocProvider(create: (context) => WishlistCubit()..loadWishlist()),
        // Provide WishlistCubit
      ],
      child: BottomNavScreen(),
    );
  }
}

class BottomNavScreen extends StatelessWidget {
  final List<Widget> pages = [
    HomePage(),
    WishlistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, BottomNavItem>(
        builder: (context, state) {
          return pages[state.index];
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavItem>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) {
              context
                  .read<BottomNavCubit>()
                  .updateTab(BottomNavItem.values[index]);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Wishlist"),
            ],
          );
        },
      ),
    );
  }
}
