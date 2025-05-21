class Vehicle {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final bool isSelected;

  Vehicle({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    this.isSelected = false,
  });

  Vehicle copyWith({
    String? id,
    String? name,
    String? description,
    String? iconPath,
    bool? isSelected,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
