import 'package:flutter/material.dart';
import 'package:explore/widgets/responsive.dart';

class CommentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Row(
        children: [
          SizedBox(
            width: screenSize.width * 4 / 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Image.network('https://picsum.photos/160'),
                  title: const Text(
                    'Lee-Walsh, Natalie',
                  ),
                  subtitle: Text('1 dk önce yayınlandı.'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır."),
                ),
                const Divider(
                  indent: 16,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                    ),
                    tooltip: 'Daha Fazla',
                    onPressed: () {}),
              )
            ],
          )
        ],
      ),
    );
  }
}
