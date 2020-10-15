class Khata {
  String name;
  String itemName;
  int quantity;
  int rate;
  String contactNumber;
  String email;
  String date;
  String remark;

  Khata(
      {
        this.name,
        this.itemName,
        this.quantity,
        this.rate,
        this.contactNumber,
        this.email,
        this.date,
        this.remark});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": this.name,
      "itemName": this.itemName,
      "quantity": this.quantity,
      "rate": this.rate,
      "contactNumber": this.contactNumber,
      "email": this.email,
      "date": this.date,
      "remark": this.remark
    };

    return map;
  }
}
