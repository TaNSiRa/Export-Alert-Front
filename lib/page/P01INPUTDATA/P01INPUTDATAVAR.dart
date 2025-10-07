// ignore_for_file: non_constant_identifier_names

class P01INPUTDATAVAR {
  static int rowsPerPage = 15;
  static String search = '';
  static bool iscontrol = false;
  static bool isHoveredClear = false;
  static dynamic SendDataToAPI = '';
  static List<String> stepAction = [];
  static List<String> dropdownCustomer = [];
  static List<String> dropdownMat = [];
  static List<String> dropdownShipment = ['Air', 'Sea', 'Truck'];
  static List<String> dropdownUOM = [
    'PCS', // Pieces (ชิ้น)
    'EA', // Each (อัน)
    'SET', // Set (ชุด)
    'BOX', // Box (กล่อง)
    'CTN', // Carton (ลัง)
    'PKG', // Package (แพ็ค)
    'ROLL', // Roll (ม้วน)
    'BAG', // Bag (ถุง)
    'KG', // Kilogram (กิโลกรัม)
    'G', // Gram (กรัม)
    'TON', // Ton (ตัน)
    'LB', // Pound (ปอนด์)
    'L', // Liter (ลิตร)
    'ML', // Milliliter (มิลลิลิตร)
    'GAL', // Gallon (แกลลอน)
    'M', // Meter (เมตร)
    'CM', // Centimeter (เซนติเมตร)
    'MM', // Millimeter (มิลลิเมตร)
    'FT', // Feet (ฟุต)
    'IN', // Inch (นิ้ว)
    'M2', // Square Meter (ตารางเมตร)
    'M3', // Cubic Meter (ลูกบาศก์เมตร)
    'PAIR', // Pair (คู่)
    'DOZEN', // Dozen (โหล)
    'PALLET', // Pallet (พาเลท)
    'CONTAINER', // Container (ตู้คอนเทนเนอร์)
  ];
}
