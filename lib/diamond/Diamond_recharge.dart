import 'package:flutter/material.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';

class DiamondRechargeScreen extends StatefulWidget {
  const DiamondRechargeScreen({Key? key}) : super(key: key);

  @override
  State<DiamondRechargeScreen> createState() => _DiamondRechargeScreenState();
}

_Notification(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Nạp Kim Cương'),
            content: Text(
                'Ducky Ôn Thi cung cấp sản phẩm kỹ thuật số như một đơn vị tiền tệ trên website - Kim cương - để đáp ứng nhu cầu trải nghiệm những tính năng nâng cấp cao có tính phí của người dùng.Bạn có thể mua các gói nạp kim cương bằng cách chuyển khoản vào tài khoản bên dưới với nội dung gồm mã khách hàng và gói nạp.\nMB Bank - Ngân hàng Quân Đội\n Số tài khoản: 9018199099999\nChủ tài khoản: Lê Trọng Quân\nMọi thắc mắc hay gặp khó khăn trong quá trình trải nghiệm website vui lòng liên hệ với Chinhxac.vn qua hộp thư thoại ngay trên website hoặc qua fanpage: Chính xác hoặc qua hotlile: 0921 560 888.\nLưu ý: Nếu bạn chưa tự chủ được tài chính của bản thân vui lòng hỏi ý kiến phụ huynh trước khi tiến hành thanh toán bằng bất kỳ phương thức nào được nêu trên.'));
      });
}

class _DiamondRechargeScreenState extends State<DiamondRechargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 189, 189, 1),
          title: Text('Nạp Kim Cương'),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 90,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text("1600 Kim Cương\nmua goi 1600 kim cương"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '248.000 VNĐ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {
                  _Notification(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 90,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text("690 kim cương \nmua goi 690 kim cương"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '124.000 VNĐ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {
                  _Notification(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 90,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text("380 Kim Cương\nmua goi 380 kim cương"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '74.000 VNĐ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {
                  _Notification(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 90,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text("240 Kim Cương\nmua goi 240 kim cương"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '49.000 VNĐ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {
                  _Notification(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 90,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text("110 Kim Cương\nmua goi 110 kim cương"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '25.000 VNĐ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {
                  _Notification(context);
                },
              ),
            ),
          ],
        ));
  }
}
