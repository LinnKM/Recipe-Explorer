import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SavedRecipePage extends StatefulWidget {
  const SavedRecipePage({super.key});

  @override
  State<SavedRecipePage> createState() => _SavedRecipePageState();
}

class _SavedRecipePageState extends State<SavedRecipePage> {
  List<String> items = ['chicken', 'pork'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Favorite Recipes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Expanded(
            child:
                items.isEmpty
                    ? Center(child: Text("No Favorite Recipes Yet"))
                    : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          enableFeedback: true,
                          style: ListTileStyle.drawer,
                          leading: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8JlWGheIlfIzO0ZIpLn2C5XHp5BQOQwRlww&s',
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            'KFC Chicken',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 20),
                              Text('20 min'),
                            ],
                          ),
                          trailing: Icon(Iconsax.save_2, size: 20),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey,
                          height: 10,
                          thickness: 0.5,
                        );
                      },
                      itemCount: 5,
                    ),
          ),
        ),
      ),
    );
  }
}
