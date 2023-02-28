import 'package:example/repository.dart';
import 'package:example/validate_repository.dart';
import 'package:flutter/material.dart';

Repository repository = Repository();
ValidateRepository validateRepository = ValidateRepository();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  repository.successRequest(
                    (data) {},
                    (code, msg) {},
                  );
                },
                child: const Text(
                  "默认仓库成功接口，结果看log",
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () => repository.errorRequest(),
                child: const Text(
                  "默认仓库失败接口\n由onError处理，结果看log",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () => validateRepository.successRequest(),
                child: const Text(
                  "REST风格仓库成功接口，结果看log",
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () => validateRepository.errorRequest(),
                child: const Text(
                  "REST风格仓库失败接口\n由onResponse处理，结果看log",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
