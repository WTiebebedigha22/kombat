import 'package:flame_3d/components.dart';

class ArenaComponent extends Component3D {
  @override
  Future<void> onLoad() async {
    await createGroundPlane();
  }
  
  Future<void> createGroundPlane() async {
    // Geometry can be added here using a Flame 3D mesh component.
  }
}