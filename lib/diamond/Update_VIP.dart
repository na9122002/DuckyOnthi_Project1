import 'package:flutter/material.dart';
import 'package:travo_app_source/helpers/asset_helper.dart';

class UpdateVIPScreen extends StatefulWidget {
  const UpdateVIPScreen({Key? key}) : super(key: key);

  @override
  State<UpdateVIPScreen> createState() => _UpdateVIPScreenState();
}

class _UpdateVIPScreenState extends State<UpdateVIPScreen> {
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
              height: 150,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text(
                            "VIP 365\n+365 ngaỳ VIP trải nghiệm cao\n cấp hơn với thành viên VIP"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '4000',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Icon(Icons.diamond),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 150,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text(
                            "VIP 180\n+180 ngaỳ VIP trải nghiệm cao\n cấp hơn với thành viên VIP"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '2500',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Icon(Icons.diamond),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 150,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text(
                            "VIP 90\n+90 ngaỳ VIP trải nghiệm cao\n cấp hơn với thành viên VIP"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '1500',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Icon(Icons.diamond),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 150,
              width: 300,
              child: MaterialButton(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(AssetHelper.diamond),
                    ),
                    Column(
                      children: [
                        new Text(
                            "VIP 30\n+30 ngaỳ VIP trải nghiệm cao\n cấp hơn với thành viên VIP"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '600',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Icon(Icons.diamond),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                color: Color.fromRGBO(255, 189, 189, 1),
                splashColor: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
