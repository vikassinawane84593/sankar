import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sankar/features/shop/data/shop_repository.dart';
import 'package:sankar/features/shop/logic/shop_bloc.dart';
import 'package:sankar/features/shop/presentation/shop_app.dart';

void main() {
  const products = [
    {
      'id': 1,
      'title': 'Everyday Cotton Shirt',
      'price': 29.99,
      'description': 'A comfortable shirt for every day.',
      'category': "men's clothing",
      'image': 'https://example.com/shirt.png',
      'rating': {'rate': 4.5, 'count': 120},
    },
  ];

  testWidgets('loads products and adds an item to the bag', (tester) async {
    final repository = ShopRepository(
      client: MockClient((_) async => httpResponse(products)),
    );
    final bloc = ShopBloc(repository)..add(const ShopStarted());
    await tester.pumpWidget(
      BlocProvider.value(value: bloc, child: const SankarShopApp()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Everyday Cotton Shirt'), findsOneWidget);
    await tester.tap(find.text('Add to bag'));
    await tester.pump();
    expect(bloc.state.cartCount, 1);
    expect(find.text('Added to your bag'), findsOneWidget);
    await bloc.close();
  });

  testWidgets('can save a product and show it in Saved', (tester) async {
    final repository = ShopRepository(
      client: MockClient((_) async => httpResponse(products)),
    );
    final bloc = ShopBloc(repository)..add(const ShopStarted());
    await tester.pumpWidget(
      BlocProvider.value(value: bloc, child: const SankarShopApp()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    await tester.tap(find.text('Saved'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Everyday Cotton Shirt'), findsOneWidget);
    await bloc.close();
  });
}

http.Response httpResponse(Object body) => http.Response(
  jsonEncode(body),
  200,
  headers: {'content-type': 'application/json'},
);
