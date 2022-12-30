#!/bin/bash
###
# @Author: zhangzhihua
# @Date: 2022-10-13 15:16:28
# @LastEditors: zhangzhihua
# @LastEditTime: 2022-10-21 15:08:48
# @Description: 生成getx目录结构插件
###

documentPath=$1
className=$2

cd $documentPath

#修正文件名
for ((i = 0; i <= ${#className}; i++)); do
  item=$(echo ${className:$i:1})
  if [[ $item = [[:upper:]] ]]; then
    S=$(echo $item | tr 'A-Z' 'a-z')
    if [[ $i != 0 ]]; then
      S='_'$S
    fi
    fileName=$fileName$S
  else
    fileName=$fileName$item
  fi
done
# echo '文件名:'$fileName

rm -rf $fileName
mkdir $fileName
cd $fileName
touch "logic.dart"
touch "state.dart"
touch "view.dart"

#修正类名
className=$(echo ${className:0:1} | tr '[a-z]' '[A-Z]')${className:1}
# echo '类名:'$className

#编辑logic
echo "import 'package:get/get.dart';" >logic.dart
echo "import 'state.dart';" >>logic.dart
echo "" >>logic.dart
echo "class ${className}Logic extends GetxController {" >>logic.dart
echo "  final state = ${className}State();" >>logic.dart
echo "  final tag = DateTime.now().microsecondsSinceEpoch.toString();" >>logic.dart
echo '''
  @override
  void onInit() {
    //Get.arguments["xxx"];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}''' >>logic.dart
# open logic.dart

#编辑state
echo "class ${className}State {" >state.dart
echo "  ${className}State() {" >>state.dart
echo '''    //Initialize variables
  }
}
''' >>state.dart
# open state.dart

#编辑view
echo "import 'package:flutter/material.dart';" >view.dart
echo "import 'package:get/get.dart';" >>view.dart
echo "" >>view.dart
echo "import 'logic.dart';" >>view.dart
echo "import 'state.dart';" >>view.dart
echo "" >>view.dart

echo "class ${className}View extends StatelessWidget {" >>view.dart
echo "  ${className}View({Key? key}) : super(key: key);" >>view.dart
echo "" >>view.dart

echo "  late ${className}Logic logic = ${className}Logic();" >>view.dart
echo "  late ${className}State state = logic.state;" >>view.dart

echo '''
  @override
  Widget build(BuildContext context) {''' >>view.dart
echo "    return GetBuilder<${className}Logic>(" >>view.dart
echo '''      init: logic,
      tag: logic.tag,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(),
          backgroundColor: const Color(0xFFF0F0F0),
          body: Container(),
        );
      },
    );
  }
}''' >>view.dart
# open view.dart
