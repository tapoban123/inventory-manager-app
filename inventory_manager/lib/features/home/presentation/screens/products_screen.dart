import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/core/utils/utils.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_events.dart';
import 'package:inventory_manager/features/home/presentation/bloc/products_bloc/products_states.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(FetchAllProductsEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsStates>(
      // listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        print(state.error);
        if (state.error == "INSUFFICIENT RESOURCES") {
          showToastMessage("Not enough resources to proceed the action.");
        }
      },
      builder: (context, state) {
        if (state.loadingStatus == ProductsLoadingStatus.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.loadingStatus == ProductsLoadingStatus.success) {
          final productsData = state.productsData;

          if (productsData!.isEmpty) {
            return Center(child: Text("No products to show."));
          }

          return ListView.builder(
            itemCount: productsData.length,
            itemBuilder: (context, index) {
              final product = productsData[index];
              final Map<String, String> materials = {};

              for (int i = 3; i < product.keys.length; i++) {
                materials[product.keys.toList()[i]] =
                    product.values.toList()[i];
              }

              return Card(
                child: ListTile(
                  title: Text("${product["product"]!} x${product["count"]!}"),
                  trailing: SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "New amount",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        // if (int.parse(value) > int.parse(product["count"]!)) {
                        context.read<ProductsBloc>().add(
                          IncreaseProductsCountEvent(
                            compositionId: product["composition_id"]!,
                            newCount:
                                (int.parse(product["count"]!) +
                                        int.parse(value))
                                    .toString(),
                            materials: materials,
                            countIncreased: int.parse(value),
                          ),
                        );
                        // } else {
                        //   context.read<ProductsBloc>().add(
                        //     DecreaseProductsCountEvent(
                        //       compositionId: product["composition_id"]!,
                        //       newCount:
                        //           (int.parse(product["count"]!) -
                        //                   int.parse(value))
                        //               .toString(),
                        //       materials: materials,
                        //       countDecreased: int.parse(value),
                        //     ),
                        //   );
                        // }
                      },
                      keyboardType: TextInputType.number,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
