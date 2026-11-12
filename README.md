# Sankar Shop

A Flutter storefront powered by Flutter BLoC and the [Fake Store API](https://fakestoreapi.com/).

## Features

- Browse the live product catalog and filter by category.
- Search products by name or category.
- Open product details, including description, rating, and price.
- Save favorites and add products to a shopping bag.
- Change quantities, review the subtotal, and place a demo checkout order.
- Retry catalog loading after a network error.

## Project structure

- `lib/features/shop/domain` contains the product model.
- `lib/features/shop/data` contains the Fake Store API repository.
- `lib/features/shop/logic` contains shop events, state, and BLoC.
- `lib/features/shop/presentation` contains the storefront, product details, and bag screens.
- `test` contains widget tests using a mocked API response.

Run the app with `flutter run`.
