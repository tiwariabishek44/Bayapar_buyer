import '../../../consts/consts.dart';
import '../../../models/order_model.dart';

List<OrderStatus> orderStatusList(Orders order) {
  return [
    OrderStatus(
      name: 'Confirm',
      icon: Icons.check,
      isCompleted: order.isConfirmed,
    ),
    OrderStatus(
      name: 'Packaging',
      icon: Icons.shopping_bag_outlined,
      isCompleted: order.isPackaging,
    ),
    OrderStatus(
      name: 'On Road',
      icon: Icons.local_shipping_outlined,
      isCompleted: order.isOnRoad,
    ),

  ];
}


// Define the order status widget
class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    Key? key,
    required this.orderStatusList,
  }) : super(key: key);

  final List<OrderStatus> orderStatusList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          orderStatusList.length,
              (index) {
            return Column(
              children: [
                if (orderStatusList[index].imageAssetPath != null)
                  Image.asset(
                    orderStatusList[index].imageAssetPath!,
                    width: 24,
                    height: 24,
                    color: orderStatusList[index].isCompleted ? Colors.green : Colors.grey,
                  ),
                if (orderStatusList[index].imageAssetPath == null)
                  Icon(
                    orderStatusList[index].icon,
                    color: orderStatusList[index].isCompleted ? Colors.green : Colors.grey,
                  ),
                Text(
                  orderStatusList[index].name,
                  style: TextStyle(
                    color: orderStatusList[index].isCompleted ? Colors.green : Colors.grey,
                    fontWeight: orderStatusList[index].isCompleted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


// Define the order status object
class OrderStatus {
  final String name;
  final IconData? icon;
  final String? imageAssetPath;
  final bool isCompleted;

  const OrderStatus({
    required this.name,
    this.icon,
    this.imageAssetPath,
    required this.isCompleted,
  });
}