// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:go_router/go_router.dart';

class MyPurchase extends StatelessWidget {
  const MyPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purchase summary',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () =>
                  context.go('/catalog'), // เพิ่มปุ่ม back ที่ Appbar เผื่อไว้
        ),
      ),
      body: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                "Thank you for your purchase!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Text(
              "Items:",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 20),
            ),
            Expanded(child: _CartList()),

            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.black54);
    var cart = context.watch<CartModel>();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: cart.items.length,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            // 2. เปลี่ยนจาก ListTile เป็น Text ธรรมดาที่มีขีดนำหน้า
            child: Text("- ${cart.items[index].name}", style: itemStyle),
          ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var totalStyle = Theme.of(
      context,
    ).textTheme.displayLarge!.copyWith(fontSize: 24, color: Colors.black);

    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // แสดงราคารวม
          Consumer<CartModel>(
            builder:
                (context, cart, child) =>
                    Text('Total: \$${cart.totalPrice}', style: totalStyle),
          ),

          const Spacer(),

          Center(
            child: FilledButton(
              onPressed: () {
                context.go('/catalog');
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFEEEBE3),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('Back to Home'),
            ),
          ),
        ],
      ),
    );
  }
}
