import 'package:flutter/material.dart';
import 'vehicle_data.dart';
import 'vehicle_detail.dart';

class VehicleGridPage extends StatefulWidget {
  const VehicleGridPage({super.key});

  @override
  State<VehicleGridPage> createState() => _VehicleGridPageState();
}

class _VehicleGridPageState extends State<VehicleGridPage> {
  final Set<String> savedVehicles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text("Daftar Mobil"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7E57C2), Color(0xFFB388FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: vehicleList.length,
        itemBuilder: (context, index) {
          final vehicle = vehicleList[index];
          final isSaved = savedVehicles.contains(vehicle.name);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VehicleDetailPage(vehicle: vehicle),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Hero(
                  tag: vehicle.name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      vehicle.imageUrls.first,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  vehicle.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C1E8E),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    "${vehicle.type} | ${vehicle.engine} | ${vehicle.fuelType}\nHarga: ${vehicle.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                trailing: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => ScaleTransition(
                    scale: anim,
                    child: child,
                  ),
                  child: IconButton(
                    key: ValueKey(isSaved),
                    icon: Icon(
                      isSaved ? Icons.star : Icons.star_border,
                      color: isSaved ? Colors.amber : Colors.grey,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isSaved) {
                          savedVehicles.remove(vehicle.name);
                        } else {
                          savedVehicles.add(vehicle.name);
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
