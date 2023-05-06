import 'package:email_client_challenge/emaildetailsjson.dart';
import 'package:email_client_challenge/emailproviderjson.dart';
import 'package:email_client_challenge/rounded_indicator.dart';
import 'package:email_client_challenge/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 52.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'All Inboxes',
                                style: kJakartaHeading1.copyWith(
                                  fontSize: kHeadingSize1,
                                ),
                              ),
                              const Icon(Icons.expand_more),
                            ],
                          ),
                          Text(
                            'Total 2500 Messages, 3 Unread',
                            style: kJakartaBodyMedium.copyWith(
                              fontSize: kBodySize1,
                              color: kParagraphColor,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        radius: 26.0,
                        foregroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2021/11/12/03/04/woman-6787784_960_720.png'),
                      ),
                    ]),
              ),
              Container(
                height: 98.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 24.0,
                ),
                child: ListView.builder(
                  itemCount: SampleJSON.provider.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 24 : 0,
                        right: index == 10 - 1 ? 24 : 8,
                      ),
                      child: buildColumn(index),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
                        child: TabBar(
                            controller: tabController,
                            labelPadding: const EdgeInsets.only(
                              right: 24,
                            ),
                            indicatorWeight: 8,
                            isScrollable: true,
                            labelColor: kDarkColor,
                            labelStyle: kJakartaBodyBold.copyWith(
                              fontSize: kBodySize1,
                            ),
                            unselectedLabelColor: kDark40Color,
                            indicator: RoundedRectangleTabIndicator(
                              color: kPrimaryColor,
                              weight: 4,
                              width: 24,
                              padding: 12.0,
                            ),
                            splashFactory: NoSplash.splashFactory,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return states.contains(MaterialState.focused)
                                    ? null
                                    : Colors.transparent;
                              },
                            ),
                            tabs: const [
                              Tab(text: 'Primary'),
                              Tab(text: 'Social'),
                              Tab(text: 'Forums'),
                            ]),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.more_horiz,
                          color: kParagraphColor,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 8.0)),
                        Text(
                          'Edit',
                          style: kJakartaBodyBold.copyWith(
                              fontSize: kBodySize1, color: kParagraphColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 16.0, right: 16.0, left: 16.0, bottom: 8.0),
                color: Colors.white,
                width: double.maxFinite,
                height: 500.0,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                      itemCount: EmailJSON.email.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: buildContainer(index),
                        );
                      },
                    ),
                    const Text("Social"),
                    const Text("Forums"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Compose',
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }

  Column buildColumn(int index) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              maxRadius: 36,
              backgroundColor: kWhiteColor,
              foregroundImage:
                  NetworkImage("${SampleJSON.provider[index]["image"]}"),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  if (SampleJSON.provider[index]["view"] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kPrimaryColor,
                      ),
                      child: IntrinsicWidth(
                        child: Text(
                          SampleJSON.provider[index]["no"].toString(),
                          style: kJakartaBodyBold.copyWith(
                            color: kWhiteColor,
                            fontSize: kBodySize2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          SampleJSON.provider[index]["name"].toString(),
          maxLines: 1,
          style: kJakartaBodyMedium.copyWith(
            color: kParagraphColor,
            fontSize: kBodySize1,
          ),
        ),
      ],
    );
  }

  Container buildContainer(int index) {
    return Container(
      height: 132.0,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        shadowColor: kBackgroundColor,
        color: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 24,
                backgroundColor: kWhiteColor,
                foregroundImage:
                    NetworkImage("${EmailJSON.email[index]["image"]}"),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      EmailJSON.email[index]["name"].toString(),
                      maxLines: 1,
                      style: kJakartaBodyMedium.copyWith(
                        color: kParagraphColor,
                        fontSize: kBodySize1,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      EmailJSON.email[index]["title"].toString(),
                      maxLines: 1,
                      style: kJakartaHeading4.copyWith(
                        color: kDarkColor,
                        fontSize: kBodySize1,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      EmailJSON.email[index]["description"].toString(),
                      maxLines: 2,
                      style: kJakartaBodyMedium.copyWith(
                        color: kParagraphColor,
                        fontSize: kBodySize1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                children: [
                  Text(
                    EmailJSON.email[index]["time"].toString(),
                    maxLines: 1,
                    style: kJakartaBodyMedium.copyWith(
                      color: kParagraphColor,
                      fontSize: kBodySize1,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  if (EmailJSON.email[index]["read"] == false)
                    const Icon(Icons.circle, color: Colors.red, size: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
